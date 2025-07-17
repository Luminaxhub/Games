-- 🔎 Flow's Prop Hunt - ESP & Settings UI
-- Script by - @Luminaprojects (RGB Credit)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "FlowUI"

-- Drag Function
local function MakeDraggable(frame)
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and not dragging then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
			dragging = false
		end
	})
end

-- Main UI Frame
local MainUI = Instance.new("Frame", ScreenGui)
MainUI.Size = UDim2.new(0, 250, 0, 330)
MainUI.Position = UDim2.new(0.05, 0, 0.2, 0)
MainUI.BackgroundTransparency = 0
MainUI.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Darker background
MainUI.BorderSizePixel = 0
MainUI.ClipsDescendants = true -- Important for ScrollingFrame content

MakeDraggable(MainUI)

-- Title Bar
local TitleBar = Instance.new("Frame", MainUI)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.BorderSizePixel = 0

-- Title Text
local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "🔎 Flow's Prop Hunt"
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Minimize Button
local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Text = "-"
MinBtn.Size = UDim2.new(0, 30, 1, 0)
MinBtn.Position = UDim2.new(1, -30, 0, 0)
MinBtn.TextColor3 = Color3.new(1, 1, 1)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 20
MinBtn.TextYAlignment = Enum.TextYAlignment.Center

MinBtn.MouseButton1Click:Connect(function()
	MainUI.Visible = not MainUI.Visible
end)

-- Featured Label
local FeaturedLabel = Instance.new("TextLabel", MainUI)
FeaturedLabel.Text = "Featured ⚙️"
FeaturedLabel.Size = UDim2.new(1, 0, 0, 25)
FeaturedLabel.Position = UDim2.new(0, 0, 0, 35) -- Below title bar
FeaturedLabel.TextColor3 = Color3.new(0.7, 0.7, 0.7)
FeaturedLabel.BackgroundTransparency = 1
FeaturedLabel.Font = Enum.Font.GothamBold
FeaturedLabel.TextSize = 15
FeaturedLabel.TextXAlignment = Enum.TextXAlignment.Left
FeaturedLabel.TextWrapped = true
FeaturedLabel.TextPadding = UDim.new(0, 10)

-- Scrolling Frame for options
local ScrollingFrame = Instance.new("ScrollingFrame", MainUI)
ScrollingFrame.Size = UDim2.new(1, 0, 1, -60) -- Takes up most of the frame, leave space for title and credit
ScrollingFrame.Position = UDim2.new(0, 0, 0, 60) -- Below Featured label
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Will be updated dynamically
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
ScrollingFrame.ScrollBarThickness = 6

-- UIListLayout for automatic positioning of options
local UILayout = Instance.new("UIListLayout", ScrollingFrame)
UILayout.FillDirection = Enum.FillDirection.Vertical
UILayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UILayout.VerticalAlignment = Enum.VerticalAlignment.Top
UILayout.Padding = UDim.new(0, 5) -- Space between items
UILayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Function to add a toggle button (ESP, Health Bar, Team Check)
local function AddToggleButton(parent, text, initialValue, callback)
    local button = Instance.new("TextButton", parent)
    button.Name = text:gsub(" ", "") .. "Toggle"
    button.Size = UDim2.new(1, -20, 0, 40) -- Slightly smaller width for padding
    button.BackgroundColor3 = initialValue and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(60, 60, 60)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = text .. (initialValue and " [ON]" or " [OFF]")
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.BorderSizePixel = 0
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.TextPadding = UDim.new(0, 10)

    local toggled = initialValue
    button.MouseButton1Click:Connect(function()
        toggled = not toggled
        button.BackgroundColor3 = toggled and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(60, 60, 60)
        button.Text = text .. (toggled and " [ON]" or " [OFF]")
        callback(toggled)
    end)
    return button
end

-- Function to add a slider (WalkSpeed, JumpPower)
local function AddSlider(parent, text, initialValue, minValue, maxValue, callback)
    local container = Instance.new("Frame", parent)
    container.Name = text:gsub(" ", "") .. "SliderContainer"
    container.Size = UDim2.new(1, -20, 0, 60) -- Height for text and slider
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0

    local label = Instance.new("TextLabel", container)
    label.Text = text .. ": " .. initialValue
    label.Size = UDim2.new(1, 0, 0, 20)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextPadding = UDim.new(0, 0)

    local sliderFrame = Instance.new("Frame", container)
    sliderFrame.Size = UDim2.new(1, 0, 0, 20)
    sliderFrame.Position = UDim2.new(0, 0, 0, 25)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderFrame.BorderSizePixel = 0

    local sliderHandle = Instance.new("Frame", sliderFrame)
    sliderHandle.Size = UDim2.new((initialValue - minValue) / (maxValue - minValue), 0, 1, 0)
    sliderHandle.Position = UDim2.new(0, 0, 0, 0)
    sliderHandle.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    sliderHandle.BorderSizePixel = 0

    local dragging = false
    local currentValue = initialValue

    sliderFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            local mousePos = UIS:GetMouseLocation()
            local framePos = sliderFrame.AbsolutePosition
            local frameSizeX = sliderFrame.AbsoluteSize.X
            local ratio = math.clamp((mousePos.X - framePos.X) / frameSizeX, 0, 1)
            currentValue = minValue + ratio * (maxValue - minValue)
            currentValue = math.floor(currentValue) -- Round to nearest integer

            sliderHandle.Size = UDim2.new((currentValue - minValue) / (maxValue - minValue), 0, 1, 0)
            label.Text = text .. ": " .. currentValue
            callback(currentValue)
        end
    end)

    sliderFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local mousePos = UIS:GetMouseLocation()
            local framePos = sliderFrame.AbsolutePosition
            local frameSizeX = sliderFrame.AbsoluteSize.X
            local ratio = math.clamp((mousePos.X - framePos.X) / frameSizeX, 0, 1)
            currentValue = minValue + ratio * (maxValue - minValue)
            currentValue = math.floor(currentValue)

            sliderHandle.Size = UDim2.new((currentValue - minValue) / (maxValue - minValue), 0, 1, 0)
            label.Text = text .. ": " .. currentValue
            callback(currentValue)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            dragging = false
        end
    end)
    return container
end

-- Add ESP Features
local espBoxEnabled = false
local espTracerEnabled = false
local healthBarEnabled = false
local teamCheckEnabled = false

AddToggleButton(ScrollingFrame, "ESP Box", espBoxEnabled, function(on)
    espBoxEnabled = on
end)
AddToggleButton(ScrollingFrame, "ESP Tracer", espTracerEnabled, function(on)
    espTracerEnabled = on
end)
AddToggleButton(ScrollingFrame, "Health Bar", healthBarEnabled, function(on)
    healthBarEnabled = on
end)
AddToggleButton(ScrollingFrame, "Team Check", teamCheckEnabled, function(on)
    teamCheckEnabled = on
end)

-- Add More Setting Features (now integrated)
local currentWalkSpeed = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.WalkSpeed or 16
local currentJumpPower = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") and LocalPlayer.Character.Humanoid.JumpPower or 50

AddSlider(ScrollingFrame, "WalkSpeed", currentWalkSpeed, 10, 100, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

AddSlider(ScrollingFrame, "JumpPower", currentJumpPower, 10, 150, function(value)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

-- Noclip Feature
local noclipEnabled = false
local noclipConnection = nil -- To store the connection for disconnecting

AddToggleButton(ScrollingFrame, "Noclip", noclipEnabled, function(on)
    noclipEnabled = on
    local char = LocalPlayer.Character
    if char then
        if on then
            noclipConnection = RunService.Stepped:Connect(function()
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                        v.CanTouch = false -- Often useful to prevent accidental triggers
                    end
                end
            end)
        else
            if noclipConnection then
                noclipConnection:Disconnect()
                noclipConnection = nil
            end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                    v.CanTouch = true
                end
            end
        end
    end
end)

-- Update CanvasSize of ScrollingFrame
local function UpdateCanvasSize()
    local contentHeight = UILayout.AbsoluteContentSize.Y
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
end

-- Listen for layout changes to update CanvasSize
UILayout.LayoutUpdated:Connect(UpdateCanvasSize)
-- Initial update in case layout is already set
RunService.Stepped:Wait() -- Wait a frame for initial layout to apply
UpdateCanvasSize()

-- Credit RGB
local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Position = UDim2.new(0.5, -100, 0.95, 0)
Credit.Size = UDim2.new(0, 200, 0, 30)
Credit.BackgroundTransparency = 1
Credit.Text = "Script by - @Luminaprojects"
Credit.TextScaled = true
Credit.Font = Enum.Font.GothamBold

-- Animate RGB
spawn(function()
	while true do
		for i = 0, 1, 0.01 do
			Credit.TextColor3 = Color3.fromHSV(i, 1, 1)
			wait(0.05)
		end
	end
end)

-- ESP Functionality (adapted from your original script)
local ESP = {}
local function CreateESP(plr)
	if plr == LocalPlayer then return end
	local box = Drawing.new("Square")
	box.Visible = false
	box.Color = Color3.fromRGB(255, 255, 255)
	box.Thickness = 1
	box.Filled = false

	local tracer = Drawing.new("Line")
	tracer.Visible = false
	tracer.Thickness = 1
	tracer.Color = Color3.new(1, 1, 1)

	local nameTag = Drawing.new("Text")
	nameTag.Visible = false
	nameTag.Size = 14
	nameTag.Color = Color3.new(1, 1, 1)
	nameTag.Center = true
	nameTag.Outline = true

	local healthBar = Drawing.new("Line")
	healthBar.Visible = false
	healthBar.Color = Color3.fromRGB(0, 255, 0)
	healthBar.Thickness = 2

	ESP[plr] = {Box = box, Tracer = tracer, Name = nameTag, Health = healthBar}
end

for _, p in ipairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(p)
	if ESP[p] then
		for _, obj in pairs(ESP[p]) do obj:Remove() end
		ESP[p] = nil
	end
end)

RunService.RenderStepped:Connect(function()
	for plr, info in pairs(ESP) do
		local char = plr.Character
		if char and char:FindFirstChild("HumanoidRootPart") and (not teamCheckEnabled or plr.Team ~= LocalPlayer.Team) then
			local hrp = char.HumanoidRootPart
			local hum = char:FindFirstChild("Humanoid")
			local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
			if onScreen then
				local sizeY = math.clamp(3000 / (hrp.Position - Camera.CFrame.Position).Magnitude, 2, 50)
                
                info.Box.Visible = espBoxEnabled
                if espBoxEnabled then
                    info.Box.Size = Vector2.new(sizeY * 0.6, sizeY)
                    info.Box.Position = Vector2.new(pos.X - sizeY * 0.3, pos.Y - sizeY / 2)
                end

                info.Tracer.Visible = espTracerEnabled
                if espTracerEnabled then
                    info.Tracer.From = Vector2.new(pos.X, pos.Y)
                    info.Tracer.To = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                end
                
				info.Name.Visible = true -- Name tag is always on if player is on screen and conditions met
				info.Name.Position = Vector2.new(pos.X, pos.Y - sizeY / 2 - 15)
				info.Name.Text = plr.Name .. " [" .. math.floor((hrp.Position - Camera.CFrame.Position).Magnitude) .. "m]"

                info.Health.Visible = healthBarEnabled
                if healthBarEnabled and hum then
                    info.Health.From = Vector2.new(pos.X - sizeY * 0.35, pos.Y - sizeY / 2)
                    info.Health.To = Vector2.new(pos.X - sizeY * 0.35, pos.Y - sizeY / 2 + (hum.Health / hum.MaxHealth) * sizeY)
                    info.Health.Color = Color3.fromRGB(math.floor(255 * (1 - hum.Health/hum.MaxHealth)), math.floor(255 * (hum.Health/hum.MaxHealth)), 0) -- Health color gradient
                end
			else
				for _, obj in pairs(info) do obj.Visible = false end
			end
		else
			for _, obj in pairs(info) do obj.Visible = false end
		end
	end
end)
