local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Build An Island",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().CollectResources = false
getgenv().AutoContribute = false
getgenv().AutoCraft = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function CollectResources()
  while getgenv().CollectResources and task.wait(1) do
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
    pcall(function()
      for _, expand in pairs(workspace.Plots[eu.Name].Expand:GetChildren()) do
        for _, resource in pairs(expand.Top.BillboardGui:GetChildren()) do
          pcall(function()
            local atual, maximo = resource.Amount.Text:match("(%d+)/(%d+)")
            if tonumber(atual) < tonumber(maximo) then
              game:GetService("ReplicatedStorage").Communication.ContributeToExpand:FireServer(expand.Name, resource.Name, tonumber(maximo))
            end
          end)
        end
      end
    end)
  end
end
local function AutoCraft()
  while getgenv().AutoCraft and task.wait(1) do
    pcall(function()
      game:GetService("ReplicatedStorage").Communication.Craft:FireServer(workspace.Plots[eu.Name].Land.S13.Crafter.Attachment)
    end)
  end
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Auto Farm")
Toggle = Menu:CreateToggle({
  Name = "Collect Resources",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().CollectResources = Value
    CollectResources()
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
Toggle = Menu:CreateToggle({
  Name = "Auto Craft",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoCraft = Value
    AutoCraft()
  end
})