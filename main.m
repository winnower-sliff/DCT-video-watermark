%%
% 清空命令行和工作区，关闭所有窗口
clc,clear,close all; 

% api目录
addpath api\
addpath api\AES\

% 文件路径
VIDEO_PATH = 'liar.mp4';
TEST_PATH = 'seu_logo.jpg';
WATERMARK_PATH = 'seu_logo.jpg';

% 读取视频&水印
video_input = VideoReader(VIDEO_PATH);
video_output = VideoReader(VIDEO_PATH);
watermark = ReadWatermark(WATERMARK_PATH);

% 水印加密
Arnold_key=[1,2,3];
subplot(2,2,1);imshow(watermark);title('原始图像');
watermark=Arnold(watermark,Arnold_key);
subplot(2,2,2);imshow(watermark);title('加密后的图像');
watermark=ReArnold(watermark,Arnold_key);
subplot(2,2,3);imshow(watermark);title('解密后的图像');
watermark=Arnold(watermark,Arnold_key);

% 水印嵌入
frames = VideoProcess_input(1, video_input, watermark, 1);

% 水印提取
% 根据本地保存文件提取水印
% VideoProcess_output(0.1,video_output,watermark);
% 从嵌入函数返回直接提取水印
watermark = VideoProcess_output(1,video_output,watermark,frames);

watermark = im2double(watermark); % 转换为实数值
watermark=ReArnold(watermark,Arnold_key);
subplot(2,2,4);imshow(watermark);title('提取解密后的图像');

% Arnold置换
% imshow(Arnold(imread(TEST_PATH),1,1,1));
% pause(0.5);
% imshow(ReArnold(Arnold(imread(TEST_PATH),1,1,1),1,1,1));


% 椒盐噪声
% imshow(AddSaltPepperNoise(imread(TEST_PATH),1));


% 裁剪
% imshow(CutPicture(imread(TEST_PATH)));
% sim=ImSimilar(imread(TEST_PATH), CutPicture(imread(TEST_PATH)));


% 最大池化
% imshow(MaxPool(imread(TEST_PATH)));
% sim=ImSimilar(imread(TEST_PATH), MaxPool(imread(TEST_PATH)));


% 随机颜色通道随机区域置零
% imshow(RandomChannelCover(imread(TEST_PATH),100,100));
% sim=ImSimilar(imread(TEST_PATH), RandomChannelCover(imread(TEST_PATH),100,100));


% 旋转
% imshow(RotatePicture(imread(TEST_PATH),135));
% sim=ImSimilar(imread(TEST_PATH), RotatePicture(imread(TEST_PATH),135));



% 测试
% a = ReadWatermark(TEST_PATH);
% b = ReadWatermark(WATERMARK_PATH);

% subplot(2,2,1)
% imshow(a);
% title('原图像');
% 
% subplot(2,2,2)
% imshow(b);
% title('水印图像');

% ALPHA = 0.01;
% ALPHA = 0.5;
% ALPHA = 10;
% 
% c = AddWatermark(a, b, ALPHA);
% c = Gray2Rgb(c);
% c = AddNoise(c, 0.05);
% subplot(2,2,3);
% imshow(c);
% title('嵌入水印并添加噪声后图像');
% 
% [MW, NW] = size(b); % 获取水印图像大小
% d = ExtractWatermark(c, a, ALPHA, MW, NW);
% d = Gray2Rgb(d);
% subplot(2,2,4);
% imshow(d);
% title('提取出的水印图像');