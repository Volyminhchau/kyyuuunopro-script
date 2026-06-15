-- ====================================================================
-- PHẦN 1: THƯ VIỆN GIAO DIỆN CYBERPUNK GRADIENT & BẢNG AUTO SPAWN
-- ====================================================================
local MyLibrary = {}

function MyLibrary:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KyyuuunoproPremiumUI_v3"
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end
    
    -- 🌟 Khung Menu Chính Cao Cấp (Nền tối sâu, đổ bóng mờ)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainFrame.BorderSizePixel = 0 MainFrame.Active = true MainFrame.Draggable = true MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner") UICorner.CornerRadius = UDim.new(0, 14) UICorner.Parent = MainFrame
    
    -- 🌟 ĐÈN LED VIỀN (STOKE GLOW): Tạo dải viền Neon mỏng bo quanh menu cực đẹp
    local UIStroke = Instance.new("UIStroke")
    UIStroke.Thickness = 2
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(45, 120, 255)
    UIStroke.Parent = MainFrame

    -- Thanh Tiêu Đề Phía Trên
    Title = Instance.new("TextLabel") 
    Title.Size = UDim2.new(1, 0, 0, 48) Title.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
    Title.Text = "     " .. (titleText or "PREMIUM HUB") Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left Title.Font = Enum.Font.GothamBold Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner") TitleCorner.CornerRadius = UDim.new(0, 14) TitleCorner.Parent = Title
    
    -- Hiệu ứng chuyển màu Gradient (UIGradient) cho thanh tiêu đề nhìn xịn hơn
    local TitleGradient = Instance.new("UIGradient")
    TitleGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 45, 255))
    })
    TitleGradient.Parent = Title

    -- Nút Dấu Trừ Thu Nhỏ Menu (-)
    local CloseMinButton = Instance.new("TextButton") CloseMinButton.Size = UDim2.new(0, 32, 0, 32) CloseMinButton.Position = UDim2.new(1, -42, 0, 8)
    CloseMinButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45) CloseMinButton.Text = "−" CloseMinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseMinButton.TextSize = 18 CloseMinButton.Font = Enum.Font.GothamBold CloseMinButton.Parent = MainFrame
    local MinCorner = Instance.new("UICorner") MinCorner.CornerRadius = UDim.new(0, 8) MinCorner.Parent = CloseMinButton
    
    -- Nút Tròn Mở Menu Ngoài Màn Hình (OPEN)
    OpenButton = Instance.new("TextButton") 
    OpenButton.Size = UDim2.new(0, 55, 0, 55) OpenButton.Position = UDim2.new(0, 25, 1, -80)
    OpenButton.BackgroundColor3 = Color3.fromRGB(45, 120, 255) OpenButton.Text = "OPEN" OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 13 OpenButton.Font = Enum.Font.GothamBold OpenButton.Visible = false OpenButton.Parent = ScreenGui
    local OpenCorner = Instance.new("UICorner") OpenCorner.CornerRadius = UDim.new(0, 28) OpenCorner.Parent = OpenButton
    
    -- Hiệu ứng Stroke cho nút Open
    local OpenStroke = Instance.new("UIStroke") OpenStroke.Thickness = 2 OpenStroke.Color = Color3.fromRGB(255, 255, 255) OpenStroke.Parent = OpenButton

    CloseMinButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
    OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenButton.Visible = false end)
    
    -- Thanh Sidebar Chọn Tab bên trái
    local Sidebar = Instance.new("Frame") Sidebar.Size = UDim2.new(0, 140, 1, -48) Sidebar.Position = UDim2.new(0, 0, 0, 48)
    Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 26) Sidebar.BorderSizePixel = 0 Sidebar.Parent = MainFrame
    local SidebarLayout = Instance.new("UIListLayout") SidebarLayout.Padding = UDim.new(0, 6) SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center SidebarLayout.Parent = Sidebar
    local SidebarPadding = Instance.new("UIPadding") SidebarPadding.PaddingTop = UDim.new(0, 12) SidebarPadding.Parent = Sidebar
    
    -- Khung nội dung bên phải (Có thêm Stroke phân cách)
    local ContentContainer = Instance.new("Frame") ContentContainer.Size = UDim2.new(1, -155, 1, -60) ContentContainer.Position = UDim2.new(0, 148, 0, 54) ContentContainer.BackgroundTransparency = 1 ContentContainer.Parent = MainFrame
    
    -- Vòng lặp liên tục chạy Đèn LED Viền Cầu Vồng (Chữa lỗi mất màu câu trước)
    task.spawn(function()
        local hue = 0
        while task.wait(0.01) do
            hue = hue + 0.004 if hue > 1 then hue = 0 end
            local rainbow = Color3.fromHSV(hue, 0.85, 0.85)
            if UIStroke then UIStroke.Color = rainbow end
            if OpenStroke then OpenStroke.Color = rainbow end
        end
    end)

    local TabCount = 0 local Tabs = {} local LibraryMethods = {}
    
    function LibraryMethods:CreateTab(tabName)
        TabCount = TabCount + 1
        local TabContent = Instance.new("ScrollingFrame") TabContent.Size = UDim2.new(1, 0, 1, 0) TabContent.BackgroundTransparency = 1 TabContent.ScrollBarThickness = 4 TabContent.Visible = (TabCount == 1) TabContent.Parent = ContentContainer
        TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y TabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        local ContentLayout = Instance.new("UIListLayout") ContentLayout.Padding = UDim.new(0, 10) ContentLayout.Parent = TabContent
        
        -- Nút bấm Sidebar có thiết kế mượt mà
        local TabButton = Instance.new("TextButton") TabButton.Size = UDim2.new(0, 124, 0, 40) TabButton.BackgroundColor3 = (TabCount == 1) and Color3.fromRGB(35, 40, 55) or Color3.fromRGB(26, 26, 34) TabButton.Text = tabName TabButton.TextColor3 = Color3.fromRGB(255, 255, 255) TabButton.TextSize = 13 TabButton.Font = Enum.Font.GothamBold TabButton.Parent = Sidebar
        local ButtonCorner = Instance.new("UICorner") ButtonCorner.CornerRadius = UDim.new(0, 8) ButtonCorner.Parent = TabButton
        local ButtonStroke = Instance.new("UIStroke") ButtonStroke.Thickness = 1 ButtonStroke.Color = (TabCount == 1) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(40, 40, 50) ButtonStroke.Parent = TabButton

        table.insert(Tabs, {Button = TabButton, Content = TabContent, Stroke = ButtonStroke})
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do 
                t.Content.Visible = (t.Button == TabButton) 
                t.Button.BackgroundColor3 = (t.Button == TabButton) and Color3.fromRGB(35, 40, 55) or Color3.fromRGB(26, 26, 34)
                t.Stroke.Color = (t.Button == TabButton) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(40, 40, 50)
            end
        end)
        
        local TabMethods = {}
        function TabMethods:CreateToggle(config)
            local toggleName = config.Name or "Toggle" local callback = config.Callback or function() end local isToggled = config.CurrentValue or false
            
            -- Khung bọc nút Toggle xịn bo góc
            local ToggleFrame = Instance.new("Frame") ToggleFrame.Size = UDim2.new(1, -5, 0, 48) ToggleFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32) ToggleFrame.BorderSizePixel = 0 ToggleFrame.Parent = TabContent
            local FrameCorner = Instance.new("UICorner") FrameCorner.CornerRadius = UDim.new(0, 10) FrameCorner.Parent = ToggleFrame
            local FrameStroke = Instance.new("UIStroke") FrameStroke.Thickness = 1 FrameStroke.Color = Color3.fromRGB(35, 35, 45) FrameStroke.Parent = ToggleFrame

            local ToggleText = Instance.new("TextLabel") ToggleText.Size = UDim2.new(1, -80, 1, 0) ToggleText.Position = UDim2.new(0, 14, 0, 0) ToggleText.BackgroundTransparency = 1 ToggleText.Text = toggleName ToggleText.TextColor3 = Color3.fromRGB(240, 240, 245) ToggleText.TextSize = 13 ToggleText.TextXAlignment = Enum.TextXAlignment.Left ToggleText.Font = Enum.Font.GothamBold ToggleText.Parent = ToggleFrame
            
            -- 🌟 THANH TRƯỢT SLIDER TOGGLE: Thiết kế rãnh trượt chuẩn công nghệ Premium
            local SliderBg = Instance.new("Frame") SliderBg.Size = UDim2.new(0, 52, 0, 26) SliderBg.Position = UDim2.new(1, -66, 0.5, -13) SliderBg.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(50, 50, 60) SliderBg.Parent = ToggleFrame
            local SliderCorner = Instance.new("UICorner") SliderCorner.CornerRadius = UDim.new(0, 13) SliderCorner.Parent = SliderBg
            
            -- Viên bi tròn chạy hoạt ảnh (Circle)
            local Circle = Instance.new("Frame") Circle.Size = UDim2.new(0, 20, 0, 20) Circle.Position = isToggled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10) Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255) Circle.Parent = SliderBg
            local CircleCorner = Instance.new("UICorner") CircleCorner.CornerRadius = UDim.new(0, 10) CircleCorner.Parent = Circle
            
            local HitButton = Instance.new("TextButton") HitButton.Size = UDim2.new(1, 0, 1, 0) HitButton.BackgroundTransparency = 1 HitButton.Text = "" HitButton.Parent = SliderBg

            HitButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                -- Chạy hiệu ứng trượt hoạt ảnh Smooth mượt mà sang 2 bên
                if isToggled then 
                    SliderBg.BackgroundColor3 = Color3.fromRGB(46, 204, 113) 
                    Circle:TweenPosition(UDim2.new(1, -23, 0.5, -10), "Out", "Quad", 0.15, true)
                else 
                    SliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60) 
                    Circle:TweenPosition(UDim2.new(0, 3, 0.5, -10), "Out", "Quad", 0.15, true)
                end
                callback(isToggled)
            end)
        end
        return TabMethods
    end
    return LibraryMethods
end

-- ====================================================================
-- PHẦN 1.2: LOGIC HỆ THỐNG TỰ ĐỘNG BẤM NÚT HỒI SINH (AUTO SPAWN)
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
                        if gui:IsA("TextButton") then 
                            buttonText = buttonText .. string.lower(gui.Text) 
                        end 
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
-- PHẦN 2: KHỞI CHẠY MENU, ĐÈN LED RGB VÀ LOGIC TÍNH NĂNG FARM QUÁI
-- ====================================================================
task.spawn(function()
    local hue = 0
    while task.wait(0.01) do
        hue = hue + 0.005 if hue > 1 then hue = 0 end
        local rgbColor = Color3.fromHSV(hue, 0.9, 0.9)
        if Title then Title.BackgroundColor3 = rgbColor end
        if OpenButton then OpenButton.BackgroundColor3 = rgbColor end
    end
end)

local MainMenu = MyLibrary:CreateWindow("Kyyuuunopro Private ⚔️")

-- Tạo mục Farm ở thanh danh mục bên trái
local FarmTab = MainMenu:CreateTab("Farm ⚔️")

local _G = _G or {}
_G.AutoFarm = false
local fakeMonsterBlacklist = {} local currentTarget = nil local previousHealth = 0 local checkTimer = 0
local targetNPCs = {"Bandit", "Thug", "Angry bob", "Angry Freddy", "Thief", "Gunslinger"}

local function isTargetNPC(name)
    local lowerName = string.lower(name)
    for _, target in pairs(targetNPCs) do if string.find(lowerName, string.lower(target)) then return true end end
    return false
end

FarmTab:CreateToggle({
    Name = "Auto Farm Mobs (Máu < 2000)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        if _G.AutoFarm then
            fakeMonsterBlacklist = {} currentTarget = nil checkTimer = 0
            task.spawn(function()
                while _G.AutoFarm do
                    task.wait(0.02)
                    local character = localPlayer.Character
                    if character then
                        local myRoot = character:FindFirstChild("HumanoidRootPart")
                        local myHumanoid = character:FindFirstChildOfClass("Humanoid")
                        if myRoot and myHumanoid and myHumanoid.Health > 0 then
                            local targetNPC = nil local targetPart = nil
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if not fakeMonsterBlacklist[obj] then
                                    local enemyHumanoid = obj:FindFirstChildOfClass("Humanoid")
                                    if enemyHumanoid and enemyHumanoid.Health > 0 and enemyHumanoid.MaxHealth < 2000 then
                                        local isPlayer = game:GetService("Players"):GetPlayerFromCharacter(obj)
                                        if not isPlayer and obj.Name ~= localPlayer.Name then
                                            if isTargetNPC(obj.Name) or obj.Name == "" or obj.Name == "NPC" or string.len(obj.Name) <= 4 or obj:IsA("Model") then
                                                local isQuestParent = false local currentParent = obj.Parent
                                                while currentParent and currentParent ~= workspace do
                                                    local parentName = string.lower(currentParent.Name)
                                                    if string.find(parentName, "quest") or string.find(parentName, "giver") or string.find(parentName, "dialog") then isQuestParent = true break end
                                                    currentParent = currentParent.Parent
                                                end
                                                if not isQuestParent then
                                                    local part = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso") or obj:FindFirstChild("Head") or obj:FindFirstChild("Base") or obj:FindFirstChildOfClass("Part")
                                                    if part then targetNPC = obj targetPart = part break end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if targetNPC and targetPart then
                                local enemyHumanoid = targetNPC:FindFirstChildOfClass("Humanoid")
                                if currentTarget == targetNPC then
                                    if enemyHumanoid and enemyHumanoid.Health >= previousHealth then
                                        checkTimer = checkTimer + 1
                                        if checkTimer > 25 then fakeMonsterBlacklist[targetNPC] = true currentTarget = nil checkTimer = 0 end
                                    else
                                        if enemyHumanoid then previousHealth = enemyHumanoid.Health end checkTimer = 0
                                    end
                                else
                                    currentTarget = targetNPC if enemyHumanoid then previousHealth = enemyHumanoid.Health end checkTimer = 0
                                end
                                if currentTarget == targetNPC and not fakeMonsterBlacklist[targetNPC] then
                                    local targetPosition = targetPart.Position + (targetPart.CFrame.LookVector * -1.2)
                                    myRoot.CFrame = CFrame.new(targetPosition, targetPart.Position)
                                    local tool = character:FindFirstChildOfClass("Tool")
                                    if not tool then local backpackTool = localPlayer.Backpack:FindFirstChildOfClass("Tool") if backpackTool then backpackTool.Parent = character end end
                                    pcall(function() VirtualUser:CaptureController() VirtualUser:ClickButton1(Vector2.new(9999, 9999)) end)
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})
-- ====================================================================
-- PHẦN MỚI: TẠO MỤC TELEPORT ĐẢO AN TOÀN - KHÓA ĐỘ CAO CHỐNG RƠI LỌT ĐẤT
-- ====================================================================
-- Khởi tạo nút "Teleport 🌀" ở thanh bên trái nằm ngay dưới nút Farm
local TeleportTab = MainMenu:CreateTab("Teleport 🌀")

-- Hàm phụ trách dò tìm đảo và đưa người chơi đáp xuống GIỮA ĐẢO TRÊN CAO an toàn
local function teleportToIsland(islandName)
    if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myRoot = localPlayer.Character.HumanoidRootPart
        local foundIsland = nil
        
        -- Quét toàn map tìm khối gạch hoặc Model có tên đảo
        for _, obj in pairs(workspace:GetDescendants()) do
            if string.find(string.lower(obj.Name), string.lower(islandName)) and (obj:IsA("BasePart") or obj:IsA("Model")) then
                foundIsland = obj
                break
            end
        end
        
        if foundIsland then
            local islandCFrame
            
            -- Xác định tọa độ trung tâm (Center CFrame) của hòn đảo
            if foundIsland:IsA("Model") then
                islandCFrame = foundIsland:GetBoundingBox()
            else
                islandCFrame = foundIsland.CFrame
            end
            
            -- 🌟 TĂNG ĐỘ CAO LÊN 120 STUDS ĐỂ SIÊU AN TOÀN
            local safeCFrame = islandCFrame * CFrame.new(0, 140, 0)
            
            -- 🌟 BỘ KHÓA VỊ TRÍ CHỐNG RƠI (ANCHOR):
            -- Đóng băng nhân vật đứng im trên không trung để tránh bị trọng lực kéo tụt xuống đất
            myRoot.Anchored = true
            myRoot.CFrame = safeCFrame
            
            -- Chờ 1.5 giây cho game tải (load) xong bản đồ và địa hình của đảo mới
            task.wait(1.5)
            
            -- Mở khóa đóng băng để nhân vật rơi nhẹ từ trên trời xuống bãi cỏ giữa đảo
            myRoot.Anchored = false
        end
    end
end

-- TẠO CÁC NÚT DỊCH CHUYỂN BÊN TRONG MỤC TELEPORT
-- ⚠️ Hãy nhớ thay thế chữ tiếng Anh trong dấu "" thành tên hòn đảo thật trong game của bạn nhé!
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Pyramid Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Pyramid") end
    end
})

TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Jungle Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Jungle Island") end
    end
})
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Island") end
    end
})
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Purple Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Purple Island") end
    end
})
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến small snow",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Small snow") end
    end
})
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Sam's Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Sam's Island") end
        end
})
-- ====================================================================
-- PHẦN 4: LOGIC MỤC COMPASS SIÊU CẤP TWEEN PHẲNG CHỐNG KẸT NÚT CHẠY
-- ====================================================================
local lastD = Vector3.new(0, 0, 0)
local sTim = 0
local tab3 = MainMenu:CreateTab("Compass 🧭")
-- 🌟 NÚT 1: TELEPORT NHẶT COMPASS RƠI TRÊN ĐẤT (ĐÃ VÁ LỖI CÚ PHÁP)
tab3:CreateToggle({
    Name = "Teleport nhặt Compass rơi trên đất",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoPickCompass = v
        if _G.AutoPickCompass then
            task.spawn(function()
                while _G.AutoPickCompass do
                    task.wait(0.1)
                    local char = lp.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local mr = char.HumanoidRootPart
                        local targetC = nil
                        
                        -- Quét tìm la bàn rơi rải rác trên bản đồ
                        for _, o in pairs(workspace:GetDescendants()) do
                            local oName = string.lower(o.Name)
                            if string.find(oName, "compass") or string.find(oName, "la ban") then
                                if o:IsA("Tool") and o:FindFirstChild("Handle") then
                                    targetC = o.Handle break
                                elseif o:IsA("BasePart") and not o:IsAncestorOf(char) then
                                    targetC = o break
                                end
                            end
                        end
                        
                        if targetC then
                            mr.Anchored = true
                            mr.CFrame = targetC.CFrame * CFrame.new(0, 2, 0)
                            task.wait(0.2)
                            mr.Anchored = false
                        end
                    end
                end
            end)
        end
    end
})

-- 🌟 NÚT 2: BAY TỰ ĐỘNG THEO TỌA ĐỘ ĐÍCH CỦA LA BÀN CHỐNG KHÓA CHÂN CHUẨN XÁC
tab3:CreateToggle({
    Name = "Bay theo hướng la bàn chỉ",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoFlyToCompassDirection = v
        if _G.AutoFlyToCompassDirection then
            lastD = Vector3.new(0, 0, 0)
            sTim = 0
            task.spawn(function()
                while _G.AutoFlyToCompassDirection do
                    task.wait(0.01)
                    local char = lp.Character
                    local mr = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if mr and char:FindFirstChildOfClass("Humanoid") then
                        -- Tự lôi la bàn ra cầm trên tay
                        local bpc = lp.Backpack:FindFirstChild("Compass") or lp.Backpack:FindFirstChild("compass")
                        if bpc then bpc.Parent = char end
                        
                        local hc = char:FindFirstChild("Compass") or char:FindFirstChild("compass")
                        if hc then
                            pcall(function() hc:Activate() end)
                            
                            -- Bẻ khóa thuộc tính đóng băng chân của game
                            mr.Anchored = false
                            for _, p in pairs(char:GetChildren()) do
                                if p:IsA("BasePart") then p.Anchored = false end
                            end
                            
                            local targetPos = nil
                            
                            -- Dò tìm tia định vị (Beam) nối từ la bàn ra đảo ẩn
                            for _, child in pairs(workspace:GetDescendants()) do
                                if child:IsA("Beam") and (child.Attachment0 and child.Attachment0:IsAncestorOf(char) or child.Attachment1 and child.Attachment1:IsAncestorOf(char)) then
                                    local targetAttachment = child.Attachment1 or child.Attachment0
                                    if targetAttachment and targetAttachment.Parent then
                                        targetPos = targetAttachment.Parent.Position break
                                    end
                                end
                            end
                            
                            -- Dò tìm điểm đánh dấu Waypoint ẩn
                            if not targetPos then
                                for _, obj in pairs(workspace:GetChildren()) do
                                    local lowerObj = string.lower(obj.Name)
                                    if string.find(lowerObj, "waypoint") or string.find(lowerObj, "destination") or string.find(lowerObj, "target") then
                                        if obj:IsA("BasePart") then targetPos = obj.Position break
                                        elseif obj:IsA("Vector3Value") then targetPos = obj.Value break end
                                    end
                                end
                            end
                            
                            -- Đọc hướng từ kim xoay la bàn
                            local flyDir = mr.CFrame.LookVector
                            local nd = hc:FindFirstChild("Needle") or hc:FindFirstChild("Pointer") or hc:FindFirstChild("Arrow") or hc:FindFirstChild("Handle")
                            if nd then flyDir = nd.CFrame.LookVector end
                            local flatDirection = Vector3.new(flyDir.X, 0, flyDir.Z).Unit
                            
                            mr.Anchored = true -- Khóa trọng lực để bay lơ lửng an toàn
                            
                            if targetPos then
                                local distanceVector = Vector3.new(targetPos.X - mr.Position.X, 0, targetPos.Z - mr.Position.Z)
                                if distanceVector.Magnitude > 15 then
                                    local dirToIsland = distanceVector.Unit
                                    local nextPos = mr.Position + (dirToIsland * 15)
                                    mr.CFrame = CFrame.new(Vector3.new(nextPos.X, 80, nextPos.Z), Vector3.new(nextPos.X + dirToIsland.X, 80, nextPos.Z + dirToIsland.Z))
                                else
                                    mr.Anchored = false
                                    for i = 1, 30 do
                                        task.wait(0.05)
                                        pcall(function() vU:CaptureController() vU:ClickButton1(Vector2.new(9999, 9999)) end)
                                    end
                                    _G.AutoFlyToCompassDirection = false
                                end
                            else
                                local angleChange = math.acos(math.clamp(lastD:Dot(flatDirection), -1, 1))
                                if angleChange > math.rad(90) and lastD.Magnitude > 0 then
                                    sTim = sTim + 1
                                    if sTim > 10 then
                                        mr.Anchored = false
                                        for i = 1, 30 do task.wait(0.05) pcall(function() vU:CaptureController() vU:ClickButton1(Vector2.new(9999, 9999)) end) end
                                        sTim = 0 mr.CFrame = CFrame.new(mr.Position.X, 80, mr.Position.Z)
                                    end
                                else
                                    sTim = 0
                                    local nextPos = mr.Position + (flatDirection * 12)
                                    mr.CFrame = CFrame.new(Vector3.new(nextPos.X, 80, nextPos.Z), Vector3.new(nextPos.X + flatDirection.X, 80, nextPos.Z + flatDirection.Z))
                                end
                                lastD = flatDirection
                            end
                        else
                            mr.Anchored = false
                        end
                    end
                end
                if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then lp.Character.HumanoidRootPart.Anchored = false end
            end)
        else
            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then lp.Character.HumanoidRootPart.Anchored = false end
        end
    end
})

