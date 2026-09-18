--[[
    HONEYPOT / BAIT SCRIPT
    ----------------------
    Purpose: This is a decoy "dupe script" meant to be posted where exploiters/cheaters
    would find and run it. When executed, it reports the executor's Roblox username
    and UserId to a Discord webhook so you can identify and ban them from your game.

    SETUP:
    1. Create a Discord webhook in a private server/channel only you can see:
       Server Settings -> Integrations -> Webhooks -> New Webhook -> Copy URL
    2. Paste that URL into WEBHOOK_URL below.
    3. Post/distribute THIS script (or an obfuscated version of it) wherever you're
       trying to bait cheaters into running it.
    4. Whoever runs it gets reported to your webhook, then sees the "gotcha" message.

    NOTE: HttpService:PostAsync only works if the executor allows HTTP requests
    (most modern exploits do). If a given executor blocks it, this specific method
    won't fire, so treat this as one layer of detection, not the only one.
--]]

local WEBHOOK_URL = "PUT_YOUR_DISCORD_WEBHOOK_URL_HERE"

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer

local function reportExecutor()
    local payload = {
        content = string.format(
            "🚨 **Dupe-script honeypot triggered!**\nUsername: `%s`\nUserId: `%s`\nDisplayName: `%s`\nPlaceId: `%s`\nTime: `%s`",
            player.Name,
            tostring(player.UserId),
            player.DisplayName,
            tostring(game.PlaceId),
            os.date("%Y-%m-%d %H:%M:%S")
        )
    }

    local ok, err = pcall(function()
        HttpService:PostAsync(
            WEBHOOK_URL,
            HttpService:JSONEncode(payload),
            Enum.HttpContentType.ApplicationJson
        )
    end)

    if not ok then
        warn("Honeypot: failed to report executor - " .. tostring(err))
    end
end

reportExecutor()

-- Optional: show the "you got caught" message in-game via a ScreenGui
-- so the person sees it immediately instead of just nothing happening.
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
    label.Position = UDim2.fromScale(0.05, 0.05)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextScaled = true
    label.TextWrapped = true
    label.Text = "thank you for using this slop tower defense dupe script, its really hard to get the users of cheaters its nice youre the one executing this \"dupe cheat\" thanks for your roblox username!"
    label.Parent = frame

    local label2 = Instance.new("TextLabel")
    label2.Size = UDim2.fromScale(0.5, 0.35)
    label2.Position = UDim2.fromScale(0.02, 0.62)
    label2.BackgroundTransparency = 1
    label2.Font = Enum.Font.GothamBold
    label2.TextColor3 = Color3.new(1, 1, 1)
    label2.TextScaled = true
    label2.TextWrapped = true
    label2.Text = "how can you be ass at cheating, transfer your units while you can dumass"
    label2.Parent = frame
end

showCaughtMessage()
