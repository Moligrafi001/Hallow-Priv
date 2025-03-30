local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Pilgrammed",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoChest = false

-- Locais
local Settings = {
  Mirror = "Select a Mirror",
  Player = "Select a Player",
  IsBusy = false,
  Position = ""
}
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function ReturnThing(type)
  local Names = {}
  
  if type == "Mirrors" then
    for _, mirror in pairs(workspace.Mirrors:GetChildren()) do
      table.insert(Names, mirror.Name)
    end
  elseif type == "Players" then
    for _, player in pairs(game.Players:GetPlayers()) do
      if player ~= eu then
        table.insert(Names, player.Name)
      end
    end
  end
  
  return Names
end
local function Teleport(type)
  pcall(function()
    if type == "Player" then
      if Settings.Player == "Select a Player" then
        Rayfield:Notify({
          Title = "Nothing is selected!",
          Content = "Select a player to teleport.",
          Duration = 3,
          Image = 17091459839,
        })
      else
        for _, player in pairs(game.Players:GetPlayers()) do
          if player.Name == Settings.Player then
            eu.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
          end
        end
      end
    elseif type == "Mirror" then
      if Settings.Mirror == "Select a Mirror" then
        Rayfield:Notify({
          Title = "Nothing is selected!",
          Content = "Select a mirror to teleport.",
          Duration = 3,
          Image = 17091459839,
        })
      else
        for _, mirror in pairs(workspace.Mirrors:GetChildren()) do
          if mirror:IsA("Model") and mirror.Name == Settings.Mirror then
            eu.Character.HumanoidRootPart.CFrame = mirror.WorldPivot or mirror.WorldPivot.Position
          end
        end
      end
    end
  end)
end
local function AutoChest()
  Settings.Position = eu.Character.HumanoidRootPart.CFrame
  while getgenv().AutoChest and not Settings.IsBusy and task.wait() do
    pcall(function()
-- workspace.Chests.Forest.Root
-- workspace.Chests.Forest.ProximityPrompt
-- workspace.GoldChests.Viking.Root.ProximityPrompt
      for _, vip in pairs(workspace.GoldChests:GetChildren()) do
        if vip:IsA("Model") and not Settings.IsBusy then
          Settings.IsBusy = true
          Settings.Position = eu.Character.HumanoidRootPart.CFrame
          
          eu.Character.HumanoidRootPart.CFrame = vip.WorldPivot or vip.WorldPivot.Position
          task.wait(0.3)
          fireproximityprompt(vip.Root.ProximityPrompt)
          task.wait(0.1)
          eu.Character.HumanoidRootPart.CFrame = Settings.Position
          task.wait(0.1)
          Settings.IsBusy = false
        end
      end
    end)
  end
  if not getgenv().AutoChest then
    pcall(function()
      eu.Character.HumanoidRootPart.CFrame = Settings.Position
    end)
  end
end

-- Teleport
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle =  Menu:CreateToggle({
   Name = "Auto Collect Chests",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoChest = Value
   	AutoChest()
   end,
})

-- Teleport
local TPsTab = Window:CreateTab("Teleport", "shell")
Section = TPsTab:CreateSection("Teleport to Mirror")
-- Button = TPsTab:CreateButton({
--    Name = "Unlock All Mirrors",
--    Callback = function()
--    	for _, mirror in pairs(ReturnThing("Mirrors")) do
--       game:GetService("ReplicatedStorage").Remotes.Mirror:FireServer(mirror)
--    	end
--    	Rayfield:Notify({
--       Title = "Done!",
--       Content = "Unlocked all the mirrors!",
--       Duration = 3,
--       Image = 17091459839,
--     })
--    end,
-- })
MirDrop = TPsTab:CreateDropdown({
   Name = "Selected Mirror",
   Options = ReturnThing("Mirrors"),
   CurrentOption = {Settings.Mirror},
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Mirror = Options[1]
   end,
})
Button = TPsTab:CreateButton({
   Name = "Teleport to Mirror",
   Callback = function()
   	Teleport("Mirror")
   end,
})
Button = TPsTab:CreateButton({
   Name = "Update List",
   Callback = function()
   	MirDrop:Refresh(ReturnThing("Mirrors"))
   	Settings.Mirror = "Select a Mirror"
   	MirDrop:Set({Settings.Mirror})
   	Rayfield:Notify({
      Title = "Done!",
      Content = "Updated the mirrors list!",
      Duration = 3,
      Image = 17091459839,
    })
   end,
})
Section = TPsTab:CreateSection("Teleport to Player")
PlayDrop = TPsTab:CreateDropdown({
   Name = "Selected Player",
   Options = ReturnThing("Players"),
   CurrentOption = {Settings.Player},
   MultipleOptions = false,
   Callback = function(Options)
   		Settings.Player = Options[1]
   end,
})
Button = TPsTab:CreateButton({
   Name = "Teleport to Player",
   Callback = function()
   	Teleport("Player")
   end,
})
Button = TPsTab:CreateButton({
   Name = "Update List",
   Callback = function()
   	PlayDrop:Refresh(ReturnThing("Players"))
   	Settings.Player = "Select a Player"
   	PlayDrop:Set({Settings.Player})
   	Rayfield:Notify({
      Title = "Done!",
      Content = "Updated the players list!",
      Duration = 3,
      Image = 17091459839,
    })
   end,
})