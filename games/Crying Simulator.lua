-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Crying%20Simulator.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Crying Simulator",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoCry = false
getgenv().AutoWat = false

-- Funções
local function AutoCry()
  while getgenv().AutoCry == true do
    game:GetService("ReplicatedStorage").RemoteEvents.ManageCrying:FireServer(true)
    wait(0.01)
  end
end
local function AutoWat()
  while getgenv().AutoWat == true do
    game:GetService("ReplicatedStorage").RemoteEvents.Drink:FireServer()
    wait(0.01)
  end
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Cry",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoCry = Value
   	AutoCry()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Water",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoWat = Value
   	AutoWat()
   end,
})