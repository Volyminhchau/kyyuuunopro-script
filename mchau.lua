-- ====================================================================
-- PHẦN 1: TỰ KHỞI TẠO GIAO DIỆN PHONG CÁCH TAB CAO CẤP (XỊN XÒ)
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
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 14)
    UICorner.Parent = MainFrame

    -- Thanh Tiêu Đề phía trên
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    Title.Text = "   " .. (titleText or "Menu Premium")
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 14)
    TitleCorner.Parent = Title

    -- Thanh Sidebar chứa các mục (Tab) bên trái
    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 130, 1, -45)
    Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SidebarLayout.Parent = Sidebar
    
    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.Parent = Sidebar

    -- Khung chứa nội dung bên phải (Container chính)
    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -140, 1, -55)
    ContentContainer.Position = UDim2.new(0, 135, 0, 50)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local TabCount = 0
    local Tabs = {}
    local LibraryMethods = {}

    -- Hàm tạo một Mục mới (Tab)
    function LibraryMethods:CreateTab(tabName)
        TabCount = TabCount + 1
        
        -- Tạo Khung chứa nội dung riêng cho Tab này (Mặc định ẩn)
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.BackgroundTransparency = 1
        TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContent.ScrollBarThickness = 4
        TabContent.Visible = (TabCount == 1) -- Tab đầu tiên sẽ hiện mặc định
        TabContent.Parent = ContentContainer
        
        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.Parent = TabContent

        -- Tạo Nút bấm chọn Tab ở thanh Sidebar bên trái
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 115, 0, 38)
        TabButton.BackgroundColor3 = (TabCount == 1) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(35, 35, 45)
        TabButton.Text = tabName
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 14
        TabButton.Font = Enum.Font.SourceSansBold
        TabButton.Parent = Sidebar
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = TabButton

        -- Lưu thông tin Tab vào danh sách
        table.insert(Tabs, {Button = TabButton, Content = TabContent})

        -- Xử lý chuyển đổi Tab khi bấm vào nút ở thanh bên trái
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Content.Visible = (t.Button == TabButton)
                t.Button.BackgroundColor3 = (t.Button == TabButton) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(35, 35, 45)
            end
        end)

        -- Hàm tạo nút Bật/Tắt (Toggle) bên trong Tab này
        local TabMethods = {}
        
        function TabMethods:CreateToggle(config)
            local toggleName = config.Name or "Toggle"
            local callback = config.Callback or function() end
            local isToggled = config.CurrentValue or false

            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Size = UDim2.new(1, 0, 0, 45)
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 40)
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
            ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(65, 65, 75)
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
                    ToggleButton.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
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
-- PHẦN 3: KHỞI CHẠY MENU VỚI LOGIC TỰ NHẬN DIỆN QUÁI KHÔNG TÊN
-- ====================================================================
local MainMenu = MyLibrary:CreateWindow("Kyyuuunopro Private ⚔️")

-- Tạo mục Farm ở thanh danh mục bên trái
local FarmTab = MainMenu:CreateTab("Farm ⚔️")

local _G = _G or {}
_G.AutoFarm = false

-- Danh sách các NPC có tên (giữ nguyên để ưu tiên săn lùng trước)
local targetNPCs = {
    "Thug",
    "Angry bob",
    "Angry Freddy",
    "Thief",
    "Gunslinger"
}

-- Hàm kiểm tra quái có tên trong danh sách
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
    Name = "Auto Farm Mobs (Toàn Map)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        
        if _G.AutoFarm then
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.02) -- Tốc độ vòng lặp tối ưu
                    
                    local character = localPlayer.Character
                    if character then
                        local rootPart = character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character:FindFirstChildOfClass("Humanoid")
                        
                        if rootPart and humanoid and humanoid.Health > 0 then
                            local targetNPC = nil
                            
                            -- 🌟 CẢI TIẾN BỘ LỌC QUÉT QUÁI THÔNG MINH
                            for _, obj in pairs(workspace:GetDescendants()) do
                                -- 1. Tìm các sinh vật có Humanoid và còn sống
                                local enemyHumanoid = obj:FindFirstChildOfClass("Humanoid")
                                if enemyHumanoid and enemyHumanoid.Health > 0 then
                                    
                                    -- 2. Đảm bảo sinh vật này KHÔNG PHẢI là chính bạn hoặc người chơi khác
                                    local isPlayer = game:GetService("Players"):GetPlayerFromCharacter(obj)
                                    if not isPlayer and obj.Name ~= localPlayer.Name then
                                        
                                        -- 3. Đảm bảo quái có vị trí gốc để bay tới
                                        if obj:FindFirstChild("HumanoidRootPart") then
                                            
                                            -- ĐIỀU KIỆN CHỌN: Có tên trong danh sách HOẶC tên bị để trống/không có tên
                                            if isTargetNPC(obj.Name) or obj.Name == "" or obj.Name == "NPC" or string.len(obj.Name) <= 1 then
                                                targetNPC = obj
                                                break -- Tìm thấy quái hợp lệ lập tức khóa mục tiêu
                                            end
                                        end
                                    end
                                end
                            end
                            
                            -- Thực hiện dịch chuyển áp sát 1.2 studs và click tấn công
                            if targetNPC then
                                local npcRoot = targetNPC.HumanoidRootPart
                                
                                -- Áp sát cực cận 1.2 studs và xoay mặt khóa mục tiêu
                                local targetPosition = npcRoot.Position + (npcRoot.CFrame.LookVector * -1.2)
                                rootPart.CFrame = CFrame.new(targetPosition, npcRoot.Position)
                                
                                -- Tự động trang bị vũ khí trên tay
                                local tool = character:FindFirstChildOfClass("Tool")
                                if not tool then
                                    local backpackTool = localPlayer.Backpack:FindFirstChildOfClass("Tool")
                                    if backpackTool then 
                                        backpackTool.Parent = character 
                                    end
                                end
                                
                                -- Giả lập click chuột ảo liên hoàn để chém quái
                                pcall(function()
                                    VirtualUser:CaptureController()
                                    VirtualUser:ClickButton1(Vector2.new(9999, 9999))
                                end)
                            end
                        end
                    end
                end
            end)
        end
    end
})

