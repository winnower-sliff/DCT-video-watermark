% ReadWatermark - 从文件中读取水印图片
%
%   watermark = ReadWatermark(filepath)
%
%   输入参数:
%       - filepath: 包含水印图片的文件路径
%
%   输出参数:
%       - watermark: 读取的水印图片矩阵，经过转换为实数值
%

function watermark = ReadWatermark(filepath)
    % 从文件中读取水印图片
    watermark = imread(filepath);
    
    % 将图像转换为双精度实数值
    watermark = im2double(watermark);
end
