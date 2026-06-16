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
                            
                            -- Quét tìm mục tiêu hợp lệ
                            for _, obj in pairs(workspace:GetDescendants()) do
                                -- Kiểm tra Blacklist theo cả Object và Tên của NPC đó
                                if not fakeMonsterBlacklist[obj] and not fakeMonsterBlacklist[obj.Name] then
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
                            
                            -- Xử lý logic tấn công và phát hiện bất tử
                            if targetNPC and targetPart then
                                local enemyHumanoid = targetNPC:FindFirstChildOfClass("Humanoid")
                                
                                if currentTarget == targetNPC then
                                    -- Nếu máu của mục tiêu giữ nguyên hoặc tăng lên (đánh không mất máu)
                                    if enemyHumanoid and enemyHumanoid.Health >= previousHealth then
                                        checkTimer = checkTimer + 1
                                        -- Đợi đủ 60 vòng lặp (~1.2 giây) để chắc chắn vũ khí đã vung trúng nhưng không gây được sát thương
                                        if checkTimer > 60 then 
                                            fakeMonsterBlacklist[targetNPC] = true 
                                            fakeMonsterBlacklist[targetNPC.Name] = true -- Đưa tên NPC vào danh sách đen vĩnh viễn
                                            warn("🔴 Đã chặn NPC bất tử: " .. targetNPC.Name)
                                            currentTarget = nil 
                                            checkTimer = 0 
                                        end
                                    else
                                        -- Nếu quái bị mất máu thành công thì cập nhật lại máu mới và reset bộ đếm lỗi
                                        if enemyHumanoid then previousHealth = enemyHumanoid.Health end 
                                        checkTimer = 0
                                    end
                                else
                                    -- Đổi mục tiêu mới
                                    currentTarget = targetNPC 
                                    if enemyHumanoid then previousHealth = enemyHumanoid.Health end 
                                    checkTimer = 0
                                end
                                
                                -- Thực hiện di chuyển và đánh (Chỉ chạy khi không nằm trong Blacklist)
                                if currentTarget == targetNPC and not fakeMonsterBlacklist[targetNPC] and not fakeMonsterBlacklist[targetNPC.Name] then
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
                            else
                                -- Nếu không tìm thấy quái nào hợp lệ, reset mục tiêu hiện tại
                                currentTarget = nil
                                checkTimer = 0
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
    Name = "Dịch chuyển đến Big Snow",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Snow") end
    end
})
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Sam's Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Sam's Island") end
        end
})



local tab3 = MainMenu:CreateTab("Compass 🧭")
-- ====================================================================
-- PHẦN 3: LOGIC COMPASS AUTO LOOP - CƯỠNG ÉP CẦM TOOL BẰNG HUMANOID (CHẠY 100%)
-- ====================================================================
local lastD = Vector3.new(0, 0, 0)

-- 🌟 NÚT 1: TELEPORT ĐI GOM LA BÀN RƠI TRÊN ĐẤT (Bản chuẩn gốc của bạn)
tab3:CreateToggle({
    Name = "Teleport nhặt Compass rơi trên đất",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoPickCompass = v
        if _G.AutoPickCompass then
            task.spawn(function()
                while _G.AutoPickCompass do
                    task.wait(0.1)
                    local pObj = game:GetService("Players").LocalPlayer
                    local char = pObj and pObj.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local mr = char.HumanoidRootPart
                        local tC = nil
                        for _, o in pairs(workspace:GetDescendants()) do
                            if string.find(string.lower(o.Name), "compass") then
                                if o:IsA("Tool") and o:FindFirstChild("Handle") then
                                    tC = o.Handle break
                                elseif o:IsA("BasePart") and not o:IsAncestorOf(char) then
                                    tC = o break
                                end
                            end
                        end
                        if tC then
                            mr.Anchored = true
                            mr.CFrame = tC.CFrame * CFrame.new(0, 2, 0)
                            task.wait(0.2)
                            mr.Anchored = false
                        end
                    end
                end
            end)
        end
    end
})

-- 🌟 NÚT 2: VÒNG LẶP AUTO ĐEO TOOL HỢP LỆ + BẺ KHÓA DỊCH CHUYỂN TỨC THỜI
tab3:CreateToggle({
    Name = "Bay theo hướng la bàn chỉ",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoFlyToCompassDirection = v
        
        local pObj = game:GetService("Players").LocalPlayer
        local vU = game:GetService("VirtualUser")
        
        if _G.AutoFlyToCompassDirection then
            task.spawn(function()
                while _G.AutoFlyToCompassDirection do
                    task.wait(0.3) -- Tốc độ quét balo liên tục chống lag
                    
                    local char = pObj.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local mr = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if mr and hum and hum.Health > 0 then
                        -- Kiểm tra xem trên tay đã cầm la bàn chưa
                        local hc = char:FindFirstChild("Compass") or char:FindFirstChild("compass")
                        
                        -- 🌟 NẾU CHƯA CẦM: Dùng lệnh hệ thống ép nhân vật tự động cầm la bàn ra tay hợp lệ
                        if not hc then
                            for _, item in pairs(pObj.Backpack:GetChildren()) do
                                local itemName = string.lower(item.Name)
                                if string.find(itemName, "comp") or string.find(itemName, "la ban") then
                                    hum:EquipTool(item) -- Lệnh gọi Tool chuẩn của Roblox chống kẹt
                                    hc = item
                                    task.wait(0.1)
                                    break
                                end
                            end
                        end
                        
                        -- Tiến hành xử lý dịch chuyển khi đã cầm la bàn trên tay
                        if hc then
                            pcall(function() hc:Activate() end) -- Kích hoạt la bàn
                            task.wait(0.15) -- Chờ game nạp vị trí rương ẩn
                            
                            -- Khử hoàn toàn lỗi đóng băng chân của cây la bàn game
                            mr.Anchored = false
                            for _, p in pairs(char:GetChildren()) do
                                if p:IsA("BasePart") then p.Anchored = false end
                            end
                            
                            -- 🌟 MẮT THẦN DÒ TÌM TOẠ ĐỘ THỰC TẾ TRONG LÕI GAME:
                            local treasurePosition = nil
                            
                            -- Hướng A: Dò tìm tia định vị ngầm (Beam)
                            for _, child in pairs(workspace:GetDescendants()) do
                                if child:IsA("Beam") and (child.Attachment0 and child.Attachment0:IsAncestorOf(char) or child.Attachment1 and child.Attachment1:IsAncestorOf(char)) then
                                    local targetAttachment = child.Attachment1 or child.Attachment0
                                    if targetAttachment and targetAttachment.Parent then
                                        treasurePosition = targetAttachment.Parent.Position break
                                    end
                                end
                            end
                            
                            -- Hướng B: Dò tìm điểm đánh dấu Waypoint hoặc dữ liệu vị trí ẩn
                            if not treasurePosition then
                                for _, obj in pairs(workspace:GetChildren()) do
                                    local lowerObj = string.lower(obj.Name)
                                    if string.find(lowerObj, "waypoint") or string.find(lowerObj, "destination") or string.find(lowerObj, "target") or string.find(lowerObj, "chest") then
                                        if obj:IsA("BasePart") then treasurePosition = obj.Position break
                                        elseif obj:IsA("Vector3Value") then treasurePosition = obj.Value break end
                                    end
                                end
                            end
                            
                            -- Hướng C: Đọc hướng kim đỏ la bàn phẳng làm phương án dự phòng
                            if not treasurePosition then
                                local nd = hc:FindFirstChild("Needle") or hc:FindFirstChild("Pointer") or hc:FindFirstChild("Arrow") or hc:FindFirstChild("Handle")
                                local flyDir = nd and nd.CFrame.LookVector or mr.CFrame.LookVector
                                local flatDirection = Vector3.new(flyDir.X, 0, flyDir.Z).Unit
                                
                                local raycastParams = RaycastParams.new()
                                raycastParams.FilterFolder = {char, workspace.Camera}
                                raycastParams.FilterType = Enum.RaycastFilterType.Exclude
                                local raycastResult = workspace:Raycast(mr.Position + Vector3.new(0, 5, 0), flatDirection * 30000, raycastParams)
                                
                                if raycastResult and raycastResult.Position then
                                    treasurePosition = raycastResult.Position
                                else
                                    -- Nhảy chặng phẳng 3500 studs theo hướng kim la bàn chỉ mặt đất
                                    treasurePosition = mr.Position + (flatDirection * 3500)
                                end
                            end
                            
                            -- 🌟 THỰC HIỆN DỊCH CHUYỂN TỨC THỜI CHỚP MẮT (INSTANT TP):
                            if treasurePosition then
                                mr.Anchored = true -- Khóa trọng lực tạm thời tránh lọt map
                                
                                local targetCFrame = CFrame.new(Vector3.new(treasurePosition.X, treasurePosition.Y + 2.5, treasurePosition.Z), Vector3.new(treasurePosition.X, treasurePosition.Y + 2.5, treasurePosition.Z) + mr.CFrame.LookVector)
                                mr.CFrame = targetCFrame
                                task.wait(0.3) -- Chờ nạp xong địa hình đảo mượt mà
                                mr.Anchored = false
                                
                                -- Đập chuột ảo liên hoàn đào rương báu x30 lần
                                for i = 1, 30 do
                                    task.wait(0.04)
                                    pcall(function() vU:CaptureController() vU:ClickButton1(Vector2.new(9999, 9999)) end)
                                end
                                task.wait(0.5) -- Chờ hốt quà xong xuôi để vòng lặp tiếp tục quét la bàn mới
                            end
                        end
                    end
                end
            end)
        end
    end
})
-- ====================================================================
-- PHẦN 4: HỆ THỐNG AUTO FISHING V3 - GIẬT CẦN RA MINIGAME + GIẢI Ô TRẮNG
-- ====================================================================
local _G = _G or {}
_G.AutoFishing = false

local tab4 = MainMenu:CreateTab("Fishing 🎣")

tab4:CreateToggle({
    Name = "Tự động Câu Cá (Auto Fishing V3)",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoFishing = v
        
        if _G.AutoFishing then
            local pObj = game:GetService("Players").LocalPlayer
            local vU = game:GetService("VirtualUser")
            local VirtualInputManager = game:GetService("VirtualInputManager")
            local GuiService = game:GetService("GuiService")
            
            task.spawn(function()
                while _G.AutoFishing do
                    task.wait(0.03) -- Tốc độ phản xạ siêu tốc để bắt trọn minigame
                    
                    local char = pObj.Character
                    local mr = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    
                    if mr and hum and hum.Health > 0 then
                        local pGui = pObj:FindFirstChild("PlayerGui")
                        local isMinigameActive = false
                        local whiteTargetGui = nil
                        
                        -- 🌟 BƯỚC 1: KIỂM TRA XEM MINIGAME ĐÃ XUẤT HIỆN CHƯA (SAU KHI KÉO CÂU)
                        if pGui then
                            for _, gui in pairs(pGui:GetDescendants()) do
                                if gui:IsA("TextLabel") and (string.find(string.lower(gui.Text), "pull") or string.find(string.lower(gui.Text), "medium") or string.find(string.lower(gui.Text), "easy")) then
                                    if gui.IsVisible or (gui.AbsoluteSize.X > 0 and gui.AbsoluteWindowPosition.X > 0) then
                                        isMinigameActive = true
                                    end
                                end
                                
                                -- Dò tìm chính xác ô con cá có khung/nền màu trắng trong minigame
                                if isMinigameActive and (gui:IsA("ImageLabel") or gui:IsA("Frame") or gui:IsA("ImageButton")) and gui.Visible and gui.AbsoluteSize.X > 0 then
                                    local gName = string.lower(gui.Name)
                                    if string.find(gName, "fish") or string.find(gName, "slot") or string.find(gName, "button") or string.find(gName, "highlight") then
                                        -- Lọc màu nền trắng tinh
                                        if gui.BackgroundColor3.R > 0.9 and gui.BackgroundColor3.G > 0.9 and gui.BackgroundColor3.B > 0.9 then
                                            whiteTargetGui = gui break
                                        end
                                        -- Lọc viền UIStroke màu trắng bao quanh
                                        local stroke = gui:FindFirstChildOfClass("UIStroke")
                                        if stroke and stroke.Color.R > 0.9 and stroke.Color.G > 0.9 then
                                            whiteTargetGui = gui break
                                        end
                                    end
                                end
                            end
                        end
                        
                        -- 🌟 BƯỚC 2: NẾU MINIGAME ĐANG HIỆN -> PHẢI TỰ ĐỘNG NHẤP Ô MÀU TRẮNG
                        if isMinigameActive and whiteTargetGui then
                            pcall(function()
                                local posX = whiteTargetGui.AbsolutePosition.X + (whiteTargetGui.AbsoluteSize.X / 2)
                                local posY = whiteTargetGui.AbsolutePosition.Y + (whiteTargetGui.AbsoluteSize.Y / 2) + GuiService:GetGuiInset().Y
                                
                                VirtualInputManager:SendMouseButtonEvent(posX, posY, 0, true, game, 1)
                                task.wait(0.02)
                                VirtualInputManager:SendMouseButtonEvent(posX, posY, 0, false, game, 1)
                                
                                if whiteTargetGui:IsA("ImageButton") or whiteTargetGui:IsA("TextButton") then
                                    whiteTargetGui:Activate()
                                end
                            end)
                            task.wait(0.05)
                        
                        -- 🌟 BƯỚC 3: NẾU CHƯA CÓ MINIGAME -> LOGIC QUĂNG DÂY VÀ CANH GIẬT CẦN KHI CÓ ĐỐM XANH
                        else
                            -- Tự động cầm cần câu ra tay
                            local holdingRod = char:FindFirstChildOfClass("Tool")
                            if not holdingRod or (not string.find(string.lower(holdingRod.Name), "rod") and not string.find(string.lower(holdingRod.Name), "fish")) then
                                for _, item in pairs(pObj.Backpack:GetChildren()) do
                                    local itemName = string.lower(item.Name)
                                    if string.find(itemName, "rod") or string.find(itemName, "fish") then
                                        hum:EquipTool(item)
                                        holdingRod = item
                                        task.wait(0.2)
                                        break
                                    end
                                end
                            end
                            
                            if holdingRod then
                                -- Dò tìm thực thể phao câu của bạn ở Workspace gần nhân vật
                                local myBobber = nil
                                for _, b in pairs(workspace:GetChildren()) do
                                    if b:IsA("BasePart") and (string.find(string.lower(b.Name), "bobber") or string.find(string.lower(b.Name), "phao") or string.find(string.lower(b.Name), "hook")) then
                                        if (mr.Position - b.Position).Magnitude < 50 then
                                            myBobber = b break
                                        end
                                    end
                                end
                                
                                -- Trường hợp A: ĐÃ QUĂNG DÂY (Có phao dưới nước) -> Quét đốm xanh để GIẬT CẦN
                                if myBobber then
                                    local fishBiting = false
                                    -- Chỉ quét hiệu ứng hạt bùng lên ngay vị trí chiếc phao để tránh trùng lặp kỹ năng bên ngoài
                                    for _, obj in pairs(workspace:GetDescendants()) do
                                        if (obj:IsA("ParticleEmitter") or obj:IsA("Sparkles")) and (obj:IsDescendantOf(myBobber) or (obj.Parent:IsA("BasePart") and (obj.Parent.Position - myBobber.Position).Magnitude < 6)) then
                                            -- Kiểm tra màu xanh lá đặc trưng cắn câu
                                            if obj:IsA("ParticleEmitter") and (obj.Color.Keypoints[1].Value.G > 0.7 and obj.Color.Keypoints[1].Value.R < 0.4) then
                                                fishBiting = true break
                                            elseif obj:IsA("Sparkles") and (obj.SparkleColor.G > 0.7 and obj.SparkleColor.R < 0.4) then
                                                fishBiting = true break
                                            end
                                        end
                                    end
                                    
                                    -- Nếu đúng là có đốm xanh ở phao -> Click chuột giật cần mở minigame!
                                    if fishBiting then
                                        pcall(function()
                                            vU:CaptureController()
                                            vU:ClickButton1(Vector2.new(9999, 9999))
                                        end)
                                        task.wait(1.5) -- Đợi một chút để trò chơi chuyển đổi trạng thái giao diện UI
                                    end
                                    
                                -- Trường hợp B: CHƯA QUĂNG DÂY (Không thấy phao) -> Click chuột để QUĂNG CẦN COU
                                else
                                    pcall(function()
                                        vU:CaptureController()
                                        vU:ClickButton1(Vector2.new(9999, 9999))
                                    end)
                                    task.wait(1.5) -- Chờ hiệu ứng quăng cần kết thúc và phao xuất hiện ổn định
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})






