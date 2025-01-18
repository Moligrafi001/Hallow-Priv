local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Difficulty Tycoon",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

workspace.Tycoons.BTycoon.Purchases.ood

-- workspace.Tycoons.GTycoon.Buttons.cp1b.Button.TouchInterest
local eu = game.Players.LocalPlayer
local cash = eu.leaderstats.Cash.Value
while true do
pcall(function()
for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
if tycoon:IsA("Model") and tycoon.Values.OwnerValue.Value == eu then
for _, button in pairs(tycoon.Buttons:GetChildren()) do
if button.Price.Value <= cash and button.Button.Transparency == 0 then
firetouchinterest(eu.Character.HumanoidRootPart, button.Button, 0)
firetouchinterest(eu.Character.HumanoidRootPart, button.Button, 1)
end
end
end
end
end)
wait(1.5)
end

-- workspace.Tycoons.GTycoon.Values.OwnerValue
-- workspace.Tycoons.GTycoon.Purchases.db1.Click.ClickDetector
local eu = game.Players.LocalPlayer
while true do
for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
if tycoon:IsA("Model") and tycoon.Values.OwnerValue.Value == eu then
fireclickdetector(tycoon.Purchases.db1.Click.ClickDetector)
end
end
wait()
end

-- workspace.Tycoons.GTycoon.MainItems.CashCollector.Button
local eu = game.Players.LocalPlayer
while true do
for _, tycoon in pairs(workspace.Tycoons:GetChildren()) do
if tycoon:IsA("Model") and tycoon.Values.OwnerValue.Value == eu then
firetouchinterest(eu.Character.HumanoidRootPart, tycoon.MainItems.CashCollector.Button, 0)
firetouchinterest(eu.Character.HumanoidRootPart, tycoon.MainItems.CashCollector.Button, 1)
end
end
wait(1.5)
end