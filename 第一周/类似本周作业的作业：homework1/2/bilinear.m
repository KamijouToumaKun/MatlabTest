function [ newIm ] = bilinear( Im,hfac,wfac )
% ������ͼ����󡢸ߺͿ������ϵ��������ֵ�����ź��ͼ�����
%% 2 ������ͼ��
[h,w,d] = size(Im);
newH = round(h*hfac); % �������ź��ͼ��ߺͿ�
newW = round(w*wfac);
newIm = zeros(newH,newW,d); % ������ͼ��
%% 3 ��չͼ���Ե
extendIm = zeros(h+2,w+2,d);
extendIm(2:h+1,2:w+1,:) = Im;
extendIm(1,2:w+1,:)=Im(1,:,:);extendIm(h+2,2:w+1,:)=Im(h,:,:);
extendIm(2:h+1,1,:)=Im(:,1,:);extendIm(2:h+1,w+2,:)=Im(:,w,:);
% ��Եʹ�ø��ƶ�����0���
extendIm(1,1,:) = Im(1,1,:);extendIm(1,w+2,:) = Im(1,w,:);
extendIm(h+2,1,:) = Im(h,1,:);extendIm(h+2,w+2,:) = Im(h,w,:);
%% 4 ��ͼ��ģ�newI��newJ��ӳ�䵽ԭͼ��i��j���ĸ������в�ֵ
for newJ = 1:newW  
    jj = (newJ-1)/wfac;
    j = floor(jj); % ����ȡ��
    v = jj - j; % ȡ��ii��jj��ȡ���󸽽��ĵ���в�ֵ
    j = j + 1;
    for newI = 1:newH   % ��ͼ�����������ɨ��
        ii = (newI-1)/hfac;
        i = floor(ii);
        u = ii - i;
        i = i + 1;
        % ��ֵ��ʽ
        newIm(newI,newJ,:) = (1-u)*(1-v)*extendIm(i,j,:) +(1-u)*v*extendIm(i,j+1,:)...
            + u*(1-v)*extendIm(i+1,j,:) +u*v*extendIm(i+1,j+1,:);
    end
end
newIm = uint8(newIm); % ����Ҫ����һ��
end  