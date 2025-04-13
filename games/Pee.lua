local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | 🚽 NEED MORE PEE 🚽",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Locais
local Settings = {
  Free = "Hammer",
  VIP = "PeeC4"
}

-- Funções
local function RemoveTool()
  game:GetService("ReplicatedStorage").remote.removeTool:InvokeServer()
end
local function GetTool(type)
  if type == "Free" then
    game:GetService("ReplicatedStorage").remote.giveTool:InvokeServer(Settings.Free)
  elseif type == "VIP" then
    game:GetService("ReplicatedStorage").remote.giveTool:InvokeServer(Settings.VIP)
  end
end

local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Get Free Items")
Dropdown = Menu:CreateDropdown({
   Name = "Selected Item",
   Options = {"Hammer", "PeeBottle", "Crowbar", "PeeBomb", "Gun"},
   CurrentOption = Settings.Free,
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Free = Options[1]
   end,
})
Button = Menu:CreateButton({
   Name = "Get Item",
   Callback = function()
   	GetTool("Free")
   end,
})
Button = Menu:CreateButton({
   Name = "Remove Item",
   Callback = function()
   	RemoveTool()
   end,
})
Section = Menu:CreateSection("Get VIP Items")
Dropdown = Menu:CreateDropdown({
   Name = "Selected Item",
   Options = {"PeeAbility", "PeeC4", "PaintBucket", "PeeGun"},
   CurrentOption = Settings.VIP,
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.VIP = Options[1]
   end,
})
Button = Menu:CreateButton({
   Name = "Get Item",
   Callback = function()
   	GetTool("VIP")
   end,
})
Button = Menu:CreateButton({
   Name = "Remove Item",
   Callback = function()
   	RemoveTool()
   end,
})