-- Credits
local Pussy = Window:CreateTab("Credits", "info")
local FounderSection = Pussy:CreateSection("Founder Developer")
local Label = Pussy:CreateLabel("Discord: moligrafi", "at-sign")
local DevSection = Pussy:CreateSection("Co-Developer")
local Label = Pussy:CreateLabel("Discord: _prismx", "at-sign")
local ServerSection = Pussy:CreateSection("Discord Server")
local Label = Pussy:CreateLabel("discord.gg/AESCuek87s")
local ButtonServer = Pussy:CreateButton({
  Name = "Copy Server Link",
  Callback = function()
    setclipboard("discord.gg/XnsG57tQWS")
    toclipboard("discord.gg/XnsG57tQWS")
  end,
})
local NoteSection = Pussy:CreateSection("Note")
local NoteLabel = Pussy:CreateLabel("If you find any bug join the discord and open a ticket")
local DividerInstructions = Pussy:CreateDivider()