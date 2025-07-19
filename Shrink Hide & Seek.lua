local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- UI Variables
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "ShrinkUI"
local ToggleButton = Instance.new("TextButton", ScreenGui)
local MainFrame = Instance.new("Frame", ScreenGui)

-- Toggle UI Button
ToggleButton.Size = UDim2.new(0, 100, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "⚙️ UI"
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextScaled = true

-- Main UI Frame
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

-- Toggle UI Logic
ToggleButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

-- RGB Credit
local rgbLabel = Instance.new("TextLabel", MainFrame)
rgbLabel.Size = UDim2.new(1, 0, 0, 25)
rgbLabel.Position = UDim2.new(0, 0, 1, -25)
rgbLabel.BackgroundTransparency = 1
rgbLabel.Text = "🔎 Script by - @Luminaprojects"
rgbLabel.TextScaled = true
rgbLabel.Font = Enum.Font.GothamBold

-- RGB Animate
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			rgbLabel.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait()
		end
	end
end)

-- ESP Toggle
local espEnabled = false
local function createESP(player)
	local BillboardGui = Instance.new("BillboardGui")
	BillboardGui.Adornee = player.Character:FindFirstChild("HumanoidRootPart")
	BillboardGui.Size = UDim2.new(0, 100, 0, 40)
	BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
	BillboardGui.AlwaysOnTop = true
	BillboardGui.Name = "ESP_TAG"

	local TextLabel = Instance.new("TextLabel", BillboardGui)
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = "👀 HIDERS"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
	TextLabel.TextScaled = true
	TextLabel.Font = Enum.Font.GothamBold

	BillboardGui.Parent = player.Character
end

local function applyESP()
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Team and tostring(player.Team):lower():find("hider") then
			if not player.Character:FindFirstChild("ESP_TAG") then
				createESP(player)
			end

			-- Box Hollow + Tracer
			local hrp = player.Character:FindFirstChild("HumanoidRootPart")
			if hrp and not hrp:FindFirstChild("Box") then
				local box = Instance.new("BoxHandleAdornment", hrp)
				box.Name = "Box"
				box.Size = hrp.Size
				box.Color3 = Color3.fromRGB(255, 255, 255)
				box.Transparency = 0
				box.ZIndex = 1
				box.AlwaysOnTop = true
				box.Adornee = hrp
			end

			if not player.Character:FindFirstChild("TracerLine") then
				local tracer = Drawing.new("Line")
				tracer.Thickness = 2
				tracer.Color = Color3.fromRGB(255, 255, 255)
				tracer.Transparency = 1
				tracer.ZIndex = 2
				tracer.From = Vector2.new()
				tracer.To = Vector2.new()
				tracer.Visible = true

				RunService.RenderStepped:Connect(function()
					if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
						local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
						tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
						tracer.To = Vector2.new(pos.X, pos.Y)
						tracer.Visible = onScreen and espEnabled
					end
				end)

				player.Character.AncestryChanged:Connect(function()
					tracer:Remove()
				end)

				tracer.Name = "TracerLine"
				tracer.Parent = player.Character
			end
		end
	end
end

-- Button ESP
local ESPBtn = Instance.new("TextButton", MainFrame)
ESPBtn.Size = UDim2.new(0.9, 0, 0, 35)
ESPBtn.Position = UDim2.new(0.05, 0, 0, 10)
ESPBtn.Text = "🔎 Toggle ESP Hiders"
ESPBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ESPBtn.TextColor3 = Color3.new(1,1,1)
ESPBtn.TextScaled = true

ESPBtn.MouseButton1Click:Connect(function()
	espEnabled = not espEnabled
	if espEnabled then
		applyESP()
	end
end)

-- Hitbox Size Custom
_G.HeadSize = 10
_G.Disabled = true

local function ApplyHitbox()
	RunService.RenderStepped:Connect(function()
		if _G.Disabled then
			for _,v in pairs(Players:GetPlayers()) do
				if v.Name ~= LocalPlayer.Name and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
					pcall(function()
						local part = v.Character.HumanoidRootPart
						part.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
						part.Transparency = 0.7
						part.BrickColor = BrickColor.new("Really blue")
						part.Material = "Neon"
						part.CanCollide = false
					end)
				end
			end
		end
	end)
end
ApplyHitbox()

-- Hitbox Toggle
local HitboxBtn = Instance.new("TextButton", MainFrame)
HitboxBtn.Size = UDim2.new(0.9, 0, 0, 35)
HitboxBtn.Position = UDim2.new(0.05, 0, 0, 55)
HitboxBtn.Text = "🎯 Toggle Hitbox"
HitboxBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
HitboxBtn.TextColor3 = Color3.new(1,1,1)
HitboxBtn.TextScaled = true

HitboxBtn.MouseButton1Click:Connect(function()
	_G.Disabled = not _G.Disabled
end)

-- Noclip Toggle
local noclip = false
local NoclipBtn = Instance.new("TextButton", MainFrame)
NoclipBtn.Size = UDim2.new(0.9, 0, 0, 35)
NoclipBtn.Position = UDim2.new(0.05, 0, 0, 100)
NoclipBtn.Text = "🚪 Toggle Noclip"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NoclipBtn.TextColor3 = Color3.new(1,1,1)
NoclipBtn.TextScaled = true

RunService.Stepped:Connect(function()
	if noclip and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide == true then
				part.CanCollide = false
			end
		end
	end
end)

NoclipBtn.MouseButton1Click:Connect(function()
	noclip = not noclip
end)
