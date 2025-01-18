-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/games/Bubble%20Gum%20Champions.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
   Name = "Hallow Hub | Bubble Gum Champions",
   Icon = 17091459839,
   LoadingTitle = "Hallow Hub",
   LoadingSubtitle = "By Moligrafi",
   Theme = "Amethyst"
})

-- Valores
getgenv().AutoBubbles = false
getgenv().AutoCoins = false
getgenv().AutoGems = false
getgenv().AutoSell = false

-- Funções
local function AutoBubbles()
	while getgenv().AutoBubbles == true do
		game:GetService("ReplicatedStorage").RemoteEvent:FireServer("BlowBubble")
		wait(0.01)
	end
end
local function AutoCoins()
local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local touch = character.HumanoidRootPart
	while getgenv().AutoCoins == true do
		for _, coin in pairs(workspace.PickupAreas.Overworld.Pickups:GetChildren()) do
			if coin:IsA("Model") and coin.Name ~= "Gem" then
				for _, ti in pairs(coin:GetDescendants()) do
					if ti.Name == "TouchInterest" then
						firetouchinterest(touch, ti.Parent, 0)
						firetouchinterest(touch, ti.Parent, 1)
					end
				end
			end
		end
		wait(1)
	end
end
local function AutoCoinsFaster()
    local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
    local touch = character.HumanoidRootPart
    while getgenv().AutoCoins == true do
        for _, island in pairs(workspace.PickupAreas.Overworld_Islands.Pickups:GetChildren()) do
            for _, subFolder in pairs(island:GetChildren()) do
                if subFolder:IsA("Model") and subFolder.Name ~= "Gem" then
                    for _, ti in pairs(subFolder:GetDescendants()) do
                        if ti.Name == "TouchInterest" then
                            firetouchinterest(touch, ti.Parent, 0)
                            firetouchinterest(touch, ti.Parent, 1)
                        end
                    end
                end
            end
        end
        wait(1)
    end
end

local function AutoGems()
local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local touch = character.HumanoidRootPart
	while getgenv().AutoGems == true do
		for _, coin in pairs(workspace.PickupAreas.Overworld.Pickups:GetChildren()) do
			if coin:IsA("Model") and coin.Name == "Gem" then
				for _, ti in pairs(coin:GetDescendants()) do
					if ti.Name == "TouchInterest" then
						firetouchinterest(touch, ti.Parent, 0)
						firetouchinterest(touch, ti.Parent, 1)
					end
				end
			end
		end
		wait(1)
	end
end

local function ReedemCodes()
	game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "MEGABOOST")
	game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "INSANEBOOST")
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "ULTRAMGABOOST")
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "Release")
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "CoolCode")
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "SuperCode")
    game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer("RedeemCode", "XMAS")
end

-- Menu		
local Menu = Window:CreateTab("Main", "home")
local Section = Menu:CreateSection("Auto Farm")
local Toggle =  Menu:CreateToggle({
   Name = "Auto Bubbles",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoBubbles = Value
   	AutoBubbles()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Auto Coins 1 (Combine with #2)",
   CurrentValue = false,
   Callback = function(Value)
       getgenv().AutoCoins = Value
       AutoCoins()
   end,
})
local Toggle = Menu:CreateToggle({
   Name = "Auto Coins 2 (Combine with #1)",
   CurrentValue = false,
   Callback = function(Value)
       getgenv().AutoCoins = Value
       AutoCoinsFaster()
   end,
})
local Toggle =  Menu:CreateToggle({
   Name = "Auto Gems",
   CurrentValue = false,
   Callback = function(Value)
   	getgenv().AutoGems = Value
   	AutoGems()
   end,
})

local Section = Menu:CreateSection("More")
local Button = Menu:CreateButton({
   Name = "Reedem Codes",
   Callback = function()
   	ReedemCodes()
   end,
})

local TP = Window:CreateTab("Teleports", "shell")
local Section = TP:CreateSection("Map Teleports")

local islandNames = {
    "Azure",
    "Beyond",
    "Neon",
    "Sandstorm",
    "Space",
    "The Floating Island",
    "The Void"
}

local selectedIsland = nil 

local IslandDropdown = TP:CreateDropdown({
    Name = "Select Checkpoint (You have to have it unlocked)",
    Options = islandNames,
    Callback = function(selected)
        if typeof(selected) == "table" then
            selectedIsland = selected[1]
        elseif typeof(selected) == "string" then
            selectedIsland = selected
        else

            selectedIsland = nil
            print("Error: Dropdown returned an unexpected value type:", typeof(selected))
        end

        if selectedIsland then
            print("Island selected: " .. selectedIsland)
        else
            print("Error: No valid island selected!")
        end
    end
})

local TeleportButton = TP:CreateButton({
    Name = "Teleport to First Model in Selected Checkpoint",
    Callback = function()
        if not selectedIsland or type(selectedIsland) ~= "string" then
            print("Error: No valid island selected!")
            return
        end

        local Checkpoints = game:GetService("Workspace"):FindFirstChild("Checkpoints")
        if not Checkpoints then
            print("Error: Checkpoints folder not found in Workspace!")
            return
        end

        local island = Checkpoints:FindFirstChild(selectedIsland)
        if not island then
            print("Error: Island not found: " .. selectedIsland)
            return
        end

        local model = island:FindFirstChildWhichIsA("Model")
        if not model then
            print("Error: No Model found in island: " .. selectedIsland)
            return
        end

        local teleportPart = model:FindFirstChildWhichIsA("BasePart")
        if not teleportPart then
            print("Error: No BasePart found in Model for island: " .. selectedIsland)
            return
        end

        local player = game.Players.LocalPlayer
        if not player then
            print("Error: LocalPlayer not found")
            return
        end

        local character = player.Character or player.CharacterAdded:Wait()
        if character then
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
            if humanoidRootPart then
                humanoidRootPart.CFrame = teleportPart.CFrame + Vector3.new(0, 3, 0) 
                print("Teleported to first Model in island: " .. selectedIsland)
            else
                print("Error: HumanoidRootPart not found")
            end
        else
            print("Error: Character not found")
        end
    end
})

local ServersTab = Window:CreateTab("Server", "compass")
local ServerSection = ServersTab:CreateSection("Server Actions", true)

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local PlaceId = game.PlaceId  
local JobId = game.JobId 

ServersTab:CreateButton({
    Name = "Rejoin Game",
    Callback = function()
        if #Players:GetPlayers() <= 1 then
            Players.LocalPlayer:Kick("\nRejoining...")
            wait(1) 
            TeleportService:Teleport(PlaceId, Players.LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
        end
    end,
})
                                                                                                    --end rejoin
                                                                                                    --serverhop

local PlaceId, JobId = game.PlaceId, game.JobId

local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function serverHop()
    if httprequest then
        local servers = {}
        local req = httprequest({
            Url = string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId),
            Method = "GET"
        })

        local body = HttpService:JSONDecode(req.Body)

        if body and body.data then
            for _, v in next, body.data do
                if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                    table.insert(servers, 1, v.id)
                end
            end
        end

        if #servers > 0 then
            local serverToJoin = servers[math.random(1, #servers)]
            TeleportService:TeleportToPlaceInstance(PlaceId, serverToJoin, Players.LocalPlayer)
        else
            Rayfield:Notify({
                Title = "Serverhop",
                Content = "Couldn't find a server.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("The user tapped Okay!")
                        end
                    },
                },
            })
        end
    else
        local servers = {}
        local success, req = pcall(function()
            return HttpService:GetAsync(string.format("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true", PlaceId))
        end)

        if success and req then
            local body = HttpService:JSONDecode(req)
            if body and body.data then
                for _, v in next, body.data do
                    if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                        table.insert(servers, 1, v.id)
                    end
                end
            end

            if #servers > 0 then
                local serverToJoin = servers[math.random(1, #servers)]
                TeleportService:TeleportToPlaceInstance(PlaceId, serverToJoin, Players.LocalPlayer)
            else
                Rayfield:Notify({
                    Title = "Serverhop",
                    Content = "Couldn't find a server.",
                    Duration = 6.5,
                    Image = 4483362458,
                    Actions = {
                        Ignore = {
                            Name = "Okay!",
                            Callback = function()
                                print("The user tapped Okay!")
                            end
                        },
                    },
                })
            end
        else
            Rayfield:Notify({
                Title = "Incompatible Exploit",
                Content = "Your exploit does not support HTTP requests.",
                Duration = 6.5,
                Image = 4483362458,
                Actions = {
                    Ignore = {
                        Name = "Okay!",
                        Callback = function()
                            print("The user tapped Okay!")
                        end
                    },
                },
            })
        end
    end
end

ServersTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        serverHop()
    end,
})
