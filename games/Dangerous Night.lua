local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
  Name = "Hallow Hub | Dangerous Night",
  Icon = 17091459839,
  LoadingTitle = "Hallow Hub",
  LoadingSubtitle = "By Moligrafi",
  Theme = "Amethyst"
})

-- Locals
local eu = game:GetService("Players").LocalPlayer
local Settings = {
  Selected = "",
  Busy = false
}

-- Functions
local function ReturnFurniture()
  local Names = {}
  
  for _, item in pairs(workspace.Wyposazenie:GetChildren()) do
    if item:IsA("Folder") then
      for _, interno in pairs(item:GetChildren()) do
        if interno:IsA("Model") and not table.find(Names, interno.Name) then
          table.insert(Names, interno.Name)
        end
      end
    elseif item:IsA("Model") and not table.find(Names, item.Name) then
      table.insert(Names, item.Name)
    end
  end
  
  return Names
end
local function GetFurniture()
  for _, furniture in pairs(workspace.Wyposazenie:GetChildren()) do
    if furniture:IsA("Folder") then
      for _, interno in pairs(furniture:GetChildren()) do
        if interno:IsA("Model") and interno.Name == Settings.Selected then
          game:GetService("ReplicatedStorage").PickupItemEvent:FireServer(interno)
          return true
        end
      end
    elseif furniture:IsA("Model") and furniture.Name == Settings.Selected then
      game:GetService("ReplicatedStorage").PickupItemEvent:FireServer(furniture)
      return true
    end
  end
  
  return false
end
local function CollectFood()
  local function ReturnFood()
    local Names = {}
    
    for _, food in pairs(workspace:GetChildren()) do
      if food:IsA("Tool") and food:FindFirstChild("Handle") then
        table.insert(Names, food)
      end
    end
    
    return Names
  end
  repeat
    if not Settings.Busy and #ReturnFood() > 0 then
      Settings.Busy = true
      eu.Character.HumanoidRootPart:SetAttribute("Marc", eu.Character.HumanoidRootPart.CFrame)
      for _, food in pairs(ReturnFood()) do
        eu.Character.HumanoidRootPart.CFrame = food.Handle.CFrame
        task.wait(0.3)
        fireproximityprompt(food.Handle.ProximityPrompt)
        eu.Character.HumanoidRootPart.CFrame = eu.Character.HumanoidRootPart:GetAttribute("Marc")
        task.wait(0.1)
      end
      Settings.Busy = false
    end
  until #ReturnFood() == 0
end

-- Menu
local Menu = Window:CreateTab("Main", "home")
Section = Menu:CreateSection("Bring Food")
Button = Menu:CreateButton({
  Name = "Collect Food",
  Callback = function()
   	if Settings.Busy then
     	Rayfield:Notify({
        Title = "Hey, wait!",
        Content = "Player is collecting!",
        Duration = 3,
        Image = 17091459839,  
      })
   	else
     	Rayfield:Notify({
        Title = "Collecting...",
        Content = "Waiting...",
        Duration = 6,
        Image = 17091459839,  
      })
      CollectFood()
    end
  end
})
Section = Menu:CreateSection("Bring Furniture")
Label = Menu:CreateLabel("CAN ONLY BRING FURNITURES THAT ARE CLOSE TO YOU", "triangle-alert")
FurnitureDropdown = Menu:CreateDropdown({
  Name = "Selected Furniture",
  Options = ReturnFurniture(),
  CurrentOption = { Settings.Selected },
  Callback = function(Options)
    Settings.Selected = Options[1]
  end
})
Button = Menu:CreateButton({
  Name = "Bring Selected Furniture",
  Callback = function()
    if GetFurniture() then
      Rayfield:Notify({
        Title = "Done!",
        Content = "Got the selected furniture!",
        Duration = 3,
        Image = 17091459839,
      })
    else
      Rayfield:Notify({
        Title = "Oops!",
        Content = "The selected furniture is not available, try to refresh the list!",
        Duration = 6,
        Image = 17091459839,
      })
    end
  end
})
Button = Menu:CreateButton({
  Name = "Update Furniture List",
  Callback = function()
   	FurnitureDropdown:Refresh(ReturnFurniture())
   	Rayfield:Notify({
      Title = "Done!",
      Content = "Updated the furniture list!",
      Duration = 3,
      Image = 17091459839,  
    })
  end
})
Label = Menu:CreateLabel("CHANCE TO FAIL", "triangle-alert")
