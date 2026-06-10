# Scripts da Fase 3 — Mundo

Scripts Luau prontos para copiar para o Roblox Studio.

## Estrutura de destino no Roblox Studio

```
game/
├── ReplicatedStorage/Modules/Config/
│   └── AtlasConfig.lua          → AtlasConfig.lua
├── ServerScriptService/Modules/
│   ├── MapaManager.lua          → MapaManager.lua
│   └── SpawnSystem.lua          → SpawnSystem.lua (atualizado)
├── ServerScriptService/
│   └── ServerMain.lua           → ServerMain_Fase3_Patch.lua (trecho)
├── StarterPlayerScripts/
│   └── MinimapaController.lua   → MinimapaController.lua
└── Workspace/Mapas/
    └── (cada portal)/Portal.lua → PortalHandler.lua
```

## Como usar

1. Abra cada arquivo `.lua` desta pasta
2. No Roblox Studio, crie o ModuleScript/Script no caminho indicado
3. Cole o conteúdo do arquivo
4. Para `SpawnSystem.lua` e `ServerMain.lua`: substitua/atualize o código existente
