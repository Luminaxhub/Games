-- ✅ Updated ESP Script UI Premium Style - Destroy Grandma by @Luminaprojects
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ESP_PLAYER_COLOR = Color3.fromRGB(255, 0, 0) -- Red for players
local ESP_KEY_COLOR = Color3.fromRGB(0, 255, 0) -- Green for keys
local ESP_CHEST_COLOR = Color3.fromRGB(255, 215, 0) -- Gold for chests
local ESP_TOOL_COLOR = Color3.fromRGB(0, 0, 255) -- Blue for tools

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DestroyGrandmaUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Rayfield-like Floating Notification (Text Only)
local RayNotif = Instance.new("TextLabel")
RayNotif.Name = "RayfieldNotification"
RayNotif.Size = UDim2.new(0, 300, 0, 40)
RayNotif.Position = UDim2.new(0.5, -150, 0.05, 0)
RayNotif.BackgroundTransparency = 1
RayNotif.Text = "Luminaprojects"
RayNotif.TextColor3 = Color3.fromRGB(255, 255, 255)
RayNotif.TextStrokeTransparency = 0.5
RayNotif.Font = Enum.Font.GothamBold
RayNotif.TextScaled = true
RayNotif.ZIndex = 10
RayNotif.Parent = ScreenGui

spawn(function()
    wait(2.5)
    RayNotif:Destroy()
end)

-- Main Frame (Modern Glass UI Style)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 400)
Frame.Position = UDim2.new(0.7, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 2
UIStroke.Color = Color3.fromRGB(0, 255, 255)
UIStroke.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.13, 0)
Title.Text = "DESTROY GRANDMA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = Frame

-- Subtitle / Credit (Bottom Center)
local Credit = Instance.new("TextLabel")
Credit.AnchorPoint = Vector2.new(0.5, 1)
Credit.Position = UDim2.new(0.5, 0, 1, -5)
Credit.Size = UDim2.new(1, -20, 0.07, 0)
Credit.Text = "🔎 script by - luminaprojects 🔎"
Credit.TextColor3 = Color3.fromRGB(0, 255, 255)
Credit.TextScaled = true
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.Gotham
Credit.Parent = Frame

-- Function createHighlight remains same
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
    player.CharacterAdded:Connect(function(character)
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

-- Toggle Builder (Premium Style Switch)
local function createToggleSwitch(parent, position, labelText, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.9, 0, 0.12, 0)
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

    local SwitchFrame = Instance.new("Frame")
    SwitchFrame.Size = UDim2.new(0.25, 0, 0.8, 0)
    SwitchFrame.Position = UDim2.new(0.75, 0, 0.1, 0)
    SwitchFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    SwitchFrame.BorderSizePixel = 0
    SwitchFrame.Parent = Container

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0.4, 0, 1, 0)
    Dot.Position = UDim2.new(0, 0, 0, 0)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.BorderSizePixel = 0
    Dot.Parent = SwitchFrame

    local Toggled = false

    SwitchFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Toggled = not Toggled
            if Toggled then
                Dot:TweenPosition(UDim2.new(0.6, 0, 0, 0), "Out", "Sine", 0.2)
                SwitchFrame.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            else
                Dot:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 0.2)
                SwitchFrame.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            end
            callback(Toggled)
        end
    end)
end

-- Add Toggles
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.18, 0), "Player ESP", togglePlayerESP)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.33, 0), "Key ESP", function(state) toggleESP("Keys", ESP_KEY_COLOR, state) end)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.48, 0), "Chest ESP", function(state) toggleESP("Chests", ESP_CHEST_COLOR, state) end)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.63, 0), "Tool ESP", function(state) toggleESP("Tools", ESP_TOOL_COLOR, state) end)
