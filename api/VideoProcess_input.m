function frames = VideoProcess_input(alpha, video, watermark, TOTAL)
% VideoProcess_input - 视频处理函数
%
%   frames = VideoProcess_input(alpha, video, watermark, TOTAL)
%
%   输入参数:
%       - alpha: 水印透明度（0-1之间的值）
%       - video: 待处理的视频对象
%       - watermark: 待添加的水印图片
%       - TOTAL: 处理的视频总帧数
%
%   输出参数:
%       - frames: 处理后的视频帧矩阵
%

    fprintf('Total frames: %d\n', video.NumFrames);

    % 写入附带水印的视频
    writerWW = VideoWriter('video_with_WM', 'MPEG-4');
    % 调整帧率  
    writerWW.FrameRate = video.FrameRate;
    open(writerWW);

    counter = 0;
    
    % 处理第一帧，创建frames的第一个元素
    counter = counter + 1;
    fprintf("Frame: %d\n", counter);
    frames =  AddWM(video, watermark, alpha, writerWW);

    % 从第二帧开始逐帧处理视频
    while counter < TOTAL && hasFrame(video)
        counter = counter + 1;
        fprintf("Frame: %d\n", counter);
        frame = AddWM(video, watermark, alpha, writerWW);
        frames = cat(4, frames, frame);
    end

    fprintf("已写入附有水印的视频");
    % figure(1);subplot(1,2,1);
    % imshow(orgin);title('嵌入水印前的图像');
    % figure(1);subplot(1,2,2);
    % imshow(frame);title('嵌入水印后的图像');
    pause(1)
    close(writerWW);
end

function dFrame = AddWM(video, watermark, alpha, writerWW)
    frame = readFrame(video);
    frame = im2double(frame); % 转换为double图
    frame = AddWatermark(frame, watermark, alpha);
    frame = Gray2Rgb(frame); % 转换为 RGB 图像

    % 添加噪声处理
    frame = AddGaussianNoise(frame, 0.05); % 添加高斯噪声
    % frame = AddSaltPepperNoise(frame, 0.05); % 添加椒盐噪声
    % frame = RandomChannelCover(frame); % 随机颜色通道随机区域置零
    % frame = CutPicture(frame); % 图片裁剪
    % frame = RotatePicture(frame,10); % 图片旋转
    % frame = RotatePicture(frame,-10); % 图片旋转
    % frame = MaxPool(frame);% 最大池图片压缩

    dFrame=frame;
    % 原始
    frame = im2uint8(frame); % double 图像转换为 uint8
    % 优化(了吗？
    % frame(:,:,:)=(frame(:,:,:)+0.1032)/1.224*255;
    % frame=uint8(frame);
    
    writeVideo(writerWW, frame);
end