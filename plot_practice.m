% plot ѧϰ
[X,Y]=meshgrid(-2:0.5:2,-2:0.5:2);  %����������
Z=2*X.*exp(-X.^2-Y.^2)+1;
num=0;
num=num+1;
subplot(2,3,num);
plot3(X,Y,Z)
axis([-2 2 -2 2 0 2]); %�޶���ʾ�ķ�Χ
xlabel('x��');
ylabel('y��');
zlabel('z��');
title('��ϰ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num=num+1;  
subplot(2,3,num);  
mesh(X,Y,Z);  
axis([-3 3 -3 3 0 2]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(2)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
meshc(X,Y,Z);  
axis([-3 3 -3 3 0 2]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(3)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
surf(X,Y,Z);  
axis([-3 3 -3 3 0 2]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(4)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
meshz(X,Y,Z);  
axis([-3 3 -3 3 0 2]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(5)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
surf(X,Y,Z);  
hold on;  
stem3(X,Y,Z,'r');%������  
axis([-3 3 -3 3 0 2]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(6)');%����  

%%%%%% ���������άͼ������
clc
clear all
X=[0 1 2 3 4 5 6 7 8 9];
Y=[0 1 2 3 4 5 6 7 8 9]; 
for i=1:1:length(X)  
    for j=1:1:length(Y)  
        Z(i,j)=mod(i*j*rand(1),9);  
    end  
end  
num=0;  
num=num+1;  
subplot(2,3,num);  
plot3(X,Y,Z);  
axis([0 9 0 9 0 9]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(1)');%����

num=num+1;  
subplot(2,3,num);  
mesh(X,Y,Z);  
axis([0 9 0 9 0 9]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(2)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
meshc(X,Y,Z);  
axis([0 9 0 9 0 9]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(3)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
surf(X,Y,Z);  
axis([0 9 0 9 0 9]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(4)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
meshz(X,Y,Z);  
axis([0 9 0 9 0 9]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(5)');%����  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
num=num+1;  
subplot(2,3,num);  
surf(X,Y,Z);  
hold on;  
stem3(X,Y,Z,'r');%������  
axis([0 9 0 9 0 9]);%�޶���ʾ�ķ�Χ  
xlabel('x��');%x������  
ylabel('y��');%y������  
zlabel('z��');%z������  
title('http://blog.csdn.net/nuptboyzhb/   figure(6)');%����  
