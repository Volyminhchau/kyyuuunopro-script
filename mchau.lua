local MyLibrary = {}
function MyLibrary:CreateWindow(titleText)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KyyuuunoproPremiumUI"
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 480, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -240, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    MainFrame.BorderSizePixel = 0 MainFrame.Active = true MainFrame.Draggable = true MainFrame.Parent = ScreenGui
    local UICorner = Instance.new("UICorner") UICorner.CornerRadius = UDim.new(0, 14) UICorner.Parent = MainFrame
    local Title = Instance.new("TextLabel") Title.Size = UDim2.new(1, 0, 0, 45) Title.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
    Title.Text = "   " .. (titleText or "Menu Premium") Title.TextColor3 = Color3.fromRGB(255, 255, 255) Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left Title.Font = Enum.Font.SourceSansBold Title.Parent = MainFrame
    local TitleCorner = Instance.new("UICorner") TitleCorner.CornerRadius = UDim.new(0, 14) TitleCorner.Parent = Title
    local CloseMinButton = Instance.new("TextButton") CloseMinButton.Size = UDim2.new(0, 30, 0, 30) CloseMinButton.Position = UDim2.new(1, -38, 0, 7)
    CloseMinButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55) CloseMinButton.Text = "-" CloseMinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseMinButton.TextSize = 20 CloseMinButton.Font = Enum.Font.SourceSansBold CloseMinButton.Parent = MainFrame
    local MinCorner = Instance.new("UICorner") MinCorner.CornerRadius = UDim.new(0, 6) MinCorner.Parent = CloseMinButton
    local OpenButton = Instance.new("TextButton") OpenButton.Size = UDim2.new(0, 50, 0, 50) OpenButton.Position = UDim2.new(0, 20, 1, -70)
    OpenButton.BackgroundColor3 = Color3.fromRGB(45, 120, 255) OpenButton.Text = "OPEN" OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    OpenButton.TextSize = 12 OpenButton.Font = Enum.Font.SourceSansBold OpenButton.Visible = false OpenButton.Parent = ScreenGui
    local OpenCorner = Instance.new("UICorner") OpenCorner.CornerRadius = UDim.new(0, 25) OpenCorner.Parent = OpenButton
    CloseMinButton.MouseButton1Click:Connect(function() MainFrame.Visible = false OpenButton.Visible = true end)
    OpenButton.MouseButton1Click:Connect(function() MainFrame.Visible = true OpenButton.Visible = false end)
    local Sidebar = Instance.new("Frame") Sidebar.Size = UDim2.new(0, 130, 1, -45) Sidebar.Position = UDim2.new(0, 0, 0, 45)
    Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 32) Sidebar.BorderSizePixel = 0 Sidebar.Parent = MainFrame
    local SidebarLayout = Instance.new("UIListLayout") SidebarLayout.Padding = UDim.new(0, 5) SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center SidebarLayout.Parent = Sidebar
    local SidebarPadding = Instance.new("UIPadding") SidebarPadding.PaddingTop = UDim.new(0, 10) SidebarPadding.Parent = Sidebar
    local ContentContainer = Instance.new("Frame") ContentContainer.Size = UDim2.new(1, -140, 1, -55) ContentContainer.Position = UDim2.new(0, 135, 0, 50) ContentContainer.BackgroundTransparency = 1 ContentContainer.Parent = MainFrame
    local TabCount = 0 local Tabs = {} local LibraryMethods = {}
    function LibraryMethods:CreateTab(tabName)
        TabCount = TabCount + 1
        local TabContent = Instance.new("ScrollingFrame") TabContent.Size = UDim2.new(1, 0, 1, 0) TabContent.BackgroundTransparency = 1 TabContent.CanvasSize = UDim2.new(0, 0, 0, 0) TabContent.ScrollBarThickness = 4 TabContent.Visible = (TabCount == 1) TabContent.Parent = ContentContainer
        local ContentLayout = Instance.new("UIListLayout") ContentLayout.Padding = UDim.new(0, 8) ContentLayout.Parent = TabContent
        local TabButton = Instance.new("TextButton") TabButton.Size = UDim2.new(0, 115, 0, 38) TabButton.BackgroundColor3 = (TabCount == 1) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(35, 35, 45) TabButton.Text = tabName TabButton.TextColor3 = Color3.fromRGB(255, 255, 255) TabButton.TextSize = 14 TabButton.Font = Enum.Font.SourceSansBold TabButton.Parent = Sidebar
        local ButtonCorner = Instance.new("UICorner") ButtonCorner.CornerRadius = UDim.new(0, 8) ButtonCorner.Parent = TabButton
        table.insert(Tabs, {Button = TabButton, Content = TabContent})
        TabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do t.Content.Visible = (t.Button == TabButton) t.Button.BackgroundColor3 = (t.Button == TabButton) and Color3.fromRGB(45, 120, 255) or Color3.fromRGB(35, 35, 45) end
        end)
        local TabMethods = {}
        function TabMethods:CreateToggle(config)
            local toggleName = config.Name or "Toggle" local callback = config.Callback or function() end local isToggled = config.CurrentValue or false
            local ToggleFrame = Instance.new("Frame") ToggleFrame.Size = UDim2.new(1, 0, 0, 45) ToggleFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 40) ToggleFrame.BorderSizePixel = 0 ToggleFrame.Parent = TabContent
            local FrameCorner = Instance.new("UICorner") FrameCorner.CornerRadius = UDim.new(0, 8) FrameCorner.Parent = ToggleFrame
            local ToggleText = Instance.new("TextLabel") ToggleText.Size = UDim2.new(1, -70, 1, 0) ToggleText.Position = UDim2.new(0, 12, 0, 0) ToggleText.BackgroundTransparency = 1 ToggleText.Text = toggleName ToggleText.TextColor3 = Color3.fromRGB(230, 230, 230) ToggleText.TextSize = 14 ToggleText.TextXAlignment = Enum.TextXAlignment.Left ToggleText.Font = Enum.Font.SourceSansBold ToggleText.Parent = ToggleFrame
            local ToggleButton = Instance.new("TextButton") ToggleButton.Size = UDim2.new(0, 50, 0, 26) ToggleButton.Position = UDim2.new(1, -62, 0.5, -13) ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(65, 65, 75) ToggleButton.Text = isToggled and "ON" or "OFF" ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255) ToggleButton.TextSize = 12 ToggleButton.Font = Enum.Font.SourceSansBold ToggleButton.Parent = ToggleFrame
            local ToggleCorner = Instance.new("UICorner") ToggleCorner.CornerRadius = UDim.new(0, 6) ToggleCorner.Parent = ToggleButton
            ToggleButton.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                if isToggled then ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113) ToggleButton.Text = "ON" else ToggleButton.BackgroundColor3 = Color3.fromRGB(65, 65, 75) ToggleButton.Text = "OFF" end
                callback(isToggled)
            end)
        end
        return TabMethods
    end
    return LibraryMethods
end
local PlayersService = game:GetService("Players") local localPlayer = PlayersService.LocalPlayer local VirtualUser = game:GetService("VirtualUser")
task.spawn(function() while true do task.wait(1) local character = localPlayer.Character if not character or (character:FindFirstChild("Humanoid") and character.Humanoid.Health <= 0) then local playerGui = localPlayer:FindFirstChild("PlayerGui") if playerGui then for _, gui in pairs(playerGui:GetDescendants()) do if gui:IsA("TextButton") or gui:IsA("ImageButton") then local buttonText = string.lower(gui.Name) if gui:IsA("TextButton") then buttonText = buttonText .. string.lower(gui.Text) end if string.find(buttonText, "spawn") or string.find(buttonText, "respawn") or string.find(buttonText, "play") or string.find(buttonText, "sinh") or string.find(buttonText, "chơi") then if gui.Visible and gui.AbsoluteSize.X > 0 then pcall(function() gui:Activate() for _, connection in pairs(getconnections(gui.MouseButton1Click)) do connection:Fire() end for _, connection in pairs(getconnections(gui.MouseButton1Down)) do connection:Fire() end end) end end end end end end end end)



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
    Name = "Auto Farm Mobs (Máu < 1000)",
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
                                    if enemyHumanoid and enemyHumanoid.Health > 0 and enemyHumanoid.MaxHealth < 1000 then
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
-- PHẦN MỚI: TẠO MỤC TELEPORT ĐỘC LẬP ĐỂ DỊCH CHUYỂN CÁC ĐẢO THEO Ý BẠN
-- ====================================================================
-- Khởi tạo nút "Teleport 🌀" ở thanh bên trái nằm ngay dưới nút Farm
local TeleportTab = MainMenu:CreateTab("Teleport 🌀")

-- Hàm phụ trách dò tìm hòn đảo và đưa người chơi bay tới nơi an toàn
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
        
        -- Tiến hành dịch chuyển nhân vật lên trên bề mặt đảo 10 studs
        if foundIsland then
            if foundIsland:IsA("Model") and foundIsland.PrimaryPart then
                myRoot.CFrame = foundIsland.PrimaryPart.CFrame * CFrame.new(0, 10, 0)
            elseif foundIsland:IsA("Model") and foundIsland:FindFirstChildOfClass("BasePart") then
                myRoot.CFrame = foundIsland:FindFirstChildOfClass("BasePart").CFrame * CFrame.new(0, 10, 0)
            else
                myRoot.CFrame = foundIsland.CFrame * CFrame.new(0, 10, 0)
            end
        end
    end
end

-- TẠO CÁC NÚT DỊCH CHUYỂN BÊN TRONG MỤC TELEPORT
-- ⚠️ Hãy nhớ thay thế chữ tiếng Anh trong dấu "" thành tên hòn đảo thật trong game của bạn nhé!
TeleportTab:CreateToggle({
    Name = "Dịch chuyển đến Piramid Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Piramid Island") end
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
    Name = "Dịch chuyển đến Big Snow Island",
    CurrentValue = false,
    Callback = function(Value)
        if Value then teleportToIsland("Big Snow Island") end
    end
})



