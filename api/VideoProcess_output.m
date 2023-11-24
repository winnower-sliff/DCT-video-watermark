function extractedWatermark = VideoProcess_output(alpha, video, watermark, frames)
% VideoProcess_output - 处理视频并提取水印
%
%   VideoProcess_output(alpha, video, watermark, frames)
%
%   输入参数:
%       - alpha: 控制水印提取的参数
%       - video: 输入的视频，为 VideoReader 对象
%       - watermark: 待提取的水印图像
%       - frames: (可选) 双精度视频的所有帧，用于避免重复读取
%
%   输出参数:
%       - extractedWatermark: 提取出的水印图像
%

    % 检查输入参数数量
    if nargin == 4
        fprintf("接收到 double 类型的视频...\n")
        TOTAL = size(frames, 4);
        fprintf('提取水印\nTotal frames: %d\n', TOTAL);

    else
        fprintf("读取本地水印视频...\n")
        video_with_WM = VideoReader("video_with_WM.mp4");
        TOTAL = video_with_WM.NumFrames;
        fprintf('提取水印\nTotal frames: %d\n', TOTAL);
    end

    % 以视频形式写入提取的水印
    writerEW = VideoWriter('extracted_watermark', 'MPEG-4');
    % 调整帧率
    writerEW.FrameRate = video.FrameRate;
    open(writerEW);

    counter = 0;

    % 逐帧处理视频
    while counter < TOTAL && hasFrame(video)
        counter = counter + 1;
        fprintf("Frame: %d\n", counter);

        % 读取原视频帧
        origin = readFrame(video);
        origin = im2double(origin); % 转换为实数值

        % 读取带有水印的视频帧
        if nargin == 4
            frame_with_WM = frames(:, :, :, counter);
        else
            frame_with_WM = readFrame(video_with_WM);
            % 原始
            frame_with_WM = im2double(frame_with_WM); % 转换为实数值
            % 优化(了吗？
            % frame_with_WM=double(frame_with_WM);
            % frame_with_WM(:,:,:)=frame_with_WM(:,:,:)/255*1.224-0.1032;
        end
        

        % 提取水印
        [MW, NW] = size(watermark); % 获取水印图像大小
        
        frame = ExtractWatermark(frame_with_WM, origin, alpha, MW, NW);
        frame = Gray2Rgb(frame); % 转换为 RGB 图像
        % frame = ReArnold(frame, 3, 5, 2);
        frame = im2uint8(frame); % double 图像转换为 uint8

        % 显示当前帧
        % 载体图片展示
        % h=figure(1);
        % set(h,'name','My Title','Numbertitle','off');
        % subplot(2,2,1);imshow(origin);title('原始视频帧');
        % subplot(2,2,2);imshow(frame_with_WM);title('添加水印后的视频帧');
        % subplot(2,2,3);imshow(watermark);title("原始水印");
        % subplot(2,2,4);imshow(frame);title("提取出来的水印");
        watermark = im2uint8(watermark);
        psnr1=psnr(watermark, frame);
        fprintf("PSNR = %.2f\n",psnr1);
        ssim1=ssim(watermark, frame);
        fprintf("SSIM = %.2f%%\n",ssim1*100);
        fprintf("余弦相似度 = %.4f\n",ImSimilar(watermark, frame));
        % 写入提取的水印帧
        writeVideo(writerEW, frame);
    end
    close(writerEW);
    extractedWatermark = frame;
end
