% �κ���������
syms x p
a=(x)/p;
N1=1-3*a^2+2*a^3;
N2=(a-2*a^2+a^3)*p;
N3=3*a^2-2*a^3;
N4=(-a^2+a^3)*p;
% �κ���
N=[N1; N2; N3; N4];
b=(diff(N',x,1))*N;
d=N'*(diff(N,x,1));
e=b-d;
pns=int(e,0,p);


syms x p c
a=(x)/p;
N1=1-3*a^2+2*a^3;
N2=(a-2*a^2+a^3)*p;
N3=3*a^2-2*a^3;
N4=(-a^2+a^3)*p;
% �κ���
N=[N1 N2 N3 N4];
F(t)={N1,N2,N3,N4)'.*c;






m=diff(N')*N;
int(m,0,p)



%�϶�������������Դ����д���

g=(diff(N,x,1))'*diff(N,x,1);
q=int(g,0,p);




m=diff(N',x,1)*diff(N,x,1);
k=int(m,0,p)

%??? ???????

f=diff(N',x,1)*N;
g=int(f,0,p);

%??????

h=N'*N;
i=int(h,0,p)





e=diff(N,x,2);
f=e'*e;
g=int(f,0,p);

