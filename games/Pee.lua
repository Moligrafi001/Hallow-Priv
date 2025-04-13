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
  Selected = "Nenhum"
}

-- Funções
local function RemoveTool()
  game:GetService("ReplicatedStorage").remote.removeTool:InvokeServer()
end
local function GetTool()
  if Settings.Selected == "Nenhum" then
    
  else
    game:GetService("ReplicatedStorage").remote.giveTool:InvokeServer(Settings.Selected)
  end
end

local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Get Items")
Dropdown = Menu:CreateDropdown({
   Name = "Selected Item",
   Options = {"Hammer", "PeeBottle", "Crowbar", "PeeBomb", "Gun"},
   CurrentOption = "Select an Item",
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Selected = Options[1]
   end,
})
Button = Menu:CreateButton({
   Name = "Get Item",
   Callback = function()
   	GetTool()
   end,
})
Button = Menu:CreateButton({
   Name = "Remove Item",
   Callback = function()
   	RemoveTool()
   end,
})