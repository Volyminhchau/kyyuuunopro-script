-- ====================================================================
-- PHẦN 1: TỰ KHỞI TẠO GIAO DIỆN PHONG CÁCH TAB LED RGB CHỚP TẮT VIP
-- ====================================================================
local MyLibrary = {}

function MyLibrary:CreateWindow(titleText)
    -- Màn hình chính chứa giao diện
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KyyuuunoproPremiumUI"
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

    -- Khung Menu Chính (Bo góc mạnh, màu nền tối huyền bí)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 480, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18) -- Tối hơn để nổi bật đèn LED
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 14)
    UICorner.Parent = MainFrame

    -- 🌟 1. HỆ THỐNG VIỀN ĐÈN LED NHẤP NHÁY RGB QUANH MENU (UIStroke)
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Parent = MainFrame

    -- Thanh Tiêu Đề phía trên
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    Title.Text = "   " .. (titleText or "Menu Premium")
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 14)
    TitleCorner.Parent = Title

    -- 🌟 2. ĐƯỜNG LED NGĂN CÁCH GIỮA TIÊU ĐỀ VÀ NỘI DUNG
    local LineGlow = Instance.new("Frame")
    LineGlow.Size = UDim2.new(1, 0, 0, 2)
    LineGlow.Position = UDim2.new(0, 0, 0, 44)
    LineGlow.BorderSizePixel = 0
    LineGlow.Parent = MainFrame

    -- 🌟 LẬP TRÌNH HIỆU ỨNG ĐÈN CHỚP ĐỔI MÀU CẦU VỒNG (RAINBOW RGB EFFECT)
    task.spawn(function()
        local tickCount = 0
        while task.wait(0.01) do
            tickCount = tickCount + 1
            -- Tính toán dải màu RGB chạy mượt (Tốc độ đổi màu phụ thuộc vào việc chia cho 200)
            local hue = (tickCount % 200) / 200
            local rainbowColor = Color3.fromHSV(hue, 1, 1)
            
            -- Ép đèn viền menu và thanh ngăn cách đổi màu nhấp nháy liên tục
            UIStroke.Color = rainbowColor
            LineGlow.BackgroundColor3 = rainbowColor
            Title.TextColor3 = rainbowColor -- Chữ tiêu đề cũng đổi màu theo LED
        end
    end)

    -- NÚT DẤU TRỪ (-) ĐỂ THU NHỎ MENU TO
    local CloseMinButton = Instance.new("TextButton")
    CloseMinButton.Size = UDim2.new(0, 30, 0, 30)
    CloseMinButton.Position = UDim2.new(1, -38, 0, 7)
    CloseMinButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
    CloseMinButton.Text = "-"
    CloseMinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseMinButton.TextSize = 20
    CloseMinButton.Font = Enum.Font.SourceSansBold
    CloseMinButton.Parent = MainFrame

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = CloseMinButton

    -- NÚT TRÒN (OPEN) ĐỂ HIỆN LẠI MENU TO (CÓ LED RGB NHẤP NHÁY QUANH NÚT LUÔN)
    local OpenButton = Instance.new("TextButton")
    OpenButton.Size = UDim2.new(0, 50, 0, 50)
    OpenButton.Position = UDim2.new(0, 20, 1, -70) 
    OpenButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30) 
    OpenButton.Text = "OPEN"
    OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 12
    OpenButton.Font = Enum.Font.SourceSansBold
    OpenButton.Visible = false 
    OpenButton.Parent = ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(0, 25) 
    OpenCorner.Parent = OpenButton

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Thickness = 2
    OpenStroke.Parent = OpenButton

    -- Đèn LED nhấp nháy cho nút OPEN khi thu nhỏ menu
    task.spawn(function()
        local tickCount = 0
        while task.wait(0.01) do
            tickCount = tickCount + 1
            local hue = (tickCount % 200) / 200
            local rainbowColor = Color3.fromHSV(hue, 1, 1)
            OpenStroke.Color = rainbowColor
            OpenButton.TextColor3 = rainbowColor
        end
    end)

    CloseMinButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = false 
        OpenButton.Visible = true 
    end)

    OpenButton.MouseButton1Click:Connect(function()
        MainFrame.Visible = true  
        OpenButton.Visible = false 
    end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 130, 1, -45)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Parent = Sidebar
    
    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.Parent = Sidebar

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -140, 1, -55)
    ContentContainer.Position = UDim2.new(0, 135, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local TabCount = 0
    local Tabs = {}
    local LibraryMethods = {}

    function LibraryMethods:CreateTab(tabName)
        TabCount = TabCount + 1
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.Visible = (TabCount == 1)
        TabContent.Parent = ContentContainer
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.Parent = TabContent

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 115, 0, 38)
        TabButton.BackgroundColor3 = (TabCount == 1) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(32, 32, 42)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Parent = Sidebar
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = TabButton

        table.insert(Tabs, {Button = TabButton, Content = TabContent})

        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Content.Visible = (t.Button == TabButton)
                t.Button.BackgroundColor3 = (t.Button == TabButton) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(32, 32, 42)
            end
        end)

        local TabMethods = {}
        
        function TabMethods:CreateToggle(config)
            local toggleName = config.Name or "Toggle"
            local callback = config.Callback or function() end
            local isToggled = config.CurrentValue or false

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
            ToggleFrame.BorderSizePixel = 0
            ToggleFrame.Parent = TabContent
            
            local FrameCorner = Instance.new("UICorner")
            FrameCorner.CornerRadius = UDim.new(0, 8)
            FrameCorner.Parent = ToggleFrame

            local ToggleText = Instance.new("TextLabel")
            ToggleText.Size = UDim2.new(1, -70, 1, 0)
            ToggleText.Position = UDim2.new(0, 12, 0, 0)
            ToggleText.BackgroundTransparency = 1
            ToggleText.Text = toggleName
            ToggleText.TextColor3 = Color3.fromRGB(230, 230, 230)
            ToggleText.TextSize = 14
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left
            ToggleText.Font = Enum.Font.SourceSansBold
            ToggleText.Parent = ToggleFrame

            local ToggleButton = Instance.new("TextButton")
            ToggleButton.Size = UDim2.new(0, 50, 0, 26)
            ToggleButton.Position = UDim2.new(1, -62, 0.5, -13)
            ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(55, 55, 65)
            ToggleButton.Text = isToggled and "ON" or "OFF"
            ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.TextSize = 12
            ToggleButton.Font = Enum.Font.SourceSansBold
            ToggleButton.Parent = ToggleFrame

            local ToggleCorner = Instance.new("UICorner")
            ToggleCorner.CornerRadius = UDim.new(0, 6)
            ToggleCorner.Parent = ToggleButton

            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                if isToggled then
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
                    ToggleButton.Text = "ON"
                else
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
                    ToggleButton.Text = "OFF"
                end
                callback(isToggled)
            end)
        end

        return TabMethods
    end

    return LibraryMethods
end



-- ====================================================================
-- PHẦN 2: LOGIC AUTO SPAWN (TỰ BẤM NÚT HỒI SINH NHANH)
-- ====================================================================
local PlayersService = game:GetService("Players")
local localPlayer = PlayersService.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

task.spawn(function()
    while true do
        task.wait(1)
        local character = localPlayer.Character
        if not character or (character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0) then
            local playerGui = localPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                for _, gui in pairs(playerGui:GetDescendants()) do
                    if gui:IsA("TextButton") or gui:IsA("ImageButton") then
                        local buttonText = string.lower(gui.Name)
                        if gui:IsA("TextButton") then buttonText = buttonText .. string.lower(gui.Text) end
                        if string.find(buttonText, "spawn") or string.find(buttonText, "respawn") or string.find(buttonText, "play") or string.find(buttonText, "sinh") or string.find(buttonText, "chơi") then
                            if gui.Visible and gui.AbsoluteSize.X > 0 then
                                pcall(function()
                                    gui:Activate()
                                    for _, connection in pairs(getconnections(gui.MouseButton1Click)) do connection:Fire() end
                                    for _, connection in pairs(getconnections(gui.MouseButton1Down)) do connection:Fire() end
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)
-- ====================================================================
-- PHẦN 3: KHỞI CHẠY MENU - KHÓA CHẶT DỊCH CHUYỂN ĐẾN NPC BLACKLIST (MÁU < 1000)
-- ====================================================================
local MainMenu = MyLibrary:CreateWindow("Kyyuuunopro Private ⚔️")

-- Tạo mục Farm ở thanh danh mục bên trái
local FarmTab = MainMenu:CreateTab("Farm ⚔️")

local _G = _G or {}
_G.AutoFarm = false

-- Hệ thống danh sách đen khóa chặt quái bất tử
local fakeMonsterBlacklist = {}
local currentTarget = nil
local previousHealth = 0
local checkTimer = 0

-- Danh sách tên quái cũ để ưu tiên quét trước (nếu có)
local targetNPCs = {"Bandit", "Thug", "Angry bob", "Angry Freddy", "Thief", "Gunslinger"}

local function isTargetNPC(name)
    local lowerName = string.lower(name)
    for _, target in pairs(targetNPCs) do
        if string.find(lowerName, string.lower(target)) then
            return true
        end
    end
    return false
end

-- Tạo nút gạt ON/OFF Auto Farm bên trong mục Farm
FarmTab:CreateToggle({
    Name = "Auto Farm Mobs (Máu < 2000)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            -- Làm mới danh sách đen mỗi khi bật lại nút
            fakeMonsterBlacklist = {}
            currentTarget = nil
            checkTimer = 0
            
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.02) -- Tốc độ vòng lặp tối ưu
                    
                    local character = localPlayer.Character
                    if character then
                        local myRoot = character:FindFirstChild("HumanoidRootPart")
                        local myHumanoid = character:FindFirstChildOfClass("Humanoid")
                        
                        if myRoot and myHumanoid and myHumanoid.Health > 0 then
                            local targetNPC = nil
                            local targetPart = nil
                            
                            -- VÒNG QUÉT LỌC GIỚI HẠN LƯỢNG MÁU < 1000
                            for _, obj in pairs(workspace:GetDescendants()) do
                                -- 🌟 SỬA LỖI TẠI ĐÂY: Kiểm tra Blacklist TRƯỚC TIÊN. Nếu nằm trong danh sách đen thì BỎ QUA NGAY KHÔNG XÉT TIẾP
                                if not fakeMonsterBlacklist[obj] then
                                    local enemyHumanoid = obj:FindFirstChildOfClass("Humanoid")
                                    
                                    -- Kiểm tra quái phải còn sống và MaxHealth hệ thống < 1000
                                    if enemyHumanoid and enemyHumanoid.Health > 0 and enemyHumanoid.MaxHealth < 2000 then
                                        
                                        -- Loại trừ chính bạn và người chơi thật khác
                                        local isPlayer = game:GetService("Players"):GetPlayerFromCharacter(obj)
                                        if not isPlayer and obj.Name ~= localPlayer.Name then
                                            
                                            if isTargetNPC(obj.Name) or obj.Name == "" or obj.Name == "NPC" or string.len(obj.Name) <= 4 or obj:IsA("Model") then
                                                -- Kiểm tra loại trừ cây thư mục cha có chữ Quest
                                                local isQuestParent = false
                                                local currentParent = obj.Parent
                                                while currentParent and currentParent ~= workspace do
                                                    local parentName = string.lower(currentParent.Name)
                                                    if string.find(parentName, "quest") or string.find(parentName, "giver") or string.find(parentName, "dialog") then
                                                        isQuestParent = true
                                                        break
                                                    end
                                                    currentParent = currentParent.Parent
                                                end
                                                
                                                if not isQuestParent then
                                                    local part = obj:FindFirstChild("HumanoidRootPart") 
                                                        or obj:FindFirstChild("Torso") 
                                                        or obj:FindFirstChild("Head") 
                                                        or obj:FindFirstChild("Base")
                                                        or obj:FindFirstChildOfClass("Part")
                                                    
                                                    if part then
                                                        targetNPC = obj
                                                        targetPart = part
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            
                            -- TIẾN HÀNH KIỂM TRA VÀ DỊCH CHUYỂN ỔN ĐỊNH
                            if targetNPC and targetPart then
                                local enemyHumanoid = targetNPC:FindFirstChildOfClass("Humanoid")
                                
                                -- BỘ THEO DÕI SÁT THƯƠNG KHÓA VỊ TRÍ TRÊN NGƯỜI QUÁI
                                if currentTarget == targetNPC then
                                    -- Nếu đứng chém thử mà máu hệ thống cứng đơ không tụt
                                    if enemyHumanoid and enemyHumanoid.Health >= previousHealth then
                                        checkTimer = checkTimer + 1
                                        -- Đứng im chém thử đúng 25 vòng lặp (khoảng 0.5 giây) nếu máu không tụt -> Cấm vĩnh viễn
                                        if checkTimer > 25 then
                                            fakeMonsterBlacklist[targetNPC] = true
                                            currentTarget = nil
                                            checkTimer = 0
                                        end
                                    else
                                        -- Quái tụt máu (quái thật), giữ mục tiêu ổn định
                                        if enemyHumanoid then previousHealth = enemyHumanoid.Health end
                                        checkTimer = 0
                                    end
                                else
                                    -- Bắt đầu khóa mục tiêu mới và ghi nhận lượng máu ban đầu
                                    currentTarget = targetNPC
                                    if enemyHumanoid then previousHealth = enemyHumanoid.Health end
                                    checkTimer = 0
                                end
                                
                                -- 🌟 CHỈ DỊCH CHUYỂN NẾU MỤC TIÊU KHÔNG BỊ CẤM (Bảo vệ nhân vật không bị bay nhấp nháy)
                                if currentTarget == targetNPC and not fakeMonsterBlacklist[targetNPC] then
                                    local targetPosition = targetPart.Position + (targetPart.CFrame.LookVector * -1.2)
                                    myRoot.CFrame = CFrame.new(targetPosition, targetPart.Position)
                                    
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if not tool then
                                        local backpackTool = localPlayer.Backpack:FindFirstChildOfClass("Tool")
                                        if backpackTool then backpackTool.Parent = character end
                                    end
                                    
                                    pcall(function()
                                        VirtualUser:CaptureController()
                                        VirtualUser:ClickButton1(Vector2.new(9999, 9999))
                                    end)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})



