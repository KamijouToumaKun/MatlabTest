function [entr] = get_entropy(I)
    [H,W] = size(I);
    hi=zeros(1,256*2+1);
    for i=1:H
        for j=1:W
            hi(I(i,j)+256+1)=hi(I(i,j)+256+1)+1; %��ÿ��ֵ����ͼ���г��ֵĴ���
        end
    end
    hi=sort(hi,'descend');
    hi=hi./H./W; %�����
    entr=0.0;
    for i=1:256*2+1
        if hi(i)>0
            entr=entr-hi(i).*log2(hi(i)); %���ʲ�Ϊ0 �ۼ�����
        else
            break;
        end
    end
end