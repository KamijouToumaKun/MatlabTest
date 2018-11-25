function [ newIm ] = bicubic( Im,hfac,wfac )
% ������ͼ����󡢸ߺͿ������ϵ��������ֵ�����ź��ͼ�����
%% 2 ������ͼ��
[h,w,d] = size(Im);
newH = round(h*hfac); % �������ź��ͼ��ߺͿ�
newW = round(w*wfac);
newIm = zeros(newH,newW,d); % ������ͼ��
%% 3 ��չͼ���Ե
extendIm = zeros(h+3,w+3,d);
extendIm(2:h+1,2:w+1,:) = Im;
extendIm(1,2:w+1,:)=Im(1,:,:);extendIm(h+2,2:w+1,:)=Im(h,:,:);
extendIm(2:h+1,1,:)=Im(:,1,:);extendIm(2:h+1,w+2,:)=Im(:,w,:);
                        extendIm(h+3,2:w+1,:)=Im(h,:,:);
                        extendIm(2:h+1,w+3,:)=Im(:,w,:);
% ��Եʹ�ø��ƶ�����0���
extendIm(1,1,:) = Im(1,1,:);extendIm(1,w+2,:) = Im(1,w,:);
extendIm(h+2,1,:) = Im(h,1,:);extendIm(h+2,w+2,:) = Im(h,w,:);
                     extendIm(1,w+3,:) = Im(1,w,:);
extendIm(h+3,1,:) = Im(h,1,:);extendIm(h+3,w+3,:) = Im(h,w,:);
%% 4 ����ͼ��ģ�newI��newJ��ӳ�䵽ԭͼ��i��j���ĸ������в�ֵ
for newJ = 1:newW
    jj = (newJ-1)/wfac;
    j = floor(jj); % ����ȡ��
    v = jj - j; % ȡ��ii��jj��ȡ���󸽽��ĵ���в�ֵ
    j = max(j + 1, 2);
    C = [sw(1+v);sw(v);sw(1-v);sw(2-v)];
    for newI = 1:newH    % ��ͼ�����������ɨ��
        ii = (newI-1)/hfac;
        i = floor(ii); 
        u = ii - i; 
        i = max(i + 1, 2); 
        A = [sw(1+u) sw(u) sw(1-u) sw(2-u)]; %u��v�㷴�Ļ���ͼ��������Եĺ�����
        for k = 1:d
            B = [extendIm(i-1,j-1,k) extendIm(i-1,j,k) extendIm(i-1,j+1,k) extendIm(i-1,j+2,k);...
                extendIm(i,j-1,k) extendIm(i,j,k) extendIm(i,j+1,k) extendIm(i,j+2,k);...
                extendIm(i+1,j-1,k) extendIm(i+1,j,k) extendIm(i+1,j+1,k) extendIm(i+1,j+2,k);...
                extendIm(i+2,j-1,k) extendIm(i+2,j,k) extendIm(i+2,j+1,k) extendIm(i+2,j+2,k)];
            % ��ֵ��ʽ����ֵ�õ���sw������ͬ���ļ��ж���
            newIm(newI,newJ,k) = A*B*C;
        end
    end
end
newIm = uint8(newIm); % ����Ҫ����һ��
end    