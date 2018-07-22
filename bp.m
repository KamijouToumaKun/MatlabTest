input = (-1:0.1:1);
output = [-0.9602, -0.5770, -0.0729, 0.3771, 0.6405, 0.6600, 0.4609, 0.1336, -0.2013, -0.4344, -0.5000, -0.3930, -0.1647, -0.0988, 0.3072, 0.3960, 0.3449, 0.1816, -0.3120, -0.2189, -0.3201];

%�ҳ�ѵ�����ݺ�Ԥ������  
input_train=input;  
output_train=output;  
input_test=input;  
output_test=output;  
  
%ѡ����������������ݹ�һ��  
[inputn,inputps]=mapminmax(input_train);  
[outputn,outputps]=mapminmax(output_train);  
  
%% BP����ѵ��  
% %��ʼ������ṹ  
net=newff(inputn,outputn,5, {'tansig','purelin'});
  
net.trainParam.epochs=100;  
net.trainParam.lr=0.1;  
net.trainParam.goal=0.00004;  
  
%����ѵ��  
net=train(net,inputn,outputn);  
  
%% BP����Ԥ��  
%Ԥ�����ݹ�һ��  
inputn_test=mapminmax('apply',input_test,inputps);  
   
%����Ԥ�����  
an=sim(net,inputn_test);  
   
%�����������һ��  
BPoutput=mapminmax('reverse',an,outputps);  
  
%% �������  
  
figure(1)  
plot(BPoutput,':og')  
hold on  
plot(output_test,'-*');  
legend('Ԥ�����','�������')  
title('BP����Ԥ�����','fontsize',12)  
ylabel('�������','fontsize',12)  
xlabel('����','fontsize',12)  
%Ԥ�����  
error=BPoutput-output_test;  
  
figure(2)  
plot(error,'-*')  
title('BP����Ԥ�����','fontsize',12)  
ylabel('���','fontsize',12)  
xlabel('����','fontsize',12)  
figure(3)  
plot((output_test-BPoutput)./BPoutput,'-*');  
title('������Ԥ�����ٷֱ�')  
errorsum=sum(abs(error))  

net.IW{1,1} %��ʾ������㵽�����������Ȩ��
net.B{1} %��ʾ��1���񾭲���ֵ
net.LW{2,1} %��ʾ�������㵽����������Ȩ��
net.B{2} %��ʾ��2���񾭲���ֵ