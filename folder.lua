-- 🔎 Flow's Prop Hunt - ESP & Settings UI
-- Script by - @Luminaprojects (🌈 RGB Credit)
-- Support Android (MT Manager, Arceus X, Hydrogen, etc)

-- 📦 Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")

-- 🧍 LocalPlayer
local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- 💡 ESP
local ESPEnabled = false
local ESPFolder = Instance.new("Folder", game.CoreGui)
ESPFolder.Name = "FlowESP"

function CreateESP(player)
	if player == lp then return end
	local char = player.Character
	if not char or not char:FindFirstChild("HumanoidRootPart") then return end

	local box = Instance.new("BoxHandleAdornment", ESPFolder)
	box.Name = player.Name .. "_Box"
	box.Adornee = char
	box.AlwaysOnTop = true
	box.ZIndex = 5
	box.Size = Vector3.new(4, 6, 1)
	box.Transparency = 0.7
	box.Color3 = Color3.fromRGB(255, 0, 0)
	box.OutlineColor = Color3.fromRGB(255, 255, 255)
	box.OutlineTransparency = 0
	box.Visible = true
end

function RemoveESP()
	for _,v in pairs(ESPFolder:GetChildren()) do
		v:Destroy()
	end
end

RunService.RenderStepped:Connect(function()
	if ESPEnabled then
		RemoveESP()
		for _,player in pairs(Players:GetPlayers()) do
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				CreateESP(player)
			end
		end
	end
end)

-- 📜 UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowUI"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BackgroundTransparency = 0.2
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05,0,0.2,0)
MainFrame.Size = UDim2.new(0, 260, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "🔎 Flow's Prop Hunt"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,0,30)

local Credit = Instance.new("TextLabel", MainFrame)
Credit.Text = "🌈 Script by - @Luminaprojects"
Credit.Font = Enum.Font.Code
Credit.TextSize = 14
Credit.TextColor3 = Color3.fromRGB(255, 0, 0)
Credit.BackgroundTransparency = 1
Credit.Position = UDim2.new(0,0,0.1,0)
Credit.Size = UDim2.new(1,0,0,20)

-- 🔘 ESP Toggle
local ESPToggle = Instance.new("TextButton", MainFrame)
ESPToggle.Text = "ESP [ OFF ]"
ESPToggle.Font = Enum.Font.Gotham
ESPToggle.TextSize = 16
ESPToggle.TextColor3 = Color3.new(1,1,1)
ESPToggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
ESPToggle.Position = UDim2.new(0.05, 0, 0.25, 0)
ESPToggle.Size = UDim2.new(0.9, 0, 0, 35)
ESPToggle.MouseButton1Click:Connect(function()
	ESPEnabled = not ESPEnabled
	ESPToggle.Text = "ESP [ " .. (ESPEnabled and "ON" or "OFF") .. " ]"
	if not ESPEnabled then RemoveESP() end
end)

-- 🎮 Walkspeed Slider
local SpeedSlider = Instance.new("TextButton", MainFrame)
SpeedSlider.Text = "WalkSpeed: 16"
SpeedSlider.Font = Enum.Font.Gotham
SpeedSlider.TextSize = 16
SpeedSlider.TextColor3 = Color3.new(1,1,1)
SpeedSlider.BackgroundColor3 = Color3.fromRGB(60,60,60)
SpeedSlider.Position = UDim2.new(0.05, 0, 0.42, 0)
SpeedSlider.Size = UDim2.new(0.9, 0, 0, 35)
SpeedSlider.MouseButton1Click:Connect(function()
	local input = tonumber(string.match(StarterGui:PromptInput("Enter WalkSpeed (default 16):"), "%d+"))
	if input then
		lp.Character.Humanoid.WalkSpeed = input
		SpeedSlider.Text = "WalkSpeed: "..input
	end
end)

-- 🚀 JumpPower Slider
local JumpSlider = Instance.new("TextButton", MainFrame)
JumpSlider.Text = "JumpPower: 50"
JumpSlider.Font = Enum.Font.Gotham
JumpSlider.TextSize = 16
JumpSlider.TextColor3 = Color3.new(1,1,1)
JumpSlider.BackgroundColor3 = Color3.fromRGB(60,60,60)
JumpSlider.Position = UDim2.new(0.05, 0, 0.59, 0)
JumpSlider.Size = UDim2.new(0.9, 0, 0, 35)
JumpSlider.MouseButton1Click:Connect(function()
	local input = tonumber(string.match(StarterGui:PromptInput("Enter JumpPower (default 50):"), "%d+"))
	if input then
		lp.Character.Humanoid.JumpPower = input
		JumpSlider.Text = "JumpPower: "..input
	end
end)

-- 🧱 Noclip Toggle
local Noclip = false
local NoclipToggle = Instance.new("TextButton", MainFrame)
NoclipToggle.Text = "Noclip [ OFF ]"
NoclipToggle.Font = Enum.Font.Gotham
NoclipToggle.TextSize = 16
NoclipToggle.TextColor3 = Color3.new(1,1,1)
NoclipToggle.BackgroundColor3 = Color3.fromRGB(60,60,60)
NoclipToggle.Position = UDim2.new(0.05, 0, 0.76, 0)
NoclipToggle.Size = UDim2.new(0.9, 0, 0, 35)
NoclipToggle.MouseButton1Click:Connect(function()
	Noclip = not Noclip
	NoclipToggle.Text = "Noclip [ " .. (Noclip and "ON" or "OFF") .. " ]"
end)

RunService.Stepped:Connect(function()
	if Noclip and lp.Character and lp.Character:FindFirstChild("Humanoid") then
		for _,v in pairs(lp.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide then
				v.CanCollide = false
			end
		end
	end
end)
