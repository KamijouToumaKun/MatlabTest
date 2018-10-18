function [ ] = affirm( Im,T,func )
% ������ͼ���ļ���������任����ͼ��Ĳ�ֵ�������޷���ֵ������ʾ���ź��ͼ��
%% 1 �������������ݽ���Ԥ����
if ~exist('Im','var') || isempty(Im)
    error('����ͼ�� δ�����Ϊ�գ�');
end
if ~exist('T','var') || isempty(T) || ~isequal(size(T), [3,3])
     error('����任���� δ�����Ϊ�ջ��С���ԣ�');
end
if ~isequal(T(3,:), [0,0,1])
     error('����任���� ������Ӧ��Ϊ[0 0 1]��');
end
if ~exist('func','var')  || isempty(func)
    error('��ֵ���� δ�����Ϊ�գ�')
end
[Im,map] = imread(Im); % ����û������ͼƬ�ĸ�ʽ������ֵ���Դ���map����ͼ���ɫ��
%% 2,3,4 �����ں��������
if strcmpi(func, 'bilinear') == 1 % �ȽϺ��Դ�Сд
    newIm = bilinear(Im, T);
elseif strcmpi(func, 'bicubic') == 1
    newIm = bicubic(Im, T);
else
    error('����֧�ֵĲ�ֵ������')
end
%% ��ȡͼ�����
[h,w,d] = size(Im);
rec = [1 1 h h;1 w 1 w;1 1 1 1]; % ԭͼ���ĸ�����
newRec = (T*rec)';
maxHW = round(max(newRec)); % �任���ͼ����Ͻ�
minHW = round(min(newRec)); % �任���ͼ����½�
newH = maxHW(1,1) - minHW(1,1) + 1;
newW = maxHW(1,2) - minHW(1,2) + 1;
%% 5 ��ͼ�����ʽ��ʾ
figure
imshow(Im,map);
axis on
title(['ԭͼ�񣨴�С�� ',num2str(h),'*',num2str(w),'*',num2str(d),')']);
figure
imshow(newIm,map);
axis on
title(['���ź��ͼ�񣨴�С�� ',num2str(newH),'*',num2str(newW),'*',num2str(d)',')']);
imwrite(newIm, 'x.jpg');
end