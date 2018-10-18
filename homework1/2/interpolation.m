function [ ] = interpolation( Im,hfac,wfac,func )
% 参数是图像文件名、高和宽的缩放系数、图像的插值方法；无返回值，而显示缩放后的图像
%% 1 检查参数、对数据进行预处理
if ~exist('Im','var') || isempty(Im)
    error('输入图像 未定义或为空！');
end
if ~exist('hfac','var') || isempty(hfac) || numel(hfac) ~= 1
     error('缩放倍数h 未定义或为空或是一个数组！');
end
if ~exist('wfac','var') || isempty(wfac) || numel(wfac) ~= 1
     error('缩放倍数w 未定义或为空或是一个数组！');
end
if hfac <= 0 || wfac <= 0
     error('缩放倍数的值应该大于0！');
end
if ~exist('func','var')  || isempty(func)
    error('插值方法 未定义或为空！')
end
[Im,map] = imread(Im); % 参数没有输入图片的格式；返回值可以带上map，即图像的色谱
%% 2,3,4 具体在函数内完成
if strcmpi(func, 'bilinear') == 1 % 比较忽略大小写
    newIm = bilinear(Im, hfac, wfac);
elseif strcmpi(func, 'bicubic') == 1
    newIm = bicubic(Im, hfac, wfac);
else
    error('不能支持的插值方法！')
end
%% 获取图像参数
[h,w,d] = size(Im);
newH = round(h*hfac); % 计算缩放后的图像高和宽
newW = round(w*wfac);
%% 5 以图像的形式显示
figure
imshow(Im,map);
axis on
title(['原图像（大小： ',num2str(h),'*',num2str(w),'*',num2str(d),')']);
figure
imshow(newIm,map);
axis on
title(['缩放后的图像（大小： ',num2str(newH),'*',num2str(newW),'*',num2str(d)',')']);
% interpolation('library.jpg', 2.4, 1.7, 'bicubic');
end