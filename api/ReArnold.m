function img = ReArnold(arnold_img, Arnold_key)
% ReArnold - 对Arnold变换后的图像进行逆操作
%
%   img = ReArnold(arnold_img, a, b, n)
%
%   输入参数:
%       - arnold_img: 经过Arnold变换的图像矩阵
%       - Arnold_key: Arnold密钥，第三个代表反向操作的次数
%
%   输出参数:
%       - img: 反向操作后的图像矩阵
%

    [h, w, c] = size(arnold_img);
    a = Arnold_key(1);
    b = Arnold_key(2);
    n = Arnold_key(3);
    img = zeros(h, w, c);
    N = h;

    % 迭代n次进行反向Arnold变换
    for i = 1:n
        for y = 1:h
            for x = 1:w           
                % 计算逆操作后的位置
                xx = mod((a * b + 1) * (x - 1) - b * (y - 1), N) + 1;
                yy = mod(-a * (x - 1) + (y - 1), N) + 1;
                
                % 将原始位置的像素放置到逆操作后的位置
                img(yy, xx, :) = arnold_img(y, x, :);
            end
        end
        % 更新arnold_img，以便进行下一次反向操作
        arnold_img = img;
    end
end
