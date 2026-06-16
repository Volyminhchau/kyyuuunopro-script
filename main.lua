local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Hàm gửi thông báo trực tiếp lên màn hình của bạn
local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 7
    })
end

notify("Mắt Thần Đã Bật", "Hãy cầm la bàn và Click chuột để tìm tên Biến!")

-- Lắng nghe xem khi dùng la bàn, có vật thể lạ nào sinh ra trên bản đồ không
workspace.DescendantAdded:Connect(function(newObject)
    -- Bỏ qua các vật thể thuộc về người chơi để đỡ rác bảng log
    if newObject:IsAncestorOf(LocalPlayer.Character) then return end
    
    -- Bộ lọc quét các từ khóa liên quan đến mục tiêu, la bàn, trái cây hoặc điểm sáng
    local nameLower = string.lower(newObject.Name)
    if string.find(nameLower, "tree") or string.find(nameLower, "fruit") or string.find(nameLower, "target") or string.find(nameLower, "compass") or string.find(nameLower, "glow") or string.find(nameLower, "chest") or string.find(nameLower, "mark") then
        
        -- Lấy tọa độ thực tế của biến vừa sinh ra
        local position = nil
        if newObject:IsA("BasePart") then
            position = newObject.Position
        elseif newObject:IsA("Model") then
            position = newObject:GetPivot().Position
        elseif newObject:IsA("Attachment") then
            position = newObject.WorldPosition
        end
        
        if position then
            print("=========================================")
            print("🌟 TÌM THẤY BIẾN VỊ TRÍ TRÁI ÁC QUỶ CHÍNH XÁC:")
            print("👉 TÊN BIẾN TRONG GAME:", newObject.Name)
            print("👉 LOẠI BIẾN (ClassName):", newObject.ClassName)
            print("👉 TỌA ĐỘ CẦN TELEPORT:", tostring(position))
            print("👉 ĐƯỜNG DẪN TRONG DEX:", newObject:GetFullName())
            print("=========================================")
            
            notify("Tìm Thấy Tên Biến!", "Tên: " .. newObject.Name .. " (Xem log F9)")
        end
    end
end)
