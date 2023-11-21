function similarity = ImSimilar(pic1, pic2)
    % ImSimilar - 计算两张图片的余弦相似度
    %
    %   similarity = ImSimilar(pic1, pic2)
    %
    %   输入参数:
    %       - pic1: 第一张图片矩阵
    %       - pic2: 第二张图片矩阵，与pic1大小相同
    %
    %   输出参数:
    %       - similarity: 余弦相似度值，值越大表示越相似
    %

    % 获取图片大小
    [a, b] = size(pic1);

    % 灰度计数器，用于统计每个灰度级别的像素个数
    cnt1 = zeros(1, 256);
    cnt2 = zeros(1, 256);

    % 获取直方图分布
    for i = 1:a
        for j = 1:b
            tmp1 = pic1(i,j) + 1; % 加1是因为MATLAB索引从1开始
            tmp2 = pic2(i,j) + 1;
            cnt1(tmp1) = cnt1(tmp1) + 1;
            cnt2(tmp2) = cnt2(tmp2) + 1;
        end
    end

    % 将直方图分为64个区，每个区包含4个灰度级别
    gram1 = zeros(1, 64);
    gram2 = zeros(1, 64);

    for i = 0:63
        gram1(1, i+1) = cnt1(4 * i + 1) + cnt1(4 * i + 2) + cnt1(4 * i + 3) + cnt1(4 * i + 4);
        gram2(1, i+1) = cnt2(4 * i + 1) + cnt2(4 * i + 2) + cnt2(4 * i + 3) + cnt2(4 * i + 4);
    end

    % 计算余弦相似度
    A = sqrt(sum(sum(gram1.^2)));
    B = sqrt(sum(sum(gram2.^2)));
    C = sum(sum(gram1 .* gram2));
    similarity = C / (A * B); % 计算余弦值，越大越相似
end
