function [entr] = get_entropy(I)
    [H,W] = size(I);
    hi=zeros(1,256*2+1);
    for i=1:H
        for j=1:W
            hi(I(i,j)+256+1)=hi(I(i,j)+256+1)+1; %求每种值的在图像中出现的次数
        end
    end
    hi=sort(hi,'descend');
    hi=hi./H./W; %求概率
    entr=0.0;
    for i=1:256*2+1
        if hi(i)>0
            entr=entr-hi(i).*log2(hi(i)); %概率不为0 累加求熵
        else
            break;
        end
    end
end