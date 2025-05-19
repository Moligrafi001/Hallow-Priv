local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Rope Battles",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoStruggle = false
getgenv().RopeAura = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  AuraDistance = 30
}

-- Functions
local function Rope(player)

end
local function AutoStruggle()
  while getgenv().AutoStruggle and task.wait(1) do
    if not eu.Character:GetAttribute("Connected") then
      eu.Character:SetAttribute("Connected", true)
      eu.Character:GetAttributeChangedSignal("StruggleProgress"):Connect(function()
        if getgenv().AutoStruggle and eu.Character:GetAttribute("StruggleProgress") ~= 0 then
          game:GetService("ReplicatedStorage").RemoteEvents.StruggleRE:FireServer({ event = "Break", activeBreak = false })
        end
      end)
    end
  end
end
local function RopeAura()
  local function GetNearby()
    local Detected = {}
    for _, part in pairs(workspace:GetPartBoundsInBox(eu.Character.HumanoidRootPart.CFrame, Vector3.new(Settings.Distance, 20, Settings.Distance), nil)) do
      if part:IsA("Model") then
        local player = game:GetService("Players"):GetPlayerFromCharacter(part)
        if player then
          table.insert(Detected, player.Character)
        end
      end
    end
    return Detected
  end
  while getgenv().RopeAura and task.wait(0.3) do
    for _, character in pairs(GetNearby()) do
      
    end
  end
end
local function AutoAttack()
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Exterminate")
Toggle = Menu:CreateToggle({
  Name = "Rope Aura",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().RopeAura = Value
    RopeAura()
  end
})
Input = Menu:CreateInput({
   Name = "Aura Distance",
   CurrentValue = tostring(Settings.AuraDistance / 2),
   PlaceholderText = "Numbers only, ex.: 15",
   Callback = function(Text)
     Settings.AuraDistance = tonumber(Text) * 2
   end,
})