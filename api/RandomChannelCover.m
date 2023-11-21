function after_picture = RandomChannelCover(picture, RH, RW)
% RandomChannelCover - 随机选取图片中随机大小的区域，并将其1至2个颜色通道置为零
%
%   after_picture = RandomChannelCover(picture, RH, RW)
%
%   输入参数:
%       - picture: 待处理的图片矩阵
%       - RH: 区域高度的偏移值
%       - RW: 区域宽度的偏移值
%
%   输出参数:
%       - after_picture: 处理后的图片矩阵
%

    [N, M, ~] = size(picture);

    % 随机选择起始位置
    x = ceil(N * rand());
    y = ceil(M * rand());

    % 随机选择1至2个颜色通道
    num_channels = randi([1, 3]); % 随机生成1到2之间的整数，表示选择的颜色通道数量
    channels = randperm(3, num_channels); % 随机排列1至3，然后选择前num_channels个作为颜色通道

    % 计算区域的结束位置，使用min函数简化边界处理
    X = min(x + RH, N);
    Y = min(y + RW, M);

    % 将选定区域的随机颜色通道像素值置为零，使用矢量化操作
    after_picture = picture;
    after_picture(x:X, y:Y, channels) = 0;
end
