function [output]=NLmeansfilter(input,t,f,h)
% t���������ڵĴ�С��f�����ƶȴ��ڵĴ�С
%  _________W2
% |         |
% |     ____|____W1
% |    |   _|_B  |
% |____|__|_| |  |
%      |  |___|  |
%      |_________|
    % Size of the image
    [m, n] = size(input);
    
    % ���ͼ��
    output = zeros(m,n);
    
    % pad����ͼ���С��ɱ��1��m+2f��1��n+2f
    input2 = padarray(input,[f f],'symmetric'); %���pad�����÷��㰡��
 
    % ����ʹ�õĺ˴�С
    kernel = make_kernel(f);
    kernel = kernel / sum(sum(kernel)); %��һ����ȡ��άkernel�ĺͿ�����ô����
 
    h=h*h;
     
    for i=1+f:m+f
        for j=1+f:n+f
            W1 = input2(i-f:i+f, j-f:j+f); %ȡ��ǰ���ص���Χ��[2f+1,2f+1]����W1
            
            wmax=0; 
            average=0;
            sweight=0;
            
            % ȡ��ǰ���ص���Χ��[i-t, i+t] �� [1+f, m+f]������B
            rmin = max(i-t,1+f);
            rmax = min(i+t,m+f);
            smin = max(j-t,1+f);
            smax = min(j+t,n+f);
         
            for r=rmin:1:rmax 
                for s=smin:1:smax
                    if(r==i && s==j)
                        continue;
                    end;
                    % ��B�е�ÿһ�����ص�ȡ[2f+1,2f+1]����W2
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
% ����һ��[2f+1,2f+1]��С��filter��w(i, j)
    kernel = zeros(2*f+1,2*f+1);   
    for d=1:f    
        value = 1 / (2*d+1)^2;    
        for i=-d:d
            for j=-d:d
                kernel(f+1-i,f+1-j) = kernel(f+1-i,f+1-j) + value; % ������������ɢ��Խ�м�Խ��Խ���ԽС
            end
        end
    end
    kernel = kernel ./ f;
end