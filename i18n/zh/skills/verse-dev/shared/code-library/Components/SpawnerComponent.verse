# SpawnerComponent - 生成器组件
# 版本: 1.0
# 添加时间: 2025-12-27
# 来源: REQ-009 (循环迭代模式)

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Temporary/SpatialMath }

# 生成器状态
spawner_state<public> := enum:
    Idle
    Spawning
    WaveDelay
    Completed
    Disabled

# 实体生成事件
entity_spawned_event<public> := class<concrete>(scene_event):
    var SpawnedEntity<public>:?entity = false
    var SpawnPosition<public>:vector3 = vector3{X := 0.0, Y := 0.0, Z := 0.0}
    var WaveIndex<public>:int = 0
    var EntityIndex<public>:int = 0

# 波次开始事件
wave_started_event<public> := class<concrete>(scene_event):
    var WaveIndex<public>:int = 0
    var TotalEntities<public>:int = 0

# 波次完成事件
wave_completed_event<public> := class<concrete>(scene_event):
    var WaveIndex<public>:int = 0
    var EntitiesSpawned<public>:int = 0

# 所有波次完成事件
all_waves_completed_event<public> := class<concrete>(scene_event):
    var TotalWaves<public>:int = 0
    var TotalEntitiesSpawned<public>:int = 0

# 波次配置
wave_config<public> := struct:
    EntityCount<public>:int = 5
    SpawnInterval<public>:float = 1.0
    WaveDelay<public>:float = 5.0

# 生成器组件
spawner_component<public> := class(component):
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
        if CurrentState = spawner_state.Disabled:
            return
        
        if Waves.Length = 0:
            # 使用默认配置创建单波次
            AddSimpleWave(DefaultSpawnCount)
        
        set CurrentWaveIndex = 0
        set CurrentEntityIndex = 0
        set CurrentState = spawner_state.Spawning
        StartWave(0)
    
    # 开始指定波次
    StartWave<private>(WaveIdx:int):void =
        if WaveIdx >= Waves.Length:
            CompleteAllWaves()
            return
        
        set CurrentWaveIndex = WaveIdx
        set CurrentEntityIndex = 0
        set CurrentState = spawner_state.Spawning
        
        if (W := Waves[WaveIdx]):
            if (O := GetOwner()):
                O.SendUp(wave_started_event{
                    WaveIndex := WaveIdx,
                    TotalEntities := W.EntityCount
                })
    
    # 更新生成（应在tick中调用）
    UpdateSpawning<public>(CurrentTime:float):void =
        if CurrentState <> spawner_state.Spawning:
            return
        
        if CurrentWaveIndex >= Waves.Length:
            return
        
        if (Wave := Waves[CurrentWaveIndex]):
            # 检查是否超出活动数量限制
            if ActiveEntities.Length >= MaxActiveEntities:
                return
            
            # 检查生成间隔
            if CurrentTime - LastSpawnTime < Wave.SpawnInterval:
                return
            
            # 检查波次是否完成
            if CurrentEntityIndex >= Wave.EntityCount:
                CompleteWave(CurrentWaveIndex)
                return
            
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
        if (O := GetOwner()):
            O.SendUp(entity_spawned_event{
                SpawnedEntity := false,  # TODO: 填充实际实体
                SpawnPosition := SpawnPos,
                WaveIndex := CurrentWaveIndex,
                EntityIndex := CurrentEntityIndex
            })
        
        return false
    
    # 获取下一个生成点
    GetNextSpawnPoint<private>():vector3 =
        if SpawnPoints.Length = 0:
            return vector3{X := 0.0, Y := 0.0, Z := 0.0}
        
        if RandomizeSpawnPoint:
            RandomIdx := GetRandomInt(0, SpawnPoints.Length - 1)
            if (P := SpawnPoints[RandomIdx]):
                return P
        else:
            if (P := SpawnPoints[SpawnPointIndex]):
                set SpawnPointIndex = (SpawnPointIndex + 1) % SpawnPoints.Length
                return P
        
        return vector3{X := 0.0, Y := 0.0, Z := 0.0}
    
    # ==========================================
    # 波次完成
    # ==========================================
    
    # 完成当前波次
    CompleteWave<private>(WaveIdx:int):void =
        if (O := GetOwner()):
            O.SendUp(wave_completed_event{
                WaveIndex := WaveIdx,
                EntitiesSpawned := CurrentEntityIndex
            })
        
        # 检查是否还有更多波次
        NextWave := WaveIdx + 1
        if NextWave < Waves.Length:
            set CurrentState = spawner_state.WaveDelay
            # TODO: 实现波次延迟后自动开始下一波
            # 简化处理：直接开始
            StartWave(NextWave)
        else:
            CompleteAllWaves()
    
    # 完成所有波次
    CompleteAllWaves<private>():void =
        set CurrentState = spawner_state.Completed
        
        if (O := GetOwner()):
            O.SendUp(all_waves_completed_event{
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
        NewList:[]entity = array{}
        for (Ent in ActiveEntities):
            if Ent <> E:
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
        if CurrentState = spawner_state.Spawning:
            set CurrentState = spawner_state.Idle
    
    # 恢复生成
    Resume<public>():void =
        if CurrentState = spawner_state.Idle:
            set CurrentState = spawner_state.Spawning
    
    # 禁用生成器
    Disable<public>():void =
        set CurrentState = spawner_state.Disabled
    
    # 启用生成器
    Enable<public>():void =
        if CurrentState = spawner_state.Disabled:
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
    IsCompleted<public>():logic = CurrentState = spawner_state.Completed
    
    # ==========================================
    # 工具函数
    # ==========================================
    
    GetRandomInt<private>(Min:int, Max:int):int =
        # TODO: 实际随机实现
        return Min
