function after_picture = RotatePicture(pic, angle)
% RotatePicture - 旋转图片
%
%   after_picture = RotatePicture(pic, angle)
%
%   输入参数:
%       - pic: 待旋转的图片，为一个矩阵
%       - angle: 旋转角度，以度为单位，可以是正数或负数
%
%   输出参数:
%       - after_picture: 旋转后的图片矩阵
%

    % 使用MATLAB内置函数imrotate进行图片旋转
    % 'crop' 表示裁剪旋转后的图像以保持原始图像的大小
    after_picture = imrotate(pic, angle, 'crop');
end
