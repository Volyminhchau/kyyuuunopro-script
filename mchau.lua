-- ====================================================================
-- PHẦN 1: THƯ VIỆN GIAO DIỆN (BẢN SIÊU RÚT GỌN)
-- ====================================================================
local MyLibrary = {}
function MyLibrary:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "KyyuuunoproPremiumUI_v3" ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end) if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end
    local MainFrame = Instance.new("Frame") MainFrame.Size = UDim2.new(0, 500, 0, 320) MainFrame.Position = UDim2.new(0.5, -250, 0.5, -160) MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20) MainFrame.Active = true MainFrame.Draggable = true MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
    local UIStroke = Instance.new("UIStroke", MainFrame) UIStroke.Thickness = 2 UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local Title = Instance.new("TextLabel", MainFrame) Title.Size = UDim2.new(1, 0, 0, 48) Title.BackgroundColor3 = Color3.fromRGB(24, 24, 30) Title.Text = "     " .. (titleText or "PREMIUM HUB") Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 16 Title.TextXAlignment = Enum.TextXAlignment.Left Title.Font = Enum.Font.GothamBold Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 14)
    local TitleGradient = Instance.new("UIGradient", Title) TitleGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 120, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 45, 255))})
    local CloseMinButton = Instance.new("TextButton", MainFrame) CloseMinButton.Size = UDim2.new(0, 32, 0, 32) CloseMinButton.Position = UDim2.new(1, -42, 0, 8) CloseMinButton.BackgroundColor3 = Color3.fromRGB(35, 35, 45) CloseMinButton.Text = "−" CloseMinButton.TextColor3 = Color3.fromRGB(255, 255, 255) CloseMinButton.TextSize = 18 CloseMinButton.Font = Enum.Font.GothamBold Instance.new("UICorner", CloseMinButton).CornerRadius = UDim.new(0, 8)
    local OpenButton = Instance.new("TextButton", ScreenGui) OpenButton.Size = UDim2.new(0, 55, 0, 55) OpenButton.Position = UDim2.new(0, 25, 1, -80) OpenButton.BackgroundColor3 = Color3.fromRGB(45, 120, 255) OpenButton.Text = "OPEN" OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255) OpenButton.TextSize = 13 OpenButton.Font = Enum.Font.GothamBold OpenButton.Visible = false local OpenStroke = Instance.new("UIStroke", OpenButton) OpenStroke.Thickness = 2 OpenStroke.Color = Color3.fromRGB(255, 255, 255) Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(0, 28)
    CloseMinButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end) OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenButton.Visible = false end)
    local Sidebar = Instance.new("Frame", MainFrame) Sidebar.Size = UDim2.new(0, 140, 1, -48) Sidebar.Position = UDim2.new(0, 0, 0, 48) Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 26) Sidebar.BorderSizePixel = 0 local SidebarLayout = Instance.new("UIListLayout", Sidebar) SidebarLayout.Padding = UDim.new(0, 6) SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center Instance.new("UIPadding", Sidebar).PaddingTop = UDim.new(0, 12)
    local ContentContainer = Instance.new("Frame", MainFrame) ContentContainer.Size = UDim2.new(1, -155, 1, -60) ContentContainer.Position = UDim2.new(0, 148, 0, 54) ContentContainer.BackgroundTransparency = 1
    task.spawn(function() local hue = 0 while task.wait(0.01) do hue = hue + 0.004 if hue > 1 then hue = 0 end local rainbow = Color3.fromHSV(hue, 0.85, 0.85) if UIStroke then UIStroke.Color = rainbow end if OpenStroke then OpenStroke.Color = rainbow end end end)
    local TabCount, Tabs = 0, {}
    function MyLibrary:CreateTab(tabName)
        TabCount = TabCount + 1
        local TabContent = Instance.new("ScrollingFrame", ContentContainer) TabContent.Size = UDim2.new(1, 0, 1, 0) TabContent.BackgroundTransparency = 1 TabContent.ScrollBarThickness = 4 TabContent.Visible = (TabCount == 1) TabContent.AutomaticCanvasSize = Enum.AutomaticSize.Y TabContent.CanvasSize = UDim2.new(0, 0, 0, 0) Instance.new("UIListLayout", TabContent).Padding = UDim.new(0, 10)
        local TabButton = Instance.new("TextButton", Sidebar) TabButton.Size = UDim2.new(0, 124, 0, 40) TabButton.BackgroundColor3 = (TabCount == 1) and Color3.fromRGB(35, 40, 55) or Color3.fromRGB(26, 26, 34) TabButton.Text = tabName TabButton.TextColor3 = Color3.fromRGB(255, 255, 255) TabButton.TextSize = 13 TabButton.Font = Enum.Font.GothamBold Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8) local ButtonStroke = Instance.new("UIStroke", TabButton) ButtonStroke.Thickness = 1 ButtonStroke.Color = (TabCount == 1) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(40, 40, 50)
        table.insert(Tabs, {Button = TabButton, Content = TabContent, Stroke = ButtonStroke})
        TabButton.MouseButton1Click:Connect(function() for _, t in pairs(Tabs) do t.Content.Visible = (t.Button == TabButton) t.Button.BackgroundColor3 = (t.Button == TabButton) and Color3.fromRGB(35, 40, 55) or Color3.fromRGB(26, 26, 34) t.Stroke.Color = (t.Button == TabButton) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(40, 40, 50) end end)
        local TabMethods = {}
        function TabMethods:CreateToggle(config)
            local toggleName, callback, isToggled = config.Name or "Toggle", config.Callback or function() end, config.CurrentValue or false
            local ToggleFrame = Instance.new("Frame", TabContent) ToggleFrame.Size = UDim2.new(1, -5, 0, 48) ToggleFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32) Instance.new("UICorner", ToggleFrame).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", ToggleFrame).Color = Color3.fromRGB(35, 35, 45)
            local ToggleText = Instance.new("TextLabel", ToggleFrame) ToggleText.Size = UDim2.new(1, -80, 1, 0) ToggleText.Position = UDim2.new(0, 14, 0, 0) ToggleText.BackgroundTransparency = 1 ToggleText.Text = toggleName ToggleText.TextColor3 = Color3.fromRGB(240, 240, 245) ToggleText.TextSize = 13 ToggleText.TextXAlignment = Enum.TextXAlignment.Left ToggleText.Font = Enum.Font.GothamBold
            local SliderBg = Instance.new("Frame", ToggleFrame) SliderBg.Size = UDim2.new(0, 52, 0, 26) SliderBg.Position = UDim2.new(1, -66, 0.5, -13) Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(0, 13)
            local Circle = Instance.new("Frame", SliderBg) Circle.Size = UDim2.new(0, 20, 0, 20) Instance.new("UICorner", Circle).CornerRadius = UDim.new(0, 10) Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            local HitButton = Instance.new("TextButton", SliderBg) HitButton.Size = UDim2.new(1, 0, 1, 0) HitButton.BackgroundTransparency = 1 HitButton.Text = ""
            local function updateToggleVisual() SliderBg.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(50, 50, 60) Circle:TweenPosition(isToggled and UDim2.new(1, -23, 0.5, -10) or UDim2.new(0, 3, 0.5, -10), "Out", "Quad", 0.15, true) end
            updateToggleVisual() callback(isToggled)
            HitButton.MouseButton1Click:Connect(function() isToggled = not isToggled updateToggleVisual() callback(isToggled) end)
        end
        function TabMethods:CreateDropdown(config)
            local dropName, options, callback, currentSelected = config.Name or "Dropdown", config.Options or {}, config.Callback or function() end, config.CurrentOption or ""
            local DropFrame = Instance.new("Frame", TabContent) DropFrame.Size = UDim2.new(1, -5, 0, 48) DropFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32) Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", DropFrame).Color = Color3.fromRGB(35, 35, 45)
            local DropText = Instance.new("TextLabel", DropFrame) DropText.Size = UDim2.new(1, -150, 1, 0) DropText.Position = UDim2.new(0, 14, 0, 0) DropText.BackgroundTransparency = 1 DropText.Text = dropName DropText.TextColor3 = Color3.fromRGB(240, 240, 245) DropText.TextSize = 13 DropText.TextXAlignment = Enum.TextXAlignment.Left DropText.Font = Enum.Font.GothamBold
            local SelectBtn = Instance.new("TextButton", DropFrame) SelectBtn.Size = UDim2.new(0, 120, 0, 30) SelectBtn.Position = UDim2.new(1, -134, 0.5, -15) SelectBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 45) SelectBtn.Text = currentSelected .. " ▾" SelectBtn.TextColor3 = Color3.fromRGB(255, 255, 255) SelectBtn.TextSize = 12 SelectBtn.Font = Enum.Font.GothamBold Instance.new("UICorner", SelectBtn).CornerRadius = UDim.new(0, 6)
            local currentIdx = 1 for i, v in ipairs(options) do if v == currentSelected then currentIdx = i break end end
            SelectBtn.MouseButton1Click:Connect(function() currentIdx = currentIdx + 1 if currentIdx > #options then currentIdx = 1 end currentSelected = options[currentIdx] SelectBtn.Text = currentSelected .. " ▾" callback(currentSelected) end)
        end
        return TabMethods
    end
    return MyLibrary
end
-- ====================================================================
-- PHẦN 2: LOGIC HỆ THỐNG AUTO SPAWN NGẦM (BẢN SIÊU GỌN)
-- ====================================================================
local P = game:GetService("Players").LocalPlayer
local VU = game:GetService("VirtualUser")
local Cam = game:GetService("Workspace").CurrentCamera
_G.AutoSpawnEnabled = false

task.spawn(function()
    while true do task.wait(0.5)
        if _G.AutoSpawnEnabled then
            local chr = P.Character local pGui = P:FindFirstChild("PlayerGui") local lGui = pGui and pGui:FindFirstChild("Load")
            if not chr or (chr:FindFirstChild("Humanoid") and chr.Humanoid.Health <= 0) or (lGui and lGui.Enabled) then
                pcall(function()
                    for _, o in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do 
                        if o:IsA("RemoteEvent") and (o.Name:lower():find("spawn") or o.Name:lower():find("respawn")) then o:FireServer() end 
                    end
                end)
                if lGui then pcall(function()
                    for _, g in pairs(lGui:GetDescendants()) do
                        if (g:IsA("TextButton") or g:IsA("ImageButton")) and g.AbsoluteSize.X > 0 and g.AbsolutePosition.X >= 0 then
                            lGui.Enabled = false if Cam.CameraType == Enum.CameraType.Scriptable then Cam.CameraType = Enum.CameraType.Custom end
                            local x, y = g.AbsolutePosition.X + (g.AbsoluteSize.X / 2), g.AbsolutePosition.Y + (g.AbsoluteSize.Y / 2) + 36
                            VU:Button1Down(Vector2.new(x, y)) task.wait(0.02) VU:Button1Up(Vector2.new(x, y)) g:Activate()
                            if getconnections then 
                                for _, c in pairs(getconnections(g.MouseButton1Click)) do c:Fire() end 
                                for _, c in pairs(getconnections(g.Activated)) do c:Fire() end 
                            end
                            task.wait(0.3) break
                        end
                    end
                end) end
            end
        end
    end
end)
-- ====================================================================
-- PHẦN 3: KHỞI TẠO MENU VÀ LIÊN KẾT TOGGLE AUTO SPAWN (EXECUTION)
-- ====================================================================
local Window = MyLibrary:CreateWindow("KYYUUUNOPRO PREMIUM")
local MainTab = Window:CreateTab("Main Scripts")

-- Kết nối nút gạt trực tiếp vào hệ thống Auto Spawn ngầm ở Phần 2
MainTab:CreateToggle({
    Name = "Auto Respawn / Spawn",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoSpawnEnabled = Value
    end
})

-- Tạo một Dropdown mẫu để bạn mở rộng thêm tính năng sau này
MainTab:CreateDropdown({
    Name = "Chọn Chế Chế Độ",
    Options = {"Mặc định", "Hồi sinh nhanh"},
    CurrentOption = "Mặc định",
    Callback = function(Option)
        print("Đã chọn chế độ: " .. Option)
    end
})

-- ====================================================================
-- PHẦN 2: ĐÈN LED RGB & LOGIC TÍNH NĂNG FARM QUÁI (SIÊU RÚT GỌN)
-- ====================================================================
local PL = game:GetService("Players").LocalPlayer
local VU = game:GetService("VirtualUser")
local W = workspace

local MainMenu = MyLibrary:CreateWindow("Kyyuuunopro Private ⚔️")
local FarmTab = MainMenu:CreateTab("Farm ⚔️")

-- Hiệu ứng RGB đổi màu nền tiêu đề mượt mà
task.spawn(function()
    local h = 0
    while task.wait(0.01) do h = h + 0.005 if h > 1 then h = 0 end
    local c = Color3.fromHSV(h, 0.9, 0.9)
    pcall(function() Title.BackgroundColor3 = c if OpenButton then OpenButton.BackgroundColor3 = c end end)
    end
end)

_G.AutoFarm = false
local bl, cur, pHealth, timer = {}, nil, 0, 0
local npcs = {"bandit", "thug", "angry bob", "angry freddy", "thief", "gunslinger"}

local function checkNPC(n)
    local ln = n:lower()
    for _, t in pairs(npcs) do if ln:find(t) then return true end end
    return false
end

FarmTab:CreateToggle({
    Name = "Auto Farm Mobs (Máu < 2000)", CurrentValue = false,
    Callback = function(v)
        _G.AutoFarm = v
        if v then
            bl, cur, timer = {}, nil, 0
            task.spawn(function()
                while _G.AutoFarm do task.wait(0.02)
                    local chr = PL.Character local root = chr and chr:FindFirstChild("HumanoidRootPart") local hum = chr and chr:FindFirstChildOfClass("Humanoid")
                    if root and hum and hum.Health > 0 then
                        local tNPC, tPart = nil, nil
                        for _, o in pairs(W:GetDescendants()) do
                            if not bl[o] and not bl[o.Name] and o:FindFirstChildOfClass("Humanoid") then
                                local eh = o:FindFirstChildOfClass("Humanoid")
                                if eh.Health > 0 and eh.MaxHealth < 2000 and o.Name ~= PL.Name and not game:GetService("Players"):GetPlayerFromCharacter(o) then
                                    if checkNPC(o.Name) or o.Name == "" or o.Name == "NPC" or #o.Name <= 4 then
                                        local pName = o.Parent and o.Parent.Name:lower() or ""
                                        if not pName:find("quest") and not pName:find("giver") and not pName:find("dialog") then
                                            local p = o:FindFirstChild("HumanoidRootPart") or o:FindFirstChild("Torso") or o:FindFirstChild("Head") or o:FindFirstChildOfClass("Part")
                                            if p then tNPC, tPart = o, p break end
                                        end
                                    end
                                end
                            end
                        end
                        if tNPC and tPart then
                            local eh = tNPC:FindFirstChildOfClass("Humanoid")
                            if cur == tNPC then
                                if eh and eh.Health >= pHealth then
                                    timer = timer + 1 if timer > 60 then bl[tNPC], bl[tNPC.Name] = true, true cur, timer = nil, 0 warn("🔴 Đã chặn NPC bất tử: "..tNPC.Name) end
                                else
                                    if eh then pHealth = eh.Health end timer = 0
                                end
                            else
                                cur = tNPC if eh then pHealth = eh.Health end timer = 0
                            end
                            if cur == tNPC and not bl[tNPC] and not bl[tNPC.Name] then
                                root.CFrame = CFrame.new(tPart.Position + (tPart.CFrame.LookVector * -1.2), tPart.Position)
                                local tl = chr:FindFirstChildOfClass("Tool") or PL.Backpack:FindFirstChildOfClass("Tool")
                                if tl and tl.Parent ~= chr then tl.Parent = chr end
                                pcall(function() VU:CaptureController() VU:ClickButton1(Vector2.new(9999, 9999)) end)
                            end
                        else
                            cur, timer = nil, 0
                        end
                    end
                end
            end)
        end
    end
})

-- ====================================================================
-- PHẦN MỚI: TẠO MỤC TELEPORT ĐẢO AN TOÀN (BẢN SIÊU GỌN)
-- ====================================================================
local TeleportTab = MainMenu:CreateTab("Teleport 🌀")

local function tpToIsland(name)
    local chr = localPlayer.Character local root = chr and chr:FindFirstChild("HumanoidRootPart")
    if root then
        local found = nil
        for _, o in pairs(workspace:GetDescendants()) do
            if o.Name:lower():find(name:lower()) and (o:IsA("BasePart") or o:IsA("Model")) then found = o break end
        end
        if found then
            local cf = found:IsA("Model") and found:GetBoundingBox() or found.CFrame
            root.Anchored = true root.CFrame = cf * CFrame.new(0, 140, 0)
            task.wait(1.5) root.Anchored = false
        end
    end
end

-- TẠO CÁC NÚT DỊCH CHUYỂN BÊN TRONG MỤC TELEPORT
local islands = {
    {N = "Dịch chuyển đến Pyramid Island", I = "Pyramid"},
    {N = "Dịch chuyển đến Jungle Island", I = "Jungle Island"},
    {N = "Dịch chuyển đến Island", I = "Rocky Island"},
    {N = "Dịch chuyển đến Purple Island", I = "Purple Island"},
    {N = "Dịch chuyển đến small snow", I = "Small snow"},
    {N = "Dịch chuyển đến Big Snow", I = "Mountains"},
    {N = "Dịch chuyển đến Sam's Island", I = "Sam's Island"}
}

for _, isl in ipairs(islands) do
    TeleportTab:CreateToggle({
        Name = isl.N, CurrentValue = false,
        Callback = function(v) if v then tpToIsland(isl.I) end end
    })
end


local tab3 = MainMenu:CreateTab("Compass 🧭")
-- ====================================================================
-- PHẦN 3: LOGIC COMPASS AUTO LOOP - ĐỒNG BỘ GIAO DIỆN UI KHÔNG LỖI
-- ====================================================================

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
-- 🌟 NÚT 2: [BẢN FIX CHỐNG TRỄ MẠNG] TP CHUỖI 2 ĐẦU KIM - KHÓA TỌA ĐỘ CỨNG VĨNH VIỄN - CHỐNG LẶP TUYỆT ĐỐI
tab3:CreateToggle({
    Name = "Dịch chuyển tức thời theo la bàn",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoFlyToCompassDirection = v
        local pObj = game:GetService("Players").LocalPlayer
        
        if _G.AutoFlyToCompassDirection then
            task.spawn(function()
                -- Bước 1: Thu thập toàn bộ linh kiện Spawner từ MapFolder.Trees
                local allTreeSpawns = {}
                local treesFolder = workspace:FindFirstChild("MapFolder") and workspace.MapFolder:FindFirstChild("Trees")
                if treesFolder then
                    for _, child in pairs(treesFolder:GetChildren()) do
                        local spawner = child:FindFirstChild("Spawner")
                        if spawner then table.insert(allTreeSpawns, spawner) end
                    end
                end
                
                -- Tạo tấm đệm tàng hình lót chân chống rơi nước biển
                local safetyPlatform = Instance.new("Part", workspace)
                safetyPlatform.Size = Vector3.new(6, 1, 6)
                safetyPlatform.Transparency = 1
                safetyPlatform.Anchored = true
                safetyPlatform.CanCollide = true
                
                -- 🔥 DANH SÁCH ĐEN KHÓA THEO TỌA ĐỘ VỊ TRÍ ĐỊA LÝ VĨNH VIỄN TRONG CHU KỲ
                local blacklistedPositions = {}
                
                while _G.AutoFlyToCompassDirection do
                    -- 🔥 TĂNG DELAY ĐỒNG BỘ: Chờ 0.55 giây để đảm bảo Server nạp kịp Danh Sách Đen và kim la bàn kịp đổi hướng
                    task.wait(0.55) 
                    
                    local char = pObj.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local rootPart = char and char:FindFirstChild("HumanoidRootPart")
                    
                    if hum and hum.Health > 0 and rootPart then
                        safetyPlatform.CFrame = rootPart.CFrame * CFrame.new(0, -3.5, 0)
                        
                        -- Kiểm tra vật phẩm la bàn trong balo hoặc trên tay của bạn
                        local hc = pObj.Backpack:FindFirstChild("Compass") or char:FindFirstChild("Compass")
                        
                        -- KIỂM TRA ĐIỀU KIỆN DỪNG: Khi không còn la bàn nào trong người -> Tự tắt và xóa bộ nhớ
                        if not hc then
                            print("🔄 Đã cạn kiệt la bàn hoặc nhận được Box DF! Tiến hành dọn dẹp bộ nhớ.")
                            blacklistedPositions = {} 
                            _G.AutoFlyToCompassDirection = false
                            if tab3.SetToggle then tab3:SetToggle(false) end
                            break
                        end
                        
                        -- Tự động cầm công cụ và kích hoạt chạy ngầm nội bộ
                        if hc.Parent == pObj.Backpack then hum:EquipTool(hc) task.wait(0.15) end
                        if hc.Parent == char then hc:Activate() end
                        
                        -- Định vị linh kiện kim la bàn trong Workspace
                        local needle = nil
                        for _, item in pairs(workspace:GetDescendants()) do
                            if item.Name == "CompassNeedle" and item:IsA("BasePart") then needle = item break end
                        end
                        
                        if needle then
                            -- Lắc nhẹ nhân vật để kích thích Server gửi gói tin đồng bộ hướng mới liên tục
                            rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(2), 0)
                            
                            -- Lấy trục RightVector phẳng của kim làm đường thẳng dẫn hướng
                            local needleDirection = needle.CFrame.RightVector
                            local moveDirection = Vector3.new(needleDirection.X, 0, needleDirection.Z).Unit
                            
                            local bestNextSpawn = nil
                            local maxDistance = 0
                            
                            -- Quét tìm cây Spawner nằm trên trục đường thẳng của kim chỉ
                            for _, spawner in pairs(allTreeSpawns) do
                                if spawner and spawner.Parent then
                                    local spawnPos = spawner:IsA("Model") and spawner:GetPivot().Position or spawner.Position
                                    
                                    -- 🔥 MÃ HÓA TỌA ĐỘ KHỬ RUNG SAI: Chia cho 10 để khóa toàn bộ vùng bán kính 10 block xung quanh cây
                                    local posX = math.floor(spawnPos.X / 10)
                                    local posY = math.floor(spawnPos.Y / 10)
                                    local posZ = math.floor(spawnPos.Z / 10)
                                    local posKey = posX .. "," .. posY .. "," .. posZ
                                    
                                    -- ĐIỀU KIỆN KHÓA CHẶT TUYỆT ĐỐI: Chỉ duyệt các tọa độ địa lý CHƯA từng được đi qua
                                    if not blacklistedPositions[posKey] then
                                        local vectorToSpawn = (spawnPos - rootPart.Position)
                                        local dist = vectorToSpawn.Magnitude
                                        
                                        -- 🔥 TĂNG KHOẢNG CÁCH TỐI THIỂU (dist > 150 block) để triệt tiêu hoàn toàn việc quét trúng đảo cũ do trễ mạng
                                        if dist > 150 and dist < 35000 then
                                            local dirToSpawn = Vector3.new(vectorToSpawn.X, 0, vectorToSpawn.Z).Unit
                                            local alignment = math.abs(moveDirection:Dot(dirToSpawn))
                                            
                                            -- Nếu cây nằm thẳng hàng trên trục kim la bàn chỉ (Góc lệch cực nhỏ > 0.90)
                                            if alignment > 0.90 and dist > maxDistance then
                                                maxDistance = dist
                                                bestNextSpawn = spawner
                                            end
                                        end
                                    end
                                end
                            end
                            
                            -- THỰC HIỆN TELEPORT SIÊU TỐC VÀ KHÓA CHẾT TOẠ ĐỘ VỪA NHẢY
                            if bestNextSpawn then
                                local targetPos = bestNextSpawn:IsA("Model") and bestNextSpawn:GetPivot().Position or bestNextSpawn.Position
                                
                                -- 🔥 ĐƯA TỌA ĐỘ VÀO DANH SÁCH ĐEN KHÓA CHẾT VĨNH VIỄN ĐẾN KHI HẾT COMPASS
                                local targetX = math.floor(targetPos.X / 10)
                                local targetY = math.floor(targetPos.Y / 10)
                                local targetZ = math.floor(targetPos.Z / 10)
                                local targetKey = targetX .. "," .. targetY .. "," .. targetZ
                                blacklistedPositions[targetKey] = true 
                                
                                print("⚡ ĐỒNG BỘ MẠNG THÀNH CÔNG -> Đã khóa vĩnh viễn vị trí: [" .. targetKey .. "]")
                                
                                -- Di dời tấm đệm lót chân và đưa nhân vật dẫm thẳng vào tâm Spawner mục tiêu
                                safetyPlatform.CFrame = CFrame.new(targetPos + Vector3.new(0, -1, 0))
                                rootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 1.2, 0))
                            else
                                -- Nếu tất cả các cây dọc đường ngắm đều đã đi qua, tự xả bảng đen để tránh đơ mạng lơ lửng
                                blacklistedPositions = {}
                                rootPart.CFrame = rootPart.CFrame + Vector3.new(0, 0.05, 0)
                            end
                        end
                    end
                end
                if safetyPlatform then safetyPlatform:Destroy() end
            end)
        end
    end
})


