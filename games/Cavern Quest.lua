local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Cavern Quest",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().KillAura = false
getgenv().MobsESP = false

-- Locais
local eu = game:GetService("Players").LocalPlayer
local ColorESP = Color3.fromRGB(255, 125, 0)

-- Funções
local function KillAura()
  while getgenv().KillAura and task.wait(0.25) do
    pcall(function()
      local Targets = {}
      for _, npc in pairs(workspace.Npc:GetChildren()) do
        table.insert(Targets, npc)
      end
      eu.Character.RE:FireServer("UseSkill", { ComboIndex = 1, UUID = "{9}", Slot = "NormalSkill", TargetList = Targets, SkillId = "SC_normal_sword_1" })
    end)
  end
end
local function MobsESP()
  while getgenv().MobsESP and task.wait(0.1) do
    pcall(function()
      for _, npc in pairs(workspace.Npc:GetChildren()) do
        if npc.Highlight.Enabled == true then
          if npc.Highlight.FillColor ~= ColorESP or npc.Highlight.OutlineColor ~= ColorESP then
            npc.Highlight.FillColor, npc.Highlight.OutlineColor = ColorESP, ColorESP
          end
        else
          npc.Highlight.Enabled = true
        end
      end
    end)
  end
  if not getgenv().MobsESP then
    pcall(function()
      for _, npc in pairs(workspace.Npc:GetChildren()) do
        if npc.Highlight.Enabled == true then
          npc.Highlight.Enabled = false
        end
      end
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Combat")
Toggle =  Menu:CreateToggle({
   Name = "Kill Aura",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().KillAura = Value
   	KillAura()
   end,
})
Section = Menu:CreateSection("Visual")
Toggle =  Menu:CreateToggle({
   Name = "ESP Enemies",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().MobsESP = Value
   	MobsESP()
   end,
})
ColorPicker = Menu:CreateColorPicker({
   Name = "Highlight Color",
   Color = ColorESP,
   Callback = function(Value)
  	ColorESP = Value
   end
})