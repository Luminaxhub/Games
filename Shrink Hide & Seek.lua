-- ⛺ Shirnk Hide & Seek Script by @Luminaprojects

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- CONFIG
_G.ESP = false
_G.HeadSize = 5
_G.Disabled = false
_G.Noclip = false

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ShirnkUI"

-- Toggle Button
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 100, 0, 35)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -80)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleBtn.BorderSizePixel = 3
ToggleBtn.Text = "⛺ OPEN"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.TextSize = 14

-- RGB Border
local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 1) % 255
	ToggleBtn.BorderColor3 = Color3.fromHSV(hue/255, 1, 1)
end)

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 380)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -190)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundTransparency = 1
Title.Text = "⛺ Shirnk Hide & Seek."
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- ESP Toggle
local EspBtn = Instance.new("TextButton", MainFrame)
EspBtn.Size = UDim2.new(0.9, 0, 0, 30)
EspBtn.Position = UDim2.new(0.05, 0, 0, 50)
EspBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
EspBtn.Text = "👀 HIDERS [OFF]"
EspBtn.TextColor3 = Color3.new(1, 1, 1)
EspBtn.Font = Enum.Font.GothamBold
EspBtn.TextSize = 14

EspBtn.MouseButton1Click:Connect(function()
	_G.ESP = not _G.ESP
	EspBtn.BackgroundColor3 = _G.ESP and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	EspBtn.Text = _G.ESP and "👀 HIDERS [ON]" or "👀 HIDERS [OFF]"
end)

-- Hitbox Slider
local HitboxSlider = Instance.new("TextButton", MainFrame)
HitboxSlider.Size = UDim2.new(0.9, 0, 0, 30)
HitboxSlider.Position = UDim2.new(0.05, 0, 0, 90)
HitboxSlider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
HitboxSlider.Text = "Hitbox Size: 5"
HitboxSlider.TextColor3 = Color3.new(1, 1, 1)
HitboxSlider.Font = Enum.Font.Gotham
HitboxSlider.TextSize = 14

HitboxSlider.MouseButton1Click:Connect(function()
	_G.HeadSize = _G.HeadSize + 5
	if _G.HeadSize > 100 then _G.HeadSize = 5 end
	HitboxSlider.Text = "Hitbox Size: ".._G.HeadSize
end)

-- Toggle Hitbox ON/OFF
local HitboxToggle = Instance.new("TextButton", MainFrame)
HitboxToggle.Size = UDim2.new(0.9, 0, 0, 30)
HitboxToggle.Position = UDim2.new(0.05, 0, 0, 130)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
HitboxToggle.Text = "Hitbox [OFF]"
HitboxToggle.TextColor3 = Color3.new(1, 1, 1)
HitboxToggle.Font = Enum.Font.GothamBold
HitboxToggle.TextSize = 14

HitboxToggle.MouseButton1Click:Connect(function()
	_G.Disabled = not _G.Disabled
	HitboxToggle.BackgroundColor3 = _G.Disabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	HitboxToggle.Text = _G.Disabled and "Hitbox [ON]" or "Hitbox [OFF]"
end)

-- NoClip
local NoclipBtn = Instance.new("TextButton", MainFrame)
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 30)
NoclipBtn.Position = UDim2.new(0.05, 0, 0, 170)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
NoclipBtn.Text = "NoClip [OFF]"
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
NoclipBtn.Font = Enum.Font.GothamBold
NoclipBtn.TextSize = 14

NoclipBtn.MouseButton1Click:Connect(function()
	_G.Noclip = not _G.Noclip
	NoclipBtn.BackgroundColor3 = _G.Noclip and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	NoclipBtn.Text = _G.Noclip and "NoClip [ON]" or "NoClip [OFF]"
end)

-- AutoSpin + Mini Mode
local AutoSpin = Instance.new("TextLabel", MainFrame)
AutoSpin.Size = UDim2.new(1, 0, 0, 30)
AutoSpin.Position = UDim2.new(0, 0, 0, 210)
AutoSpin.BackgroundTransparency = 1
AutoSpin.Text = "🔁 AutoSpin | Mini Mode 💸 39R$"
AutoSpin.TextColor3 = Color3.new(1,1,1)
AutoSpin.Font = Enum.Font.GothamSemibold
AutoSpin.TextSize = 13

-- Drag Function
local dragToggle, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragToggle = true
		dragStart = input.Position
		startPos = MainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragToggle and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- Toggle UI ON/OFF
ToggleBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- ESP Loop
RunService.RenderStepped:Connect(function()
	if _G.ESP then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Head") then
				if not player.Character.Head:FindFirstChild("👀 HIDERS") then
					local tag = Instance.new("BillboardGui", player.Character.Head)
					tag.Name = "👀 HIDERS"
					tag.Size = UDim2.new(0, 100, 0, 40)
					tag.AlwaysOnTop = true
					local text = Instance.new("TextLabel", tag)
					text.Size = UDim2.new(1,0,1,0)
					text.BackgroundTransparency = 1
					text.Text = "👀 HIDERS"
					text.TextColor3 = Color3.fromRGB(255, 170, 0)
					text.Font = Enum.Font.GothamBold
					text.TextSize = 16
				end
			end
		end
	else
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("Head") then
				if player.Character.Head:FindFirstChild("👀 HIDERS") then
					player.Character.Head:FindFirstChild("👀 HIDERS"):Destroy()
				end
			end
		end
	end
end)

-- Hitbox Loop
RunService.RenderStepped:Connect(function()
	if _G.Disabled then
		for _,v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character.HumanoidRootPart
				pcall(function()
					hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
					hrp.Transparency = 0.7
					hrp.BrickColor = BrickColor.new("Really blue")
					hrp.Material = Enum.Material.Neon
					hrp.CanCollide = false
				end)
			end
		end
	end
end)

-- Noclip Loop
RunService.Stepped:Connect(function()
	if _G.Noclip and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)
