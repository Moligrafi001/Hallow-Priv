-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Prib/main/Key%20System.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local PandaAuth = loadstring(game:HttpGet("https://raw.githubusercontent.com/Panda-Repositories/PandaKS_Libraries/refs/heads/main/library/LuaLib/ROBLOX/PandaSVALLib.lua"))()
PandaAuth:Initialize({
  Service = "hallowhub",
  API_Key = "1de6c1d876b400422be46795b66c82f973f7f5487474e01dbade47ca192f8c33",
  DisplayName = "My Panda Service",
  IsDebug = false,
  Allow_BlacklistUsers = false,
  GUIVersion = false,
  EnableWebhook = false,
  Webhook_URL = "https://yourwebhook.url",
  Authenticated = function() 
    print("[Pelinda] Key authenticated successfully! Access granted.") 
  end, 
  NotAuthenticated = function()
    print("[Pelinda] Authentication failed. Access denied.") 
  end 
}) 
local HttpService = game:GetService("HttpService")
local ChaveHub ="nil"
local function ChecarChave()
  if PandaAuth:ValidateKey(ChaveHub) then
    Rayfield:Notify({
      Title = "Right key!",
      Content = "Perfect!",
      Duration = 9,
      Image = 17091459839,
    })
  else
    Rayfield:Notify({
      Title = "Wrong key!",
      Content = "Bad!",
      Duration = 9,
      Image = 17091459839,
    })
  end
end
getgenv().PegouChave = false
local function PegarChave()
  if getgenv().PegouChave == false then
    setclipboard(PandaAuth:GetKey())
    Rayfield:Notify({
      Title = "Got the link key!",
      Content = "Perfect!",
      Duration = 9,
      Image = 17091459839,
    })
  else
    Rayfield:Notify({
      Title = "You already got the link!",
      Content = "Very bad!",
      Duration = 9,
      Image = 17091459839,
    })
  end
end

local Window = Rayfield:CreateWindow({
    Name = "Hallow Hub | Authentication",
    Icon = 17091459839,
    LoadingTitle = "Hallow Hub",
    LoadingSubtitle = "By Moligrafi",
    Theme = "Amethyst"
})
local Menu = Window:CreateTab("Key System", "key")
local SectionInstructions = Menu:CreateSection("🔑 Key Instructions 🔑")
local Paragraph = Menu:CreateParagraph({
    Title = "How to Get the Key",
    Content = "To get the key, simply click the 'Get Key' button below. After you have clicked the button, a link will be copied to your clipboard. Go into your browser and paste in the link. Follow all the necessary steps until you reach the key page. Copy the key that is shown and paste it in the box below the Get Key button."
})
local DividerInstructions = Menu:CreateDivider()
local SectionGetKey = Menu:CreateSection("Get Your Key")
local DividerGetKey = Menu:CreateDivider()
local ButtonGetKey = Menu:CreateButton({
    Name = "Get Key",
    Callback = function()
      PegarChave()
      getgenv().PegouChave = true
    end,
})
local DividerEnd = Menu:CreateDivider()
local Input = Menu:CreateInput({
   Name = "Paste here your key",
   CurrentValue = "Paste here your key",
   PlaceholderText = "Paste here your key",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	ChaveHub = Text
   	ChecarChave
   end,
})