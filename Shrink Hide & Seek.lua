-- ⛺ Shrink Hide & Seek by @luminaprojects
if game.PlaceId ~= 137541498231955 then return end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ShrinkHubUI"

-- OPEN BUTTON
local openBtn = Instance.new("TextButton", ScreenGui)
openBtn.Size = UDim2.new(0, 120, 0, 35)
openBtn.Position = UDim2.new(0, 10, 0.4, 0)
openBtn.Text = "OPEN ⛺"
openBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
openBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
openBtn.BorderSizePixel = 0
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 16
openBtn.AutoButtonColor = false

-- RGB Border Effect
local function RGB(obj)
	local hue = 0
	RunService.RenderStepped:Connect(function()
		hue = (hue + 0.005) % 1
		obj.BorderColor3 = Color3.fromHSV(hue, 1, 1)
		obj.BorderSizePixel = 2
	end)
end
RGB(openBtn)

-- MAIN UI
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 310)
Frame.Position = UDim2.new(0.5, -125, 0.5, -155)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Visible = false
Frame.BorderSizePixel = 0

-- Drag Support
local dragging, dragInput, dragStart, startPos
Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Toggle UI
openBtn.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)

-- CREATE BUTTON FUNCTION
local function createBtn(name, color, y, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(0, 230, 0, 35)
	btn.Position = UDim2.new(0, 10, 0, y)
	btn.BackgroundColor3 = color
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	btn.MouseButton1Click:Connect(callback)
end

-- ESP
createBtn("ESP", Color3.fromRGB(0, 200, 255), 10, function()
	for _,v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character then
			local box = Instance.new("BoxHandleAdornment", v.Character)
			box.Adornee = v.Character:FindFirstChild("HumanoidRootPart")
			box.Size = Vector3.new(4, 6, 1)
			box.Color3 = Color3.fromRGB(255, 0, 0)
			box.AlwaysOnTop = true
			box.ZIndex = 5
		end
	end
end)

-- Hitbox
createBtn("Hitbox", Color3.fromRGB(255, 0, 0), 50, function()
	for _,v in pairs(Players:GetPlayers()) do
		if v ~= LocalPlayer and v.Character then
			local hrp = v.Character:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.Size = Vector3.new(10, 10, 10) end
		end
	end
end)

-- Noclip
createBtn("Noclip", Color3.fromRGB(255, 100, 0), 90, function()
	local noclip = true
	RunService.Stepped:Connect(function()
		if noclip and LocalPlayer.Character then
			for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end)
end)

-- Auto Spin
createBtn("Auto Spin", Color3.fromRGB(0, 255, 0), 130, function()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Spin"):InvokeServer()
end)

-- Mini Mode 39R$
createBtn("Mini Mode 39R$", Color3.fromRGB(255, 0, 0), 170, function()
	local args = {
		{
			{ "Shrink" },
			"\005"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end)

-- Big Mode
createBtn("Big Mode", Color3.fromRGB(0, 200, 255), 210, function()
	local args = {
		{
			{ "Grow" },
			"\005"
		}
	}
	game:GetService("ReplicatedStorage"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
end)

-- CREDIT
local credit = Instance.new("TextLabel", Frame)
credit.Size = UDim2.new(1, 0, 0, 30)
credit.Position = UDim2.new(0, 0, 1, -30)
credit.BackgroundTransparency = 1
credit.Text = "⭐ Script by - @Luminaprojects ⭐"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 12
credit.TextColor3 = Color3.new(1,1,1)

-- RGB Credit Text
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			credit.TextColor3 = Color3.fromHSV(i,1,1)
			wait()
		end
	end
end)
