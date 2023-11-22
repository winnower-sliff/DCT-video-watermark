function after_picture = RandomChannelCover(picture)
% RandomChannelCover - 随机选取图片中1个颜色通道置为零
%
%   after_picture = RandomChannelCover(picture, RH, RW)
%
%   输入参数:
%       - picture: 待处理的图片矩阵
%
%   输出参数:
%       - after_picture: 处理后的图片矩阵
%

    % 随机选择1个颜色通道
    channel = randperm(3, 1); % 随机排列1至3，然后选择1个作为颜色通道

    % 将选定区域的随机颜色通道像素值置为零，使用矢量化操作
    after_picture = picture;
    after_picture(1:end,1:end, channel) = 0;
end
