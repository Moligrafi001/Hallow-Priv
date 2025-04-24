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
  Selected = {},
  Names = { "OreMesh", "CrystallineMetalOre", "GemBlockMesh", "CubicBlockMetal", "ShaleMetalBlock" }
}

-- Funções
local function OresESP()
  while getgenv().OresESP and task.wait(0.1) do
    for _, ore in pairs(workspace.SpawnedBlocks:GetChildren()) do
      if ore:IsA("MeshPart") then
        if ore:FindFirstChild("Highlight") then
          if table.find(Settings.Selected, ore.Name) then
            ore.Highlight.Enabled = true
          else
            ore.Highlight.Enabled = false
          end
        else
          if table.find(Settings.Selected, ore.Name) then
            
          end
        end
      end
    end
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Dropdown = Menu:CreateDropdown({
  Name = "Selected Ores",
  Options = Settings.Names,
  CurrentOption = { "Nothing Selected" },
  MultipleOptions = true,
  Callback = function(Options)
    Settings.Selected = Options
  end,
})