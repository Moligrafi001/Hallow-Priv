-- Global Values
getgenv().AutoHarvest = false
getgenv().AutoContribute = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function AutoHarvest()
  while getgenv().AutoHarvest and task.wait(1) do
    pcall(function()
      for _, resource in pairs(workspace.Plots[eu.Name].Resources:GetChildren()) do
        if resource:GetAttribute("HP") > 0 then
          game:GetService("ReplicatedStorage").Communication.HitResource:FireServer(resource)
        end
      end
    end)
  end
end
local function AutoContribute()
  while getgenv().AutoContribute and task.wait(1) do
    for _, expand in pairs(workspace.Plots[eu.Name].Expand:GetChildren()) do
      for _, resource in pairs(expand.Top.BillboardGui:GetChildren()) do
        if resource:FindFirstChild("Amount") then
          local atual, maximo = resource.Amount.Text:match("(%d+)/(%d+)")
          if tonumber(atual) < tonumber(maximo) then
            game:GetService("ReplicatedStorage").Communication.ContributeToExpand:FireServer(expand.Name, resource.Name, math.huge)
          end
        end
      end
    end
-- workspace.Plots[eu.Name].Expand.S13.Top.BillboardGui.Stone.Amount
-- workspace.Plots[eu.Name].Expand.S13.Top.BillboardGui.Log.Amount
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle = Menu:CreateToggle({
  Name = "Auto Harvest",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoHarvest = Value
    AutoHarvest()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Contribute",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoContribute = Value
    AutoContribute()
  end
})

-- game:GetService("ReplicatedStorage").Communication.Craft:FireServer(workspace.Plots[eu.Name].Land.S13.Crafter.Attachment) 