function arnold_img = Arnold(img, a, b, n)
% Arnold - Arnold置换算法
%
%   arnold_img = Arnold(img, a, b, n)
%
%   输入参数:
%       - img: 输入图像矩阵
%       - a: 参数a
%       - b: 参数b
%       - n: 迭代次数
%
%   输出参数:
%       - arnold_img: 经过Arnold置换后的图像矩阵
%

    [h, w, c] = size(img);
    N = h;
    arnold_img = zeros(h, w, c);

    % 执行n次Arnold置换
    for i = 1:n
        for y = 1:h
            for x = 1:w
                % Arnold置换公式
                xx = mod(x - 1 + b * (y - 1), N) + 1;
                yy = mod(a * (x - 1) + (a * b + 1) * (y - 1), N) + 1;
                
                % 将原图像对应位置的像素放置到新位置
                arnold_img(yy, xx, :) = img(y, x, :);
            end
        end
        % 更新img，用于下一次迭代
        img = arnold_img;
    end
end
