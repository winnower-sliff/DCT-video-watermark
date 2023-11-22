function after_picture = MaxPool(img)
% MaxPool - 最大池化操作
%
%   after_picture = MaxPool(img)
%   采用 $3X3$ 矩阵对原图片进行最大值池化压缩，多余的行列被废弃
%
%   输入参数:
%       - img: 输入图片矩阵
%
%   输出参数:
%       - after_picture: 经过最大池化后的图片矩阵
%

    [N, M, ~] = size(img);
    
    % 预处理图片为3x3块
    img_size = size(img);
    while 1
        if mod(img_size(1), 3) == 0
            break;
        end
        img = img(1:end-1, :, :);
        img_size = size(img);
    end
    while 1
        if mod(img_size(2), 3) == 0
            break;
        end
        img = img(:, 1:end-1, :);
        img_size = size(img);
    end

    % 取出颜色块
    im1 = img(1:3:end, 1:3:end, :);
    im2 = img(2:3:end, 1:3:end, :);
    im3 = img(3:3:end, 1:3:end, :);
    im4 = img(1:3:end, 2:3:end, :);
    im5 = img(2:3:end, 2:3:end, :);
    im6 = img(3:3:end, 2:3:end, :);
    im7 = img(1:3:end, 3:3:end, :);
    im8 = img(2:3:end, 3:3:end, :);
    im9 = img(3:3:end, 3:3:end, :);    

    % 获取每个颜色块的最大值，进行最大池化
    im_max = max(cat(4, im1, im2, im3, im4, im5, im6, im7, im8, im9), [], 4);
    
    % 将池化后的图像大小调整为原始图片大小
    after_picture = imresize(im_max, [N,M], 'bicubic');
end
