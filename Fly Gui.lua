-- FLY GUI (NEW) by luminaprojects
local players = game:GetService("Players")
local userInput = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local plr = players.LocalPlayer
local gui = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
gui.Name = "FlyGUI_New"
gui.ResetOnSpawn = false

-- Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 250, 0, 300)
frame.Position = UDim2.new(0.4,0,0.2,0)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 4

-- Border RGB
spawn(function()
  while true do
    for i=0,1,0.01 do
      frame.BorderColor3 = Color3.fromHSV(i,1,1)
      task.wait(0.01)
    end
  end
end)

-- Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Text = "FLY GUI (NEW)"
spawn(function()
  while true do
    for i=0,1,0.01 do
      title.TextColor3 = Color3.fromHSV(i,1,1)
      task.wait(0.02)
    end
  end
end)

-- Utility
local spacing = 40
local flyOn = false
local smoothOn = false
local keybind = Enum.KeyCode.F
local flySpeed = 50
local platformStand = false
local bodyGyro, bodyVelocity

local function startFly()
  local char = plr.Character
  if not char or not char:FindFirstChild("HumanoidRootPart") then return end
  local root = char.HumanoidRootPart

  bodyGyro = Instance.new("BodyGyro", root)
  bodyGyro.P = 9e4
  bodyGyro.maxTorque = Vector3.new(9e9,9e9,9e9)
  bodyGyro.cframe = root.CFrame

  bodyVelocity = Instance.new("BodyVelocity", root)
  bodyVelocity.maxForce = Vector3.new(9e9,9e9,9e9)
  bodyVelocity.velocity = Vector3.new(0,0,0)

  platformStand = char:FindFirstChildOfClass("Humanoid").PlatformStand
  char:FindFirstChildOfClass("Humanoid").PlatformStand = true

  flyOn = true
end

local function stopFly()
  if bodyGyro then bodyGyro:Destroy() end
  if bodyVelocity then bodyVelocity:Destroy() end
  if plr.Character then
    plr.Character:FindFirstChildOfClass("Humanoid").PlatformStand = platformStand
  end
  flyOn = false
end

runService.RenderStepped:Connect(function()
  if flyOn then
    local cam = workspace.CurrentCamera
    local dir = Vector3.new()
    if userInput:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
    if userInput:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
    if userInput:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
    if userInput:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
    bodyGyro.CFrame = cam.CFrame
    local target = dir.Unit * flySpeed
    bodyVelocity.velocity = smoothOn and target or dir * flySpeed
  end
end)

-- Buttons
local function makeButton(text, func)
  local btn = Instance.new("TextButton", frame)
  btn.Size = UDim2.new(0.9,0,0,30)
  btn.Position = UDim2.new(0.05,0,0,spacing)
  btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
  btn.TextColor3 = Color3.new(1,1,1)
  btn.Font = Enum.Font.Gotham
  btn.TextSize = 16
  btn.Text = text
  spacing += 35
  btn.MouseButton1Click:Connect(func)
  return btn
end

-- Fly Toggle
makeButton("Toggle Fly", function()
  if flyOn then stopFly() else startFly() end
end)

-- Smooth Toggle
makeButton("Smooth Fly: OFF", function(btn)
  smoothOn = not smoothOn
  btn.Text = "Smooth Fly: " .. (smoothOn and "ON" or "OFF")
end)

-- Keybind select
makeButton("Change Keybind ("..keybind.Name..")", function(btn)
  btn.Text = "Press new key..."
  local conn
  conn = userInput.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.Keyboard then
      keybind = inp.KeyCode
      btn.Text = "Change Keybind ("..keybind.Name..")"
      conn:Disconnect()
    end
  end)
end)

-- Keybind toggle
makeButton("Use Keybind: ON", function(btn)
  btn.Text = "Use Keybind: " .. ((useKeybind := not (useKeybind or true)) and "ON" or "OFF")
end)

-- Speed adjusters
makeButton("+ Speed", function() flySpeed += 10 end)
makeButton("- Speed", function() flySpeed = math.max(10, flySpeed-10) end)

-- Collapse
local collapseBtn = makeButton("Collapse GUI", function()
  for _,c in pairs(frame:GetChildren()) do
    if c:IsA("TextButton") and c ~= collapseBtn and c.Name ~= "CloseBtn" then
      c.Visible = not c.Visible
    end
  end
end)

-- Close
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0.2,0,0,30)
closeBtn.Position = UDim2.new(0.8, -5, 0, 2)
closeBtn.Text = "✖️"
closeBtn.TextColor3 = Color3.new(1,0.3,0.3)
closeBtn.BackgroundTransparency = 1
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Keybind handler
userInput.InputBegan:Connect(function(inp)
  if inp.KeyCode == keybind and (useKeybind or true) then 
    if flyOn then stopFly() else startFly() end
  end
end)

-- Drag
local dragging = false
local dragStart, startPos, dragInput
frame.InputBegan:Connect(function(inp)
  if inp.UserInputType == Enum.UserInputType.MouseButton1 then
    dragging = true
    dragStart = inp.Position
    startPos = frame.Position
    inp.Changed:Connect(function()
      if inp.UserInputState == Enum.UserInputState.End then
        dragging = false
      end
    end)
  end
end)
frame.InputChanged:Connect(function(inp)
  if inp.UserInputType == Enum.UserInputType.MouseMovement then dragInput = inp end
end)
runService.RenderStepped:Connect(function()
  if dragging and dragInput then
    local delta = dragInput.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
  end
end)
