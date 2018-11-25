%����ָ��;����ͼ��
%1.RGBת��ΪYUV,��YCbCr
rgb=imread('lena.png');
yuv=rgb2ycbcr(rgb);
%���õ���YUVת��Ϊ�ɽ�����ѧ�����double���ͣ�ԭ��Ϊuint8 ����
yuv=double(yuv);
%�ֱ���ȡ���е�Y,U,V����
y=yuv(:,:,1);
u=yuv(:,:,2);
v=yuv(:,:,3);
%�趨��������
eql=8;
%�趨�����ʱdct����
T = dctmtx(8);
%2.��Y,U,V����ָ�Ϊ8*8 ��С�飬����ÿ��С�����DCT�任
y_dct=blkproc(y,[8,8],'P1*x*P2',T, T');
u_dct=blkproc(u,[8,8],'P1*x*P2',T, T');
v_dct=blkproc(v,[8,8],'P1*x*P2',T, T');
%���õ���DCTϵ��������������
y_dct=y_dct/eql;
u_dct=u_dct/eql; %(eql*16);
v_dct=v_dct/eql; %(eql*16);
%���������ϵ����������
y_dct_c=fix(y_dct);
u_dct_c=fix(u_dct);
v_dct_c=fix(v_dct);
%������
y_dct_c=y_dct_c*eql;
u_dct_c=u_dct_c*eql; %*16;
v_dct_c=v_dct_c*eql; %*16;
%����DCT���任
y_idct=blkproc(y_dct_c,[8,8],'P1*x*P2', T^-1,(T')^-1);
u_idct=blkproc(u_dct_c,[8,8],'P1*x*P2', T^-1,(T')^-1);
v_idct=blkproc(v_dct_c,[8,8],'P1*x*P2', T^-1,(T')^-1);
%�ָ�ΪYUV����ת��Ϊuint8 ���ͣ�
yuv(:,:,1)=y_idct;
yuv(:,:,2)=u_idct;
yuv(:,:,3)=v_idct;
yuv=uint8(yuv);
%YUVת��ΪRGB
rgb1=ycbcr2rgb(yuv);
%��ʾ����ͼ��
subplot(211),imshow(rgb),title('ԭʼͼ��');
subplot(212),imshow(rgb1),title('�����ͼ��');