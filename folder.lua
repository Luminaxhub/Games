-- 🔎 Flow's Prop Hunt - ESP & Settings UI
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- 🧊 UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowUI"
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 260, 0, 340)
Frame.Position = UDim2.new(0.05, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", Frame)
Title.Text = "🔎 Flow's Prop Hunt"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 10)
Title.Size = UDim2.new(1, -20, 0, 20)

local Subtitle = Instance.new("TextLabel", Frame)
Subtitle.Text = "Featured ⚙️"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 14
Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
Subtitle.BackgroundTransparency = 1
Subtitle.Position = UDim2.new(0, 10, 0, 35)
Subtitle.Size = UDim2.new(1, -20, 0, 20)

-- Scrollable Area
local Scroll = Instance.new("ScrollingFrame", Frame)
Scroll.Size = UDim2.new(1, -20, 1, -70)
Scroll.Position = UDim2.new(0, 10, 0, 60)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 500)
Scroll.ScrollBarThickness = 4
Scroll.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", Scroll)
UIListLayout.Padding = UDim.new(0, 8)

-- 🧩 Buat Toggle Button
local function CreateToggle(name, callback)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(1, -10, 0, 30)
	toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	toggle.TextColor3 = Color3.new(1, 1, 1)
	toggle.Font = Enum.Font.Gotham
	toggle.TextSize = 14
	toggle.Text = "❌ " .. name
	toggle.AutoButtonColor = false

	local corner = Instance.new("UICorner", toggle)
	corner.CornerRadius = UDim.new(0, 6)

	local on = false
	toggle.MouseButton1Click:Connect(function()
		on = not on
		toggle.Text = (on and "✅ " or "❌ ") .. name
		pcall(callback, on)
	end)

	toggle.Parent = Scroll
end

-- 🔲 ESP Box
local ESPEnabled = false
local function CreateESP(player)
	if player.Character then
		local box = Instance.new("BoxHandleAdornment")
		box.Size = Vector3.new(2, 3, 1)
		box.Name = "ESPBox"
		box.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
		box.AlwaysOnTop = true
		box.ZIndex = 5
		box.Color3 = Color3.new(1, 1, 1)
		box.Transparency = 0.5
		box.Parent = player.Character
	end
end

local function RemoveESP(player)
	if player.Character then
		local box = player.Character:FindFirstChild("ESPBox")
		if box then box:Destroy() end
	end
end

CreateToggle("ESP Box", function(state)
	ESPEnabled = state
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			if state then
				CreateESP(p)
			else
				RemoveESP(p)
			end
		end
	end
end)

-- 🔷 Morph ESP (menampilkan nama Morph di atas pemain)
CreateToggle("Morph ESP", function(state)
	if state then
		RunService:BindToRenderStep("MorphESP", Enum.RenderPriority.Camera.Value + 1, function()
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character then
					local head = player.Character:FindFirstChild("Head")
					if head and not head:FindFirstChild("MorphTag") then
						local tag = Instance.new("BillboardGui", head)
						tag.Name = "MorphTag"
						tag.Size = UDim2.new(0, 100, 0, 40)
						tag.StudsOffset = Vector3.new(0, 2, 0)
						tag.AlwaysOnTop = true

						local label = Instance.new("TextLabel", tag)
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.Text = "Morph"
						label.TextColor3 = Color3.fromRGB(255, 200, 0)
						label.TextStrokeTransparency = 0.5
						label.Font = Enum.Font.GothamBold
						label.TextSize = 14
					end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("MorphESP")
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character then
				local head = player.Character:FindFirstChild("Head")
				if head and head:FindFirstChild("MorphTag") then
					head.MorphTag:Destroy()
				end
			end
		end
	end
end)

-- 🩹 Auto Heal
CreateToggle("Auto Heal", function(state)
	if state then
		_G.HealLoop = true
		task.spawn(function()
			while _G.HealLoop do
				local gui = LocalPlayer:FindFirstChild("PlayerGui")
				if gui and gui:FindFirstChild("HealButton") then
					fireclickdetector(gui.HealButton)
				end
				wait(2)
			end
		end)
	else
		_G.HealLoop = false
	end
end)

-- 💀 Auto Taunt
CreateToggle("Auto Taunt", function(state)
	if state then
		_G.TauntLoop = true
		task.spawn(function()
			while _G.TauntLoop do
				local gui = LocalPlayer:FindFirstChild("PlayerGui")
				if gui and gui:FindFirstChild("TauntButton") then
					fireclickdetector(gui.TauntButton)
				end
				wait(3)
			end
		end)
	else
		_G.TauntLoop = false
	end
end)

-- 🌈 RGB Credit
local credit = Instance.new("TextLabel", Frame)
credit.Position = UDim2.new(0, 0, 1, -22)
credit.Size = UDim2.new(1, 0, 0, 20)
credit.BackgroundTransparency = 1
credit.Text = "Script by - @Luminaprojects"
credit.Font = Enum.Font.GothamBold
credit.TextSize = 12
credit.TextColor3 = Color3.fromRGB(255, 0, 0)

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 0.005) % 1
	credit.TextColor3 = Color3.fromHSV(hue, 1, 1)
end)
