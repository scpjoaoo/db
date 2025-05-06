-- ParryLogic.lua
-- Responsável pela detecção da bola e execução do parry baseado em hitbox

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local ParryLogic = {}
ParryLogic.enabled = true
local hitboxRadius = 14 -- raio da esfera invisível
local connection

-- Cria esfera invisível
local hitbox = Instance.new("Part")
hitbox.Name = "AutoParryHitbox"
hitbox.Shape = Enum.PartType.Ball
hitbox.Size = Vector3.new(hitboxRadius * 2, hitboxRadius * 2, hitboxRadius * 2)
hitbox.Anchored = true
hitbox.CanCollide = false
hitbox.Transparency = 1
hitbox.Material = Enum.Material.ForceField
hitbox.Color = Color3.fromRGB(255, 100, 100)
hitbox.Parent = workspace

-- Atualiza transparência
function ParryLogic:SetTransparency(value)
    hitbox.Transparency = value
end

-- Detecta bolas com DeflectParticles
local function isBall(part)
    return part:IsA("BasePart") and part.Name == "Part" and part:FindFirstChild("DeflectParticles")
end

-- Simula tecla F
local function simulateParry()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
end

-- Verifica toque da esfera
local function checkHit()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if isBall(obj) and (obj.Position - hrp.Position).Magnitude <= hitboxRadius then
            simulateParry()
        end
    end
end

-- Loop principal
connection = RunService.Heartbeat:Connect(function()
    if not ParryLogic.enabled then return end

    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        hrp = player.Character.HumanoidRootPart
        hitbox.Position = hrp.Position
        checkHit()
    end
end)

-- Tecla G ativa/desativa
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.G then
        ParryLogic.enabled = not ParryLogic.enabled
    end
end)

-- Finalizador
function ParryLogic:Unload()
    if connection then connection:Disconnect() end
    if hitbox then hitbox:Destroy() end
end

return ParryLogic
