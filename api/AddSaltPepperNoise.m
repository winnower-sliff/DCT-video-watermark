function after_picture = AddSaltPepperNoise(image, density)
% SaltPepperNoise - 在图片中添加椒盐噪声
%
%   after_picture = SaltPepperNoise(image, density)
%
%   输入参数:
%       - image: 待添加噪声的图片矩阵
%       - density: 噪声密度，即需要修改的像素总数占总像素数的比例
%
%   输出参数:
%       - after_picture: 添加椒盐噪声后的图片矩阵
%

    [M, N, ~] = size(image);
    total = round(M * N * density); % 计算需要修改的像素总数
    
    counter = 0; % 初始化计数器
    
    % 循环，修改指定数量的像素
    while counter < total
        counter = counter + 1;
        
        % 随机选择要修改的像素的坐标
        x = randi(M);
        y = randi(N);
        
        % 随机确定修改的像素值为0或1，模拟椒盐噪声
        image(x, y, :) = rand() > 0.5;
    end
    
    % 返回添加噪声后的图片
    after_picture = image;
end
