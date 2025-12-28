// 在 Epic 文档页面的控制台运行此脚本
// 会自动复制所有需要的信息到剪贴板

(async function() {
  const fingerprint = {
    // User-Agent
    userAgent: navigator.userAgent,
    
    // 平台信息
    platform: navigator.platform,
    language: navigator.language,
    languages: navigator.languages,
    
    // 屏幕信息
    screen: {
      width: screen.width,
      height: screen.height,
      colorDepth: screen.colorDepth,
      pixelRatio: window.devicePixelRatio
    },
    
    // 时区
    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
    timezoneOffset: new Date().getTimezoneOffset(),
    
    // Cookies (可见的)
    cookies: document.cookie,
    
    // 当前 URL
    url: window.location.href
  };
  
  // 格式化输出
  const output = JSON.stringify(fingerprint, null, 2);
  
  // 复制到剪贴板
  try {
    await navigator.clipboard.writeText(output);
    console.log('✅ 浏览器指纹已复制到剪贴板！');
    console.log('请粘贴给 AI 助手');
  } catch(e) {
    console.log('📋 请手动复制以下内容：');
    console.log(output);
  }
  
  return fingerprint;
})();
