# PROMPT — Implementar Placeholders de Mobs no Roblox Studio

## Contexto
O projeto ROBR é um MMORPG no Roblox. A Fase 3 (Mundo) está concluída — mapas, portais, minimapa e remotes estão todos implementados. Agora precisamos criar os modelos 3D placeholder dos 15 mobs MVP para que o sistema de spawn funcione end-to-end.

> [!WARNING]
> **ATENÇÃO CONTRA REGRESSÃO DE DESIGN:**
> O `AISystem.lua` existente no Roblox Studio (`ServerScriptService/Modules/AISystem`) possui mecânicas avançadas da Fase 2 (frenesi do Saci, invisibilidade, teletransporte para dano verdadeiro por trás, redemoinho sombrio de partículas e integração com o DamageCalculator). 
> **NÃO substitua o AISystem por completo** por versões simplificadas. Em vez disso, adapte a função `SpawnPhysicalModel` do `AISystem` para tentar clonar os placeholders gerados pelo `MobPlaceholderFactory`, mantendo o código procedimental existente como fallback de segurança.

---

## O que fazer

### Passo 1: Criar MobPlaceholderFactory em ReplicatedStorage

1. No Roblox Studio, crie um **ModuleScript** em `ReplicatedStorage` chamado `MobPlaceholderFactory`.
2. Copie o conteúdo do arquivo local [MobPlaceholderFactory.lua](file:///c:/Users/bikaa/OneDrive/Projeto%20Vibe%20Codig/ROBR/Scripts/MobPlaceholderFactory.lua) para esse ModuleScript.
3. Este script gera os 15 modelos placeholders com base na raridade (verde = comum, azul = incomum, roxo = raro, laranja = elite, vermelho = chefe) e elementos.

### Passo 2: Adaptar SpawnPhysicalModel no AISystem

1. Abra o script `game.ServerScriptService.Modules.AISystem` no Roblox Studio.
2. Localize a função `AISystem.SpawnPhysicalModel(mob)`.
3. Substitua a inicialização da variável `model` e do `humanoid` para verificar se existe a pasta `ReplicatedStorage.Mobs` com os templates clonáveis.
4. Use a implementação integrada a seguir, que tenta clonar do `ReplicatedStorage/Mobs/` e, caso não ache, executa a criação procedimental legada (mantendo compatibilidade e as habilidades intactas):

```lua
function AISystem.SpawnPhysicalModel(mob)
    if mob.model and mob.model.Parent then return mob.model end

    local model
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local mobsFolder = ReplicatedStorage:FindFirstChild("Mobs")
    local template = mobsFolder and mobsFolder:FindFirstChild(mob.configId)

    if template then
        -- 1. Clonar o placeholder do ReplicatedStorage
        model = template:Clone()
        model.Name = mob.nome
        model:SetAttribute("MobId", mob.id)

        -- Posicionar no spawn correto com elevação segura
        if model.PrimaryPart then
            model:PivotTo(CFrame.new(mob.posicao + Vector3.new(0, 1.5, 0)))
        end

        -- Configurar propriedades de vida do Humanoid
        local humanoid = model:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = mob.hpMax
            humanoid.Health = mob.hp
            humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        end
    else
        -- 2. Fallback procedimental legado (se o template não foi gerado)
        model = Instance.new("Model")
        model.Name = mob.nome
        model:SetAttribute("MobId", mob.id)

        local hrp = Instance.new("Part")
        hrp.Name = "HumanoidRootPart"
        hrp.Size = Vector3.new(2, 2, 2)
        hrp.Transparency = 1
        hrp.Anchored = false
        hrp.CanCollide = true
        hrp.CFrame = CFrame.new(mob.posicao + Vector3.new(0, 2, 0))
        hrp.Parent = model
        model.PrimaryPart = hrp

        local humanoid = Instance.new("Humanoid")
        humanoid.MaxHealth = mob.hpMax
        humanoid.Health = mob.hp
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
        humanoid.Parent = model

        local bodyColor = Color3.fromRGB(120, 120, 120)
        local element = mob.elemento or "neutro"
        if element == "agua" then
            bodyColor = Color3.fromRGB(0, 120, 255)
        elseif element == "fogo" then
            bodyColor = Color3.fromRGB(255, 60, 0)
        elseif element == "terra" then
            bodyColor = Color3.fromRGB(90, 180, 90)
        elseif element == "vento" or element == "vento corrompido" then
            bodyColor = Color3.fromRGB(200, 200, 250)
        elseif element == "sombra" then
            bodyColor = Color3.fromRGB(40, 20, 60)
        end

        -- Criação procedimental dos partes visuais para Mobs Especiais (Saci, Cururu, Capivara)
        if mob.configId == "MOB_006" then -- Saci Sombrio
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(1.8, 1.8, 0.9)
            torso.Color = Color3.fromRGB(50, 20, 70)
            torso.Parent = model
            
            local weldTorso = Instance.new("WeldConstraint")
            weldTorso.Part0 = hrp
            weldTorso.Part1 = torso
            weldTorso.Parent = hrp
            torso.Position = hrp.Position

            local head = Instance.new("Part")
            head.Name = "Head"
            head.Size = Vector3.new(1.2, 1.2, 1.2)
            head.Color = Color3.fromRGB(120, 80, 50)
            head.Parent = model
            
            local weldHead = Instance.new("WeldConstraint")
            weldHead.Part0 = torso
            weldHead.Part1 = head
            weldHead.Parent = torso
            head.Position = torso.Position + Vector3.new(0, 1.5, 0)

            local hat = Instance.new("Part")
            hat.Name = "Gorro"
            hat.Size = Vector3.new(1.2, 0.8, 1.2)
            hat.Color = Color3.fromRGB(150, 0, 50)
            hat.Parent = model
            
            local weldHat = Instance.new("WeldConstraint")
            weldHat.Part0 = head
            weldHat.Part1 = hat
            weldHat.Parent = head
            hat.Position = head.Position + Vector3.new(0, 1.0, 0)

            local leg = Instance.new("Part")
            leg.Name = "Perna"
            leg.Size = Vector3.new(0.6, 1.8, 0.6)
            leg.Color = Color3.fromRGB(120, 80, 50)
            leg.Parent = model

            local weldLeg = Instance.new("WeldConstraint")
            weldLeg.Part0 = torso
            weldLeg.Part1 = leg
            weldLeg.Parent = torso
            leg.Position = torso.Position - Vector3.new(0, 1.8, 0)
        elseif mob.configId == "MOB_001" then -- Sapo Cururu
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(2.2, 1.2, 2.2)
            torso.Color = Color3.fromRGB(34, 139, 34)
            torso.Parent = model
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = torso
            weld.Parent = hrp
            torso.Position = hrp.Position

            local eye1 = Instance.new("Part")
            eye1.Size = Vector3.new(0.4, 0.4, 0.4)
            eye1.Color = Color3.fromRGB(255, 255, 255)
            eye1.Parent = model
            local w1 = Instance.new("WeldConstraint")
            w1.Part0 = torso
            w1.Part1 = eye1
            w1.Parent = torso
            eye1.Position = torso.Position + Vector3.new(0.6, 0.6, 0.8)

            local eye2 = Instance.new("Part")
            eye2.Size = Vector3.new(0.4, 0.4, 0.4)
            eye2.Color = Color3.fromRGB(255, 255, 255)
            eye2.Parent = model
            local w2 = Instance.new("WeldConstraint")
            w2.Part0 = torso
            w2.Part1 = eye2
            w2.Parent = torso
            eye2.Position = torso.Position + Vector3.new(-0.6, 0.6, 0.8)
        elseif mob.configId == "MOB_015" then -- Capivara
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(1.8, 1.6, 2.8)
            torso.Color = Color3.fromRGB(139, 69, 19)
            torso.Parent = model
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = torso
            weld.Parent = hrp
            torso.Position = hrp.Position

            local head = Instance.new("Part")
            head.Name = "Head"
            head.Size = Vector3.new(1.2, 1.2, 1.4)
            head.Color = Color3.fromRGB(100, 50, 10)
            head.Parent = model
            local wHead = Instance.new("WeldConstraint")
            wHead.Part0 = torso
            wHead.Part1 = head
            wHead.Parent = torso
            head.Position = torso.Position + Vector3.new(0, 0.8, 1.2)
        else
            -- Bloco genérico para os demais
            local torso = Instance.new("Part")
            torso.Name = "Torso"
            torso.Size = Vector3.new(2, 3, 2)
            torso.Color = bodyColor
            torso.Parent = model
            
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = hrp
            weld.Part1 = torso
            weld.Parent = hrp
            torso.Position = hrp.Position
        end

        -- Desabilitar colisão interna
        for _, part in ipairs(model:GetChildren()) do
            if part:IsA("BasePart") and part ~= hrp then
                part.CanCollide = false
                part.Massless = true
            end
        end
    end

    -- Vincular na pasta do respectivo mapa
    local mapName = mob.mapa or "Mapa1_YbiráPuera"
    local mapFolder = workspace:FindFirstChild("Mapas") and workspace.Mapas:FindFirstChild(mapName)
    if mapFolder then
        model.Parent = mapFolder
    else
        model.Parent = workspace
    end

    mob.model = model
    return model
end
```

### Passo 3: Executar o CreateAll() para gerar os templates

1. No Roblox Studio, abra a **Command Bar** (View -> Command Bar).
2. Execute:
   ```lua
   require(game.ReplicatedStorage.MobPlaceholderFactory).CreateAll()
   ```
3. Verifique se a pasta `game.ReplicatedStorage.Mobs` foi criada contendo os 15 modelos placeholders (`MOB_001` até `MOB_016`, exceto `MOB_010`).
4. Cada modelo gerado deve possuir:
   - Parts coloridos correspondentes à raridade do monstro.
   - Um `Humanoid` ativo.
   - O `HumanoidRootPart` como `PrimaryPart`.
   - Um `BillboardGui` com o nome do mob exibido na cabeça.
   - Atributos configurados: `MobId`, `Nome`, `Nivel`, `Elemento` e `Raridade`.

### Passo 4: Testar a Integração no Play

1. Clique em **Play** (F5) no Studio.
2. Certifique-se de que os logs de inicialização no console não reportam erros:
   - `[MobPlaceholderFactory] Criado: MOB_001 (Sapo Cururu)` ...
   - `[SpawnSystem] 37 mobs spawned em 6 mapas.`
3. Verifique se os monstros nasceram em suas respectivas pastas geográficas no Workspace.
4. Aproxime-se dos monstros para testar o sistema de inteligência artificial (patrulha, perseguição com aggro, ataques e leashing).
5. Mate um monstro e confirme se após ~30 segundos ele ressurge corretamente na sua zona de spawn.

---

## 📁 Arquivos de Referência (Workspace local)

*   `MobPlaceholderFactory.lua` -> [MobPlaceholderFactory.lua](file:///c:/Users/bikaa/OneDrive/Projeto%20Vibe%20Codig/ROBR/Scripts/MobPlaceholderFactory.lua)
*   `AISystem.lua` -> [AISystem.lua](file:///c:/Users/bikaa/OneDrive/Projeto%20Vibe%20Codig/ROBR/Scripts/AISystem.lua)
*   `SpawnSystem.lua` -> [SpawnSystem.lua](file:///c:/Users/bikaa/OneDrive/Projeto%20Vibe%20Codig/ROBR/Scripts/Fase3/SpawnSystem.lua)
