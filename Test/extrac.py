import re
import argparse

# 读取文件并提取机器代码
def extract_machine_code(filename):
    # 正则表达式匹配8位十六进制数 (以0x开头)
    pattern = r'[0-9A-Fa-f]{8}'
    
    # 打开文件进行读取
    with open(filename, 'r') as file:
        # 逐行读取文件
        for line in file:
            # 使用正则表达式查找匹配的机器码
            match = re.search(pattern, line)
            if match:
                # 输出匹配到的机器码
                print(match.group(0)," ",end="")

# 主程序
if __name__ == "__main__":
    # 设置命令行参数解析
    parser = argparse.ArgumentParser(description="Extract machine code from a file.")
    parser.add_argument("filename", help="Path to the input file")
    
    # 解析命令行参数
    args = parser.parse_args()
    
    # 调用提取机器码的函数
    extract_machine_code(args.filename)
