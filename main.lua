-- SCRIPT QUÈT LÕI DỮ LIỆU LA BÀN OPL
local p = game.Players.LocalPlayer
local char = p.Character
local tool = char:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")

print("=== [BẮT ĐẦU QUÉT LA BÀN OPL] ===")
if tool then
    print("Tên chính xác của vật phẩm:", tool.Name)
    
    -- 1. Quét toàn bộ vật thể con bên trong Tool
    print("--- Vật thể con bên trong Tool ---")
    for _, child in pairs(tool:GetChildren()) do
        print(string.format("  + Tên: %s | Loại (ClassName): %s", child.Name, child.ClassName))
        if child:IsA("ValueBase") then
            print("    -> Giá trị lưu bên trong là:", tostring(child.Value))
        end
    end
    
    -- 2. Quét các thuộc tính ẩn (Attributes)
    print("--- Thuộc tính ẩn (Attributes) ---")
    for attr, val in pairs(tool:GetAttributes()) do
        print(string.format("  + Tên thuộc tính: %s | Giá trị: %s", attr, tostring(val)))
    end
else
    print("LỖI: Bạn cần cầm cây La Bàn trên tay trước khi bật script quét này!")
end
print("=== [KẾT THÚC QUÉT] ===")
