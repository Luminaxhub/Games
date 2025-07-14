local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local SubmitAnswer = Remotes:WaitForChild("SubmitAnswer")
local RunService = game:GetService("RunService")

-- UI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "MiniAnswerUI"

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 80)
Frame.Position = UDim2.new(0.5, -110, 0.5, -40)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 8)

-- Title
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -35, 0, 25)
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Text = "🎧 Auto Answer"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize Button
local MinBtn = Instance.new("TextButton", Frame)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -30, 0, 5)
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MinBtn.Font = Enum.Font.Gotham
MinBtn.TextSize = 18

local uiMinimized = false
MinBtn.MouseButton1Click:Connect(function()
	uiMinimized = not uiMinimized
	for _, v in pairs(Frame:GetChildren()) do
		if (v:IsA("TextLabel") or v:IsA("TextButton")) and v ~= MinBtn and v ~= Title then
			v.Visible = not uiMinimized
		end
	end
end)

-- RGB Credit
local Credit = Instance.new("TextLabel", Frame)
Credit.Size = UDim2.new(1, -20, 0, 20)
Credit.Position = UDim2.new(0, 10, 1, -25)
Credit.Text = "Script by - @Luminaprojects"
Credit.BackgroundTransparency = 1
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 13
Credit.TextXAlignment = Enum.TextXAlignment.Left
Credit.TextColor3 = Color3.new(1, 1, 1)
Credit.Parent = Frame

local hue = 0
RunService.RenderStepped:Connect(function()
	hue = (hue + 1) % 360
	local color = Color3.fromHSV(hue/360, 1, 1)
	Credit.TextColor3 = color
end)

-- Auto Answer Logic: Delay per kata
game.DescendantAdded:Connect(function(obj)
	if obj:IsA("Sound") then
		task.defer(function()
			for attempt = 1, 10 do
				local soundId = obj.SoundId
				local assetId = soundId:match("%d+")

				if assetId then
					local success, info = pcall(function()
						return MarketplaceService:GetProductInfo(tonumber(assetId))
					end)

					if success and info and info.Name then
						local fullName = info.Name
						fullName = fullName:match("^(.-)%s*%(%d+%)$") or fullName

						for word in fullName:gmatch("%S+") do
							local args1 = { "Type", word }
							SubmitAnswer:FireServer(unpack(args1))
							task.wait(0.35) -- Delay ketik antar kata
						end

						local args2 = { "Submit", fullName }
						SubmitAnswer:FireServer(unpack(args2))
					end
					break
				end
				task.wait(0.1)
			end
		end)
	end
end)
