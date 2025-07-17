-- Flow's Prop Hunt ESP UI with GetKey, Team Check, and Credit (RGB)
-- Script by - @Luminaprojects

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Variables
local ESPEnabled = false
local TeamCheckEnabled = false
local drawings = {}

-- GetKey UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowESPUI"

local function createFrame(name, size, pos, parent)
    local f = Instance.new("Frame", parent)
    f.Name = name
    f.Size = size
    f.Position = pos
    f.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    f.BorderSizePixel = 0
    f.BackgroundTransparency = 0.3
    return f
end

local function createButton(text, pos, parent)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(0, 120, 0, 30)
    b.Position = pos
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(1,1,1)
    b.BorderSizePixel = 0
    return b
end

local function createLabel(text, size, pos, parent)
    local l = Instance.new("TextLabel", parent)
    l.Size = size
    l.Position = pos
    l.Text = text
    l.BackgroundTransparency = 1
    l.TextColor3 = Color3.new(1,1,1)
    l.TextScaled = true
    l.Font = Enum.Font.SourceSansBold
    return l
end

-- Main UI Frame
local Frame = createFrame("MainFrame", UDim2.new(0, 300, 0, 200), UDim2.new(0.5, -150, 0.5, -100), ScreenGui)
Frame.Visible = false

-- Title + Credit
createLabel("🔎 Flow's Prop Hunt", UDim2.new(1, 0, 0, 30), UDim2.new(0, 0, 0, 0), Frame)
local rgbCredit = createLabel("Script by - @Luminaprojects", UDim2.new(1, 0, 0, 20), UDim2.new(0, 0, 1, -20), Frame)

-- ESP Toggle
local ToggleESP = createButton("ESP: OFF", UDim2.new(0, 20, 0, 40), Frame)
ToggleESP.MouseButton1Click:Connect(function()
    ESPEnabled = not ESPEnabled
    ToggleESP.Text = ESPEnabled and "ESP: ON" or "ESP: OFF"
end)

-- Team Check Toggle
local ToggleTeamCheck = createButton("TEAM CHECK: OFF", UDim2.new(0, 160, 0, 40), Frame)
ToggleTeamCheck.MouseButton1Click:Connect(function()
    TeamCheckEnabled = not TeamCheckEnabled
    ToggleTeamCheck.Text = TeamCheckEnabled and "TEAM CHECK: ON" or "TEAM CHECK: OFF"
end)

-- Minimize Button
local MinBtn = createButton("-", UDim2.new(1, -35, 0, 5), Frame)
MinBtn.Size = UDim2.new(0, 30, 0, 20)
MinBtn.Text = "-"
MinBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Dragging
local dragging, offset
Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        offset = input.Position - Frame.Position
    end
end)
Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        Frame.Position = UDim2.new(0, input.Position.X - offset.X.Offset, 0, input.Position.Y - offset.Y.Offset)
    end
end)

-- RGB Credit Loop
task.spawn(function()
    while true do
        for hue = 0, 1, 0.01 do
            rgbCredit.TextColor3 = Color3.fromHSV(hue, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- ESP Loop
RunService.RenderStepped:Connect(function()
    for _, v in pairs(drawings) do
        for _, d in pairs(v) do
            d.Visible = false
        end
    end
    if not ESPEnabled then return end
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            if TeamCheckEnabled and player.Team == LocalPlayer.Team then
                continue
            end
            local root = player.Character.HumanoidRootPart
            local pos, onscreen = workspace.CurrentCamera:WorldToViewportPoint(root.Position)
            if not onscreen then continue end
            local head = player.Character:FindFirstChild("Head")
            local distance = (root.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
            local size = math.clamp(3000 / distance, 50, 300)
            local box = drawings[player] and drawings[player].Box or Drawing.new("Square")
            local health = drawings[player] and drawings[player].Health or Drawing.new("Square")
            box.Size = Vector2.new(size / 2, size)
            box.Position = Vector2.new(pos.X - size / 4, pos.Y - size / 2)
            box.Thickness = 1.5
            box.Color = Color3.new(1,1,1)
            box.Transparency = 1
            box.Visible = true
            box.Filled = false
            health.Size = Vector2.new(4, (player.Character.Humanoid.Health/player.Character.Humanoid.MaxHealth) * size)
            health.Position = Vector2.new(pos.X - size / 4 - 6, pos.Y - size / 2 + (size - health.Size.Y))
            health.Color = Color3.fromRGB(0,255,0)
            health.Visible = true
            health.Filled = true
            drawings[player] = {Box = box, Health = health}
        else
            if drawings[player] then
                for _, d in pairs(drawings[player]) do
                    d.Visible = false
                end
            end
        end
    end
end)

-- GetKey UI
local KeyFrame = createFrame("KeyUI", UDim2.new(0, 250, 0, 150), UDim2.new(0.5, -125, 0.5, -75), ScreenGui)
local keyBox = Instance.new("TextBox", KeyFrame)
keyBox.Size = UDim2.new(0, 200, 0, 30)
keyBox.Position = UDim2.new(0, 25, 0, 50)
keyBox.PlaceholderText = "Enter Key Here"
keyBox.Text = ""
keyBox.TextScaled = true
keyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.BorderSizePixel = 0

local getKeyBtn = createButton("Get Key", UDim2.new(0, 65, 0, 90), KeyFrame)
getKeyBtn.TextColor3 = Color3.fromRGB(255,255,0)
getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard("https://get-key-luminakey.vercel.app/")
end)

local confirmBtn = createButton("Submit", UDim2.new(0, 65, 0, 120), KeyFrame)
confirmBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "LUMINAKEY_pxs0up8r2bh2j19" then
        KeyFrame.Visible = false
        Frame.Visible = true
    else
        keyBox.Text = "Invalid Key!"
    end
end)
