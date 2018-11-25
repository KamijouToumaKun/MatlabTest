function [ ] = interpolation( Im,hfac,wfac,func )
% ������ͼ���ļ������ߺͿ������ϵ����ͼ��Ĳ�ֵ�������޷���ֵ������ʾ���ź��ͼ��
%% 1 �������������ݽ���Ԥ����
if ~exist('Im','var') || isempty(Im)
    error('����ͼ�� δ�����Ϊ�գ�');
end
if ~exist('hfac','var') || isempty(hfac) || numel(hfac) ~= 1
     error('���ű���h δ�����Ϊ�ջ���һ�����飡');
end
if ~exist('wfac','var') || isempty(wfac) || numel(wfac) ~= 1
     error('���ű���w δ�����Ϊ�ջ���һ�����飡');
end
if hfac <= 0 || wfac <= 0
     error('���ű�����ֵӦ�ô���0��');
end
if ~exist('func','var')  || isempty(func)
    error('��ֵ���� δ�����Ϊ�գ�')
end
[Im,map] = imread(Im); % ����û������ͼƬ�ĸ�ʽ������ֵ���Դ���map����ͼ���ɫ��
%% 2,3,4 �����ں��������
if strcmpi(func, 'bilinear') == 1 % �ȽϺ��Դ�Сд
    newIm = bilinear(Im, hfac, wfac);
elseif strcmpi(func, 'bicubic') == 1
    newIm = bicubic(Im, hfac, wfac);
else
    error('����֧�ֵĲ�ֵ������')
end
%% ��ȡͼ�����
[h,w,d] = size(Im);
newH = round(h*hfac); % �������ź��ͼ��ߺͿ�
newW = round(w*wfac);
%% 5 ��ͼ�����ʽ��ʾ
figure
imshow(Im,map);
axis on
title(['ԭͼ�񣨴�С�� ',num2str(h),'*',num2str(w),'*',num2str(d),')']);
figure
imshow(newIm,map);
axis on
title(['���ź��ͼ�񣨴�С�� ',num2str(newH),'*',num2str(newW),'*',num2str(d)',')']);
% interpolation('library.jpg', 2.4, 1.7, 'bicubic');
end