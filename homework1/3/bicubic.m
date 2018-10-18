function [ newIm ] = bicubic(Im,T)
% ������ͼ����󡢷���任���󣻷���ֵ�Ǳ任���ͼ�����
%% 2 ������ͼ��
[h,w,d] = size(Im);
rec = [1 1 h h;1 w 1 w;1 1 1 1]; % ԭͼ���ĸ�����
newRec = (T*rec)';
maxHW = round(max(newRec)); % �任���ͼ����Ͻ�
minHW = round(min(newRec)); % �任���ͼ����½�
newH = maxHW(1,1) - minHW(1,1) + 1;
newW = maxHW(1,2) - minHW(1,2) + 1;
minH = minHW(1,1); % Ҫ��minH��maxH��1��maxH-minH+1֮�佨������
minW = minHW(1,2);
newIm = -ones(newH,newW,d); % ������ͼ���ȶ�Ĭ��Ϊ-1
%% 3 ����Եʡ�ԣ���Ϊ��֪��T�Ǹ������ľ�����������ȷ������������/��
%% 4 ��ͼ��ģ�newI��newJ��ӳ�䵽ԭͼ��i��j���ĸ������в�ֵ
for newJ = 1:newW
    for newI = 1:newH    % ��ͼ�����������ɨ��
        iijj = T\[newI-1+minH;newJ-1+minW;1]; % �Ȼ�ԭ��minH��maxH�ĳ߶ȣ������T������������任
        ii = iijj(1); jj = iijj(2);
        i = floor(ii); j = floor(jj); % ����ȡ��
        u = ii - i; v = jj - j;
        if i>=2 && i<=h-2 && j>=2 && j<=w-2
            A = [sw(1+u) sw(u) sw(1-u) sw(2-u)]; %u��v�㷴�Ļ���ͼ��������Եĺ�����
            C = [sw(1+v);sw(v);sw(1-v);sw(2-v)];
            for k = 1:d
                B = [Im(i-1,j-1,k) Im(i-1,j,k) Im(i-1,j+1,k) Im(i-1,j+2,k);...
                    Im(i,j-1,k) Im(i,j,k) Im(i,j+1,k) Im(i,j+2,k);...
                    Im(i+1,j-1,k) Im(i+1,j,k) Im(i+1,j+1,k) Im(i+1,j+2,k);...
                    Im(i+2,j-1,k) Im(i+2,j,k) Im(i+2,j+1,k) Im(i+2,j+2,k)];
                B = double(B); % ����ᱨ������ʹ��  * 
                % MTIMES ����ȫ֧�������ࡣ������һ���������Ϊ������
                % ��ֵ��ʽ����ֵ�õ���sw������ͬ���ļ��ж���
                newIm(newI,newJ,k) = A*B*C;
            end
        end
    end
end
newIm = uint8(newIm); % ����Ҫ����һ��
end