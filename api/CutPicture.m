function after_picture = CutPicture(pic)
% CutPicture - 随机裁剪一张RGB格式图片
%
%   after_picture = CutPicture(pic)
%   
%   输入参数:
%       - pic: 待裁剪的图片，为一个矩阵（RGB图像）
%
%   输出参数:
%       - after_picture: 裁剪后的图片矩阵
%

    [a, b, ~] = size(pic);
    
    % 随机选择裁剪的起始位置和大小
    hx = randi(a);
    hy = randi(a - hx);
    wx = randi(b);
    wy = randi(b - wx);
    
    % 将选择的位置及其后的像素设置为黑色（0, 0, 0）
    pic(hx:hx+hy, wx:wx+wy, :) = 0;
    
    % 返回裁剪后的图片
    after_picture = pic;
end
