-- ⛺ Shirnk Hide & Seek UI by @Luminaprojects

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Destroy existing UI
pcall(function()
    CoreGui:FindFirstChild("ShrinkUI"):Destroy()
end)

-- ESP Settings
_G.ESP_ENABLED = false
_G.HitboxSize = 10
_G.HitboxEnabled = false
_G.AutoSpin = false
_G.MiniMode = false
_G.Noclip = false

-- Create UI
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "ShrinkUI"
ScreenGui.ResetOnSpawn = false

local mainBtn = Instance.new("TextButton", ScreenGui)
mainBtn.Text = "⛺ OPEN"
mainBtn.Size = UDim2.new(0, 120, 0, 40)
mainBtn.Position = UDim2.new(0, 20, 0.5, -100)
mainBtn.TextScaled = true
mainBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
mainBtn.BorderSizePixel = 4
mainBtn.BorderColor3 = Color3.fromRGB(255,0,0)
mainBtn.TextColor3 = Color3.new(1,1,1)
mainBtn.ZIndex = 5
mainBtn.Active = true
mainBtn.Draggable = true

-- RGB Border Animation
task.spawn(function()
	while true do
		for i = 0, 255, 5 do
			mainBtn.BorderColor3 = Color3.fromHSV(i/255, 1, 1)
			task.wait()
		end
	end
end)

-- Main Frame
local main = Instance.new("Frame", ScreenGui)
main.Size = UDim2.new(0, 300, 0, 380)
main.Position = UDim2.new(0, 150, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Visible = false
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true

local title = Instance.new("TextLabel", main)
title.Text = "⛺ Shirnk Hide & Seek"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local function createToggle(text, yPos, callback)
	local toggle = Instance.new("TextButton", main)
	toggle.Size = UDim2.new(0.9, 0, 0, 40)
	toggle.Position = UDim2.new(0.05, 0, 0, yPos)
	toggle.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
	toggle.Text = text .. " (OFF)"
	toggle.TextColor3 = Color3.new(1, 1, 1)
	toggle.Font = Enum.Font.GothamBold
	toggle.TextScaled = true

	local state = false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.BackgroundColor3 = state and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(100, 0, 0)
		toggle.Text = text .. (state and " (ON)" or " (OFF)")
		callback(state)
	end)
end

createToggle("👀 ESP HIDERS", 50, function(state)
	_G.ESP_ENABLED = state
end)

createToggle("📦 Hitbox Expander", 100, function(state)
	_G.HitboxEnabled = state
end)

createToggle("🌪 Auto Spin", 150, function(state)
	_G.AutoSpin = state
end)

createToggle("🧍‍♂️ Mini Mode (39R$)", 200, function(state)
	_G.MiniMode = state
end)

createToggle("🚪 Noclip", 250, function(state)
	_G.Noclip = state
end)

-- Hitbox Slider
local hitboxSlider = Instance.new("TextButton", main)
hitboxSlider.Size = UDim2.new(0.9, 0, 0, 30)
hitboxSlider.Position = UDim2.new(0.05, 0, 0, 300)
hitboxSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
hitboxSlider.Text = "Hitbox Size: 10"
hitboxSlider.TextColor3 = Color3.new(1,1,1)
hitboxSlider.Font = Enum.Font.Gotham
hitboxSlider.TextScaled = true

hitboxSlider.MouseButton1Click:Connect(function()
	_G.HitboxSize = _G.HitboxSize + 10
	if _G.HitboxSize > 100 then _G.HitboxSize = 10 end
	hitboxSlider.Text = "Hitbox Size: ".._G.HitboxSize
end)

-- Show/Hide main
mainBtn.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)

-- ESP Script
RunService.RenderStepped:Connect(function()
	if _G.ESP_ENABLED then
		for _,v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
				if not v.Character.Head:FindFirstChild("HIDER_TAG") then
					local tag = Instance.new("BillboardGui", v.Character.Head)
					tag.Name = "HIDER_TAG"
					tag.Size = UDim2.new(0, 100, 0, 40)
					tag.StudsOffset = Vector3.new(0, 2, 0)
					tag.AlwaysOnTop = true

					local txt = Instance.new("TextLabel", tag)
					txt.Size = UDim2.new(1, 0, 1, 0)
					txt.Text = "👀 HIDERS"
					txt.TextColor3 = Color3.fromRGB(255, 165, 0)
					txt.BackgroundTransparency = 1
					txt.TextScaled = true
					txt.Font = Enum.Font.GothamBold
				end
			end
		end
	else
		for _,v in pairs(Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("Head") then
				local tag = v.Character.Head:FindFirstChild("HIDER_TAG")
				if tag then tag:Destroy() end
			end
		end
	end
end)

-- Hitbox Script
RunService.RenderStepped:Connect(function()
	if _G.HitboxEnabled then
		for _,v in pairs(Players:GetPlayers()) do
			if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
				local part = v.Character.HumanoidRootPart
				part.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
				part.Transparency = 0.7
				part.BrickColor = BrickColor.new("Really blue")
				part.Material = Enum.Material.Neon
				part.CanCollide = false
			end
		end
	end
end)

-- Noclip Script
RunService.Stepped:Connect(function()
	if _G.Noclip and LocalPlayer.Character then
		for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
	end
end)

-- Auto Spin Script
task.spawn(function()
	while true do
		if _G.AutoSpin then
			local args = {
				[1] = "Spin"
			}
			game:GetService("ReplicatedStorage"):WaitForChild("RemoteFunction"):InvokeServer(unpack(args))
		end
		task.wait(3)
	end
end)

-- Mini Mode (just a placeholder script)
task.spawn(function()
	while true do
		if _G.MiniMode then
			-- Example effect
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(0.5,0.5,0.5)
			end
		end
		task.wait()
	end
end)
