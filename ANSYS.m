% ģ̬��������    % ��λ�������⣡��
% No.1 
%�������ݵ�����
fprintf( '����Euler-Bernoulli Beam ������⡢�ڵ����ɶ�Ϊ2\n' );
L=input( 'ϵͳ����(m):  ' );
Nel=input( '΢Ԫ��������' );
E=input( '������ϵĵ���ģ��(10^11pa):   ');
B=input( '������ͷ���⾶(m)��   ');
D=input( '�����׹ܵ��⾶(m)��   ');
d=input( '�����׹ܵ��ھ�(m):    ');
ef=input( '����ˮ�ཬ���ܶȣ�kg/m^3):    ');
ep=input( '�����׹ܵ��ܶ� (kg/m^3)��     ');
                                                                  % mpa.s �� pa.s �ĵ�λ����
I=pi*(D^4-d^4)/64;                                                % ת�����������
A1=pi*(B^2)/4;                                                    % ���ۺ�����
A2=pi*(D^2)/4;                                                    % �׹������
A3=pi*(d^2)/4;                                                    % �׹������
E=E*10^11; 
cm=(B^2+D^2)/(B^2-D^2);
ma=cm*ef*A2;                                                      
mf=ef*A3;
mp=ep*(A2-A3);
m=mf+mp+ma;

%΢Ԫ��ڵ���б��
Nnode=Nel+1;                                                  % �ڵ�����
node=(1:Nnode);                                               % ���ɽڵ�����
x=0:(L/Nel):L;                                                % �Խڵ����������
xx=x';                                                        % �ڵ�x��������
yy=zeros(Nnode,1);                                            % �ڵ��node
                %�ڵ���            �ڵ�x����             �ڵ�y����
gNode=[   transpose(node)              xx                    yy];   %�ڵ���б��

 %No.3΢Ԫ��ͽڵ�Ĺ�ϵ����

              %΢Ԫ����             ��˽ڵ�             �Ҷ˽ڵ�
gElement=[    (1:Nel)',               (1:Nel)',            (2:Nnode)'];  


  %No.4 ��һ�߽���������

	    %�ڵ��       ���ɶȺ�               �߽�ֵ
 gBco=[    1,              1,                 0
	       1,              2,                 0
	       Nnode,          1,                 0
		   Nnode,          2,                 0];
         
   % No.5 ΢Ԫ��ĳ���
   xi=gNode(gElement(1,2),2);
   xj=gNode(gElement(1,3),2);
   yi=gNode(gElement(1,2),3);
   yj=gNode(gElement(1,3),3);
   p=sqrt((xi-xj)^2+(yi-yj)^2);    
   
   % ����΢Ԫ�����������
     me=m/420*...            
	[156*p  22*p^2  54*p     -13*p^2;...
    22*p^2 4*p^3  13*p^2      -3*p^3;...
    54*p  13*p^2   156*p     -22*p^2;...
    -13*p^2  -3*p^3  -22*p^2  4*p^3];

	%�׹ܵ�΢Ԫ�նȾ���
     Kea=E*I/(p^3)*...
	[12     6*p    -12     6*p;...
    6*p   4*p^2   -6*p    2*p^2;...
    -12    -6*p     12    -6*p;...
    6*p    2*p^2  -6*p    4*p^2];

 %΢Ԫ������նȾ���
	   ke=Kea; 
   % No7. ��������͸նȾ��������װ 
       gK=zeros(Nnode*2);
       gM=zeros(Nnode*2);
     %����΢Ԫ�����װ��       
   for ie=1:Nel        % Nel ��ʾ�ж��ٸ�΢Ԫ
     for i=1:2
       for j=1:2
           for p=1:2
               for q=1:2
                   m=(i-1)*2+p;
                   n=(j-1)*2+q;
                   M=(gElement(ie,i)-1)*2+m;      
                   N=(gElement(ie,j)-1)*2+n;
                   gK(M,N)=gK(M,N)+ke(m,n);
                   gM(M,N)=gM(M,N)+me(m,n);
               end
           end
        end
     end
   end      
   
   % No.8 ���õ�һ��߽���������ʩ�ӱ߽����� 
  [bc1_number, ~]=size(gBco);
  w2max = max( diag(gK)./diag(gM) ); 
    
   for ibc=1:1:bc1_number
        n = gBco(ibc, 1 );                                       %������ҵ��ǽڵ�
        d = gBco(ibc, 2 );                                       %����Լ��ʩ�ӵ����ɶ�
        m = (n-1)*2 + d;                                         %����Լ�����ɶ����ܸվ�����ռ�õ����ɶ�
        gK(:,m) = zeros( Nnode*2, 1 );                           %�л���0
        gK(m,:) = zeros( 1, Nnode*2 );                           %�л���0
        gK(m,m) = 1;  
   end
    
   for ibc=1:1:bc1_number
        n = gBco(ibc, 1 );
        d = gBco(ibc, 2 );
        m = (n-1)*2 + d;      
        gM(:,m) = zeros( Nnode*2, 1 );
        gM(m,:) = zeros( 1, Nnode*2 ) ;
        gM(m,m) = gK(m,m)/w2max/1e10 ;         
   end
    
    for i=1:Nnode*2
           for j=i:Nnode*2
               gK(j,i) = gK(i,j);
               gM(j,i) = gM(i,j);                           % ���жԳƻ�����
           end 
    end
                     
   % ��������ֵ��������
    [gEigVector, gEigValue] = eigs(gK, gM, 6, 'SM' );       %��ȡ��������ֵ 
    fre_number=length(diag(gEigValue));  
 
	% ��ӡ����ֵ
    fprintf( '\n\n\n\n ���   ����ֵ(Ƶ��)�б�  \n' ) ;
    fprintf( '----------------------------------------------------------\n') ;
    fprintf( '   ����       ����ֵ       ������Ƶ��(Hz)     ԲƵ��(rad/s)\n') ;
    fprintf( '----------------------------------------------------------\n') ;
    for i=fre_number:-1:1
        fprintf( '%6d   %15.7e   %15.7e   %15.7e\n', fre_number-i+1, ...
            gEigValue(i,i), sqrt(gEigValue(i,i))/2/pi, sqrt(gEigValue(i,i)) ) ;
    end
    fprintf( '----------------------------------------------------------\n') ;

