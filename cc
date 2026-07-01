-- ====================================================================
-- PHẦN 1: THƯ VIỆN GIAO DIỆN (ĐÃ TỐI ƯU Ô NHẬP TEXTBOX)
-- ====================================================================
local MyLibrary = {}
local Players = game:GetService("Players")
local PL = Players.LocalPlayer
local Cam = workspace.CurrentCamera

function MyLibrary:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui") ScreenGui.Name = "KyyuuunoproPremiumUI_v3" ScreenGui.ResetOnSpawn = false
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end) if not ScreenGui.Parent then ScreenGui.Parent = PL:WaitForChild("PlayerGui") end
    
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
    
    task.spawn(function() local hue = 0 while task.wait(0.01) do hue = hue + 0.004 if hue > 1 then hue = 0 end local rainbow = Color3.fromHSV(hue, 0.85, 0.85) if UIStroke then UIStroke.Color = rainbow end if OpenStroke then OpenStroke.Color = rainbow end pcall(function() Title.BackgroundColor3 = rainbow if OpenButton then OpenButton.BackgroundColor3 = rainbow end end) end end)
    
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
        
        function TabMethods:CreateTextBox(config)
            local boxName, placeholder, callback = config.Name or "TextBox", config.Placeholder or "Nhập ở đây...", config.Callback or function() end
            local BoxFrame = Instance.new("Frame", TabContent) BoxFrame.Size = UDim2.new(1, -5, 0, 48) BoxFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 32) Instance.new("UICorner", BoxFrame).CornerRadius = UDim.new(0, 10) Instance.new("UIStroke", BoxFrame).Color = Color3.fromRGB(35, 35, 45)
            local BoxText = Instance.new("TextLabel", BoxFrame) BoxText.Size = UDim2.new(1, -160, 1, 0) BoxText.Position = UDim2.new(0, 14, 0, 0) BoxText.BackgroundTransparency = 1 BoxText.Text = boxName BoxText.TextColor3 = Color3.fromRGB(240, 240, 245) BoxText.TextSize = 13 BoxText.TextXAlignment = Enum.TextXAlignment.Left BoxText.Font = Enum.Font.GothamBold
            local TextBox = Instance.new("TextBox", BoxFrame) TextBox.Size = UDim2.new(0, 130, 0, 30) TextBox.Position = UDim2.new(1, -144, 0.5, -15) TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45) TextBox.Text = "" TextBox.PlaceholderText = placeholder TextBox.TextColor3 = Color3.fromRGB(255, 255, 255) TextBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130) TextBox.TextSize = 12 TextBox.Font = Enum.Font.GothamBold Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6) Instance.new("UIStroke", TextBox).Color = Color3.fromRGB(50, 50, 60)
            TextBox.FocusLost:Connect(function(enterPressed) callback(TextBox.Text) end)
        end
        return TabMethods
    end
    return MyLibrary
end

-- ====================================================================
-- PHẦN 2: KHỞI TẠO MENU CHÍNH VÀ CÁC TAB
-- ====================================================================
local MainMenu = MyLibrary:CreateWindow("Kyyuuunopro Private ⚔️")
local FarmTab = MainMenu:CreateTab("Farm ⚔️")
local TeleportTab = MainMenu:CreateTab("Teleport 🌀")

-- ====================================================================
-- PHẦN 3: LOGIC AUTO TP ĐẾN NPC THEO TÊN (KHÔNG TẤN CÔNG)
-- ====================================================================
_G.TargetNPCName = "Cobalt"
_G.AutoTPToNPC = false

-- Ô nhập tên NPC tự chọn
FarmTab:CreateTextBox({
    Name = "Nhập tên NPC muốn TP",
    Placeholder = "Ví dụ: Cobalt",
    Callback = function(text)
        _G.TargetNPCName = text
        print("🎯 Đã đổi mục tiêu tìm kiếm sang NPC: " .. text)
    end
})

-- Nút gạt kích hoạt vòng lặp bám đuôi NPC ngầm
FarmTab:CreateToggle({
    Name = "Auto TP áp sát sau lưng NPC",
    CurrentValue = false,
    Callback = function(v)
        _G.AutoTPToNPC = v
        if v then
            task.spawn(function()
                while _G.AutoTPToNPC do task.wait(0.01)
                    local chr = PL.Character 
                    local root = chr and chr:FindFirstChild("HumanoidRootPart") 
                    local hum = chr and chr:FindFirstChildOfClass("Humanoid")
                    
                    if root and hum and hum.Health > 0 and _G.TargetNPCName ~= "" then
                        local tPart = nil
                        
                        -- Quét tìm NPC theo chuỗi chữ cái (Không phân biệt hoa thường)
                        for _, o in pairs(workspace:GetDescendants()) do
                            if o:FindFirstChildOfClass("Humanoid") then
                                local eh = o:FindFirstChildOfClass("Humanoid")
                                if eh.Health > 0 and o.Name:lower():find(_G.TargetNPCName:lower()) and o.Name ~= PL.Name and not game:GetService("Players"):GetPlayerFromCharacter(o) then
                                    local p = o:FindFirstChild("HumanoidRootPart") or o:FindFirstChild("Torso") or o:FindFirstChild("Head") or o:FindFirstChildOfClass("Part")
                                    if p then tPart = p break end
                                end
                            end
                        end
                        
                        -- Thực hiện dịch chuyển áp sát lưng mục tiêu
                        if tPart then
                            root.CFrame = CFrame.new(tPart.Position + (tPart.CFrame.LookVector * -1.5), tPart.Position)
                        end
                    end
                end
            end)
        end
    end
})

-- ====================================================================
-- PHẦN 4: TELEPORT ĐẢO AN TOÀN
-- ====================================================================
local function tpToIsland(name)
    local chr = PL.Character local root = chr and chr:FindFirstChild("HumanoidRootPart")
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

local islands = {
    {N = "Blossom Haven", I = "map-9"},
    {N = "Jungle Island", I = "Jungle Island"},
    {N = "Rocky Island", I = "Rocky Island"},
    {N = "Purple Island", I = "Purple Island"},
    {N = "Small Snow Island", I = "Small snow"},
    {N = "Big Snow (Mountains)", I = "Mountains"},
    {N = "Sam's Island", I = "Sam's Island"}
}

for _, isl in ipairs(islands) do
    TeleportTab:CreateToggle({
        Name = "Đến " .. isl.N, CurrentValue = false,
        Callback = function(v) if v then tpToIsland(isl.I) end end
    })
end
