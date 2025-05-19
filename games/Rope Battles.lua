-- 6944270854
local args = {
    [1] = {
        ["event"] = "Break",
        ["activeBreak"] = false
    }
}

game:GetService("ReplicatedStorage").RemoteEvents.StruggleRE:FireServer(unpack(args))
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
