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

    % 将灰度图像按列分成三个部分，分别代表RGB通道
    channels = mat2cell(gray, m, ones(1, n/3)*n/3);

    % 将三个通道合并成一个RGB图像
    rgb = cat(3, channels{:});
end
