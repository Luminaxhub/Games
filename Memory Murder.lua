-- Services
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

-- Variables
local hue = 0
local isMinimized = false

-- GUI Setup
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "RGBLoaderRU"
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 170, 0, 80)
frame.Position = UDim2.new(0.4, 0, 0.4, 0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BackgroundTransparency = 0.1
frame.Active = true
frame.Draggable = true

-- Title Label
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -25, 0, 25)
title.Position = UDim2.new(0, 5, 0, 0)
title.BackgroundTransparency = 1
title.Text = "📜 Убийство памяти"
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextColor3 = Color3.fromRGB(255,255,255)

-- Minimize Button
local min = Instance.new("TextButton", frame)
min.Size = UDim2.new(0, 20, 0, 20)
min.Position = UDim2.new(1, -22, 0, 2)
min.BackgroundTransparency = 1
min.Font = Enum.Font.GothamBold
min.Text = "-"
min.TextColor3 = Color3.fromRGB(255,255,255)
min.TextSize = 16

-- Execute Button
local exe = Instance.new("TextButton", frame)
exe.Size = UDim2.new(0.8, 0, 0.35, 0)
exe.Position = UDim2.new(0.1, 0, 0.5, 0)
exe.BackgroundColor3 = Color3.fromRGB(0,170,255)
exe.Text = "Выполнить"
exe.Font = Enum.Font.GothamBold
exe.TextColor3 = Color3.fromRGB(255,255,255)
exe.TextSize = 14

-- Credit Label (Bottom Center)
local credit = Instance.new("TextLabel", gui)
credit.AnchorPoint = Vector2.new(0.5, 1)
credit.Position = UDim2.new(0.5, 0, 1, -20)
credit.Size = UDim2.new(0, 300, 0, 25)
credit.BackgroundTransparency = 1
credit.Text = "⭐ Скрипт от - Luminaprojects ⭐"
credit.Font = Enum.Font.Gotham
credit.TextSize = 14
credit.TextColor3 = Color3.fromRGB(255,255,255)

-- Drag Compatibility
local dragging, dragStart, startPos
frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.Touch then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)
frame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.Touch then
		dragging = false
	end
end)

-- Execute Script
exe.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/rndmq/Serverlist/refs/heads/main/Loader"))()
end)

-- Minimize Function
min.MouseButton1Click:Connect(function()
	isMinimized = not isMinimized
	if isMinimized then
		TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 170, 0, 28)}):Play()
		exe.Visible = false
	else
		TweenService:Create(frame, TweenInfo.new(0.3), {Size = UDim2.new(0, 170, 0, 80)}):Play()
		exe.Visible = true
	end
end)

-- RGB Loop
task.spawn(function()
	while true do
		hue = (hue + 1) % 360
		local color = Color3.fromHSV(hue/360, 1, 1)
		credit.TextColor3 = color
		exe.BackgroundColor3 = color
		task.wait(0.03)
	end
end)
