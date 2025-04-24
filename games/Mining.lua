local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Mining",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Valores
getgenv().OresESP = false

-- Locais
local Settings = {
  Ores = {
    Selecteds = {},
    Names = { "OreMesh", "CrystallineMetalOre", "GemBlockMesh", "CubicBlockMetal", "ShaleMetalBlock" }
  },
  Teleport = {
    Plot = "Select a Plot",
    Player = "Select a Player"
  }
}
local eu = game:GetService("Players").LocalPlayer

-- Funções
local function OresESP()
  while getgenv().OresESP and task.wait(0.1) do
    for _, ore in pairs(workspace.SpawnedBlocks:GetChildren()) do
      if ore:IsA("MeshPart") then
        if ore:FindFirstChild("Highlight") then
          if table.find(Settings.Ores.Selecteds, ore.Name) then
            ore.Highlight.Enabled = true
          else
            ore.Highlight.Enabled = false
          end
        else
          if table.find(Settings.Ores.Selecteds, ore.Name) then
            local highlight = Instance.new("Highlight")
						highlight.FillTransparency = 0.6
						highlight.Adornee = ore
						highlight.Parent = ore
						
            local Ore = Settings.Ores.Names
            if ore.Name == Ore[1] then
  						highlight.FillColor, highlight.OutlineColor = Color3.fromRGB(171, 237, 85), Color3.fromRGB(171, 237, 85)
  					else
  						highlight.FillColor, highlight.OutlineColor = Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)
						end
          end
        end
      end
    end
  end
end
local function Teleport(place)
  if place == "Home" then
    for _, p in pairs(workspace.Plots:GetChildren()) do
      if p:GetAttribute("OwnerId") == eu.UserId then
        eu.Character.HumanoidRootPart.CFrame = (p.WorldPivot * CFrame.new(0, 9, 0))
      end
    end
  elseif place == "Player" then
    eu.Character.HumanoidRootPart.CFrame = game:GetService("Players")[Settings.Teleport.Player].Character.HumanoidRootPart.CFrame
  elseif place == "Plot" then
    eu.Character.HumanoidRootPart.CFrame = (workspace.Plots[Settings.Teleport.Plot].WorldPivot * CFrame.new(0, 9, 0))
  end
end
local function ReturnThing(type)
  local Names = {}
  
  if type == "Plots" then
    for _, p in pairs(workspace.Plots:GetChildren()) do
      table.insert(Names, p.Name)
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

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Dropdown = Menu:CreateDropdown({
  Name = "Selected Ores",
  Options = Settings.Ores.Names,
  CurrentOption = { "Nothing Selected" },
  MultipleOptions = true,
  Callback = function(Options)
    local filteredOptions = {}
    for _, option in ipairs(Options) do
      if option ~= "Nothing Selected" then
        table.insert(filteredOptions, option)
      end
    end
    Settings.Ores.Selecteds = filteredOptions
  end
})
Toggle = Menu:CreateToggle({
  Name = "Triggerbot",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().OresESP = Value
    OresESP()
  end
})

-- Teleport
local TPsTab = Window:CreateTab("Teleport", "shell")
Section = TPsTab:CreateSection("Helpful Tele.")
Button = TPsTab:CreateButton({
  Name = "Teleport Home",
  Callback = function()
    Teleport("Home")
  end
})
Section = TPsTab:CreateSection("Teleport to Plot")
MirDrop = TPsTab:CreateDropdown({
  Name = "Selected Plot",
  Options = ReturnThing("Plots"),
  CurrentOption = {Settings.Teleport.Plot},
  MultipleOptions = false,
  Callback = function(Options)
    Settings.Teleport.Plot = Options[1]
  end
})
Button = TPsTab:CreateButton({
  Name = "Teleport to Plot",
  Callback = function()
    Teleport("Plot")
  end
})
Section = TPsTab:CreateSection("Teleport to Player")
PlayDrop = TPsTab:CreateDropdown({
  Name = "Selected Player",
  Options = ReturnThing("Players"),
  CurrentOption = {Settings.Teleport.Player},
  MultipleOptions = false,
  Callback = function(Options)
    Settings.Teleport.Player = Options[1]
  end
})
Button = TPsTab:CreateButton({
  Name = "Teleport to Player",
  Callback = function()
    Teleport("Player")
  end
})
Button = TPsTab:CreateButton({
  Name = "Update List",
  Callback = function()
    PlayDrop:Refresh(ReturnThing("Players"))
    Settings.Teleport.Player = "Select a Player"
    PlayDrop:Set({Settings.Teleport.Player})
    Rayfield:Notify({
      Title = "Done!",
      Content = "Updated the players list!",
      Duration = 3,
      Image = 17091459839
    })
  end
})