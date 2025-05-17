workspace.MainGame.EndTower.Rewards.Carpet.ProximityPrompPart
for _, p in pairs(game.Players:GetPlayers()) do
if p ~= game.Players.LocalPlayer then
local args = {
    [1] = "slash",
    [2] = p.Character,
    [3] = Vector3.new(4.95231819152832, -7.653632394521992e-08, 0.6888718605041504)
}

game:GetService("Players").LocalPlayer.Character.YeetGlove.Event:FireServer(unpack(args))
end
end