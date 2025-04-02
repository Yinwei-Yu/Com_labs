from PIL import Image
import numpy as np
import os

def convert_image_to_coe(input_image, output_coe, target_width=400, target_height=300):
    """
    将图像转换为12位RGB COE文件(4位R + 4位G + 4位B)
    - 数据位宽：12位，符合16位限制
    - 存储深度：控制在2^18以内
    """
    # 检查像素总数限制
    total_pixels = target_width * target_height
    if total_pixels > 2**18:
        print(f"警告：图像像素总数 {total_pixels} 超过了2^18 (262144)的限制")
        # 自动调整大小以符合限制
        scale = (2**18 / total_pixels) ** 0.5
        target_width = int(target_width * scale)
        target_height = int(target_height * scale)
        print(f"自动调整分辨率为 {target_width}x{target_height}")
    
    # 打开并调整图像大小
    img = Image.open(input_image)
    img = img.resize((target_width, target_height), Image.Resampling.LANCZOS)
    
    # 确保图像是RGB模式
    if img.mode != 'RGB':
        img = img.convert('RGB')
    
    # 转换为numpy数组
    img_array = np.array(img)
    
    # 创建COE文件
    with open(output_coe, 'w') as f:
        # 写入COE文件头
        f.write("memory_initialization_radix=16;\n")
        f.write("memory_initialization_vector=\n")
        
        # 写入像素数据
        for y in range(target_height):
            for x in range(target_width):
                # 获取RGB值
                r, g, b = img_array[y, x]
                
                # 将8位RGB通道转换为4位（0-255 -> 0-15）
                r4 = r >> 4
                g4 = g >> 4
                b4 = b >> 4
                
                # 组合为12位值: [rrrr][gggg][bbbb]
                rgb_12bit = (r4 << 8) | (g4 << 4) | b4
                
                # 写入16进制表示 (最多3位十六进制数)
                f.write(f"{rgb_12bit:03x}")
                
                # 添加逗号或分号
                if y == target_height-1 and x == target_width-1:
                    f.write(";\n")
                else:
                    f.write(",\n")
        
    print(f"已成功创建COE文件：{output_coe}")
    print(f"图像分辨率：{target_width}x{target_height}")
    print(f"总像素数：{target_width * target_height}")
    print(f"每个像素：12位 (R:4位 G:4位 B:4位)")

if __name__ == "__main__":
    input_image = input("输入图片路径: ")
    output_coe = input("输出COE文件路径 (默认为output.coe): ") or "output.coe"
    width = int(input("目标宽度 (默认为400): ") or "400")
    height = int(input("目标高度 (默认为300): ") or "300")
    
    convert_image_to_coe(input_image, output_coe, width, height)