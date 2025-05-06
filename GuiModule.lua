-- GuiModule.lua
local GuiModule = {}

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local gui, transparencyValueLabel, toggleButton, transparency = nil, nil, nil, 1

function GuiModule:Init(parryLogic)
    gui = Instance.new("ScreenGui")
    gui.Name = "AutoParryGui"
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 160)
    frame.Position = UDim2.new(0.5, -150, 0.2, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Text = "⚙️ AutoParry"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    title.Parent = frame

    toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(1, -20, 0, 30)
    toggleButton.Position = UDim2.new(0, 10, 0, 40)
    toggleButton.Font = Enum.Font.Gotham
    toggleButton.TextSize = 14
    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggleButton.TextColor3 = Color3.new(1, 1, 1)
    toggleButton.Text = "Parry Ativado"
    toggleButton.Parent = frame

    toggleButton.MouseButton1Click:Connect(function()
        parryLogic:SetEnabled(not parryLogic:IsEnabled())
        GuiModule:UpdateToggleButton(parryLogic:IsEnabled())
    end)

    transparencyValueLabel = Instance.new("TextLabel")
    transparencyValueLabel.Text = "Transparência: 1.0"
    transparencyValueLabel.Font = Enum.Font.Gotham
    transparencyValueLabel.TextSize = 14
    transparencyValueLabel.TextColor3 = Color3.new(1, 1, 1)
    transparencyValueLabel.Size = UDim2.new(1, -20, 0, 20)
    transparencyValueLabel.Position = UDim2.new(0, 10, 0, 80)
    transparencyValueLabel.BackgroundTransparency = 1
    transparencyValueLabel.Parent = frame

    local decreaseBtn = Instance.new("TextButton")
    decreaseBtn.Size = UDim2.new(1, -20, 0, 30)
    decreaseBtn.Position = UDim2.new(0, 10, 0, 110)
    decreaseBtn.Font = Enum.Font.Gotham
    decreaseBtn.TextSize = 14
    decreaseBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    decreaseBtn.TextColor3 = Color3.new(1, 1, 1)
    decreaseBtn.Text = "Diminuir Transparência"
    decreaseBtn.Parent = frame

    decreaseBtn.MouseButton1Click:Connect(function()
        transparency = math.max(0, transparency - 0.1)
        GuiModule:UpdateTransparency(transparency)
        parryLogic:SetTransparency(transparency)
    end)

    GuiModule:UpdateToggleButton(true)
    GuiModule:UpdateTransparency(transparency)
    parryLogic:Init(LocalPlayer, transparency)
end

function GuiModule:UpdateToggleButton(state)
    toggleButton.Text = state and "Parry Ativado" or "Parry Desativado"
    toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end

function GuiModule:UpdateTransparency(value)
    transparencyValueLabel.Text = string.format("Transparência: %.1f", value)
end

return GuiModule
