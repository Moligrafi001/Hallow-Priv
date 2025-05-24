local args = {
    [1] = workspace.Plots.HallowHubby.Resources:FindFirstChild("Palm Tree")
}

game:GetService("ReplicatedStorage").Communication.HitResource:FireServer(unpack(args))
local args = {
    [1] = "S28",
    [2] = "Log",
    [3] = 1
}

game:GetService("ReplicatedStorage").Communication.ContributeToExpand:FireServer(unpack(args))
workspace.Plots.HallowHubby.Expand.S13.Top.BillboardGui.Stone.Amount
workspace.Plots.HallowHubby.Expand.S13.Top.BillboardGui.Log.Amount
while task.wait(1) do
for _, resource in pairs(workspace.Plots.HallowHubby.Resources:GetChildren()) do
if resource:GetAttribute("HP") > 0 then
local args = {
    [1] = resource
}

game:GetService("ReplicatedStorage").Communication.HitResource:FireServer(unpack(args))
end
end
end
local args = {
    [1] = workspace.Plots.HallowHubby.Land.S13.Crafter.Attachment
}

game:GetService("ReplicatedStorage").Communication.Craft:FireServer(unpack(args))
7541395924