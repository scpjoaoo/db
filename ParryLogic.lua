-- ParryLogic.lua
local ParryLogic = {}

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local active = true
local sphere = nil
local player = nil
local radius = 15
local transparency = 1
local trackedBall = nil

function ParryLogic:Init(localPlayer, initialTransparency)
    player = localPlayer
    transparency = initialTransparency or 1
    self:CreateSphere()
    self:MonitorBall()
    self:BindToggleKey()
end

function ParryLogic:CreateSphere()
    if sphere then sphere:Destroy() end
    sphere = Instance.new("Part")
    sphere.Anchored = true
    sphere.CanCollide = false
    sphere.Shape = Enum.PartType.Ball
    sphere.Material = Enum.Material.ForceField
    sphere.Color = Color3.fromRGB(0, 255, 255)
    sphere.Transparency = transparency
    sphere.Size = Vector3.new(radius * 2, radius * 2, radius * 2)
    sphere.Name = "ParryHitbox"
    sphere.Parent = workspace
end

function ParryLogic:MonitorBall()
    RunService.Heartbeat:Connect(function()
        if not active or not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end

        sphere.CFrame = player.Character.HumanoidRootPart.CFrame

        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name == "Part" and obj:FindFirstChild("DeflectParticles") then
                if (obj.Position - sphere.Position).Magnitude <= radius then
                    self:TriggerParry()
                end
            end
        end
    end)
end

function ParryLogic:TriggerParry()
    keypress(Enum.KeyCode.F)
    wait()
    keyrelease(Enum.KeyCode.F)
end

function ParryLogic:SetTransparency(value)
    transparency = value
    if sphere then
        sphere.Transparency = transparency
    end
end

function ParryLogic:SetEnabled(state)
    active = state
end

function ParryLogic:IsEnabled()
    return active
end

function ParryLogic:BindToggleKey()
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.G then
            self:SetEnabled(not self:IsEnabled())
        end
    end)
end

return ParryLogic
