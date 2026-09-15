-- Kiểm tra xem game đã load xong chưa
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- Xóa UI cũ nếu có để tránh bị trùng lặp
if CoreGui:FindFirstChild("ECLS_StealAnEgg_Hub") then
    CoreGui.ECLS_StealAnEgg_Hub:Destroy()
end

-- Tạo ScreenGui chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ECLS_StealAnEgg_Hub"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ==================== 1. MÀN HÌNH LOADING (5 GIÂY) ====================
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Name = "LoadingFrame"
LoadingFrame.Parent = ScreenGui
LoadingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
LoadingFrame.BorderSizePixel = 0
LoadingFrame.Position = UDim2.new(0.5, -160, 0.5, -100)
LoadingFrame.Size = UDim2.new(0, 320, 0, 180)
LoadingFrame.Active = true
LoadingFrame.Draggable = true

local LoadingCorner = Instance.new("UICorner")
LoadingCorner.CornerRadius = UDim.new(0, 12)
LoadingCorner.Parent = LoadingFrame

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingFrame
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Position = UDim2.new(0, 0, 0, 20)
LoadingTitle.Size = UDim2.new(1, 0, 0, 30)
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.Text = "ECLS HUB - LOADING"
LoadingTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LoadingTitle.TextSize = 18

local LoadingStatus = Instance.new("TextLabel")
LoadingStatus.Parent = LoadingFrame
LoadingStatus.BackgroundTransparency = 1
LoadingStatus.Position = UDim2.new(0, 0, 0, 60)
LoadingStatus.Size = UDim2.new(1, 0, 0, 30)
LoadingStatus.Font = Enum.Font.Gotham
LoadingStatus.Text = "Đang tải tài nguyên... (5s)"
LoadingStatus.TextColor3 = Color3.fromRGB(180, 180, 180)
LoadingStatus.TextSize = 14

local ContinueBtn = Instance.new("TextButton")
ContinueBtn.Name = "ContinueBtn"
ContinueBtn.Parent = LoadingFrame
ContinueBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
ContinueBtn.BorderSizePixel = 0
ContinueBtn.Position = UDim2.new(0.5, -100, 0, 110)
ContinueBtn.Size = UDim2.new(0, 200, 0, 40)
ContinueBtn.Font = Enum.Font.GothamBold
ContinueBtn.Text = "Vui lòng đợi..."
ContinueBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ContinueBtn.TextSize = 14
ContinueBtn.Active = false

local ContinueCorner = Instance.new("UICorner")
ContinueCorner.CornerRadius = UDim.new(0, 8)
ContinueCorner.Parent = ContinueBtn

-- ==================== 2. GIAO DIỆN MENU CHÍNH ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "ECLS HUB - Steal An Egg (Pro Edition)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = Title

local Container = Instance.new("ScrollingFrame")
Container.Parent = MainFrame
Container.Active = true
Container.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0, 10, 0, 50)
Container.Size = UDim2.new(0, 380, 0, 255)
Container.CanvasSize = UDim2.new(0, 0, 0, 350)
Container.ScrollBarThickness = 4

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Đếm ngược 5 giây
task.spawn(function()
    for i = 5, 1, -1 do
        LoadingStatus.Text = "Đang chuẩn bị hệ thống... (" .. i .. "s)"
        task.wait(1)
    end
    LoadingStatus.Text = "Tải thành công!"
    ContinueBtn.Text = "CONTINUE"
    ContinueBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ContinueBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
    ContinueBtn.Active = true
end)

ContinueBtn.MouseButton1Click:Connect(function()
    if ContinueBtn.Active and ContinueBtn.Text == "CONTINUE" then
        LoadingFrame.Visible = false
        MainFrame.Visible = true
    end
end)

-- Hàm tạo nút bấm
local function createButton(name, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = Container
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
    Btn.BorderSizePixel = 0
    Btn.Size = UDim2.new(1, 0, 0, 35)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn

    local toggled = false
    Btn.MouseButton1Click:Connect(function()
        toggled = not toggled
        if toggled then
            Btn.BackgroundColor3 = Color3.fromRGB(0, 170, 127)
        else
            Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
        end
        callback(toggled)
    end)
end

-- Hàm tạo ô nhập liệu (TextBox)
local function createTextBox(placeholder, callback)
    local Box = Instance.new("TextBox")
    Box.Parent = Container
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
    Box.BorderSizePixel = 0
    Box.Size = UDim2.new(1, 0, 0, 35)
    Box.Font = Enum.Font.Gotham
    Box.PlaceholderText = placeholder
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 13

    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 8)
    BoxCorner.Parent = Box

    Box.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(Box.Text)
        end
    end)
end

-- ==================== CHỨC NĂNG HỆ THỐNG ====================

local selectedEggName = ""

createTextBox("Nhập tên loại trứng muốn Steal (VD: Dragon Egg)...", function(text)
    selectedEggName = text
    print("Đã lọc trứng mục tiêu: " .. (text == "" and "Tất cả" or text))
end)

-- 1. Auto Steal Egg
local autoStealActive = false
task.spawn(function()
    while true do
        task.wait(0.2)
        if autoStealActive then
            pcall(function()
                local eggsFolder = Workspace:FindFirstChild("Eggs") or Workspace:FindFirstChild("Collectibles")
                if eggsFolder and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = LocalPlayer.Character.HumanoidRootPart
                    for _, egg in pairs(eggsFolder:GetChildren()) do
                        if autoStealActive and egg:IsA("Model") and egg.PrimaryPart then
                            local match = true
                            if selectedEggName ~= "" then
                                if not string.find(string.lower(egg.Name), string.lower(selectedEggName)) then
                                    match = false
                                end
                            end
                            
                            if match then
                                rootPart.CFrame = egg.PrimaryPart.CFrame
                                local prompt = egg:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then
                                    fireproximityprompt(prompt)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

createButton("Auto Steal Egg: OFF / ON", function(state)
    autoStealActive = state
end)

-- 2. Chỉnh tốc độ chạy (WalkSpeed = 1000)
local speedActive = false
RunService.RenderStepped:Connect(function()
    if speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 1000
    end
end)

createButton("Speed Hack (WalkSpeed = 1000): OFF / ON", function(state)
    speedActive = state
    if not state and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

-- 3. ESP Trứng
local eggEspActive = false
local espContainer = Instance.new("Folder")
espContainer.Name = "ECLS_EggESP"
espContainer.Parent = CoreGui

task.spawn(function()
    while true do
        task.wait(1)
        if eggEspActive then
            pcall(function()
                espContainer:ClearAllChildren()
                local eggsFolder = Workspace:FindFirstChild("Eggs") or Workspace:FindFirstChild("Collectibles")
                if eggsFolder then
                    for _, egg in pairs(eggsFolder:GetChildren()) do
                        if egg:IsA("Model") and egg.PrimaryPart then
                            local weight = egg:GetAttribute("Weight") or 100
                            local valuePerSec = egg:GetAttribute("ValuePerSec") or 50
                            
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESP_Info"
                            billboard.Adornee = egg.PrimaryPart
                            billboard.Size = UDim2.new(0, 150, 0, 50)
                            billboard.StudsOffset = Vector3.new(0, 2, 0)
                            billboard.AlwaysOnTop = true
                            billboard.Parent = espContainer
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Font = Enum.Font.GothamBold
                            textLabel.TextSize = 12
                            textLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                            textLabel.TextStrokeTransparency = 0
                            textLabel.Text = "Trứng: " .. egg.Name .. "\n⚖️ Weight: " .. tostring(weight) .. "\n💰 $" .. tostring(valuePerSec) .. "/s"
                            textLabel.Parent = billboard
                        end
                    end
                end
            end)
        else
            espContainer:ClearAllChildren()
        end
    end
end)

createButton("ESP Trứng (Weight & Value/s): OFF / ON", function(state)
    eggEspActive = state
end)

-- 4. ESP Plot
local plotEspActive = false
local plotEspContainer = Instance.new("Folder")
plotEspContainer.Name = "ECLS_PlotESP"
plotEspContainer.Parent = CoreGui

task.spawn(function()
    while true do
        task.wait(2)
        if plotEspActive then
            pcall(function()
                plotEspContainer:ClearAllChildren()
                local plotsFolder = Workspace:FindFirstChild("Plots") or Workspace:FindFirstChild("Bases")
                if plotsFolder then
                    for _, plot in pairs(plotsFolder:GetChildren()) do
                        local primaryPart = plot.PrimaryPart or plot:FindFirstChildWhichIsA("BasePart")
                        if primaryPart then
                            local billboard = Instance.new("BillboardGui")
                            billboard.Name = "ESP_Plot"
                            billboard.Adornee = primaryPart
                            billboard.Size = UDim2.new(0, 200, 0, 40)
                            billboard.StudsOffset = Vector3.new(0, 5, 0)
                            billboard.AlwaysOnTop = true
                            billboard.Parent = plotEspContainer
                            
                            local textLabel = Instance.new("TextLabel")
                            textLabel.Size = UDim2.new(1, 0, 1, 0)
                            textLabel.BackgroundTransparency = 1
                            textLabel.Font = Enum.Font.GothamBold
                            textLabel.TextSize = 14
                            textLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
                            textLabel.TextStrokeTransparency = 0
                            textLabel.Text = "🏠 Plot: " .. plot.Name
                            textLabel.Parent = billboard
                        end
                    end
                end
            end)
        else
            plotEspContainer:ClearAllChildren()
        end
    end
end)

createButton("ESP Plot (Khu vực căn cứ): OFF / ON", function(state)
    plotEspActive = state
end)

-- 5. Fix Lag
createButton("Fix Lag (Xóa vật thể thừa)", function(state)
    if state then
        pcall(function()
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("Part") and v.Name == "Debris" then
                    v:Destroy()
                end
            end
        end)
    end
end)

-- 6. Boost FPS
createButton("Boost FPS (Tối ưu đồ họa)", function(state)
    if state then
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end
    else
        Lighting.GlobalShadows = true
        settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
    end
end)

print("ECLS Hub Pro Edition đã khởi động hoàn tất!")
