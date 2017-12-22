% ˮƽ�����׹ܵļ�������

syms gMaterial gNode L gElement gEigValue gEigvalue

% No.1 
%�������ݵ�����
fprintf( '����Euler-Bernoulli Beam ������⡢�ڵ����ɶ�Ϊ2\n' )
L=input( 'ϵͳ����(m):  ' );
Nel=input( '΢Ԫ��������' );
E=input ( '������ϵĵ���ģ��(10^11pa): '   );
N=input( '������������ѹ����Mpa����   ' );
Q=input('��������(m^3/min)��');
B=input( '������ͷ���⾶(m)��   ');
D=input( '�����׹ܵ��⾶(m)�� ' );
d=input( '�����׹ܵ��ھ�(m):     ' );
ef=input( '����ˮ�ཬ���ܶȣ�kg/m^3):   ' );
ep=input( '�����׹ܵ��ܶ� (kg/m^3)��   ' );
gTimeEnd=input('����ʱ�䳤�ȣ�s����');
gDeltaT=input('����ʱ�䲽����s����');
Force=input('�������ش�С��N��:   ');                       % ǿ����ʱ��Ҫ�������Ƶ��
w=input('���뼤��Ƶ�ʣ�Hz��:   ');
Distance_For=input('�����������õ�λ��(m)��   '); 


Q=Q/60;                                                           % ��λ����
N=10^6 * N;                                                     % ��λѹǿ����
c=10^(-3)*c;                                                      % mpa.s �� pa.s �ĵ�λ����
I=(D^4-d^4)/64;                                               % ת�����������
A1=pi*(B^2)/4;                                                % ���ۺ�����
A2=pi*(D^2)/4;                                                 % �׹������
A3=pi*(d^2)/4;                                                  % �������
Uo=Q/(A1-A2);                                                 % �����ⷵ��
Ui=Q/A3;                                                           % ����������
E=E*10^11;
timestep=gTimeEnd/gDeltaT;
cm=( D^2+d^2)/( D^2-d^2);                            % ����Ӱ��ϵ��
ma=cm*ef*A2;
mf=ef*A3;
mp=ep*(A2-A3);
m=mf+mp+ma;


% No.2 
%΢Ԫ��ڵ���б��
Nnode=Nel+1;                                                  % �ڵ�����
node=(1:Nnode);                                               % ���ɽڵ�����
x=0:(L/Nel):L;                                                  % �Խڵ����������
xx=x';                                                                 % �ڵ�x��������
yy=zeros(Nnode,1);                                           % �ڵ��node
                %�ڵ���      �ڵ�x����       �ڵ�y����
gNode=[        node'             xx                    yy];   %�ڵ���б��

  %No.3΢Ԫ��ͽڵ�Ĺ�ϵ����

               %΢Ԫ����           ��˽ڵ�             �Ҷ˽ڵ�
gElement=[    (1:Nel)',               (1:Nel)',            (2:Nnode)'];  


  %No.4 ��һ�߽���������

	    %�ڵ��      ���ɶȺ�     �߽�ֵ
 gBco=[  1,               1,                  0
	           1,               2,                  0
	        Nnode,          1,                 0
		    Nnode,          2,                 0];
         
        % No.5 ΢Ԫ��ĳ���
   xi=gNode(gElement(1,2),2);
   xj=gNode(gElement(1,3),2);
   yi=gNode(gElement(1,2),3);
   yj=gNode(gElement(1,3),3);
    p=sqrt((xi-xj)^2+(yi-yj)^2);
    
    if mod(Distance_For, p)==0
    For_Node=Distance_For/p;
    For_Node=For_Node+1;                              % ���������ڽڵ�
         % �����������
              %  �����õĽڵ�        ���ɶ�                    �����ô�С
  gNF=[ For_Node,                         1,                              Force*sin(w*t);
              For_Node ,                        2,                                 0  ];
    else
        gNF=[ ceil(Distance/p),               1,        (p-mod(Distance_For, p)/p)*Force*sin(w*t); 
                    ceil(Distance/p)                2,                               0;
                    ceil(Distance/p)+1           1,             (mod(Distance,p)/p)*Force*sin(w*t);
                    ceil(Distance/p)+1           2,                               0]; 
    end      
    
    ������õ����ɶȷ���
    
   % No.6 ��������͸նȾ���
   
   	 % ����΢Ԫ�����������
     me=m/420*...            
	[156*p  22*p^2  54*p  -13*p^2;...
    22*p^2 4*p^3 13*p^2  -3*p^3;...
    54*p 13*p^2 156*p    -22*p^2;...
    -13*p^2  -3*p^3  -22*p^2  4*p^3];

	%�׹ܵ�΢Ԫ�նȾ���
    Kea=E*I/(p^3)*...
	[12     6*p    -12         6*p;...
    6*p   4*p^2  -6*p    2*p^2; ...
    -12    -6*p     12         -6*p;...
    6*p    2*p^2  -6*p     4*p^2];

    %�ɿ�����������΢Ԫ�նȾ���
	Keb=(N*A1-mf*Ui^2)*...
    [6/(5*p) 1/10    -6/(5*p)   1/10;...
    1/10    2*p/15   -1/10      -1/30;...
    -6/(5*p) -1/10   6/(5*p)  -1/10;...
    1/10    -1/30     -1/10      2*p/15];
	%΢Ԫ������նȾ���
	ke=Kea+Keb;
    
    
% No7. ��������͸նȾ��������װ 
       gK=zeros(Nnode*2);
       gM=zeros(Nnode*2);
     %����΢Ԫ�����װ��       
   for ie=1:Nel    % Nel ��ʾ�ж��ٸ�΢Ԫ
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
       
   
   % No.8 ���õ�һ�߽���������ʩ�ӱ߽����� 
  [bc1_number,~]=size(gBco);
    w2max = max( diag(gK)./diag(gM) ); 
   for ibc=1:1:bc1_number
        n = gBco(ibc, 1 );                                       %������ҵ��ǽڵ�
        d = gBco(ibc, 2 );                                       %����Լ��ʩ�ӵ����ɶ�
        m = (n-1)*2 + d;                                        %����Լ�����ɶ����ܸվ�����ռ�õ����ɶ�
        gK(:,m) = zeros( Nnode*2, 1 );                  %�л���0
        gK(m,:) = zeros( 1, Nnode*2 );                  %�л���0
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
               gM(j,i) = gM(i,j);                                  % ���жԳƻ�����
           end
    end
  
    % ��������ֵ��������
    [gEigVector, gEigValue] = eigs(gK, gM, 3, 'SM' );      %��ȡ��������ֵ 
    
    for ibc=1:1:bc1_number
	    n = gBco(ibc, 1 );
        d = gBco(ibc, 2 );
        m = (n-1)*2 + d;                                   
        gEigVector(m,:) = gBco(ibc,3);                  %�����ͽ��б߽绯
    end
    
    
    fre_number=length(diag(gEigValue));                    
    w1=sqrt(gEigValue(1,1))/2/pi;                                    
    w2=sqrt(gEigValue(2,2))/2/pi;                     % ��ȡǰ���׹�����Ƶ��
    
    %No.9 ˮ�ཬ�����΢Ԫ��ճ��������� 
    dRatio=0.008;                                               % �ṹ����ȣ��ֲ�ˮ��ѡȡ0.008
    % Rayleigh Damping                                     % ճ�����ᣬ���ñ������᷽ʽ
    alpha=2*(w1*w2)*dRatio/(w1+w2);            % w1��w2�ǹܲĵĹ�����Ƶ��
    beta= 2*dRatio/(w1+w2);
    Ca=alpha*gM+beta*gK;                               % rayleigh ����ȷ���Ľṹ�������
    
    %�����������
	cb=-(2*mf*Ui + ma*Uo)*...
    [0          -p/10       -1/2          p/10;...
    p/10       0           -p/10         p^2/60;...
    1/2        p/10           0            -p/10;...
    -p/10     -p^2/60     p/10         0];                                
   % ��������������װ���Ӷ��ܹ��ĳ�������������
 
 Cb=zeros(Nnode*2);
    for ie=1:Nel                                                    % Nel ��ʾ�ж��ٸ�΢Ԫ
     for i=1:2
       for j=1:2
           for p=1:2
               for q=1:2
                   m=(i-1)*2+p;
                   n=(j-1)*2+q;
                   M=(gElement(ie,i)-1)*2+m;      
                   N=(gElement(ie,j)-1)*2+n;
                  Cb(M,N)=Cb(M,N)+cb(m,n);
               end
           end
        end
     end
   end
   
     % ���������rayleigh �����ó���
     % �ܹ�����������ǣ�  
     gC=Cb+Ca;
     
     % ��ӡ��������(����)
    fprintf( '\n\n ��һ   ��������(����)  \n' );
    for i=1:fre_number
        fprintf( '----------------') ;
    end
    fprintf( '\n' ) ;
    for i=1:fre_number
        fprintf( '  %6d        ', i ) ;
    end
    fprintf( '\n' ) ;
    for i=1:fre_number
        fprintf( '----------------') ;
    end
    fprintf( '\n' ) ;
    [dof,~]=size(gEigVector) ;
    for i=1:dof
        for j=fre_number:-1:1
            fprintf( '%15.7e ', gEigVector(j,j) ) ;
        end
        fprintf( '\n' ) ;
    end
    for i=1:fre_number
        fprintf( '----------------') ;
    end
    fprintf( '\n' ) ;
	
	% ��ӡ����ֵ
    fprintf( '\n\n\n\n ���   ����ֵ(Ƶ��)�б�  \n' ) ;
    fprintf( '----------------------------------------------------------\n') ;
    fprintf( '   ����       ����ֵ       ������Ƶ��(Hz)     ԲƵ��(rad/s)\n') ;
    fprintf( '----------------------------------------------------------\n') ;
    for i=fre_number:-1:1
        fprintf( '%6d   %15.7e   %15.7e   %15.7e\n', fre_number-i+1, ...
            gEigValue(i,i), sqrt(gEigValue(i,i))/2/pi, sqrt(gEigValue(j,j)) ) ;
    end
    fprintf( '----------------------------------------------------------\n') ;

     % No.9  ��������ͼ
    for j=fre_number:-1:1
        figure
        x = gNode(:,2) ;
        y = gNode(:,3) ;
        dx = gEigVector(1:2:length(x)*2, j ) ;
        dy = gEigVector(2:2:length(x)*2, j );
        factor = max( [max(abs(x))/max(abs(dx)), max(abs(y))/max(abs(dy))] )* 0.05;
        plot(x,y,'-', x+factor*dx, y+factor*dy,'r:');
        hold on
        title( sprintf( '��%d��Ƶ��: %.3f Hz', fre_number-j+1, sqrt(gEigValue(j,j))/2/pi ) ) ;
        grid on
    end
    
   % -----------------------------------------------------------------------------------------------------  ��������ͼû���κ�����
 
% ��������Ӧ����
% ���ȶ��峣����ֵ
% �ú�������ƽ���ϵ������Ԫģ�����ݣ�
% gNode -------- �ڵ㶨��
% gElement ----- ��Ԫ����
% gMaterial ---- ���϶��壬��������ģ�������Ľ���������Ŀ�����Ծ�
% gBC1 --------- Լ������
% gDeltaT ------ ʱ�䲽��
% gTimeEnd ----- �������ʱ��
% gDisp -------- λ��ʱ����Ӧ
% gVelo -------- �ٶ�ʱ����Ӧ
% gAcce -------- ���ٶ�ʱ����Ӧ
    
    gDeltaT=input('����ʱ�䵥������     ');
    gTimeEnd=input('�����ܵ�ʱ�䳤�ȣ� ');
 
 % ����λ�ƣ��ٶȺͼ��ٶ�
    gDisp = zeros( Nnode*2, timestep ) ;
    gVelo = zeros( Nnode*2, timestep ) ;
    gAcce = zeros( Nnode*2, timestep ) ;
    f=zeros(Nnode*2, timestep);
  
    % ��ʼ����
    gDisp(:,1) = zeros(Nnode*2, 1 ) ;                   %��ʼλ��
    gVelo(:,1) = zeros(Nnode*2, 1) ;                    %��ʼ�ٶ�
    
    % �����ʼ��
   [nf_number, ~] = size( gNF ) ;
    for inf=1:1:nf_number
        n = gNF( inf, 1 ) ;                                       % ʩ�����Ľڵ�
        d = gNF( inf, 2 ) ;                                       % ���������ɶȵĲ���
        m=(n-1)*2+ d;
        f( m, 1) = gNF( inf, 3 ) ;                               % ǿ���񶯣�ÿʱ���������
    end   
 
    % ������Ҫ���¶���û��ʩ�ӱ߽��������������󡢸նȾ���
    
    hK=zeros(Nnode*2);
    hM=zeros(Nnode*2);
    
   for ie=1:Nel                                                     % Nel ��ʾ�ж��ٸ�΢Ԫ
     for i=1:2
       for j=1:2
           for p=1:2
               for q=1:2
                   m=(i-1)*2+p;
                   n=(j-1)*2+q;
                   M=(gElement(ie,i)-1)*2+m;      
                   N=(gElement(ie,j)-1)*2+n;
                   hK(M,N)=hK(M,N)+ke(m,n);
                   hM(M,N)=hM(M,N)+me(m,n);
               end
           end
        end
     end
   end
   
   %�����ʼ���ٶ�
    gAcce(:,1) =hM\(f(:,1)-hK*gDisp(:,1)-gC*gVelo(:,1)); 
   
    %������Newmark���������񶯷���
    gama = 0.5 ;
    beta = 0.25 ;                                                   % ����ƽ�����ٶȷ��� Newmark- beta ����
    alpha0 = 1/beta/gDeltaT^2;
    alpha1 = gama/beta/gDeltaT;
    alpha2 = 1/beta/gDeltaT;
    alpha3 = 1/2/beta - 1;
    alpha4 = gama/beta - 1;
    alpha5 = gDeltaT/2*(gama/beta-2);
    alpha6 = gDeltaT*(1-gama);
    alpha7 = gama*gDeltaT;
    K1 = hK + alpha0*hM + alpha1*gC;            %������Ч�նȾ���
     
%-------------------------------------------------------------------------
% �Ѽ��������ɵ�����ڵ���������

   [bc1_number, ~]=size(gBco);
   K1im = zeros(Nnode*2, bc1_number);
    for ibc=1:1:bc1_number
        n=gBco(ibc,1);
        d=gBco(ibc,2);
        m=(n-1)*2+d;
        K1im(:,ibc)=K1(:,m);                                 %���ǽ�ԭʼ�߽��������浽Klim��ȥ����������������ʩ�ӱ߽�����
        K1(:,m) = zeros( Nnode*2, 1 );                  %����Ч�նȾ�����и�ֵ
        K1(m,:) = zeros( 1, Nnode*2);                   % ���С����з��Ա߽���������ʩ��
        K1(m,m) = 1.0;                                          %ʩ�ӱ߽�����
    end
  [KL,KU]=lu(K1);
   
   %��ÿһ��ʱ�䲽���㡢�ǰ���ʱ�䲽�����м���
  
    for i=2:1:timestep
        
        if mod(i,100) == 0
            fprintf( '��ǰʱ�䲽��%d\n', i );          % ��ʾ����������ģΪ������
        end
            
   % ��K1���б߽���������
   [nf_number, ~] = size( gNF ) ;
    for inf=1:1:nf_number
        n = gNF( inf, 1 ) ;                                       % ʩ�����Ľڵ�
        d = gNF( inf, 2 ) ;                                       % ���������ɶȵĲ���
        m=(n-1)*2+ d;
        f( m, i) = gNF( inf, 3 ) ;                               % ǿ���񶯣�ÿʱ���������
    end   
    
        f1 =f(:,i)+hM*(alpha0*gDisp(:,i-1)+alpha2*gVelo(:,i-1)+alpha3*gAcce(:,i-1)) ...
                  + gC*(alpha1*gDisp(:,i-1)+alpha4*gVelo(:,i-1)+alpha5*gAcce(:,i-1)) ;
       
        % ��f1���б߽���������, ʩ�����ı߽�����
        [bc1_number,~] = size( gBco ) ;
        for ibc=1:1:bc1_number
            n = gBco(ibc, 1 ) ;
            d = gBco(ibc, 2 ) ;
            m = (n-1)*2 + d ;
        %�������  ��ô��Ҫ��������ʩ�ӱ߽�����
            f1 = f1 - gBco(ibc,3) * K1im(:,ibc) ;      % �����ʩ�ӱ߽�����    ���û��л��з�ʩ�ӱ߽�����    
            f1(m)=gBco(ibc,3);
        end
        y=KL\f1;
        gDisp(:,i) = KU\y ;
        gAcce(:,i) = alpha0*(gDisp(:,i)-gDisp(:,i-1)) - alpha2*gVelo(:,i-1) - alpha3*gAcce(:,i-1) ;
        gVelo(:,i) = gVelo(:,i-1) + alpha6*gAcce(:,i-1) + alpha7*gAcce(:,i) ;
     end

    % ����ʱ������
   t = 0:gDeltaT:(gTimeEnd-gDeltaT);
    d = gDisp((floor(Nnode/4)*2)+1,:);
    subplot(2,1,1);
    plot( t, d );
    title( 'L/2���Ӷ�ʱ������');
    xlabel( 'ʱ��(s)');
    ylabel( '�Ӷ�(cm)' );
    grid on
   
    % ��ʱ�����߽���FFT�任����ȡƵ������
    fd = fft( d ) ;
    df = 1/gTimeEnd ;
    f = (0:length(d)-1)*df ;
    subplot(2,1,2);
    plot(f,abs(fd)) ;
    set(gca,'xlim',[0,10]) ;
    title( 'L/2���Ӷȵ�Ƶ��ͼ' ) ;
    xlabel( 'Ƶ��(Hz)') ;
    ylabel( '��ֵ' ) ;
   
    % ��עƵ�ʷ�ֵ
    fifi1 = diff(abs(fd));
    n = length(fifi1) ;
    d1 = fifi1(1:n-1);
    d2 = fifi1(2:n) ;
    indmax = find( d1.*d2<0 & d1>0 )+1;
    for i=1:length(indmax)
        if f(indmax(i)) > 10
            break;
        end
        text( f(indmax(i)+2), abs(fd(indmax(i)))*0.9, sprintf('f=%.3f',f(indmax(i))));
    end
 %----------------------------------------------------------------------------------------------------------------------------------------------------------------------
    %  �ƶ��غ��µļ�������
    % �����ǹ̶��غ������µ���Ӧ������
    %  �ƶ��غ��µ���Ӧ����Ӧ�������ж��غ�λ�ã��ڶ������и�ֵ���Ӷ�ȷ�����Ĵ�С������Newmark�������м��㡣
  
    % �����κ��������ƶ��غɷֽ⵽�ڵ��Ч����
    % ���غ�λ�ý��г����ж�
  
    % ���غ�λ�ý��г����ж�
    timespace=gTimeEnd/gDeltaT;
    t=volum/Q;                                                    % Ԥ���ƶ��غ����õ�ʱ��
    v=L/t;                                                             % �ƶ��غ��˶����ٶ�
    Force_moving=input('�����ƶ��غ����Ĵ�С��');
    gDeltaT=input('����ʱ�䲽����     ');                           %  ������Ϊ0.01
    f=zeros(gNode*2, timespace);                                         % ����������
   gDisp=zeros(gNode*2, timespace);                                  % ����λ�ƾ���                  
   gVelo=zeros(gNode*2, timespace);                                  % �����ٶȾ���
   
    for i=1:timespace                                            % ÿ��ʱ�䲽������
        cosin=mod(i*v, p)/p;
        N1=1-3*cosin^2+2*cosin^3;
        N2=(cosin-2*cosin^2+cosin^3)*p;
        N3=3*cosin^2-2*cosin^3;
        N4=(-cosin^2+cosin^3)*p;
        Hermite=[N1, N2, N3, N4]';
        N_Moving=Force_moving*Hermite;
        Mload_node=ceil(i*v/p);
        Mload_Hermite=[Mload_node,            1         N_Moving11;...
                                     Mload_node,            2         N_Moving21;...
                                     Mload_node +1,      1         N_Moving31;...
                                     Mload_node +1,      2         N_Moving41];
        [number_Mload_node, ~]=size(Mload_Hermite);
        for v =1: number_Mload_node
              n=Mload_Hermite(v,1);                         % �˶����Ľڵ�
              d=Mload_Hermite(v,2);                         % �˶��������ɶ�
              m=(n-1)*2 +d;                                      %  ���ܵ���������ռ�����ɶ�       
            f(m,i)=Mload_Hermite(m, 3);
        end
    end   
    
   %������Newmark���������񶯷���
    gama = 0.5 ;
    beta = 0.25 ;                                                   % ����ƽ�����ٶȷ��� Newmark- beta ������ƽ�����ٶȷ�
    [~,N]=size(hK);
    alpha0 = 1/beta/gDeltaT^2;
    alpha1 = gama/beta/gDeltaT;
    alpha2 = 1/beta/gDeltaT;
    alpha3 = 1/2/beta - 1;
    alpha4 = gama/beta - 1;
    alpha5 = gDeltaT/2*(gama/beta-2);
    alpha6 = gDeltaT*(1-gama);
    alpha7 = gama*gDeltaT;
    K1 = hK + alpha0*hM + alpha1*gC;            %������Ч�նȾ���
     
% ��K1���б߽���������
   [bc1_number,dummy] = size(gBco) ;
   K1im = zeros(Nnode, bc1_number);
    for ibc=1:1:bc1_number
        n=gBco(ibc,1);
        d=gBco(ibc,2);
        m=(n-1)*2+d;
        K1im(:, ibc)=K1(:, m);                               %���ǽ�ԭʼ�߽��������浽Klim��ȥ����������������ʩ�ӱ߽�����
        K1(:,m) = zeros( Nnode*2, 1 );                  %����Ч�նȾ�����и�ֵ
        K1(m,:) = zeros( 1, Nnode*2);                   % ���С����з��Ա߽���������ʩ��
        K1(m,m) = 1.0;                                          %ʩ�ӱ߽�����
    end
    [KL,KU] = lu(K1);                                         % ����LU�ֽ⣬��ʡ��������ʱ��
   
   %�����ʼ���ٶ�
    gAcce(:,1) =hM\(f(:,1)-hK*gDisp(:,1)-gC*gVelo(:,1));         % ��ʼ���ٶ�һ�㶼��Ϊ���      
   
   %��ÿһ��ʱ�䲽����
    for i=2:1:timestep
        if mod(i,100) == 0
            fprintf( '��ǰʱ�䲽��%d\n', i );          % ��ʾ����������ģΪ������
        end
        f1 =f(:,i)+hM*(alpha0*gDisp(:,i-1)+alpha2*gVelo(:,i-1)+alpha3*gAcce(:,i-1)) ...
                  + gC*(alpha1*gDisp(:,i-1)+alpha4*gVelo(:,i-1)+alpha5*gAcce(:,i-1)) ;            
       
        % ��f1���б߽���������, ʩ�����ı߽�����
        [bc1_number,dummy] = size( gBco ) ;
        for ibc=1:1:bc1_number
            n = gBco(ibc, 1 ) ;
            d = gBco(ibc, 2 ) ;
            m = (n-1)*2 + d ;
        %�������  ��ô��Ҫ��������ʩ�ӱ߽�����
            f1 = f1 - gBco(ibc,3) * K1im(:,ibc) ;      % �����ʩ�ӱ߽�����    ���û��л��з�ʩ�ӱ߽�����                                          
        end
        y = KL\f1 ;
        gDisp(:,i) = KU\y ;
        gAcce(:,i) = alpha0*(gDisp(:,i)-gDisp(:,i-1)) - alpha2*gVelo(:,i-1) - alpha3*gAcce(:,i-1) ;   % ��һ��ʱ�εļ��ٶ�
        gVelo(:,i) = gVelo(:,i-1) + alpha6*gAcce(:,i-1) + alpha7*gAcce(:,i) ;
    end
    
   % ����ʱ������
    t = 0:gDeltaT:(gTimeEnd-gDeltaT);
    d = gDisp((floor(Nnode/2)*2)+1,:);
    subplot(2,1,1);
    plot( t, d );
    title( 'L/4���Ӷ�ʱ������');
    xlabel( 'ʱ��(s)');
    ylabel( '�Ӷ�(cm)' );
    grid on
   
    % ��ʱ�����߽���FFT�任����ȡƵ������
    fd = fft( d ) ;
    df = 1/gTimeEnd ;
    f = (0:length(d)-1)*df ;
    subplot(2,1,2);
    plot(f,abs(fd)) ;
    set(gca,'xlim',[0,10]) ;
    title( 'L/4���Ӷȵ�Ƶ��ͼ' ) ;
    xlabel( 'Ƶ��(Hz)') ;
    ylabel( '��ֵ' ) ;
   
    % ��עƵ�ʷ�ֵ
    fifi1 = diff(abs(fd));
    n = length(fifi1) ;
    d1 = fifi1(1:n-1);
    d2 = fifi1(2:n) ;
    indmax = find( d1.*d2<0 & d1>0 )+1;
    for i=1:length(indmax)
        if f(indmax(i)) > 10
            break;
        end
        text( f(indmax(i)+2), abs(fd(indmax(i)))*0.9, sprintf('f=%.3f',f(indmax(i))));
    end
   


 