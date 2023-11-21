function after_picture = AddGaussianNoise(picture, std)
% AddGaussianNoise - 向输入图片添加高斯噪声
%
%   after_picture = AddGaussianNoise(picture, std)
%
%   输入参数:
%       - picture: 待添加噪声的图片矩阵
%       - std: 噪声的标准差，表示噪声的强度
%
%   输出参数:
%       - after_picture: 添加了高斯噪声后的图片矩阵
%

    % 使用imnoise函数向图片添加高斯噪声
    % 'gaussian'表示添加高斯噪声，std是噪声的标准差
    after_picture = imnoise(picture, 'gaussian', std);
    
end
