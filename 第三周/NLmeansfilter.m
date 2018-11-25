function [output]=NLmeansfilter(input,t,f,h)
% t是搜索窗口的大小，f是相似度窗口的大小
%  _________W2
% |         |
% |     ____|____W1
% |    |   _|_B  |
% |____|__|_| |  |
%      |  |___|  |
%      |_________|
    % Size of the image
    [m, n] = size(input);
    
    % 输出图像
    output = zeros(m,n);
    
    % pad，把图像大小变成变成1～m+2f，1～n+2f
    input2 = padarray(input,[f f],'symmetric'); %这个pad函数好方便啊！
 
    % 计算使用的核大小
    kernel = make_kernel(f);
    kernel = kernel / sum(sum(kernel)); %归一化；取二维kernel的和可以这么做！
 
    h=h*h;
     
    for i=1+f:m+f
        for j=1+f:n+f
            W1 = input2(i-f:i+f, j-f:j+f); %取当前像素点周围的[2f+1,2f+1]邻域W1
            
            wmax=0; 
            average=0;
            sweight=0;
            
            % 取当前像素点周围的[i-t, i+t] 交 [1+f, m+f]的邻域B
            rmin = max(i-t,1+f);
            rmax = min(i+t,m+f);
            smin = max(j-t,1+f);
            smax = min(j+t,n+f);
         
            for r=rmin:1:rmax 
                for s=smin:1:smax
                    if(r==i && s==j)
                        continue;
                    end;
                    % 对B中的每一个像素点取[2f+1,2f+1]邻域W2
                    W2 = input2(r-f:r+f, s-f:s+f);                
                    d = sum(sum(kernel.*(W1-W2).*(W1-W2)));
                    w = exp(-d/h);                 
                    if w>wmax                
                        wmax=w;                   
                    end
                    sweight = sweight + w;
                    average = average + w*input2(r,s);                                  
                end 
            end
             
            average = average + wmax*input2(i,j);
            sweight = sweight + wmax;
            if sweight > 0
                output(i-f,j-f) = average / sweight;
            else
                output(i-f,j-f) = input(i-f,j-f);
            end                
        end
    end
end
 
function [kernel] = make_kernel(f)              
% 生成一个[2f+1,2f+1]大小的filter：w(i, j)
    kernel = zeros(2*f+1,2*f+1);   
    for d=1:f    
        value = 1 / (2*d+1)^2;    
        for i=-d:d
            for j=-d:d
                kernel(f+1-i,f+1-j) = kernel(f+1-i,f+1-j) + value; % 呈菱形向外扩散，越中间越大、越外层越小
            end
        end
    end
    kernel = kernel ./ f;
end