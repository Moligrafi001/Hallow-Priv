-- Global Values
getgenv().AutoStruggle = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function AutoStruggle()
  while getgenv().AutoStruggle and task.wait(1) do
    if not eu.Character:GetAttribute("Connected") then
      eu.Character:SetAttribute("Connected", true)
      eu.Character:GetAttributeChangedSignal("StruggleProgress"):Connect(function()
        if getgenv().AutoStruggle and eu.Character:GetAttribute("StruggleProgress") > 0 then
          game:GetService("ReplicatedStorage").RemoteEvents.StruggleRE:FireServer({ event = "Break", activeBreak = false })
        end
      end)
    end
  end
end
local function AutoAttack()
  local args = {
      [1] = {
          ["toolInstance"] = game:GetService("Players").LocalPlayer.Character.Common,
          ["target"] = game:GetService("Players").yuliaa3413.Character,
          ["ropeInfos"] = {
              ["Thickness"] = 0.3,
              ["WinchForce"] = math.huge,
              ["WinchTarget"] = 18,
              ["WinchResponsiveness"] = 200,
              ["Color"] = BrickColor.new(356),
              ["WinchEnabled"] = true,
              ["WinchSpeed"] = 15,
              ["Visible"] = true
          },
          ["attacker"] = game:GetService("Players").LocalPlayer.Character,
          ["body"] = game:GetService("Players").yuliaa3413.Character:FindFirstChild("Right Arm")
      }
  }
  game:GetService("ReplicatedStorage").RemoteEvents.OnHitRE:FireServer(unpack(args))
end