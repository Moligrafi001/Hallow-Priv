while task.wait(1) do
pcall(function()
for _, p in pairs(game.Players:GetPlayers()) do
local args = {
    [1] = p.Character
}

game:GetService("ReplicatedStorage").Remotes.Heal:FireServer(unpack(args))
end
end)
end