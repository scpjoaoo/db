-- GuiModule.lua
-- Responsável pela interface gráfica e configurações visuais

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local GuiModule = {}

function GuiModule:Init(parryLogic)
    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "AutoParryUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")

    -- Janela principal
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 240, 0, 180)
    frame.Position = UDim2.new(0.02, 0, 0.2, 0)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Draggable = true
    frame.Active = true
    frame.Name = "MainFrame"
    frame.Parent = gui

    -- Título
    local title = Instance.new("TextLabel")
    title.Text = "⚙️ AutoParry"
    title.Size = UDim2.new(1, 0, 0, 28)
    title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    -- Toggle AutoParry
    local toggle = Instance.new("TextButton")
    toggle.Text = "🟢 Parry Ativado"
    toggle.Size = UDim2.new(1, -20, 0, 30)
    toggle.Position = UDim2.new(0, 10, 0, 40)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.Gotham
    toggle.TextSize = 13
    toggle.Parent = frame

    toggle.MouseButton1Click:Connect(function()
        parryLogic.enabled = not parryLogic.enabled
        toggle.Text = parryLogic.enabled and "🟢 Parry Ativado" or "🔴 Parry Desativado"
    end)

    -- Slider transparência (simples com botão)
    local transparencyLabel = Instance.new("TextLabel")
    transparencyLabel.Text = "Transparência: 1.0"
    transparencyLabel.Position = UDim2.new(0, 10, 0, 80)
    transparencyLabel.Size = UDim2.new(1, -20, 0, 20)
    transparencyLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    transparencyLabel.BackgroundTransparency = 1
    transparencyLabel.Font = Enum.Font.Gotham
    transparencyLabel.TextSize = 12
    transparencyLabel.Parent = frame

    local transVal = 1
    local stepBtn = Instance.new("TextButton")
    stepBtn.Text = "Diminuir Transparência"
    stepBtn.Size = UDim2.new(1, -20, 0, 26)
    stepBtn.Position = UDim2.new(0, 10, 0, 105)
    stepBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    stepBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stepBtn.Font = Enum.Font.Gotham
    stepBtn.TextSize = 12
    stepBtn.Parent = frame

    stepBtn.MouseButton1Click:Connect(function()
        transVal -= 0.1
        if transVal < 0 then transVal = 1 end
        transparencyLabel.Text = string.format("Transparência: %.1f", transVal)
        parryLogic:SetTransparency(transVal)
    end)

    -- Botão fechar
    local close = Instance.new("TextButton")
    close.Text = "✖"
    close.Size = UDim2.new(0, 28, 0, 28)
    close.Position = UDim2.new(1, -28, 0, 0)
    close.BackgroundColor3 = Color3.fromRGB(60, 0, 0)
    close.TextColor3 = Color3.fromRGB(255, 255, 255)
    close.Font = Enum.Font.GothamBold
    close.TextSize = 14
    close.ZIndex = 2
    close.Parent = frame

    close.MouseButton1Click:Connect(function()
        gui:Destroy()
        parryLogic:Unload()
    end)
end

return GuiModule
