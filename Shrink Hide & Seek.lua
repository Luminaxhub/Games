--⛺ Shrink Hide & Seek Script UI - by @Luminaprojects
--Hanya bisa dijalankan di game Shrink Hide & Seek
if game.PlaceId ~= 137541498231955 then return warn("Script hanya untuk Shrink Hide & Seek") end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ShrinkUI"
ScreenGui.ResetOnSpawn = false

-- Border RGB + Toggle UI OPEN ⛺
local toggleButton = Instance.new("TextButton", ScreenGui)
toggleButton.Text = "⛺ OPEN"
toggleButton.Size = UDim2.new(0, 120, 0, 35)
toggleButton.Position = UDim2.new(0, 20, 0.5, -150)
toggleButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.BorderSizePixel = 2
toggleButton.AutoButtonColor = false
toggleButton.Active = true
toggleButton.Draggable = true

local rainbow = 0
RunService.RenderStepped:Connect(function()
	rainbow = rainbow + 1
	toggleButton.BorderColor3 = Color3.fromHSV((tick() % 5)/5, 1, 1)
end)

-- Main Frame UI
local main = Instance.new("Frame", ScreenGui)
main.Size = UDim2.new(0, 250, 0, 330)
main.Position = UDim2.new(0, 150, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
main.Visible = false
main.Draggable = true
main.Active = true

local UIList = Instance.new("UIListLayout", main)
UIList.Padding = UDim.new(0, 5)
UIList.SortOrder = Enum.SortOrder.LayoutOrder

-- Toggle Function
local function createToggle(name, callback)
	local toggle = Instance.new("TextButton")
	toggle.Size = UDim2.new(1, -10, 0, 30)
	toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggle.Text = "❌ "..name
	toggle.Parent = main

	local state = false
	toggle.MouseButton1Click:Connect(function()
		state = not state
		toggle.Text = (state and "✅ " or "❌ ")..name
		callback(state)
	end)
end

-- ESP 👀 HIDERS
createToggle("ESP 👀 HIDERS", function(state)
	if state then
		RunService:BindToRenderStep("HiderESP", Enum.RenderPriority.Camera.Value, function()
			for _, player in pairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Team.Name == "Hider" then
					if not player.Character then continue end
					if not player.Character:FindFirstChild("Head") then continue end
					if not player.Character.Head:FindFirstChild("👀") then
						local tag = Instance.new("BillboardGui", player.Character.Head)
						tag.Name = "👀"
						tag.Size = UDim2.new(0, 100, 0, 40)
						tag.AlwaysOnTop = true
						local label = Instance.new("TextLabel", tag)
						label.Size = UDim2.new(1, 0, 1, 0)
						label.BackgroundTransparency = 1
						label.Text = "👀 HIDERS"
						label.TextColor3 = Color3.new(1, 0, 0)
						label.TextScaled = true
					end
				end
			end
		end)
	else
		RunService:UnbindFromRenderStep("HiderESP")
		for _, player in pairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("Head") then
				local esp = player.Character.Head:FindFirstChild("👀")
				if esp then esp:Destroy() end
			end
		end
	end
end)

-- Hitbox
createToggle("Hitbox Resize", function(state)
	if state then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") then
						part.Size = Vector3.new(5,5,5)
					end
				end
			end
		end
	else
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= LocalPlayer and player.Character then
				for _, part in pairs(player.Character:GetChildren()) do
					if part:IsA("BasePart") then
						part.Size = Vector3.new(2,2,1)
					end
				end
			end
		end
	end
end)

-- Noclip On/Off
local noclipConnection
createToggle("Noclip", function(state)
	if state then
		noclipConnection = RunService.Stepped:Connect(function()
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
				for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end)
	else
		if noclipConnection then
			noclipConnection:Disconnect()
		end
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end)

-- Auto Spin
createToggle("Auto Spin", function(state)
	while state do
		local args = {[1] = {"Spin"}, [2] = "\005"}
		ReplicatedStorage:WaitForChild("dataRemoteEvent"):FireServer(args)
		task.wait(2)
	end
end)

-- Mini Mode (39R$)
createToggle("Mini Mode 39R$", function(state)
	if state then
		local args = { {{"Shrink"}, "\005"} }
		ReplicatedStorage:WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
	end
end)

-- Big Mode
createToggle("Big Mode", function(state)
	if state then
		local args = { {{"Grow"}, "\005"} }
		ReplicatedStorage:WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
	end
end)

-- UI Show/Hide
toggleButton.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
end)
