local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Fast Food Simulator",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Global Values
getgenv().AutoDirty = false
getgenv().AutoOrder = false

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function AutoDirty()
  for _, tray in pairs(workspace.OwnedRestaurants[eu.Name].DirtyTrays:GetChildren()) do
    tray.Collect:FireServer()
  end
  if not workspace.OwnedRestaurants[eu.Name].DirtyTrays:GetAttribute("Connected") then
    workspace.OwnedRestaurants[eu.Name].DirtyTrays:SetAttribute("Connected", true)
    workspace.OwnedRestaurants[eu.Name].DirtyTrays.ChildAdded:Connect(function(instance)
      if getgenv().AutoDirty then
        instance.Collect:FireServer()
      end
    end)
  end
end
local function AutoOrder()
  while getgenv().AutoOrder and task.wait(3) do
    workspace.OwnedRestaurants[eu.Name].Furniture.CashRegisters.Register.TakeOrder:FireServer()
  end
end

-- Menu
local Menu = Window:CreateTab("Menu", "home")
Section = Menu:CreateSection("Helpful")
Toggle = Menu:CreateToggle({
  Name = "Collect Dirty Trays",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoDirty = Value
    AutoDirty()
  end
})
Toggle = Menu:CreateToggle({
  Name = "Auto Take Orders",
  CurrentValue = false,
  Callback = function(Value)
    getgenv().AutoOrder = Value
    AutoOrder()
  end
})


-- workspace.OwnedRestaurants.HallowHubby.DirtyTrays:FindFirstChild("Dirty Tray").Collect:FireServer()
-- local args = {
--     [1] = workspace.OwnedRestaurants.HallowHubby.Ingredients:FindFirstChild("{aea78d64-214e-4190-8386-0ce3b6e8737e}")
-- }

-- game:GetService("ReplicatedStorage").Remotes.Gameplay.TakeIngredient:FireServer(unpack(args))
-- workspace.OwnedRestaurants.HallowHubby.Furniture.CashRegisters.Register.TakeOrder:FireServer()
-- -- workspace.OwnedRestaurants.HallowHubby.Trash.Tray.FoodsLeft.Burger["Cooked Patty"]
-- 7118588325
-- workspace.OwnedRestaurants.HallowHubby.Furniture.CashRegisters.Register.TakeOrder:FireServer()
-- local args = {
--     [1] = workspace.OwnedRestaurants.HallowHubby.Ingredients:FindFirstChild("{aea78d64-214e-4190-8386-0ce3b6e8737e}")
-- }

-- game:GetService("ReplicatedStorage").Remotes.Gameplay.TakeIngredient:FireServer(unpack(args))
-- local args = {
--     [1] = workspace.OwnedRestaurants.HallowHubby.Trash:FindFirstChild("Burger Bun"),
--     [2] = workspace.OwnedRestaurants.HallowHubby.Trash.Paper.Part
-- }

-- game:GetService("ReplicatedStorage").Remotes.Gameplay.SnapIngredient:FireServer(unpack(args))