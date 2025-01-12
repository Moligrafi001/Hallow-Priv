-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Prib/main/Key%20System.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Key System",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})

local Button = Credits:CreateButton({
   Name = "Get Key",
   Callback = function()
   	GetKey()
   end,
})