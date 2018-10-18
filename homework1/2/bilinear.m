function [ newIm ] = bilinear( Im,hfac,wfac )
% 参数是图像矩阵、高和宽的缩放系数；返回值是缩放后的图像矩阵
%% 2 创建新图像
[h,w,d] = size(Im);
newH = round(h*hfac); % 计算缩放后的图像高和宽
newW = round(w*wfac);
newIm = zeros(newH,newW,d); % 创建新图像
%% 3 扩展图像边缘
extendIm = zeros(h+2,w+2,d);
extendIm(2:h+1,2:w+1,:) = Im;
extendIm(1,2:w+1,:)=Im(1,:,:);extendIm(h+2,2:w+1,:)=Im(h,:,:);
extendIm(2:h+1,1,:)=Im(:,1,:);extendIm(2:h+1,w+2,:)=Im(:,w,:);
% 边缘使用复制而不是0填充
extendIm(1,1,:) = Im(1,1,:);extendIm(1,w+2,:) = Im(1,w,:);
extendIm(h+2,1,:) = Im(h,1,:);extendIm(h+2,w+2,:) = Im(h,w,:);
%% 4 新图像的（newI，newJ）映射到原图（i，j）的附近进行插值
for newJ = 1:newW  
    jj = (newJ-1)/wfac;
    j = floor(jj); % 向下取整
    v = jj - j; % 取（ii，jj）取整后附近的点进行插值
    j = j + 1;
    for newI = 1:newH   % 对图像进行逐行列扫描
        ii = (newI-1)/hfac;
        i = floor(ii);
        u = ii - i;
        i = i + 1;
        % 插值公式
        newIm(newI,newJ,:) = (1-u)*(1-v)*extendIm(i,j,:) +(1-u)*v*extendIm(i,j+1,:)...
            + u*(1-v)*extendIm(i+1,j,:) +u*v*extendIm(i+1,j+1,:);
    end
end
newIm = uint8(newIm); % 必须要有这一行
end  