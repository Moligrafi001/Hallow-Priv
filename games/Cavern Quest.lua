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

-- Locais
local eu = game:GetService("Players").LocalPlayer

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