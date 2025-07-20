-- ⛺ Shrink Hide & Seek UI Script by @Luminaprojects
-- FINAL VERSION (✅ Stable, Full Feature, Android Support)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- UI Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 130, 0, 36)
toggleBtn.Position = UDim2.new(0, 15, 0.5, -100)
toggleBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
toggleBtn.Text = "⛺ OPEN"
toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.TextSize = 18
toggleBtn.BorderSizePixel = 2
toggleBtn.Parent = game.CoreGui
toggleBtn.Active = true
toggleBtn.Draggable = true

-- RGB Border Effect
task.spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			toggleBtn.BorderColor3 = Color3.fromHSV(i, 1, 1)
			task.wait()
		end
	end
end)

-- Main UI
local MainUI = Instance.new("ScreenGui", game.CoreGui)
MainUI.Name = "ShrinkHideSeekUI"
local Frame = Instance.new("Frame", MainUI)
Frame.Size = UDim2.new(0, 290, 0, 360)
Frame.Position = UDim2.new(0.5, -145, 0.5, -180)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Visible = false
Frame.Active = true
Frame.Draggable = true

local UIListLayout = Instance.new("UIListLayout", Frame)
UIListLayout.Padding = UDim.new(0, 6)

local function createToggle(label, callback)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -12, 0, 32)
	btn.Position = UDim2.new(0, 6, 0, 0)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.new(0, 1, 0)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 18
	btn.Text = "🟩 "..label
	local state = false
	btn.MouseButton1Click:Connect(function()
		state = not state
		btn.Text = (state and "🟩 " or "🟥 ")..label
		btn.TextColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
		callback(state)
	end)
end

-- HITBOX SLIDER
local HitboxSize = 10
_G.Disabled = false
_G.HeadSize = 10

local Slider = Instance.new("TextButton", Frame)
Slider.Size = UDim2.new(1, -12, 0, 32)
Slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Slider.Text = "📦 Hitbox Size: ".._G.HeadSize
Slider.Font = Enum.Font.SourceSansBold
Slider.TextSize = 18
Slider.TextColor3 = Color3.fromRGB(255, 255, 255)

Slider.MouseButton1Click:Connect(function()
	_G.HeadSize = _G.HeadSize + 10
	if _G.HeadSize > 100 then
		_G.HeadSize = 10
	end
	Slider.Text = "📦 Hitbox Size: ".._G.HeadSize
end)

-- HITBOX RENDER
RS.RenderStepped:Connect(function()
	if _G.Disabled then
		for _,v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local hrp = v.Character:FindFirstChild("HumanoidRootPart")
				pcall(function()
					hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
					hrp.Transparency = 0.7
					hrp.Material = Enum.Material.Neon
					hrp.BrickColor = BrickColor.new("Really blue")
					hrp.CanCollide = false
				end)
			end
		end
	end
end)

-- ESP NameTag
local ESPEnabled = false
local function createESP(player)
	if player.Character then
		local head = player.Character:FindFirstChild("Head")
		if head and not head:FindFirstChild("ESPName") then
			local tag = Instance.new("BillboardGui", head)
			tag.Name = "ESPName"
			tag.Size = UDim2.new(0,100,0,40)
			tag.Adornee = head
			tag.AlwaysOnTop = true
			local txt = Instance.new("TextLabel", tag)
			txt.Size = UDim2.new(1,0,1,0)
			txt.Text = "👀 HIDERS"
			txt.TextColor3 = Color3.fromRGB(255,140,0)
			txt.BackgroundTransparency = 1
			txt.TextScaled = true
		end
	end
end

-- Toggle Features
createToggle("ESP 👀 HIDERS", function(state)
	ESPEnabled = state
	if state then
		for _,v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer then
				createESP(v)
			end
		end
	else
		for _,v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
				local tag = v.Character.Head:FindFirstChild("ESPName")
				if tag then tag:Destroy() end
			end
		end
	end
end)

createToggle("Hitbox ON/OFF", function(state)
	_G.Disabled = state
end)

-- Noclip
local Noclip = false
createToggle("Noclip", function(state)
	Noclip = state
end)

RS.Stepped:Connect(function()
	if Noclip and LocalPlayer.Character then
		for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide then
				v.CanCollide = false
			end
		end
	end
end)

-- Auto Spin
createToggle("🔄 Auto Spin", function(state)
	if state then
		_G.spinLoop = true
		task.spawn(function()
			while _G.spinLoop do
				game:GetService("ReplicatedStorage"):WaitForChild("SpinRemote"):FireServer()
				task.wait(2)
			end
		end)
	else
		_G.spinLoop = false
	end
end)

-- Mini / BIG MODE
createToggle("🎮 Mini Mode (39R$)", function(state)
	if state then
		LocalPlayer.Character.Humanoid.HipHeight = 1
	end
end)

createToggle("🧍 BIG MODE", function(state)
	if state then
		LocalPlayer.Character.Humanoid.HipHeight = 15
	end
end)

-- Toggle UI visibility
toggleBtn.MouseButton1Click:Connect(function()
	Frame.Visible = not Frame.Visible
end)
