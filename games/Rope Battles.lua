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
getgenv().AutoRope = false

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Cooldown = 1
}

-- Functions
local function RopeAll()
  pcall(function()
    for _, p in pairs(game.Players:GetPlayers()) do
      for _, tool in pairs(eu.Character:GetChildren()) do
        if p ~= eu and tool:IsA("Tool") then
          local args = {
            [1] = {
              ["toolInstance"] = tool,
              ["target"] = p.Character,
              ["ropeInfos"] = {
                ["Thickness"] = math.huge,
                ["WinchForce"] = math.huge,
                ["WinchTarget"] = 18,
                ["WinchResponsiveness"] = 200,
                ["Color"] = BrickColor.new(356),
                ["WinchEnabled"] = true,
                ["WinchSpeed"] = 15,
                ["Visible"] = false
              },
              ["attacker"] = eu.Character,
              ["body"] = p.Character:FindFirstChild("Right Leg")
            }
          }
        
          game:GetService("ReplicatedStorage").RemoteEvents.OnHitRE:FireServer(unpack(args))
        end
      end
    end
  end)
end
local function AutoRope()
  while getgenv().AutoRope and task.wait(Settings.Cooldown) do
    RopeAll()
  end
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

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Exterminate")
Button = Menu:CreateButton({
  Name = "Rope All",
  CurrentValue = false,
  Callback = function(Value)
    RopeAll()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Rope All",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoRope = Value
    AutoRope()
  end
})
Input = Menu:CreateInput({
   Name = "Aura Rope Cooldown",
   CurrentValue = tostring(Settings.Cooldown),
   PlaceholderText = "Seconds only, ex.: 1.5",
   Callback = function(Text)
     Settings.Cooldown = tonumber(Text)
   end,
})
Section = Menu:CreateSection("Helpful")
Toggle = Menu:CreateToggle({
  Name = "Auto Struggle",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoStruggle = Value
    AutoStruggle()
  end
})