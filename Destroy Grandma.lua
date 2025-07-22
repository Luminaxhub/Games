-- ✅ Final Version - Destroy Grandma ESP UI
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ESP_PLAYER_COLOR = Color3.fromRGB(255, 0, 0)
local ESP_KEY_COLOR = Color3.fromRGB(0, 255, 0)
local ESP_CHEST_COLOR = Color3.fromRGB(255, 215, 0)
local ESP_TOOL_COLOR = Color3.fromRGB(0, 0, 255)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DestroyGrandmaUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Rayfield-like Notification
local Notification = Instance.new("TextLabel")
Notification.Size = UDim2.new(0, 300, 0, 50)
Notification.Position = UDim2.new(0.5, -150, 0.05, 0)
Notification.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Notification.Text = "Luminaprojects"
Notification.TextColor3 = Color3.fromRGB(255, 255, 255)
Notification.TextScaled = true
Notification.Font = Enum.Font.GothamBold
Notification.BackgroundTransparency = 0.1
Notification.BorderSizePixel = 0
Notification.ZIndex = 10
Notification.Parent = ScreenGui

spawn(function()
    wait(3)
    Notification:Destroy()
end)

-- Main UI
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 350)
Frame.Position = UDim2.new(0.7, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 2
Frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "Destroy Grandma"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0.2, 0, 0.15, 0)
CloseButton.Position = UDim2.new(0.8, 0, 0, 0)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Frame
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

local function createHighlight(target, color)
    if target:IsA("Model") or target:IsA("BasePart") then
        if not target:FindFirstChildOfClass("Highlight") then
            local highlight = Instance.new("Highlight")
            highlight.Adornee = target
            highlight.FillColor = color
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.OutlineTransparency = 0.1
            highlight.Parent = target
        end
    end
end

local function toggleESP(category, color, state)
    local parent = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild(category)
    if parent then
        for _, obj in pairs(parent:GetChildren()) do
            if state then
                createHighlight(obj, color)
            else
                local highlight = obj:FindFirstChildOfClass("Highlight")
                if highlight then highlight:Destroy() end
            end
        end
    end
end

local function togglePlayerESP(state)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            if state then
                createHighlight(player.Character, ESP_PLAYER_COLOR)
            else
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight then highlight:Destroy() end
            end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        togglePlayerESP(true)
    end)
end)

if workspace:FindFirstChild("Map") then
    for _, category in pairs({"Keys", "Chests", "Tools"}) do
        if workspace.Map:FindFirstChild(category) then
            workspace.Map[category].ChildAdded:Connect(function(obj)
                toggleESP(category, _G["ESP_" .. category:upper() .. "_COLOR"], true)
            end)
        end
    end
end

local function createToggleSwitch(parent, position, labelText, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.9, 0, 0.15, 0)
    Container.Position = position
    Container.BackgroundTransparency = 1
    Container.Parent = parent

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 0, 0, 0)
    Label.Text = labelText
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextScaled = true
    Label.Font = Enum.Font.Gotham
    Label.Parent = Container

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.25, 0, 1, 0)
    Button.Position = UDim2.new(0.75, 0, 0, 0)
    Button.Text = "OFF"
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    Button.Parent = Container

    local Toggled = false

    Button.MouseButton1Click:Connect(function()
        Toggled = not Toggled
        Button.Text = Toggled and "ON" or "OFF"
        Button.BackgroundColor3 = Toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(200, 0, 0)
        callback(Toggled)
    end)
end

createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.2, 0), "Player ESP", togglePlayerESP)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.35, 0), "Key ESP", function(state) toggleESP("Keys", ESP_KEY_COLOR, state) end)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.5, 0), "Chest ESP", function(state) toggleESP("Chests", ESP_CHEST_COLOR, state) end)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.65, 0), "Tool ESP", function(state) toggleESP("Tools", ESP_TOOL_COLOR, state) end)
