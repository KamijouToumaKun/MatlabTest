function [ newIm ] = bilinear(Im,T)
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
    for newI = 1:newH   % ��ͼ�����������ɨ��
        iijj = T\[newI-1+minH;newJ-1+minW;1]; % �Ȼ�ԭ��minH��maxH�ĳ߶ȣ������T������������任
        ii = iijj(1); jj = iijj(2);
        i = floor(ii); j = floor(jj); % ����ȡ��
        u = ii - i; v = jj - j;
        if i>=1 && i<=h-1 && j>=1 && j<=w-1
            % ��ֵ��ʽ
            newIm(newI,newJ,:) = (1-u)*(1-v)*Im(i,j,:) +(1-u)*v*Im(i,j+1,:)...
                + u*(1-v)*Im(i+1,j,:) +u*v*Im(i+1,j+1,:);
        end
    end
end
newIm = uint8(newIm); % ����Ҫ����һ��
end