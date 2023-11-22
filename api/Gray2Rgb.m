function rgb = Gray2Rgb(gray)
% Gray2Rgb - 将灰度图像转换为RGB图像
%
%   rgb = Gray2Rgb(gray)
%
%   输入参数:
%       - gray: 灰度图像的矩阵 (必须为2D矩阵)
%
%   输出参数:
%       - rgb: 转换后的RGB图像矩阵
%

    % 获取灰度图像的大小
    [m, n] = size(gray);
    
    % 将灰度图像分成三个通道，每个通道的大小为原图像的1/3
    tmp = mat2cell(gray, m, [n/3 n/3 n/3]);
    
    % 分别提取三个通道的数据
    [a, b, c] = deal(tmp{:});
    
    % 使用cat函数将三个通道合并成一个RGB图像
    rgb = cat(3, a, b, c);
end
