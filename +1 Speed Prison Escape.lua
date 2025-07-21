--// 🔒 Local references
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// 🎛️ Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "CheatSheet"
ScreenGui.Parent = playerGui

--// 🪟 Create Background Frame
local Frame = Instance.new("Frame")
Frame.Name = "BackgroundFrame"
Frame.Size = UDim2.new(0, 250, 0, 300)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BackgroundTransparency = 0.5
Frame.BorderSizePixel = 3
Frame.Visible = true
Frame.Parent = ScreenGui

--// 🧲 Drag support
local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.Parent = Frame

--// 🎨 RGB effect
local function applyRGB(obj)
    coroutine.wrap(function()
        while true do
            for i = 0, 1, 0.01 do
                obj.TextColor3 = Color3.fromHSV(i, 1, 1)
                obj.BorderColor3 = Color3.fromHSV(i, 1, 1)
                task.wait(0.02)
            end
        end
    end)()
end

--// 🏷️ Title Label
local Title = Instance.new("TextLabel")
Title.Name = "DragLabel"
Title.Text = "+1 Speed Prison Escape"
Title.TextScaled = true
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
applyRGB(Title)
Title.Parent = Frame

--// 📜 Scrolling Frame
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 0, 210)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollingFrame.ScrollBarThickness = 6
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Parent = Frame

--// 💰 CASH Label
local TextLabel2 = Instance.new("TextLabel")
TextLabel2.Name = "FinishLabel"
TextLabel2.Text = "CASH"
TextLabel2.TextScaled = true
TextLabel2.Size = UDim2.new(1, 0, 0, 25)
TextLabel2.Position = UDim2.new(0, 0, 0, 10)
TextLabel2.BackgroundTransparency = 1
TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel2.Parent = ScrollingFrame

--// 🎯 Claim Button
local ImageButton2 = Instance.new("ImageButton")
ImageButton2.Size = UDim2.new(0, 25, 0, 25)
ImageButton2.Position = UDim2.new(0.75, 0, 0, 0)
ImageButton2.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ImageButton2.BackgroundTransparency = 0.5
ImageButton2.ImageTransparency = 1
ImageButton2.Parent = TextLabel2

--// ✅ Teleport Toggle Logic
local Debounce2 = false
ImageButton2.MouseButton1Click:Connect(function()
    local pos = nil
    for _, model in ipairs(workspace:WaitForChild("Mainbuild"):WaitForChild("Levels"):WaitForChild("Finish"):GetChildren()) do
        if model:IsA("Model") then
            pos = model:GetPivot()
            break
        end
    end

    if not pos then warn("❗ Finish position not found!") return end

    Debounce2 = not Debounce2
    ImageButton2.BackgroundColor3 = Debounce2 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)

    if Debounce2 then
        task.spawn(function()
            while Debounce2 do
                task.wait(1)
                if player.Character then
                    player.Character:PivotTo(pos)
                end
            end
        end)
    end
end)

--// 🏃‍♂️ WalkSpeed Control
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Text = "Custom WalkSpeed"
SpeedLabel.Size = UDim2.new(1, -10, 0, 25)
SpeedLabel.Position = UDim2.new(0, 5, 0, 45)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.TextScaled = true
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.Parent = ScrollingFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.PlaceholderText = "Enter Speed (e.g. 100)"
SpeedBox.Text = ""
SpeedBox.Size = UDim2.new(1, -20, 0, 25)
SpeedBox.Position = UDim2.new(0, 10, 0, 75)
SpeedBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.ClearTextOnFocus = false
SpeedBox.BorderSizePixel = 2
applyRGB(SpeedBox)
SpeedBox.Parent = ScrollingFrame

SpeedBox.FocusLost:Connect(function(enter)
    if enter then
        local speed = tonumber(SpeedBox.Text)
        if speed and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = speed
        end
    end
end)

--// ⚙️ Toggle UI Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Position = UDim2.new(0, 5, 0.5, -25)
ToggleBtn.Text = "⚙️"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleBtn.BackgroundTransparency = 0.5
ToggleBtn.BorderSizePixel = 2
applyRGB(ToggleBtn)
ToggleBtn.Parent = ScreenGui

ToggleBtn.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

--// Credit Label
local Credit = Instance.new("TextLabel")
Credit.Text = "Script by - @Luminaprojects"
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.TextScaled = true
Credit.Font = Enum.Font.GothamSemibold
applyRGB(Credit)
Credit.Parent = Frame
