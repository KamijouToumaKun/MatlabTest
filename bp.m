input = (-1:0.1:1);
output = [-0.9602, -0.5770, -0.0729, 0.3771, 0.6405, 0.6600, 0.4609, 0.1336, -0.2013, -0.4344, -0.5000, -0.3930, -0.1647, -0.0988, 0.3072, 0.3960, 0.3449, 0.1816, -0.3120, -0.2189, -0.3201];

%找出训练数据和预测数据  
input_train=input;  
output_train=output;  
input_test=input;  
output_test=output;  
  
%选连样本输入输出数据归一化  
[inputn,inputps]=mapminmax(input_train);  
[outputn,outputps]=mapminmax(output_train);  
  
%% BP网络训练  
% %初始化网络结构  
net=newff(inputn,outputn,5, {'tansig','purelin'});
  
net.trainParam.epochs=100;  
net.trainParam.lr=0.1;  
net.trainParam.goal=0.00004;  
  
%网络训练  
net=train(net,inputn,outputn);  
  
%% BP网络预测  
%预测数据归一化  
inputn_test=mapminmax('apply',input_test,inputps);  
   
%网络预测输出  
an=sim(net,inputn_test);  
   
%网络输出反归一化  
BPoutput=mapminmax('reverse',an,outputps);  
  
%% 结果分析  
  
figure(1)  
plot(BPoutput,':og')  
hold on  
plot(output_test,'-*');  
legend('预测输出','期望输出')  
title('BP网络预测输出','fontsize',12)  
ylabel('函数输出','fontsize',12)  
xlabel('样本','fontsize',12)  
%预测误差  
error=BPoutput-output_test;  
  
figure(2)  
plot(error,'-*')  
title('BP网络预测误差','fontsize',12)  
ylabel('误差','fontsize',12)  
xlabel('样本','fontsize',12)  
figure(3)  
plot((output_test-BPoutput)./BPoutput,'-*');  
title('神经网络预测误差百分比')  
errorsum=sum(abs(error))  

net.IW{1,1} %表示由输入层到隐含层的连接权重
net.B{1} %表示第1个神经层阈值
net.LW{2,1} %表示由隐含层到输出层的连接权重
net.B{2} %表示第2个神经层阈值