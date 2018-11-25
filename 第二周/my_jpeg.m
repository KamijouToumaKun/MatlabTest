%读入指定途径的图像
%1.RGB转换为YUV,即YCbCr
rgb=imread('lena.png');
yuv=rgb2ycbcr(rgb);
%将得到的YUV转换为可进行数学运算的double类型，原来为uint8 类型
yuv=double(yuv);
%分别提取其中的Y,U,V矩阵
y=yuv(:,:,1);
u=yuv(:,:,2);
v=yuv(:,:,3);
%设定量化步长
eql=8;
%设定块操作时dct矩阵
T = dctmtx(8);
%2.将Y,U,V矩阵分割为8*8 的小块，并对每个小块进行DCT变换
y_dct=blkproc(y,[8,8],'P1*x*P2',T, T');
u_dct=blkproc(u,[8,8],'P1*x*P2',T, T');
v_dct=blkproc(v,[8,8],'P1*x*P2',T, T');
%将得到的DCT系数除以量化步长
y_dct=y_dct/eql;
u_dct=u_dct/eql; %(eql*16);
v_dct=v_dct/eql; %(eql*16);
%将量化后的系数四舍五入
y_dct_c=fix(y_dct);
u_dct_c=fix(u_dct);
v_dct_c=fix(v_dct);
%反量化
y_dct_c=y_dct_c*eql;
u_dct_c=u_dct_c*eql; %*16;
v_dct_c=v_dct_c*eql; %*16;
%进行DCT反变换
y_idct=blkproc(y_dct_c,[8,8],'P1*x*P2', T^-1,(T')^-1);
u_idct=blkproc(u_dct_c,[8,8],'P1*x*P2', T^-1,(T')^-1);
v_idct=blkproc(v_dct_c,[8,8],'P1*x*P2', T^-1,(T')^-1);
%恢复为YUV矩阵，转换为uint8 类型，
yuv(:,:,1)=y_idct;
yuv(:,:,2)=u_idct;
yuv(:,:,3)=v_idct;
yuv=uint8(yuv);
%YUV转换为RGB
rgb1=ycbcr2rgb(yuv);
%显示两幅图像
subplot(211),imshow(rgb),title('原始图像');
subplot(212),imshow(rgb1),title('处理后图像');