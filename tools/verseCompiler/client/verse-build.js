#!/usr/bin/env node
/**
 * Verse CLI Build Tool
 * 
 * 通过命令行触发 UEFN 编译 Verse 代码
 * 
 * 用法:
 *   node verse-build.js [--port 1962] [--host 127.0.0.1] [--push] [--watch]
 * 
 * 选项:
 *   --port    UEFN Workflow Server 端口 (默认: 1962)
 *   --host    UEFN Workflow Server 地址 (默认: 127.0.0.1)
 *   --push    编译后推送代码到服务器
 *   --watch   监听文件变化自动编译
 *   --help    显示帮助信息
 * 
 * 前提条件:
 *   UEFN 必须已经打开并加载了项目
 */

const net = require('net');
const fs = require('fs');
const path = require('path');

// ============================================================================
// 协议定义 (与 UEFN VSCode 插件保持一致)
// ============================================================================

const MessageType = {
    Notification: 0,
    Request: 1,
    Response: 2
};

const BuildState = {
    Success: 0,
    Warnings: 1,
    Errors: 2,
    Building: 3,
    NoBuild: 4
};

const Severity = {
    1: 'Error',
    2: 'Warning',
    3: 'Info',
    4: 'Log'
};

// ============================================================================
// Verse Workflow Client
// ============================================================================

class VerseWorkflowCLI {
    constructor(options = {}) {
        this.host = options.host || '127.0.0.1';
        this.port = options.port || 1962;
        this.socket = null;
        this.sequence = 1;
        this.pendingRequests = new Map();
        this.rawData = Buffer.alloc(0);
        this.contentLength = -1;
        this.connected = false;
        this.verbose = options.verbose || false;
    }

    log(message, level = 'info') {
        const timestamp = new Date().toISOString();
        const prefix = {
            'info': '\x1b[36m[INFO]\x1b[0m',
            'success': '\x1b[32m[SUCCESS]\x1b[0m',
            'warning': '\x1b[33m[WARNING]\x1b[0m',
            'error': '\x1b[31m[ERROR]\x1b[0m',
            'debug': '\x1b[90m[DEBUG]\x1b[0m'
        }[level] || '[INFO]';
        
        if (level === 'debug' && !this.verbose) return;
        console.log(`${prefix} ${message}`);
    }

    connect() {
        return new Promise((resolve, reject) => {
            this.log(`正在连接到 UEFN Workflow Server (${this.host}:${this.port})...`);
            
            this.socket = net.createConnection(this.port, this.host, () => {
                this.connected = true;
                this.log('已连接到 UEFN Workflow Server!', 'success');
                resolve();
            });

            this.socket.on('data', (data) => this.handleData(data));

            this.socket.on('error', (error) => {
                this.log(`连接失败: ${error.message}`, 'error');
                this.log('请确保 UEFN 已经打开并加载了项目', 'error');
                reject(error);
            });

            this.socket.on('close', () => {
                this.connected = false;
                this.log('连接已关闭');
            });

            this.socket.on('end', () => {
                this.connected = false;
            });

            // 连接超时
            setTimeout(() => {
                if (!this.connected) {
                    this.socket.destroy();
                    reject(new Error('连接超时'));
                }
            }, 5000);
        });
    }

    disconnect() {
        if (this.socket) {
            this.socket.end();
            this.socket = null;
        }
        this.connected = false;
    }

    send(type, command, params = {}) {
        return new Promise((resolve, reject) => {
            const message = {
                seq: this.sequence++,
                type: type,
                command: command,
                params: params
            };

            if (type === MessageType.Request) {
                this.pendingRequests.set(message.seq, { resolve, reject });
            }

            const json = JSON.stringify(message);
            const header = `Content-Length: ${Buffer.byteLength(json, 'utf8')}\r\n\r\n`;
            
            this.log(`发送请求: ${command}`, 'debug');
            this.socket.write(header + json, 'utf8');

            if (type !== MessageType.Request) {
                resolve();
            }
        });
    }

    handleData(data) {
        this.rawData = Buffer.concat([this.rawData, data]);

        while (true) {
            if (this.contentLength >= 0) {
                if (this.rawData.length >= this.contentLength) {
                    const message = this.rawData.toString('utf8', 0, this.contentLength);
                    this.rawData = this.rawData.slice(this.contentLength);
                    this.contentLength = -1;

                    if (message.length > 0) {
                        this.dispatch(message);
                    }
                    continue;
                }
            } else {
                const idx = this.rawData.indexOf('\r\n\r\n');
                if (idx !== -1) {
                    const header = this.rawData.toString('utf8', 0, idx);
                    const match = header.match(/Content-Length:\s*(\d+)/i);
                    if (match) {
                        this.contentLength = parseInt(match[1], 10);
                    }
                    this.rawData = this.rawData.slice(idx + 4);
                    continue;
                }
            }
            break;
        }
    }

    dispatch(body) {
        let rawData;
        try {
            rawData = JSON.parse(body);
        } catch (error) {
            this.log(`解析消息失败: ${error.message}`, 'error');
            return;
        }

        switch (rawData.type) {
            case MessageType.Notification:
                this.handleNotification(rawData);
                break;

            case MessageType.Response:
                this.handleResponse(rawData);
                break;

            default:
                this.log(`未知消息类型: ${rawData.type}`, 'warning');
        }
    }

    handleNotification(message) {
        switch (message.command) {
            case 'logMessage':
                const severity = Severity[message.params.type] || 'Log';
                const logLevel = message.params.type <= 2 ? 'error' : 'info';
                this.log(`[UEFN ${severity}] ${message.params.message}`, logLevel);
                break;

            case 'updateBuildState':
                const states = ['Success', 'Warnings', 'Errors', 'Building', 'NoBuild'];
                this.log(`构建状态更新: ${states[message.params] || message.params}`, 'debug');
                break;

            case 'canPushVerseChanges':
                this.log(`可以推送变更: ${message.params}`, 'debug');
                break;

            default:
                this.log(`收到通知: ${message.command}`, 'debug');
        }
    }

    handleResponse(response) {
        const pending = this.pendingRequests.get(response.seq);
        if (pending) {
            this.pendingRequests.delete(response.seq);
            if (response.result !== undefined) {
                pending.resolve(response.result);
            } else if (response.error !== undefined) {
                pending.reject(new Error(response.error));
            } else {
                pending.reject(new Error('无效的响应'));
            }
        }
    }

    // ========================================================================
    // 高级命令
    // ========================================================================

    async compile() {
        this.log('正在请求编译 Verse 代码...');
        
        try {
            const result = await this.send(MessageType.Request, 'compileProject', {});
            
            if (result.numErrors > 0) {
                this.log(`编译完成，有 ${result.numErrors} 个错误`, 'error');
                console.log('\n--- 构建日志 ---');
                console.log(result.message);
                console.log('--- 构建日志结束 ---\n');
                return { success: false, errors: result.numErrors, warnings: result.numWarnings };
            } else if (result.numWarnings > 0) {
                this.log(`编译完成，有 ${result.numWarnings} 个警告`, 'warning');
                console.log('\n--- 构建日志 ---');
                console.log(result.message);
                console.log('--- 构建日志结束 ---\n');
                return { success: true, errors: 0, warnings: result.numWarnings };
            } else {
                this.log('编译成功!', 'success');
                return { success: true, errors: 0, warnings: 0 };
            }
        } catch (error) {
            this.log(`编译失败: ${error.message}`, 'error');
            throw error;
        }
    }

    async pushChanges(verseOnly = true) {
        this.log(`正在推送变更 (仅Verse: ${verseOnly})...`);
        
        try {
            const result = await this.send(MessageType.Request, 'pushChanges', verseOnly);
            this.log(`推送成功: ${result}`, 'success');
            return result;
        } catch (error) {
            this.log(`推送失败: ${error.message}`, 'error');
            throw error;
        }
    }
}

// ============================================================================
// 文件监听器 (可选的 watch 模式)
// ============================================================================

class VerseWatcher {
    constructor(client, directories) {
        this.client = client;
        this.directories = directories;
        this.watchers = [];
        this.debounceTimer = null;
        this.debounceDelay = 500; // ms
    }

    start() {
        console.log('\n\x1b[36m[WATCH]\x1b[0m 开始监听 .verse 文件变化...');
        console.log('\x1b[36m[WATCH]\x1b[0m 按 Ctrl+C 停止\n');

        for (const dir of this.directories) {
            if (fs.existsSync(dir)) {
                this.watchDirectory(dir);
            }
        }
    }

    watchDirectory(dir) {
        try {
            const watcher = fs.watch(dir, { recursive: true }, (eventType, filename) => {
                if (filename && filename.endsWith('.verse')) {
                    this.scheduleCompile(filename);
                }
            });
            this.watchers.push(watcher);
            console.log(`\x1b[36m[WATCH]\x1b[0m 监听目录: ${dir}`);
        } catch (error) {
            console.log(`\x1b[33m[WARNING]\x1b[0m 无法监听目录: ${dir} - ${error.message}`);
        }
    }

    scheduleCompile(filename) {
        if (this.debounceTimer) {
            clearTimeout(this.debounceTimer);
        }
        
        this.debounceTimer = setTimeout(async () => {
            console.log(`\n\x1b[36m[WATCH]\x1b[0m 检测到文件变化: ${filename}`);
            try {
                await this.client.compile();
            } catch (error) {
                // 错误已在 compile() 中处理
            }
        }, this.debounceDelay);
    }

    stop() {
        for (const watcher of this.watchers) {
            watcher.close();
        }
        this.watchers = [];
        if (this.debounceTimer) {
            clearTimeout(this.debounceTimer);
        }
    }
}

// ============================================================================
// CLI 入口
// ============================================================================

function parseArgs() {
    const args = process.argv.slice(2);
    const options = {
        host: '127.0.0.1',
        port: 1962,
        push: false,
        watch: false,
        verbose: false,
        help: false,
        watchDirs: []
    };

    for (let i = 0; i < args.length; i++) {
        const arg = args[i];
        switch (arg) {
            case '--host':
            case '-h':
                options.host = args[++i] || options.host;
                break;
            case '--port':
            case '-p':
                options.port = parseInt(args[++i], 10) || options.port;
                break;
            case '--push':
                options.push = true;
                break;
            case '--watch':
            case '-w':
                options.watch = true;
                break;
            case '--verbose':
            case '-v':
                options.verbose = true;
                break;
            case '--help':
                options.help = true;
                break;
            case '--dir':
            case '-d':
                options.watchDirs.push(args[++i]);
                break;
        }
    }

    return options;
}

function showHelp() {
    console.log(`
\x1b[36mVerse CLI Build Tool\x1b[0m

通过命令行触发 UEFN 编译 Verse 代码

\x1b[33m用法:\x1b[0m
  node verse-build.js [选项]

\x1b[33m选项:\x1b[0m
  --host, -h <地址>    UEFN Workflow Server 地址 (默认: 127.0.0.1)
  --port, -p <端口>    UEFN Workflow Server 端口 (默认: 1962)
  --push               编译成功后推送代码到服务器
  --watch, -w          监听文件变化自动编译
  --dir, -d <目录>     添加监听目录 (可多次使用)
  --verbose, -v        显示详细日志
  --help               显示此帮助信息

\x1b[33m示例:\x1b[0m
  # 单次编译
  node verse-build.js

  # 编译并推送
  node verse-build.js --push

  # 监听当前目录变化
  node verse-build.js --watch

  # 监听指定目录
  node verse-build.js --watch --dir "E:/Game/MyProject/Content"

\x1b[33m前提条件:\x1b[0m
  - UEFN 必须已经打开并加载了项目
  - UEFN 会在内部启动 Workflow Server 监听端口 1962

\x1b[33m退出码:\x1b[0m
  0 - 编译成功
  1 - 编译有错误
  2 - 连接失败
`);
}

async function main() {
    const options = parseArgs();

    if (options.help) {
        showHelp();
        process.exit(0);
    }

    console.log('\n\x1b[36m╔══════════════════════════════════════╗\x1b[0m');
    console.log('\x1b[36m║      Verse CLI Build Tool v1.0       ║\x1b[0m');
    console.log('\x1b[36m╚══════════════════════════════════════╝\x1b[0m\n');

    const client = new VerseWorkflowCLI({
        host: options.host,
        port: options.port,
        verbose: options.verbose
    });

    try {
        await client.connect();
    } catch (error) {
        process.exit(2);
    }

    if (options.watch) {
        // Watch 模式
        const watchDirs = options.watchDirs.length > 0 
            ? options.watchDirs 
            : [process.cwd()];
        
        const watcher = new VerseWatcher(client, watchDirs);
        watcher.start();

        // 首次编译
        try {
            await client.compile();
        } catch (error) {
            // 继续监听
        }

        // 处理退出信号
        process.on('SIGINT', () => {
            console.log('\n\x1b[36m[INFO]\x1b[0m 正在停止...');
            watcher.stop();
            client.disconnect();
            process.exit(0);
        });
    } else {
        // 单次编译模式
        try {
            const result = await client.compile();
            
            if (options.push && result.success) {
                await client.pushChanges(true);
            }

            client.disconnect();
            process.exit(result.errors > 0 ? 1 : 0);
        } catch (error) {
            client.disconnect();
            process.exit(1);
        }
    }
}

// 运行
main().catch(error => {
    console.error('未捕获的错误:', error);
    process.exit(1);
});
