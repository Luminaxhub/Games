if game.PlaceId ~= 9638489687 then
    return warn("❌ This script only works in Memory Murder.")
end

local userKey = "LUMINAKEY_pxs0up8r2bh2j19"
local getKeyURL = "https://get-key-luminakey.vercel.app/"
local mainScriptURL = "https://raw.githubusercontent.com/Luminaxhub/Games/refs/heads/main/Memory%20Murder.lua"

-- UI Setup
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui", PlayerGui)
screenGui.Name = "Lumina_KeyUI"
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local blur = Instance.new("BlurEffect", game:GetService("Lighting"))
blur.Size = 15

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 350, 0, 200)
frame.Position = UDim2.new(0.5, -175, 0.5, -100)
frame.BackgroundTransparency = 0.25
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.Parent = screenGui
frame.Active = true
frame.Draggable = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "🔐 Key system"
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local keyBox = Instance.new("TextBox", frame)
keyBox.PlaceholderText = "Enter key here..."
keyBox.Size = UDim2.new(0.9, 0, 0, 40)
keyBox.Position = UDim2.new(0.05, 0, 0, 55)
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 16
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

-- Verify Button
local verifyBtn = Instance.new("TextButton", frame)
verifyBtn.Size = UDim2.new(0.9, 0, 0, 35)
verifyBtn.Position = UDim2.new(0.05, 0, 0, 105)
verifyBtn.Text = "✅ Verify"
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextSize = 16
verifyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 6)

-- Get Key (link)
local linkText = Instance.new("TextLabel", frame)
linkText.Size = UDim2.new(0.9, 0, 0, 30)
linkText.Position = UDim2.new(0.05, 0, 1, -35)
linkText.Text = "🔗 Get Key: " .. getKeyURL
linkText.Font = Enum.Font.Gotham
linkText.TextSize = 13
linkText.TextColor3 = Color3.fromRGB(180, 180, 255)
linkText.TextWrapped = true
linkText.BackgroundTransparency = 1

-- Close Button
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BackgroundTransparency = 1

-- Verify Click
verifyBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == userKey then
        verifyBtn.Text = "Loading..."
        wait(1)
        screenGui:Destroy()
        blur:Destroy()
        loadstring(game:HttpGet(mainScriptURL))()
    else
        keyBox.Text = ""
        keyBox.PlaceholderText = "❌ Invalid Key"
    end
end)

-- Close GUI
closeBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    blur:Destroy()
end)
