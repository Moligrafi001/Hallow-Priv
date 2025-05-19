local args = {
    [1] = "M1911",
    [2] = CFrame.new(-99.67828369140625, 6.019713401794434, -230.1353759765625) * CFrame.Angles(-0.04435689374804497, 0.4749751687049866, 0.020295660942792892),
    [3] = {
        [1] = {
            ["id"] = "135"
        }
    }
}

game:GetService("ReplicatedStorage").Networking.Remotes.Weapons.GunFired:FireServer(unpack(args))
workspace.Things.Zombies
for _, zombie in pairs(workspace.Things.Zombies:GetChildren()) do
end
for i = 1, 3 do
game:GetService("ReplicatedStorage").Networking.Remotes.Game.UpgradeGate:FireServer(i)
end
for i = 1, 20 do
game:GetService("ReplicatedStorage").Networking.Remotes.Drops.CollectDrop:FireServer(i)
end