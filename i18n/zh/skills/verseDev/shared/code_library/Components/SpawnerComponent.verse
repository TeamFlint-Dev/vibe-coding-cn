# SpawnerComponent - 生成器组件
# 版本: 1.3
# 添加时间: 2025-12-27
# 更新: 修复 Mod 函数和 vector3 类型
# 来源: REQ-009 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Verse.org/Random }
using { /Verse.org/Verse }  # Mod 函数
using { /Verse.org/SpatialMath }  # SceneGraph 使用的 vector3 (Forward/Left/Up)

# 生成器状态
spawner_state<public> := enum:
    Idle
    Spawning
    WaveDelay
    Completed
    Disabled

# 实体生成事件
entity_spawned_event<public> := class<concrete>(scene_event):
    SpawnedEntity<public>:?entity = false
    SpawnPosition<public>:vector3 = vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
    WaveIndex<public>:int = 0
    EntityIndex<public>:int = 0

# 波次开始事件
wave_started_event<public> := class<concrete>(scene_event):
    WaveIndex<public>:int = 0
    TotalEntities<public>:int = 0

# 波次完成事件
wave_completed_event<public> := class<concrete>(scene_event):
    WaveIndex<public>:int = 0
    EntitiesSpawned<public>:int = 0

# 所有波次完成事件
all_waves_completed_event<public> := class<concrete>(scene_event):
    TotalWaves<public>:int = 0
    TotalEntitiesSpawned<public>:int = 0

# 波次配置
wave_config<public> := struct:
    EntityCount<public>:int = 5
    SpawnInterval<public>:float = 1.0
    WaveDelay<public>:float = 5.0

# 生成器组件
spawner_component<public> := class<final_super>(component):
    # 可编辑属性
    @editable 
    var SpawnPoints<public>:[]vector3 = array{}
    @editable 
    var DefaultSpawnCount<public>:int = 5
    @editable 
    var DefaultSpawnInterval<public>:float = 1.0
    @editable 
    var DefaultWaveDelay<public>:float = 5.0
    @editable 
    var RandomizeSpawnPoint<public>:logic = true
    @editable 
    var MaxActiveEntities<public>:int = 20
    
    # 波次配置
    var Waves<private>:[]wave_config = array{}
    var CurrentWaveIndex<private>:int = 0
    var CurrentEntityIndex<private>:int = 0
    
    # 运行时状态
    var CurrentState<private>:spawner_state = spawner_state.Idle
    var ActiveEntities<private>:[]entity = array{}
    var TotalSpawned<private>:int = 0
    var LastSpawnTime<private>:float = 0.0
    var SpawnPointIndex<private>:int = 0
    
    # ==========================================
    # 波次配置
    # ==========================================
    
    # 添加波次
    AddWave<public>(Config:wave_config):void =
        set Waves += array{Config}
    
    # 添加简单波次
    AddSimpleWave<public>(EntityCount:int):void =
        AddWave(wave_config{
            EntityCount := EntityCount,
            SpawnInterval := DefaultSpawnInterval,
            WaveDelay := DefaultWaveDelay
        })
    
    # 设置多波次
    SetWaves<public>(Configs:[]wave_config):void =
        set Waves = Configs
    
    # 清除所有波次
    ClearWaves<public>():void =
        set Waves = array{}
        set CurrentWaveIndex = 0
    
    # ==========================================
    # 生成控制
    # ==========================================
    
    # 开始生成
    StartSpawning<public>():void =
        if (CurrentState = spawner_state.Disabled):
            # 禁用状态不能开始
        else:
            if (Waves.Length = 0):
                # 使用默认配置创建单波次
                AddSimpleWave(DefaultSpawnCount)
            
            set CurrentWaveIndex = 0
            set CurrentEntityIndex = 0
            set CurrentState = spawner_state.Spawning
            StartWave(0)
    
    # 开始指定波次
    StartWave<private>(WaveIdx:int):void =
        if (WaveIdx >= Waves.Length):
            CompleteAllWaves()
        else:
            set CurrentWaveIndex = WaveIdx
            set CurrentEntityIndex = 0
            set CurrentState = spawner_state.Spawning
            
            if (W := Waves[WaveIdx]):
                OwnerEntity := Self.Entity
                OwnerEntity.SendUp(wave_started_event{
                    WaveIndex := WaveIdx,
                    TotalEntities := W.EntityCount
                })
    
    # 更新生成（应在tick中调用）
    UpdateSpawning<public>(CurrentTime:float):void =
        if (CurrentState <> spawner_state.Spawning):
            # 非生成状态
        else if (CurrentWaveIndex >= Waves.Length):
            # 无效波次
        else if (Wave := Waves[CurrentWaveIndex]):
            # 检查是否超出活动数量限制
            if (ActiveEntities.Length >= MaxActiveEntities):
                # 超出限制
            # 检查生成间隔
            else if (CurrentTime - LastSpawnTime < Wave.SpawnInterval):
                # 还在冷却
            else:
                # 检查波次是否完成
                if (CurrentEntityIndex >= Wave.EntityCount):
                    CompleteWave(CurrentWaveIndex)
                else:
                    # 执行生成
                    SpawnEntity()
                    set LastSpawnTime = CurrentTime
                    set CurrentEntityIndex += 1
    
    # 生成单个实体
    SpawnEntity<private>():?entity =
        SpawnPos := GetNextSpawnPoint()
        
        # TODO: 实际创建实体的逻辑
        # NewEntity := CreateEntity(...)
        # set ActiveEntities += array{NewEntity}
        # set TotalSpawned += 1
        
        # 发送事件
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(entity_spawned_event{
            SpawnedEntity := false,  # TODO: 填充实际实体
            SpawnPosition := SpawnPos,
            WaveIndex := CurrentWaveIndex,
            EntityIndex := CurrentEntityIndex
        })
        
        false
    
    # 获取下一个生成点
    GetNextSpawnPoint<private>():vector3 =
        if (SpawnPoints.Length = 0):
            vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
        else if (RandomizeSpawnPoint?):
            # 使用标准库 GetRandomInt
            RandomIdx := GetRandomInt(0, SpawnPoints.Length - 1)
            if (P := SpawnPoints[RandomIdx]):
                P
            else:
                vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
        else:
            if (P := SpawnPoints[SpawnPointIndex]):
                # 更新索引，避免使用 Mod（它是 decides 函数）
                NextIdx := SpawnPointIndex + 1
                if (NextIdx >= SpawnPoints.Length):
                    set SpawnPointIndex = 0
                else:
                    set SpawnPointIndex = NextIdx
                P
            else:
                vector3{Forward := 0.0, Left := 0.0, Up := 0.0}
    
    # 随机数生成 - 直接使用 GetRandomInt 而不是 random 对象
    
    # ==========================================
    # 波次完成
    # ==========================================
    
    # 完成当前波次
    CompleteWave<private>(WaveIdx:int):void =
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(wave_completed_event{
            WaveIndex := WaveIdx,
            EntitiesSpawned := CurrentEntityIndex
        })
        
        # 检查是否还有更多波次
        NextWave := WaveIdx + 1
        if (NextWave < Waves.Length):
            set CurrentState = spawner_state.WaveDelay
            # TODO: 实现波次延迟后自动开始下一波
            # 简化处理：直接开始
            StartWave(NextWave)
        else:
            CompleteAllWaves()
    
    # 完成所有波次
    CompleteAllWaves<private>():void =
        set CurrentState = spawner_state.Completed
        
        OwnerEntity := Self.Entity
        OwnerEntity.SendUp(all_waves_completed_event{
            TotalWaves := Waves.Length,
            TotalEntitiesSpawned := TotalSpawned
        })
    
    # ==========================================
    # 实体追踪
    # ==========================================
    
    # 注册活动实体
    RegisterEntity<public>(E:entity):void =
        set ActiveEntities += array{E}
    
    # 注销实体（实体销毁时调用）
    UnregisterEntity<public>(E:entity):void =
        var NewList:[]entity = array{}
        for (Ent : ActiveEntities):
            if (Ent <> E):
                set NewList += array{Ent}
        set ActiveEntities = NewList
    
    # 获取活动实体数量
    GetActiveCount<public>():int = ActiveEntities.Length
    
    # 获取总生成数量
    GetTotalSpawned<public>():int = TotalSpawned
    
    # 清除所有活动实体
    ClearActiveEntities<public>():void =
        # TODO: 销毁实体
        set ActiveEntities = array{}
    
    # ==========================================
    # 状态控制
    # ==========================================
    
    # 暂停生成
    Pause<public>():void =
        if (CurrentState = spawner_state.Spawning):
            set CurrentState = spawner_state.Idle
    
    # 恢复生成
    Resume<public>():void =
        if (CurrentState = spawner_state.Idle):
            set CurrentState = spawner_state.Spawning
    
    # 禁用生成器
    Disable<public>():void =
        set CurrentState = spawner_state.Disabled
    
    # 启用生成器
    Enable<public>():void =
        if (CurrentState = spawner_state.Disabled):
            set CurrentState = spawner_state.Idle
    
    # 重置生成器
    Reset<public>():void =
        set CurrentState = spawner_state.Idle
        set CurrentWaveIndex = 0
        set CurrentEntityIndex = 0
        set TotalSpawned = 0
        ClearActiveEntities()
    
    # 状态查询
    GetState<public>():spawner_state = CurrentState
    GetCurrentWave<public>():int = CurrentWaveIndex
    GetTotalWaves<public>():int = Waves.Length
    IsCompleted<public>():logic =
        if (CurrentState = spawner_state.Completed):
            true
        else:
            false
