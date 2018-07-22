% 读取文件b.xls的第1个工作表中的数据
[x,y]=xlsread('b.xls');
% 提取矩阵x的第1列数据
bac = x(:,1);
% 提取矩阵x的第2列数据
day = x(:,2);

for i=1:3
    dayi = day(bac==i);
    [h,p]=lillietest(dayi);
    result(i,:)=p;
end
result

p = vartestn(day, bac)

[p,table,stats] = anova1(day, bac)