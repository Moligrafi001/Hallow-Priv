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

-- Locals
local eu = game:GetService("Players").LocalPlayer

-- Functions
local function AutoDirty()
  while getgenv().AutoDirty and task.wait(1) do
    if not GetAttribute("Connected") then
    end
  end
end

workspace.OwnedRestaurants.HallowHubby.DirtyTrays:FindFirstChild("Dirty Tray").Collect:FireServer()
local args = {
    [1] = workspace.OwnedRestaurants.HallowHubby.Ingredients:FindFirstChild("{aea78d64-214e-4190-8386-0ce3b6e8737e}")
}

game:GetService("ReplicatedStorage").Remotes.Gameplay.TakeIngredient:FireServer(unpack(args))
workspace.OwnedRestaurants.HallowHubby.Furniture.CashRegisters.Register.TakeOrder:FireServer()
workspace.OwnedRestaurants.HallowHubby.Trash.Tray.FoodsLeft.Burger["Cooked Patty"]