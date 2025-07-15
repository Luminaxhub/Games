local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

repeat task.wait() until LocalPlayer:FindFirstChild("PlayerGui")

local DamageRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PunchEvents"):WaitForChild("DamageRE")
local RebirthRE = ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("RebirthEvents"):WaitForChild("Rebirth")

local npcList = {
    "Noob Farmer", "Strong Farmer", "Bandit", "Cowboy", "Candy Man", "Gingerbread Man",
    "Snow Bandit", "Snow Knight", "Monkey", "Monkey King", "Toy Soldier", "Teddy Bear",
    "Astronaut", "Space Man", "Crew Member", "Pirate Captain", "Lava Guard", "Dark Trooper"
}

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "AutoSystemUI"
ScreenGui.ResetOnSpawn = false

-- Coba ambil posisi yang tersimpan
local savedPos = LocalPlayer.PlayerGui:FindFirstChild("SavedPos")
local posX, posY = 0.5, 0.2
if savedPos and savedPos:FindFirstChild("X") and savedPos:FindFirstChild("Y") then
	posX = tonumber(savedPos.X.Value)
	posY = tonumber(savedPos.Y.Value)
end

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 380)
MainFrame.Position = UDim2.new(posX, -130, posY, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(70, 50, 150)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local gradient = Instance.new("UIGradient", MainFrame)
gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(136, 84, 208)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(72, 219, 251))
}

local Title = Instance.new("TextLabel", MainFrame)
Title.Text = "🥊1 Punch Every Seconds"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 18
Title.Size = UDim2.new(1, -40, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 10)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local Minimize = Instance.new("TextButton", MainFrame)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.TextSize = 20
Minimize.Size = UDim2.new(0, 30, 0, 30)
Minimize.Position = UDim2.new(1, -35, 0, 10)
Minimize.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 6)

local Content = Instance.new("Frame", MainFrame)
Content.Name = "Content"
Content.Size = UDim2.new(1, -20, 1, -60)
Content.Position = UDim2.new(0, 10, 0, 45)
Content.BackgroundTransparency = 1

local dragging, dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then 
                dragging = false 
                -- Simpan posisi ke PlayerGui
                local saveFolder = LocalPlayer.PlayerGui:FindFirstChild("SavedPos") or Instance.new("Folder", LocalPlayer.PlayerGui)
                saveFolder.Name = "SavedPos"
                local xVal = saveFolder:FindFirstChild("X") or Instance.new("StringValue", saveFolder)
                xVal.Name = "X"
                local yVal = saveFolder:FindFirstChild("Y") or Instance.new("StringValue", saveFolder)
                yVal.Name = "Y"
                xVal.Value = tostring(MainFrame.Position.X.Scale)
                yVal.Value = tostring(MainFrame.Position.Y.Scale)
            end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local function createButton(text, yPos, color)
    local btn = Instance.new("TextButton", Content)
    btn.Text = text .. ": OFF"
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 16
    btn.Size = UDim2.new(0, 260, 0, 34)
    btn.Position = UDim2.new(0, 0, 0, yPos)
    btn.BackgroundColor3 = color
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local ToggleTrain = createButton("Auto Train", 0, Color3.fromRGB(100, 100, 255))
local ToggleRebirth = createButton("Auto Rebirth", 40, Color3.fromRGB(255, 100, 100))
local ToggleAura3x = createButton("Add Aura 3x", 80, Color3.fromRGB(255, 165, 0))
local ToggleKill = createButton("Kill Aura", 120, Color3.fromRGB(100, 255, 150))

local Dropdown = Instance.new("TextButton", Content)
Dropdown.Size = UDim2.new(0, 260, 0, 34)
Dropdown.Position = UDim2.new(0, 0, 0, 160)
Dropdown.Text = "Select NPC: Bandit"
Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Dropdown.Font = Enum.Font.Gotham
Dropdown.TextColor3 = Color3.new(1, 1, 1)
Dropdown.TextSize = 14
Instance.new("UICorner", Dropdown).CornerRadius = UDim.new(0, 6)

local SelectedNPC = "Bandit"
Dropdown.MouseButton1Click:Connect(function()
    local currentIndex = table.find(npcList, SelectedNPC) or 1
    local nextIndex = currentIndex + 1
    if nextIndex > #npcList then nextIndex = 1 end
    SelectedNPC = npcList[nextIndex]
    Dropdown.Text = "Select NPC: " .. SelectedNPC
end)

local autoTrain, autoRebirth, autoKill = false, false, false

ToggleTrain.MouseButton1Click:Connect(function()
    autoTrain = not autoTrain
    ToggleTrain.Text = "Auto Train: " .. (autoTrain and "ON" or "OFF")
end)
ToggleRebirth.MouseButton1Click:Connect(function()
    autoRebirth = not autoRebirth
    ToggleRebirth.Text = "Auto Rebirth: " .. (autoRebirth and "ON" or "OFF")
end)
ToggleKill.MouseButton1Click:Connect(function()
    autoKill = not autoKill
    ToggleKill.Text = "Kill Aura: " .. (autoKill and "ON" or "OFF")
end)
ToggleAura3x.MouseButton1Click:Connect(function()
	local args = {
		true,
		3,
		"Multi"
	}
	ReplicatedStorage:WaitForChild("ServerEvents"):WaitForChild("PlaytimeRewardEvent"):WaitForChild("ButtonClicked"):InvokeServer(unpack(args))
end)

local minimized = false
Minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    MainFrame:TweenSize(UDim2.new(0, 260, 0, minimized and 50 or 380), "Out", "Quad", 0.3, true)
end)

task.spawn(function()
    while true do
        local character = LocalPlayer.Character
        if autoTrain and character then
            for i = 1, 9 do
                local zone = Workspace:FindFirstChild("Zone "..i)
                if zone and zone:FindFirstChild("Punching bag "..i) then
                    local bag = zone["Punching bag "..i]:FindFirstChild("PunchBag")
                    if bag then
                        DamageRE:FireServer(character, bag, true)
                    end
                end
            end
        end

        if autoRebirth then
            pcall(function()
                RebirthRE:FireServer()
            end)
        end

        if autoKill and character then
            for zone = 1, 9 do
                local zoneFolder = Workspace:FindFirstChild("Zone " .. zone)
                if zoneFolder and zoneFolder:FindFirstChild("NPC's") then
                    local npcFolder = zoneFolder["NPC's"]
                    local npc = npcFolder:FindFirstChild(SelectedNPC)
                    if npc and npc:FindFirstChild("LowerTorso") then
                        local dist = (character.HumanoidRootPart.Position - npc.LowerTorso.Position).Magnitude
                        if dist <= 30 then
                            local args = {
                                character,
                                npc.LowerTorso,
                                false,
                                true
                            }
                            DamageRE:FireServer(unpack(args))
                        end
                    end
                end
            end
        end

        RunService.RenderStepped:Wait()
    end
end)

local Credit = Instance.new("TextLabel", ScreenGui)
Credit.Text = "📜 Script By - @Luminaprojects ⚙️"
Credit.Font = Enum.Font.GothamBold
Credit.TextSize = 14
Credit.Position = UDim2.new(0.5, -130, 1, -25)
Credit.Size = UDim2.new(0, 260, 0, 20)
Credit.BackgroundTransparency = 1
Credit.TextStrokeTransparency = 0.5
Credit.TextStrokeColor3 = Color3.new(0, 0, 0)
Credit.TextWrapped = true

task.spawn(function()
    local h = 0
    while true do
        h = (h + 1) % 360
        Credit.TextColor3 = Color3.fromHSV(h / 360, 1, 1)
        task.wait(0.05)
    end
end)
