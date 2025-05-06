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
local Gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/scpjoaoo/db/refs/heads/main/GuiModule.lua"))()
local ParryLogic = loadstring(game:HttpGet("https://raw.githubusercontent.com/scpjoaoo/db/refs/heads/main/ParryLogic.lua"))()
GuiModule:Init(ParryLogic)

-- O script se manterá vivo pois RunService.Heartbeat está vinculado na lógica de parry
-- O Gui controla a visibilidade, unload, e configuração da transparência/cor do campo de detecção
