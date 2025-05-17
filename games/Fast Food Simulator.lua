local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Fast Food Simulator",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})


-- Global Values
getgenv().AutoDirty = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function AutoDirty()
  while getgenv().AutoDirty and task.wait(1) do
    if not GetAttribute("Connected") then
    end
  end
end