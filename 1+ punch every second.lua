local code = [[
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui")

-- Main UI Container
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DualSystemUI_Mobile"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Toggle buttons
local ToggleButton1 = Instance.new("TextButton")
ToggleButton1.Name = "PunchToggle"
ToggleButton1.Text = "🥊"
ToggleButton1.Font = Enum.Font.GothamBold
ToggleButton1.TextSize = 20
ToggleButton1.Size = UDim2.new(0, 40, 0, 40)
ToggleButton1.Position = UDim2.new(0, 10, 0.5, -60)
ToggleButton1.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
ToggleButton1.TextColor3 = Color3.new(1, 1, 1)
ToggleButton1.BackgroundTransparency = 0.3
Instance.new("UICorner", ToggleButton1).CornerRadius = UDim.new(0, 12)
ToggleButton1.Parent = ScreenGui

local ToggleButton2 = Instance.new("TextButton")
ToggleButton2.Name = "RewardToggle"
ToggleButton2.Text = "💰"
ToggleButton2.Font = Enum.Font.GothamBold
ToggleButton2.TextSize = 20
ToggleButton2.Size = UDim2.new(0, 40, 0, 40)
ToggleButton2.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton2.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
ToggleButton2.TextColor3 = Color3.new(1, 1, 1)
ToggleButton2.BackgroundTransparency = 0.3
Instance.new("UICorner", ToggleButton2).CornerRadius = UDim.new(0, 12)
ToggleButton2.Parent = ScreenGui

-- UI 1: Punch System Frame
local MainFrame1 = Instance.new("Frame")
MainFrame1.Size = UDim2.new(0, 220, 0, 350)
MainFrame1.Position = UDim2.new(0.5, -250, 0.1, 0)
MainFrame1.AnchorPoint = Vector2.new(0.5, 0)
MainFrame1.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame1.BackgroundTransparency = 0.3
MainFrame1.Visible = false
Instance.new("UICorner", MainFrame1).CornerRadius = UDim.new(0, 12)

local TitleBar1 = Instance.new("Frame")
TitleBar1.Size = UDim2.new(1, 0, 0, 30)
TitleBar1.Position = UDim2.new(0, 0, 0, 0)
TitleBar1.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
TitleBar1.BackgroundTransparency = 0.2
Instance.new("UICorner", TitleBar1).CornerRadius = UDim.new(0, 12)
TitleBar1.Parent = MainFrame1

local Title1 = Instance.new("TextLabel")
Title1.Text = "🥊 Punch System"
Title1.Font = Enum.Font.GothamBold
Title1.TextColor3 = Color3.new(1, 1, 1)
Title1.TextSize = 16
Title1.Size = UDim2.new(1, -40, 1, 0)
Title1.Position = UDim2.new(0, 10, 0, 0)
Title1.BackgroundTransparency = 1
Title1.TextXAlignment = Enum.TextXAlignment.Left
Title1.Parent = TitleBar1

local CloseButton1 = Instance.new("TextButton")
CloseButton1.Text = "X"
CloseButton1.Font = Enum.Font.GothamBold
CloseButton1.TextColor3 = Color3.new(1, 1, 1)
CloseButton1.TextSize = 16
CloseButton1.Size = UDim2.new(0, 30, 1, 0)
CloseButton1.Position = UDim2.new(1, -35, 0, 0)
CloseButton1.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton1.BackgroundTransparency = 0.5
Instance.new("UICorner", CloseButton1).CornerRadius = UDim.new(0, 6)
CloseButton1.Parent = TitleBar1

-- UI 2: Reward System Frame
local MainFrame2 = Instance.new("Frame")
MainFrame2.Size = UDim2.new(0, 220, 0, 220)
MainFrame2.Position = UDim2.new(0.5, 30, 0.1, 0)
MainFrame2.AnchorPoint = Vector2.new(0.5, 0)
MainFrame2.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
MainFrame2.BackgroundTransparency = 0.3
MainFrame2.Visible = false
Instance.new("UICorner", MainFrame2).CornerRadius = UDim.new(0, 12)

local TitleBar2 = Instance.new("Frame")
TitleBar2.Size = UDim2.new(1, 0, 0, 30)
TitleBar2.Position = UDim2.new(0, 0, 0, 0)
TitleBar2.BackgroundColor3 = Color3.fromRGB(50, 100, 50)
TitleBar2.BackgroundTransparency = 0.2
Instance.new("UICorner", TitleBar2).CornerRadius = UDim.new(0, 12)
TitleBar2.Parent = MainFrame2

local Title2 = Instance.new("TextLabel")
Title2.Text = "💰 Reward System"
Title2.Font = Enum.Font.GothamBold
Title2.TextColor3 = Color3.new(1, 1, 1)
Title2.TextSize = 16
Title2.Size = UDim2.new(1, -40, 1, 0)
Title2.Position = UDim2.new(0, 10, 0, 0)
Title2.BackgroundTransparency = 1
Title2.TextXAlignment = Enum.TextXAlignment.Left
Title2.Parent = TitleBar2

local CloseButton2 = Instance.new("TextButton")
CloseButton2.Text = "X"
CloseButton2.Font = Enum.Font.GothamBold
CloseButton2.TextColor3 = Color3.new(1, 1, 1)
CloseButton2.TextSize = 16
CloseButton2.Size = UDim2.new(0, 30, 1, 0)
CloseButton2.Position = UDim2.new(1, -35, 0, 0)
CloseButton2.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton2.BackgroundTransparency = 0.5
Instance.new("UICorner", CloseButton2).CornerRadius = UDim.new(0, 6)
CloseButton2.Parent = TitleBar2

-- New Credit Label (Centered at bottom)
local Credit = Instance.new("TextLabel")
Credit.Name = "CreditLabel"
Credit.Text = "🔎 Script by - @Luminaprojects"
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 18
Credit.TextColor3 = Color3.fromRGB(100, 200, 255)
Credit.Size = UDim2.new(0, 300, 0, 30)
Credit.Position = UDim2.new(0.5, -150, 1, -40)
Credit.AnchorPoint = Vector2.new(0.5, 1)
Credit.BackgroundTransparency = 1
Credit.Parent = ScreenGui

-- Toggle functionality
ToggleButton1.MouseButton1Click:Connect(function()
    MainFrame1.Visible = not MainFrame1.Visible
    if MainFrame1.Visible then
        MainFrame2.Visible = false
    end
end)

ToggleButton2.MouseButton1Click:Connect(function()
    MainFrame2.Visible = not MainFrame2.Visible
    if MainFrame2.Visible then
        MainFrame1.Visible = false
    end
end)

CloseButton1.MouseButton1Click:Connect(function()
    MainFrame1.Visible = false
end)

CloseButton2.MouseButton1Click:Connect(function()
    MainFrame2.Visible = false
end)

-- Drag functionality
local function setupDrag(frame, titleBar)
    local dragging, dragStart, startPos
    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then 
                    dragging = false 
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

setupDrag(MainFrame1, TitleBar1)
setupDrag(MainFrame2, TitleBar2)

-- Parent frames
MainFrame1.Parent = ScreenGui
MainFrame2.Parent = ScreenGui

-- Add sample content to UI1
local SampleLabel = Instance.new("TextLabel")
SampleLabel.Text = "Punch System Content"
SampleLabel.Font = Enum.Font.GothamMedium
SampleLabel.TextSize = 16
SampleLabel.TextColor3 = Color3.new(1,1,1)
SampleLabel.Size = UDim2.new(1, -20, 0, 30)
SampleLabel.Position = UDim2.new(0, 10, 0, 40)
SampleLabel.BackgroundTransparency = 1
SampleLabel.Parent = MainFrame1

-- Add sample reward content to UI2
local RewardContent = Instance.new("Frame")
RewardContent.Size = UDim2.new(1, -10, 1, -40)
RewardContent.Position = UDim2.new(0, 5, 0, 35)
RewardContent.BackgroundTransparency = 1
RewardContent.Parent = MainFrame2

local RewardLabel = Instance.new("TextLabel")
RewardLabel.Text = "Select reward type and amount"
RewardLabel.Font = Enum.Font.GothamMedium
RewardLabel.TextSize = 14
RewardLabel.TextColor3 = Color3.new(1,1,1)
RewardLabel.Size = UDim2.new(1, 0, 0, 30)
RewardLabel.Position = UDim2.new(0, 0, 0, 0)
RewardLabel.BackgroundTransparency = 1
RewardLabel.Parent = RewardContent
]]

-- Execute the code safely
local success, err = pcall(function()
    loadstring(code)()
end)

if not success then
    warn("Error executing script: " .. err)
end
