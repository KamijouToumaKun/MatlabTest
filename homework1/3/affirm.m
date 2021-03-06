function [ ] = affirm( Im,T,func )
% 参数是图像文件名、仿射变换矩阵、图像的插值方法；无返回值，而显示缩放后的图像
%% 1 检查参数、对数据进行预处理
if ~exist('Im','var') || isempty(Im)
    error('输入图像 未定义或为空！');
end
if ~exist('T','var') || isempty(T) || ~isequal(size(T), [3,3])
     error('仿射变换矩阵 未定义或为空或大小不对！');
end
if ~isequal(T(3,:), [0,0,1])
     error('仿射变换矩阵 第三行应该为[0 0 1]！');
end
if ~exist('func','var')  || isempty(func)
    error('插值方法 未定义或为空！')
end
[Im,map] = imread(Im); % 参数没有输入图片的格式；返回值可以带上map，即图像的色谱
%% 2,3,4 具体在函数内完成
if strcmpi(func, 'bilinear') == 1 % 比较忽略大小写
    newIm = bilinear(Im, T);
elseif strcmpi(func, 'bicubic') == 1
    newIm = bicubic(Im, T);
else
    error('不能支持的插值方法！')
end
%% 获取图像参数
[h,w,d] = size(Im);
rec = [1 1 h h;1 w 1 w;1 1 1 1]; % 原图的四个顶点
newRec = (T*rec)';
maxHW = round(max(newRec)); % 变换后的图像的上界
minHW = round(min(newRec)); % 变换后的图像的下界
newH = maxHW(1,1) - minHW(1,1) + 1;
newW = maxHW(1,2) - minHW(1,2) + 1;
%% 5 以图像的形式显示
figure
imshow(Im,map);
axis on
title(['原图像（大小： ',num2str(h),'*',num2str(w),'*',num2str(d),')']);
figure
imshow(newIm,map);
axis on
title(['缩放后的图像（大小： ',num2str(newH),'*',num2str(newW),'*',num2str(d)',')']);
imwrite(newIm, 'x.jpg');
end