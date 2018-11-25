function [newI] = my_median(I, filterH, filterW)
    [H,W,C] = size(I);
    newI = I;
    for i=(filterH+1)/2:H+1-(filterH+1)/2
        for j=(filterW+1)/2:W+1-(filterW+1)/2
            temp = reshape(I(i+1-(filterH+1)/2:i-1+(filterH+1)/2,j+1-(filterW+1)/2:j-1+(filterW+1)/2,:), filterH*filterW, C);
            newI(i,j,:) = median(temp);
        end
    end
end