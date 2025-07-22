-- ✅ Premium UI Destroy Grandma (Android-Friendly, Toggleable)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local ESP_PLAYER_COLOR = Color3.fromRGB(255, 0, 0)
local ESP_KEY_COLOR = Color3.fromRGB(0, 255, 0)
local ESP_CHEST_COLOR = Color3.fromRGB(255, 215, 0)
local ESP_TOOL_COLOR = Color3.fromRGB(0, 0, 255)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.Name = "DestroyGrandmaUI"

-- RGB border cycle
local function createRGB(frame)
    local r, g, b = 255, 0, 0
    local direction = "g"
    RunService.RenderStepped:Connect(function()
        if direction == "g" then g = g + 5 if g >= 255 then direction = "b" end
        elseif direction == "b" then r = r - 5 if r <= 0 then direction = "r" end
        elseif direction == "r" then b = b - 5; r = r + 5 if b <= 0 and r >= 255 then direction = "g" end
        end
        frame.BorderColor3 = Color3.fromRGB(r, g, b)
    end)
end

-- Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 240, 0, 240)
Frame.Position = UDim2.new(0.7, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
createRGB(Frame)

-- Toggle UI button
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "⚙️"
ToggleButton.TextScaled = true
ToggleButton.Font = Enum.Font.GothamBlack
ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BorderSizePixel = 2
ToggleButton.Parent = ScreenGui
createRGB(ToggleButton)

ToggleButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Text = "DESTROY GRANDMA"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = Frame

-- Credit
local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0.1, 0)
Credit.Position = UDim2.new(0, 0, 0.9, 0)
Credit.Text = "🔎 script by - luminaprojects 🔎"
Credit.TextColor3 = Color3.new(1, 1, 1)
Credit.TextScaled = true
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.GothamBold
Credit.Parent = Frame
createRGB(Credit)

-- Create toggle switch
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
    Button.Size = UDim2.new(0.25, 0, 0.8, 0)
    Button.Position = UDim2.new(0.75, 0, 0.1, 0)
    Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    Button.Text = ""
    Button.AutoButtonColor = false
    Button.Parent = Container

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0.4, 0, 1, 0)
    Dot.Position = UDim2.new(0, 0, 0, 0)
    Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Dot.BorderSizePixel = 0
    Dot.Parent = Button

    local Toggled = false

    Button.MouseButton1Click:Connect(function()
        Toggled = not Toggled
        if Toggled then
            Dot:TweenPosition(UDim2.new(0.6, 0, 0, 0), "Out", "Sine", 0.2)
            Button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        else
            Dot:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Sine", 0.2)
            Button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end
        callback(Toggled)
    end)
end

-- ESP functions
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

-- Create toggles
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.2, 0), "Player ESP", togglePlayerESP)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.35, 0), "Key ESP", function(state) toggleESP("Keys", ESP_KEY_COLOR, state) end)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.5, 0), "Chest ESP", function(state) toggleESP("Chests", ESP_CHEST_COLOR, state) end)
createToggleSwitch(Frame, UDim2.new(0.05, 0, 0.65, 0), "Tool ESP", function(state) toggleESP("Tools", ESP_TOOL_COLOR, state) end)
