-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua",true))()
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local PandaAuth = loadstring(game:HttpGet("https://raw.githubusercontent.com/Panda-Repositories/PandaKS_Libraries/refs/heads/main/library/LuaLib/ROBLOX/PandaSVALLib.lua"))()
PandaAuth:Initialize({
  Service = "hallowhub",
  API_Key = "9e2587f18e0b05c969b3b383f9bb8465f202d7822191dbe81902b11a8db12389",
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
local ChaveHub = "nil"
local VerificadorCarregou = false
local function ChecarChave()
  if PandaAuth:ValidateKey(ChaveHub) then
    if VerificadorCarregou == false then
      VerificadorCarregou = true
      Rayfield:Notify({
      Title = "Yay! Right key!",
      Content = "Script is loading... Don't execute it again.",
      Duration = 4,
      Image = 17091459839,
      })
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Moligrafi001/Hallow-Hub/main/Loader.lua",true))()
    else
      Rayfield:Notify({
      Title = "You already verified!",
      Content = "Script is loading.",
      Duration = 4,
      Image = 17091459839,
      })
    end
  else
    Rayfield:Notify({
      Title = "Wrong key!",
      Content = "Bad!",
      Duration = 4,
      Image = 17091459839,
    })
  end
end
local function PegarChave()
  setclipboard(PandaAuth:GetKey())
  Rayfield:Notify({
    Title = "Got the link key!",
    Content = "Link copied!",
    Duration = 9,
    Image = 17091459839,
  })
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
    Content = "1. Click the 'Generate Key' button below;\n2. After you have clicked the button, a link will be copied to your, paste it into your browser;\n3. Go into your browser and paste in the link. Follow all the necessary steps until you reach the key page;\n4. Copy the key that is shown and paste it in the box below the Get Key button."
})
local DividerInstructions = Menu:CreateDivider()
local SectionGetKey = Menu:CreateSection("Get Your Key")
local ButtonGetKey = Menu:CreateButton({
    Name = "Generate Link",
    Callback = function()
      PegarChave()
      getgenv().PegouChave = true
    end,
})
local SectionGetKey = Menu:CreateSection("Authenticate Key")
local InputKey = Menu:CreateInput({
   Name = "Key",
   CurrentValue = "",
   PlaceholderText = "Paste your key here",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
   	ChaveHub = Text
   	ChecarChave()
   end,
})
local VerifyKey = Menu:CreateButton({
    Name = "Verify Key",
    Callback = function()
      ChecarChave()
    end,
})

-- Credits
local Credits = Window:CreateTab("Credits", "info")
local Section = Credits:CreateSection("Founder Developer")
local Label = Credits:CreateLabel("Discord: moligrafi", "at-sign")
local Section = Credits:CreateSection("Developer")
local Label = Credits:CreateLabel("Discord: _prismx", "at-sign")
local Section = Credits:CreateSection("Discord Server")
local Label = Credits:CreateLabel("discord.gg/AESCuek87s")
local Button = Credits:CreateButton({
   Name = "Copy Server Link",
   Callback = function()
   	setclipboard("discord.gg/XnsG57tQWS")
   	toclipboard("discord.gg/XnsG57tQWS")
    end,
})
local Section = Credits:CreateSection("Note")
local Label = Credits:CreateLabel("If you find any bug join the discord and open a ticket")