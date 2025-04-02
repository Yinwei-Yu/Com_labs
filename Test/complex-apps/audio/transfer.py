import argparse
import os
import numpy as np
from pydub import AudioSegment
import math

def audio_to_coe(input_file="input.mp3", output_file="output.coe", 
                 max_duration_sec=10, sample_rate=8000, bit_width=8, max_samples=80000):
    """
    将任意音频文件转换为COE文件
    
    参数:
    input_file: 输入音频文件路径
    output_file: 输出COE文件路径
    max_duration_sec: 最大音频长度(秒)
    sample_rate: 目标采样率（默认8kHz）
    bit_width: 位宽度（默认8位）
    max_samples: 最大样本数量，默认80000（8kHz下10秒）
    """
    print(f"正在处理: {input_file}")
    print(f"目标参数: 采样率={sample_rate}Hz, 位宽={bit_width}位, 最大样本数={max_samples}")
    
    # 加载音频文件（支持多种格式）
    audio = AudioSegment.from_file(input_file)
    
    # 转换为单声道
    if audio.channels > 1:
        print(f"将音频从{audio.channels}声道转换为单声道")
        audio = audio.set_channels(1)
    
    # 转换采样率
    if audio.frame_rate != sample_rate:
        print(f"将采样率从{audio.frame_rate}Hz转换为{sample_rate}Hz")
        audio = audio.set_frame_rate(sample_rate)
    
    # 确保正确的位深度
    if audio.sample_width != bit_width // 8:
        print(f"将位深度调整为{bit_width}位")
        audio = audio.set_sample_width(bit_width // 8)
    
    # 计算原始音频时长
    original_duration_sec = len(audio) / 1000
    print(f"原始音频长度: {original_duration_sec:.2f}秒")
    
    # 根据最大时长限制音频
    if max_duration_sec is not None and original_duration_sec > max_duration_sec:
        print(f"截取前{max_duration_sec}秒的音频")
        audio = audio[:max_duration_sec * 1000]  # pydub使用毫秒
    
    # 获取音频样本
    samples = np.array(audio.get_array_of_samples())
    
    # 检查样本数是否超过最大限制
    if len(samples) > max_samples:
        print(f"警告: 样本数({len(samples)})超过最大限制({max_samples})")
        print(f"将样本数截取至{max_samples}（约{max_samples/sample_rate:.2f}秒）")
        samples = samples[:max_samples]
    
    # 计算最终音频时长
    final_duration_sec = len(samples) / sample_rate
    print(f"最终音频长度: {final_duration_sec:.2f}秒")
    print(f"样本数量: {len(samples)}/{max_samples} ({len(samples)/max_samples*100:.1f}%)")
    print(f"音频大小: {len(samples) * (bit_width // 8) / 1024:.2f} KB")
    
    # 创建COE文件
    with open(output_file, 'w') as coe_file:
        coe_file.write("memory_initialization_radix=16;\n")
        coe_file.write("memory_initialization_vector=\n")
        
        # 写入十六进制值 - 根据位宽确定格式
        for i, sample in enumerate(samples):
            # 根据位宽确定掩码和格式
            if bit_width == 8:
                # 8位数据处理 - 使用2位十六进制格式
                # 确保数据在8位有符号范围内(-128到127)
                sample = max(min(sample, 127), -128)
                hex_value = format(sample & 0xFF, '02x')
            else:  # 16位
                # 16位数据处理 - 使用4位十六进制格式
                # 确保数据在16位有符号范围内(-32768到32767)
                sample = max(min(sample, 32767), -32768)
                hex_value = format(sample & 0xFFFF, '04x')
            
            # 写入COE文件
            if i == len(samples) - 1:
                coe_file.write(hex_value + ";")
            else:
                coe_file.write(hex_value + ",\n")
    
    print(f"COE文件已生成: {output_file}")
    print(f"用于Block RAM IP核的参数:")
    print(f"  - 数据宽度: {bit_width}位")
    print(f"  - 深度: {len(samples)}字 (最大深度: {max_samples})")

def main():
    parser = argparse.ArgumentParser(description='将音频转换为COE文件')
    parser.add_argument('input_file', nargs='?', default="input.mp3", help='输入音频文件路径 (默认: input.mp3)')
    parser.add_argument('-o', '--output', default="output.coe", help='输出COE文件路径 (默认: output.coe)')
    parser.add_argument('-d', '--duration', type=float, default=10, help='最大音频时长(秒) (默认: 10秒)')
    parser.add_argument('-s', '--sample_rate', type=int, default=8000, help='采样率(Hz) (默认: 8000)')
    parser.add_argument('-b', '--bit_width', type=int, default=8, choices=[8, 16], help='位宽度(8或16位) (默认: 8)')
    parser.add_argument('-m', '--max_samples', type=int, default=80000, help='最大样本数 (默认: 80000)')
    
    args = parser.parse_args()
    
    audio_to_coe(args.input_file, args.output, args.duration, 
                 args.sample_rate, args.bit_width, args.max_samples)

if __name__ == "__main__":
    main()