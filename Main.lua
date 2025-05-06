--[[
📁 Projeto: AutoParry com GUI configurável
Estrutura de pastas:

📁 AutoParryProject
├── Main.lua           <- Ponto de entrada
├── GuiModule.lua      <- Interface Gráfica
└── ParryLogic.lua     <- Lógica do AutoParry
]]

-- Main.lua
-- Arquivo principal (ponto de entrada)
local Gui = loadstring(readfile("AutoParryProject/GuiModule.lua"))()
local ParryLogic = loadstring(readfile("AutoParryProject/ParryLogic.lua"))()

Gui:Init(ParryLogic)
ParryLogic:Start()

-- O script se manterá vivo pois RunService.Heartbeat está vinculado na lógica de parry
-- O Gui controla a visibilidade, unload, e configuração da transparência/cor do campo de detecção