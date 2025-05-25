while task.wait(1) do
for _, enemie in pairs(workspace.Enemies:GetChildren()) do
game:GetService("ReplicatedStorage").HurtEnemy:FireServer(enemie, math.huge)
end
end
-- 7516718402