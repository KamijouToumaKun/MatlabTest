function [ newIm ] = bilinear(Im,T)
% 参数是图像矩阵、仿射变换矩阵；返回值是变换后的图像矩阵
%% 2 创建新图像
[h,w,d] = size(Im);
rec = [1 1 h h;1 w 1 w;1 1 1 1]; % 原图的四个顶点
newRec = (T*rec)';
maxHW = round(max(newRec)); % 变换后的图像的上界
minHW = round(min(newRec)); % 变换后的图像的下界
newH = maxHW(1,1) - minHW(1,1) + 1;
newW = maxHW(1,2) - minHW(1,2) + 1;
minH = minHW(1,1); % 要在minH～maxH和1～maxH-minH+1之间建立换算
minW = minHW(1,2);
newIm = -ones(newH,newW,d); % 创建新图像，先都默认为-1
%% 3 填充边缘省略，因为不知道T是个怎样的矩阵，所以难以确定该填充多少行/列
%% 4 新图像的（newI，newJ）映射到原图（i，j）的附近进行插值
for newJ = 1:newW
    for newI = 1:newH   % 对图像进行逐行列扫描
        iijj = T\[newI-1+minH;newJ-1+minW;1]; % 先还原到minH～maxH的尺度，再左乘T的逆矩阵进行逆变换
        ii = iijj(1); jj = iijj(2);
        i = floor(ii); j = floor(jj); % 向下取整
        u = ii - i; v = jj - j;
        if i>=1 && i<=h-1 && j>=1 && j<=w-1
            % 插值公式
            newIm(newI,newJ,:) = (1-u)*(1-v)*Im(i,j,:) +(1-u)*v*Im(i,j+1,:)...
                + u*(1-v)*Im(i+1,j,:) +u*v*Im(i+1,j+1,:);
        end
    end
end
newIm = uint8(newIm); % 必须要有这一行
end