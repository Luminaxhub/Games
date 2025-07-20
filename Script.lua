-- 🌟 Shrink Hide & Seek ESP UI with Skeleton, Hitbox, Noclip & RGB Effects - Script by @Luminaprojects

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

-- Settings
local esp_settings = {
    enabled = true,
    skel_col = Color3.fromRGB(255, 255, 255),
    hitbox_size = 10,
    hitbox_enabled = false,
    noclip_enabled = false
}

-- UI Elements
local ui = Instance.new("ScreenGui", game.CoreGui)
ui.Name = "ESP_UI"

local main = Instance.new("Frame", ui)
main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
main.BorderSizePixel = 2
main.Position = UDim2.new(0, 100, 0, 100)
main.Size = UDim2.new(0, 250, 0, 220)
main.Active = true
main.Draggable = true

local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 8)

-- RGB Border Effect
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            main.BorderColor3 = Color3.fromHSV(i, 1, 1)
            task.wait()
        end
    end
end)

-- Title
local title = Instance.new("TextLabel", main)
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "⛺ Shrink Hide & Seek"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Toggle UI Button
local toggleUI = Instance.new("TextButton", ui)
toggleUI.Position = UDim2.new(0, 10, 0, 10)
toggleUI.Size = UDim2.new(0, 40, 0, 40)
toggleUI.Text = "⚙️"
toggleUI.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleUI.TextColor3 = Color3.new(1, 1, 1)

local toggleCorner = Instance.new("UICorner", toggleUI)
toggleCorner.CornerRadius = UDim.new(1, 0)

-- RGB Border Effect on toggle
spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            toggleUI.BorderColor3 = Color3.fromHSV(i, 1, 1)
            toggleUI.BorderSizePixel = 2
            task.wait()
        end
    end
end)

toggleUI.MouseButton1Click:Connect(function()
    main.Visible = not main.Visible
end)

-- Create Toggle Button Function
local function createToggle(name, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 30)
    btn.Position = UDim2.new(0.05, 0, 0, #parent:GetChildren() * 35)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
    btn.Text = name .. ": ON"

    local state = true
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(60, 150, 60) or Color3.fromRGB(150, 60, 60)
        btn.Text = name .. (state and ": ON" or ": OFF")
        callback(state)
    end)

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 4)
end

-- ESP Toggle
createToggle("ESP", main, function(val)
    esp_settings.enabled = val
end)

-- Noclip Toggle
createToggle("Noclip", main, function(val)
    esp_settings.noclip_enabled = val
end)

-- Hitbox Toggle
createToggle("Hitbox", main, function(val)
    esp_settings.hitbox_enabled = val
end)

-- Hitbox Size Slider
local hitboxLabel = Instance.new("TextLabel", main)
hitboxLabel.Text = "Hitbox Size"
hitboxLabel.Size = UDim2.new(0.9, 0, 0, 20)
hitboxLabel.Position = UDim2.new(0.05, 0, 0, 150)
hitboxLabel.BackgroundTransparency = 1
hitboxLabel.TextColor3 = Color3.new(1, 1, 1)
hitboxLabel.Font = Enum.Font.Gotham
hitboxLabel.TextSize = 14

local hitboxSlider = Instance.new("TextBox", main)
hitboxSlider.Size = UDim2.new(0.9, 0, 0, 30)
hitboxSlider.Position = UDim2.new(0.05, 0, 0, 175)
hitboxSlider.PlaceholderText = "0 - 100"
hitboxSlider.Text = tostring(esp_settings.hitbox_size)
hitboxSlider.TextColor3 = Color3.new(1, 1, 1)
hitboxSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
hitboxSlider.Font = Enum.Font.Gotham
hitboxSlider.TextSize = 14

hitboxSlider.FocusLost:Connect(function()
    local val = tonumber(hitboxSlider.Text)
    if val and val >= 0 and val <= 100 then
        esp_settings.hitbox_size = val
    else
        hitboxSlider.Text = tostring(esp_settings.hitbox_size)
    end
end)

-- RGB Credit
local credit = Instance.new("TextLabel", ui)
credit.Position = UDim2.new(0, 10, 1, -30)
credit.Size = UDim2.new(0, 300, 0, 25)
credit.Text = "Script by - @Luminaprojects"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 14
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(255, 255, 255)

spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            credit.TextColor3 = Color3.fromHSV(i, 1, 1)
            task.wait()
        end
    end
end)

-- Noclip Logic
RunService.Stepped:Connect(function()
    if esp_settings.noclip_enabled then
        for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-- Hitbox Logic
RunService.RenderStepped:Connect(function()
    if esp_settings.hitbox_enabled then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = plr.Character.HumanoidRootPart
                hrp.Size = Vector3.new(esp_settings.hitbox_size, esp_settings.hitbox_size, esp_settings.hitbox_size)
                hrp.Transparency = 0.7
                hrp.BrickColor = BrickColor.new("Really blue")
                hrp.Material = "Neon"
                hrp.CanCollide = false
            end
        end
    end
end)

-- TODO: ESP Box/Tracer/Skeleton Implementation Here
