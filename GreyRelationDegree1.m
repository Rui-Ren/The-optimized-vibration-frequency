
function GreyRelationDegree1(stats)    % stats ��һ��m��n �����۾��� m �����۶���n ������ָ��
% ���òο����У�����ָ�������������ɵ���������ά����stats��ͬ��
% ԭʼ���۾����������
[r,c]=size(stats);            % stats�������������������۶���ĸ���������ָ��ĸ���
samNo=1:r;                    % ��������
% ���ݹ淶����������ָ��������ο�����һ��淶����0-1֮��
stdMatrix=zeros(r,c);         % ����׼���������ռ䣬��һ��Ϊ�ο����еı�׼��ֵ���ڶ��������һ��Ϊԭʼ���۾���ı�׼��ֵ
maxOfCols=max(stats);         % �������������ڵĸ��е����ֵ
minOfCols=min(stats);         % �������������ڵĸ��е���Сֵ

for j=1:c
    for i=1:r
        stdMatrix(i,j)=(stats(i,j)-minOfCols(j))./(maxOfCols(j)-minOfCols(j)); % �����׼��
    end
end

R_0=[1 1 1 0 1 0];

% �������ϵ��
absValue=zeros(r,c);                        % �����Բ�ֵ���з���ռ�
for i=1:r
    absValue(i,:)=abs(stdMatrix(i,:)-R_0);  % ���Բ�ֵ���м���
end
minAbsValueOfCols=min(absValue,[],1);    % absValueÿһ�е���Сֵ
maxAbsValueOfCols=max(absValue,[],1);    % absValueÿһ�е����ֵ
minAbsValue=min(minAbsValueOfCols);      % absValue����Сֵ
maxAbsValue=max(maxAbsValueOfCols);      % absValue�����ֵ
defCoeff=0.5;                            % ���÷ֱ�ϵ��Ϊ0.5
relCoeff=(minAbsValue+defCoeff*maxAbsValue)./(absValue+defCoeff*maxAbsValue);  % ����ϵ������
 
% ���������
% ����A-m
[V,D]=eigs(P);
V=V(:,1);
w=V(:,1)/sum(V(:,1));
R=zeros(r,1);
for i=1:r
        R(i,1)=relCoeff(i,:)*w;  % �����ȼ���
end
 
% Ȩ�ؿ��ӻ�
[sortW,IXW]=sort(w,'descend');   % Ȩ�ؽ�������IXWȷ����Ӧ��ָ������һ��
indexes={};
for i=1:c                        % cΪ�ܹ���ָ�����
    indexes(i)={strcat('ָ��',num2str(i))}; % ָ������Ϊ��ָ��1����ָ�ꡰ2������
end
sortIndex=indexes(IXW);                % �������Ȩ�ض�Ӧ��ָ������
figure;
subplot(1,2,1);
bar(w);
xlim([0 c+1]);   % ����x�᷶Χ
xlabel('ָ������','FontSize',12,'FontWeight','bold');
set(gca,'xtick',1:c);
set(gca,'XTickLabel',indexes,'FontWeight','light');
ylabel('Ȩ��','FontSize',12,'FontWeight','bold');
set(gca,'YGrid','on');
for i=1:c
    text(i-0.35,w(i)+0.005,sprintf('%.3f',w(i)));
end
title('ָ��Ȩ�ؿ��ӻ�');
box off;
 
subplot(1,2,2);
bar(sortW);
xlim([0 c+1]);   % ����x�᷶Χ
xlabel('ָ������','FontSize',12,'FontWeight','bold');
set(gca,'xtick',1:c);
set(gca,'XTickLabel',sortIndex,'FontWeight','light');
ylabel('Ȩ��','FontSize',12,'FontWeight','bold');
set(gca,'YGrid','on');
for i=1:c
    text(i-0.35,sortW(i)+0.005,sprintf('%.3f',sortW(i)));
end
title('ָ��Ȩ�ؿ��ӻ����������У�');
box off;
 
 
% �����ȷ������չʾ
[sortR,IX]=sort(R,'descend');  % �����Ƚ�������IXȷ����Ӧ���������һ��
sortSamNo=samNo(IX);           % �����������ȶ�Ӧ���������
figure;
subplot(2,1,1);
plot(R,'--ro',...
    'LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','b',...
    'MarkerSize',10);
xlim([1 r]);   % ����x�᷶Χ
xlabel('17 1/2 ��ͷ','FontSize',10,'FontWeight','bold');
set(gca,'xtick',1:r);
set(gca,'XTickLabel',samNo,'FontWeight','light');
ylabel('������','FontSize',10,'FontWeight','bold');
title('��ͷ��ɫ�������ۺ����۽��');
grid on;

 
subplot(2,1,2);
plot(sortR,'--ro',...
    'LineWidth',1,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','b',...
    'MarkerSize',10);
xlim([1 r]);   % ����x�᷶Χ
xlabel('17 1/2 ��ͷ','FontSize',10,'FontWeight','bold');
set(gca,'xtick',1:r);
set(gca,'XTickLabel',sortSamNo,'FontWeight','light');
ylabel('������','FontSize',10,'FontWeight','bold');
title('��ͷ��ɫ�������ۺ����۽��');
grid on;
hold off;
 
end


   