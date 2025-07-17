-- 🔎 Flow's Prop Hunt - ESP & Settings UI
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

-- UI Part
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 250, 0, 380)
Frame.Position = UDim2.new(0, 10, 0.5, -190)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "🔎 Flow's Prop Hunt"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local Scrolling = Instance.new("ScrollingFrame", Frame)
Scrolling.Size = UDim2.new(1, 0, 1, -70)
Scrolling.Position = UDim2.new(0, 0, 0, 40)
Scrolling.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Scrolling.BackgroundTransparency = 1
Scrolling.ScrollBarThickness = 4

local UIList = Instance.new("UIListLayout", Scrolling)
UIList.Padding = UDim.new(0, 5)

-- Minimize Button
local MinBtn = Instance.new("TextButton", Frame)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -30, 0, 5)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.TextSize = 22
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.TextColor3 = Color3.new(1,1,1)

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Scrolling.Visible = not minimized
    Frame.Size = minimized and UDim2.new(0, 250, 0, 40) or UDim2.new(0, 250, 0, 380)
end)

-- Credit
local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Text = "Script by - @Luminaprojects"
Credit.TextColor3 = Color3.fromRGB(255, 255, 255)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 14
Credit.Size = UDim2.new(0, 300, 0, 25)
Credit.Position = UDim2.new(0.5, -150, 1, -30)
Credit.BackgroundTransparency = 1

-- Function: Create Toggle
local function CreateToggle(text, callback)
	local Toggle = Instance.new("TextButton")
	Toggle.Size = UDim2.new(1, -10, 0, 30)
	Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Toggle.TextColor3 = Color3.new(1,1,1)
	Toggle.Text = "❌ " .. text
	Toggle.Font = Enum.Font.Gotham
	Toggle.TextSize = 14
	Toggle.Parent = Scrolling

	local On = false
	Toggle.MouseButton1Click:Connect(function()
		On = not On
		Toggle.Text = (On and "✅ " or "❌ ") .. text
		if callback then callback(On) end
	end)
end

-- ESP
CreateToggle("ESP Box", function(on)
	if on then
		RunService:BindToRenderStep("ESP", Enum.RenderPriority.Camera.Value + 1, function()
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
					if player.Character:FindFirstChild("Highlight") == nil then
						local highlight = Instance.new("Highlight", player.Character)
						highlight.FillColor = Color3.fromRGB(255, 50, 50)
						highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
					end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("ESP")
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("Highlight") then
				player.Character.Highlight:Destroy()
			end
		end
	end
end)

-- Team Check
CreateToggle("Team Check", function(enabled)
	_G.TeamCheck = enabled
end)

-- Noclip (di bawah team check)
CreateToggle("Noclip", function(active)
	if active then
		RunService.Stepped:Connect(function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				LocalPlayer.Character.Humanoid:ChangeState(11)
			end
		end)
	end
end)

-- Auto Heal
CreateToggle("Auto Heal", function(state)
	if state then
		while wait(1) do
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				local hum = LocalPlayer.Character.Humanoid
				if hum.Health < 50 then
					hum.Health = hum.Health + 10
				end
			end
			if not state then break end
		end
	end
end)

-- Morph ESP
CreateToggle("Morph ESP", function(enable)
	if enable then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				if player.Character:FindFirstChild("MorphPart") then
					warn("Morph Detected: "..player.Name)
				end
			end
		end
	end
end)

-- Auto Taunt
CreateToggle("Auto Taunt", function(active)
	if active then
		while wait(5) do
			game:GetService("ReplicatedStorage"):WaitForChild("TauntEvent"):FireServer()
			if not active then break end
		end
	end
end)

-- Custom Walkspeed (Slider)
local SpeedLabel = Instance.new("TextLabel", Scrolling)
SpeedLabel.Text = "Walkspeed: "
SpeedLabel.Size = UDim2.new(1, -10, 0, 25)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.new(1,1,1)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 14

local Slider = Instance.new("TextButton", Scrolling)
Slider.Size = UDim2.new(1, -10, 0, 25)
Slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Slider.Text = "Click to increase (10 - 100)"
Slider.TextColor3 = Color3.new(1,1,1)
Slider.Font = Enum.Font.Gotham
Slider.TextSize = 14

local Speed = 16
Slider.MouseButton1Click:Connect(function()
	Speed = Speed + 10
	if Speed > 100 then Speed = 10 end
	Slider.Text = "Walkspeed: "..Speed
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = Speed
	end
end)
