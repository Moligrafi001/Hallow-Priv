local eu = game:GetService("Players").LocalPlayer

while task.wait(0.09) do
local root = eu.Character.HumanoidRootPart
if not eu.Character:FindFirstChildOfClass("Tool") then
firetouchinterest(root, workspace.Map.Lobby.ScriptObjects.Blocks_Carry.PickupZone, 0)
firetouchinterest(root, workspace.Map.Lobby.ScriptObjects.Blocks_Carry.PickupZone, 1)
end
firetouchinterest(root, workspace.Map.StairsFolder.HitBox, 0)
firetouchinterest(root, workspace.Map.StairsFolder.HitBox, 1)
end
local args = {
    [1] = "Hit",
    [2] = workspace.Baller
}

game:GetService("Players").LocalPlayer.Character.Sword.SwordEvent:FireServer(unpack(args))
-- 7126928133
-- place 101551583206330