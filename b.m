% ��ȡ�ļ�b.xls�ĵ�1���������е�����
[x,y]=xlsread('b.xls');
% ��ȡ����x�ĵ�1������
bac = x(:,1);
% ��ȡ����x�ĵ�2������
day = x(:,2);

for i=1:3
    dayi = day(bac==i);
    [h,p]=lillietest(dayi);
    result(i,:)=p;
end
result

p = vartestn(day, bac)

[p,table,stats] = anova1(day, bac)