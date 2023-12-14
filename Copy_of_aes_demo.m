addpath api\AES\
addpath api\

% Initialization
[s_box, inv_s_box, w, poly_mat, inv_poly_mat] = aes_init;

% Define an arbitrary series of 16 plaintext bytes 
% in hexadecimal (string) representation
% The following two specific plaintexts are used as examples 
% in the AES-Specification (draft)
plaintext_hex = {'00' '11' '22' '33' '44' '55' '66' '77' ...
                 '88' '99' 'aa' 'bb' 'cc' 'dd' 'ee' 'ff'};
%plaintext_hex = {'32' '43' 'f6' 'a8' '88' '5a' '30' '8d' ...
%                 '31' '31' '98' 'a2' 'e0' '37' '07' '34'};

% 文件路径
WATERMARK_PATH = 'seu_logo.jpg';

% 读取水印
watermark = ReadWatermark(WATERMARK_PATH);
watermark=double(im2uint8(watermark));
watermark=reshape(watermark,[],1);

re_watermark=zeros(size(watermark,1),1);

tic;                                % tic;与toc;配合使用能够返回程序运行时间
bar = waitbar(0,'读取数据中...');    % waitbar显示进度条

len_watermark=size(watermark,1);

for i=1:16:len_watermark

    % Convert plaintext from hexadecimal (string) to decimal representation
    plaintext = watermark(i:i+15);
    
    % This is the real McCoy.
    % Convert the plaintext to ciphertext,
    % using the expanded key, the S-box, and the polynomial transformation matrix
    ciphertext = cipher (plaintext, w, s_box, poly_mat, 1);
    
    % Convert the ciphertext back to plaintext
    % using the expanded key, the inverse S-box, 
    % and the inverse polynomial transformation matrix
    re_plaintext = inv_cipher (ciphertext, w, inv_s_box, inv_poly_mat, 1);
    % disp(re_plaintext);
    re_watermark(i:i+15)=re_plaintext(:);

    ctime=toc;

    str=['计算中...',num2str(100*i/len_watermark,2),'%，预计还需要 ',num2str(uint64(ctime/(i+15)*(len_watermark-i-15))),' 秒'];    % 百分比形式显示处理进程,不需要删掉这行代码就行
    waitbar(i/len_watermark,bar,str)                       % 更新进度条bar，配合bar使用
end
ctime=toc;
str=['已完成，耗时 ',num2str(uint64(ctime)),' 秒']
waitbar(1,bar,str);

re_watermark=reshape(re_watermark,300,300,3);
re_watermark=uint8(re_watermark);
re_watermark=im2double(re_watermark);
imshow(re_watermark);
% close(bar)                % 循环结束可以关闭进度条，个人一般留着不关闭
% toc;                      % tic;与toc;配合使用能够返回程序运行时间