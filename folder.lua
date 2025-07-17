local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local settings = {
    TeamCheck = false,
    Tracer = true,
    BoxESP = true,
    HealthBar = true,
    WalkSpeed = 16,
    JumpPower = 50,
}

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowESPUI"

-- Draggable Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 250, 0, 300)
Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.Active = true
Main.Draggable = true

local UICorner = Instance.new("UICorner", Main)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Main)
Title.Text = "🔎 Flow's Prop Hunt"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Name = "Title"

local Subtitle = Instance.new("TextLabel", Main)
Subtitle.Text = "Featured ⚙️"
Subtitle.Position = UDim2.new(0, 0, 0, 30)
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.BackgroundTransparency = 1
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 12
Subtitle.Name = "Subtitle"

local isMinimized = false

local MinimizeBtn = Instance.new("TextButton", Main)
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 2)
MinimizeBtn.Text = "-"
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 18
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.TextColor3 = Color3.new(1,1,1)

-- Toggle & Slider Creation
local ContentElements = {}

local function createToggle(name, default, yPosition, callback)
    local Toggle = Instance.new("TextButton", Main)
    Toggle.Size = UDim2.new(0, 220, 0, 25)
    Toggle.Position = UDim2.new(0, 15, 0, yPosition)
    Toggle.BackgroundColor3 = default and Color3.fromRGB(70, 200, 70) or Color3.fromRGB(200, 70, 70)
    Toggle.Text = name
    Toggle.TextColor3 = Color3.new(1, 1, 1)
    Toggle.Font = Enum.Font.Gotham
    Toggle.TextSize = 14

    table.insert(ContentElements, Toggle)

    local state = default
    Toggle.MouseButton1Click:Connect(function()
        state = not state
        Toggle.BackgroundColor3 = state and Color3.fromRGB(70, 200, 70) or Color3.fromRGB(200, 70, 70)
        callback(state)
    end)

    callback(default)
end

local function createSlider(name, min, max, yPosition, callback)
    local Label = Instance.new("TextLabel", Main)
    Label.Text = name
    Label.Position = UDim2.new(0, 15, 0, yPosition)
    Label.Size = UDim2.new(0, 100, 0, 20)
    Label.TextColor3 = Color3.new(1, 1, 1)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    table.insert(ContentElements, Label)

    local Slider = Instance.new("TextButton", Main)
    Slider.Position = UDim2.new(0, 120, 0, yPosition)
    Slider.Size = UDim2.new(0, 100, 0, 20)
    Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Slider.Text = tostring(settings[name])
    Slider.TextColor3 = Color3.new(1, 1, 1)
    Slider.Font = Enum.Font.Gotham
    Slider.TextSize = 12
    table.insert(ContentElements, Slider)

    Slider.MouseButton1Click:Connect(function()
        local value = tonumber(Slider.Text)
        value = value + 10
        if value > max then value = min end
        Slider.Text = tostring(value)
        callback(value)
    end)

    callback(settings[name])
end

-- Apply Settings
createToggle("ESP Box", true, 60, function(v) settings.BoxESP = v end)
createToggle("ESP Tracer", true, 95, function(v) settings.Tracer = v end)
createToggle("Health Bar", true, 130, function(v) settings.HealthBar = v end)
createToggle("Team Check", false, 165, function(v) settings.TeamCheck = v end)

createSlider("WalkSpeed", 16, 100, 200, function(v)
    settings.WalkSpeed = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
end)

createSlider("JumpPower", 50, 100, 235, function(v)
    settings.JumpPower = v
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
end)

-- Health Bar & ESP
local function createESP(player)
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    local hum = player.Character:FindFirstChild("Humanoid")
    if not root or not hum then return end

    local Billboard = Instance.new("BillboardGui", root)
    Billboard.Adornee = root
    Billboard.Size = UDim2.new(4, 0, 5, 0)
    Billboard.AlwaysOnTop = true
    Billboard.Name = "ESPBox"

    local BoxFrame = Instance.new("Frame", Billboard)
    BoxFrame.Size = UDim2.new(1, 0, 1, 0)
    BoxFrame.BackgroundTransparency = 1
    BoxFrame.BorderSizePixel = 2
    BoxFrame.BorderColor3 = Color3.new(1, 1, 1)

    local HealthBar = Instance.new("Frame", Billboard)
    HealthBar.Name = "HealthBar"
    HealthBar.Size = UDim2.new(0.1, 0, 1, 0)
    HealthBar.Position = UDim2.new(-0.15, 0, 0, 0)
    HealthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
end

local function updateESP()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if settings.TeamCheck and v.Team == LocalPlayer.Team then continue end
            if not v.Character:FindFirstChild("ESPBox") then
                createESP(v)
            end

            local esp = v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("ESPBox")
            local hpbar = esp and esp:FindFirstChild("HealthBar")
            if esp and hpbar and settings.HealthBar then
                local hum = v.Character:FindFirstChild("Humanoid")
                if hum then
                    local hpRatio = hum.Health / hum.MaxHealth
                    hpbar.Size = UDim2.new(0.1, 0, hpRatio, 0)
                    hpbar.Position = UDim2.new(-0.15, 0, 1 - hpRatio, 0)
                    hpbar.Visible = true
                end
            elseif hpbar then
                hpbar.Visible = false
            end
        end
    end
end

-- Update ESP every frame
RunService.RenderStepped:Connect(updateESP)

-- MINIMIZE LOGIC
MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        for _, v in pairs(ContentElements) do
            v.Visible = false
        end
        Main.Size = UDim2.new(0, 250, 0, 35)
        MinimizeBtn.Text = "+"
    else
        for _, v in pairs(ContentElements) do
            v.Visible = true
        end
        Main.Size = UDim2.new(0, 250, 0, 300)
        MinimizeBtn.Text = "-"
    end
end)
