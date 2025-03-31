from PIL import Image
import numpy as np

def convert_image_to_32bit_coe(input_path, output_path):
    # 打开图片并转换为RGB格式
    img = Image.open(input_path).convert("RGB")
    pixels = np.array(img)
    height, width, _ = pixels.shape

    # 生成COE文件头
    coe_content = [
        "memory_initialization_radix=16;",
        "memory_initialization_vector="
    ]

    # 像素处理缓冲区
    hex_words = []

    # 遍历每个像素行
    for y in range(height):
        # 遍历每对像素（每2个像素打包为一个32位字）
        for x in range(0, width, 2):
            # 第一个像素（x, y）
            r1, g1, b1 = pixels[y, x][:3]
            pixel1 = ((r1 >> 4) << 8) | ((g1 >> 4) << 4) | (b1 >> 4)

            # 第二个像素（x+1, y），若超出宽度则补零
            if x+1 < width:
                r2, g2, b2 = pixels[y, x+1][:3]
                pixel2 = ((r2 >> 4) << 8) | ((g2 >> 4) << 4) | (b2 >> 4)
            else:
                pixel2 = 0

            # 组合为32位字（pixel2在16-27位，pixel1在0-11位）
            word = (pixel2 << 16) | pixel1
            hex_words.append(f"{word:08X}")

    # 格式化输出内容
    if hex_words:
        # 所有条目用逗号分隔
        formatted = [f"{word}," for word in hex_words[:-1]]
        formatted.append(f"{hex_words[-1]};")  # 最后条目用分号
        coe_content += formatted
    else:
        coe_content.append(";")  # 空文件处理

    # 写入文件
    with open(output_path, "w") as f:
        f.write("\n".join(coe_content))

if __name__ == "__main__":
    input_image = "input.jpg"    # 输入图片路径
    output_file = "output.coe"   # 输出文件路径
    convert_image_to_32bit_coe(input_image, output_file)
    print(f"转换完成！生成文件：{output_file}")