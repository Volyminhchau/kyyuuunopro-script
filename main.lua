local MyLibrary = {}

function MyLibrary:CreateWindow(titleText)
    -- 1. Tạo màn hình chứa giao diện (Gắn vào CoreGui để ẩn khỏi người chơi thường)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "KyyuuunoproPrivateUI"
    pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
    if not ScreenGui.Parent then ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end

    -- 2. Tạo Khung Menu Chính (Main Frame)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 350, 0, 220)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -110)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Nền tối hiện đại
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true -- Có thể giữ chuột để kéo menu di chuyển khắp màn hình
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 12)
    UICorner.Parent = MainFrame

    -- 3. Tạo Tiêu đề Menu (Title Bar)
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.Text = titleText or "Menu Của Tôi"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.SourceSansBold
    Title.Parent = MainFrame
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = Title

    -- Khung chứa danh sách các nút bấm
    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -20, 1, -65)
    Container.Position = UDim2.new(0, 10, 0, 55)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    Container.ScrollBarThickness = 4
    Container.Parent = MainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 8)
    UIListLayout.Parent = Container

    -- 4. Hàm xử lý tạo nút Bật/Tắt (Toggle)
    local Elements = {}
    
    function Elements:CreateToggle(config)
        local toggleName = config.Name or "Toggle"
        local callback = config.Callback or function() end
        local isToggled = config.CurrentValue or false

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(1, 0, 0, 45)
        ToggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(46, 204, 113) or Color3.fromRGB(60, 60, 60)
        ToggleButton.Text = toggleName .. " : " .. (isToggled and "BẬT" or "TẮT")
        ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleButton.TextSize = 15
        ToggleButton.Font = Enum.Font.SourceSansBold
        ToggleButton.Parent = Container

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 8)
        ButtonCorner.Parent = ToggleButton

        -- Kích hoạt hành động khi click chuột vào nút toggle
        ToggleButton.MouseButton1Click:Connect(function()
            isToggled = not isToggled
            if isToggled then
                ToggleButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113) -- Màu xanh lá khi bật
                ToggleButton.Text = toggleName .. " : BẬT"
            else
                ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- Màu xám khi tắt
                ToggleButton.Text = toggleName .. " : TẮT"
            end
            callback(isToggled)
        end)
    end

    return Elements
end

return MyLibrary
