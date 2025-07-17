-- 🔎 Flow's Prop Hunt - ESP & Settings UI
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- UI Library Basic
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowPropHuntUI"

-- Main Frame
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 300, 0, 370)
Main.Position = UDim2.new(0.5, -150, 0.5, -185)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

-- Title
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "🔎 Flow's Prop Hunt"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Featured Label
local Featured = Instance.new("TextLabel", Main)
Featured.Size = UDim2.new(1, 0, 0, 20)
Featured.Position = UDim2.new(0, 0, 0, 35)
Featured.BackgroundTransparency = 1
Featured.Text = "⚙️ Featured"
Featured.Font = Enum.Font.Gotham
Featured.TextSize = 14
Featured.TextColor3 = Color3.fromRGB(150, 150, 150)

-- Scroll Area
local Scroll = Instance.new("ScrollingFrame", Main)
Scroll.Size = UDim2.new(1, -10, 1, -80)
Scroll.Position = UDim2.new(0, 5, 0, 60)
Scroll.CanvasSize = UDim2.new(0, 0, 0, 600)
Scroll.ScrollBarThickness = 4
Scroll.BackgroundTransparency = 1

-- Template Toggle
function createToggle(parent, text, callback)
	local button = Instance.new("TextButton", parent)
	button.Size = UDim2.new(1, -10, 0, 30)
	button.Position = UDim2.new(0, 5, 0, (#parent:GetChildren()-1) * 35)
	button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	button.Text = "⏺️ " .. text
	button.TextColor3 = Color3.fromRGB(255,255,255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.BorderSizePixel = 0

	local toggled = false
	button.MouseButton1Click:Connect(function()
		toggled = not toggled
		button.BackgroundColor3 = toggled and Color3.fromRGB(0, 170, 127) or Color3.fromRGB(40, 40, 40)
		pcall(callback, toggled)
	end)
end

-- Add Toggles
createToggle(Scroll, "ESP Box", function(on) print("ESP", on) end)
createToggle(Scroll, "Health Bar", function(on) print("Health", on) end)
createToggle(Scroll, "Tracer", function(on) print("Tracer", on) end)
createToggle(Scroll, "Nametag + Distance", function(on) print("Name + Dist", on) end)
createToggle(Scroll, "Auto Heal", function(on) print("Auto Heal", on) end)
createToggle(Scroll, "Morph ESP", function(on)
	if on then
		RunService.RenderStepped:Connect(function()
			for _, v in pairs(Players:GetPlayers()) do
				if v.Character and v.Character:FindFirstChild("Morph") then
					-- tambahkan highlight atau box ke morph
				end
			end
		end)
	end
end)
createToggle(Scroll, "Auto Taunt", function(on)
	if on then
		while on do
			task.wait(5)
			-- ganti sesuai event taunt game
			print("Auto Taunt Trigger")
		end
	end
end)

createToggle(Scroll, "Team Check", function(on) print("Team Check", on) end)
createToggle(Scroll, "Noclip", function(on)
	if on then
		RunService.Stepped:Connect(function()
			if LocalPlayer.Character then
				for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end)
	end
end)

-- Minimize Button
local Minimize = Instance.new("TextButton", Main)
Minimize.Size = UDim2.new(0, 25, 0, 25)
Minimize.Position = UDim2.new(1, -30, 0, 5)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.TextColor3 = Color3.fromRGB(255,255,255)
Minimize.BackgroundTransparency = 1

local minimized = false
Minimize.MouseButton1Click:Connect(function()
	minimized = not minimized
	Scroll.Visible = not minimized
	Featured.Visible = not minimized
	Main.Size = minimized and UDim2.new(0, 300, 0, 40) or UDim2.new(0, 300, 0, 370)
end)

-- Credit RGB
local RGB = Instance.new("TextLabel", ScreenGui)
RGB.Size = UDim2.new(0, 300, 0, 20)
RGB.Position = UDim2.new(0.5, -150, 1, -25)
RGB.BackgroundTransparency = 1
RGB.Text = "Script by - @Luminaprojects"
RGB.Font = Enum.Font.GothamBold
RGB.TextSize = 14

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 1) % 255
	RGB.TextColor3 = Color3.fromHSV(hue/255, 1, 1)
end)
