
    % �����κ��������ƶ��غɷֽ⵽�ڵ��Ч����
    % ���غ�λ�ý��г����ж�
    timespace=gTimeEnd/gDeltaT;
    v=input('�����غ��ƶ����ٶȣ� ');
    Force_moving=input('�����ƶ��غ����Ĵ�С��');
    gDeltaT=input('����ʱ�䲽����     ');
    f=zeros(gNode*2,gTimeEnd/gDeltaT);                                          % ����������
   gDisp=zeros(gNode*2,gTimeEnd/gDeltaT);                                  % ����λ�ƾ���                  
   gVelo=zeros(gNode*2,gTimeEnd/gDeltaT);                                  % �����ٶȾ���
   
    for i=1:gTimeEnd/gDeltaT
        cosin=mod(i*v,p)/p;
        N1=1-3*cosin^2+2*cosin^3;
        N2=(cosin-2*cosin^2+cosin^3)*l;
        N3=3*cosin^2-2*cosin^3;
        N4=(-cosin^2+cosin^3)*l;
        N=[N1, N2, N3, N4]';
        f(:,i)=Force_moving*N;
    end                                                                  % ʩ���ƶ������м���
    

   %������Newmark���������񶯷���
    gama = 0.5 ;
    beta = 0.25 ;                                                   % ����ƽ�����ٶȷ��� Newmark- beta ������ƽ�����ٶȷ�
    [~,N]=size(gK);
    alpha0 = 1/beta/gDeltaT^2;
    alpha1 = gama/beta/gDeltaT;
    alpha2 = 1/beta/gDeltaT;
    alpha3 = 1/2/beta - 1;
    alpha4 = gama/beta - 1;
    alpha5 = gDeltaT/2*(gama/beta-2);
    alpha6 = gDeltaT*(1-gama);
    alpha7 = gama*gDeltaT;
    K1 = gK + alpha0*gM + alpha1*gC;            %������Ч�նȾ���
     
%-------------------------------------------------------------------------
      
  
% ��K1���б߽���������
   [bc1_number,dummy] = size(gBC1) ;
   K1im = zeros(Nnode, bc1_number);
    for ibc=1:1:bc1_number
        n=gBC1(ibc,1);
        d=gBC1(ibc,2);
        m=(n-1)*2+d;
        K1im(:,ibc)=K1(:,m);                                 %���ǽ�ԭʼ�߽��������浽Klim��ȥ����������������ʩ�ӱ߽�����
        K1(:,m) = zeros( Nnode*2, 1 );                  %����Ч�նȾ�����и�ֵ
        K1(m,:) = zeros( 1, Nnode*2);                   % ���С����з��Ա߽���������ʩ��
        K1(m,m) = 1.0;                                          %ʩ�ӱ߽�����
    end
    [KL,KU] = lu(K1);                                         % ����LU�ֽ⣬��ʡ��������ʱ��
   
   %�����ʼ���ٶ�
    gAcce(:,1) =gM\(-gK*gDisp(:,1)-gC*gVelo(:,1));         % ��ʼ���ٶ�һ�㶼��Ϊ���      
   
   %��ÿһ��ʱ�䲽����
    for i=2:1:timestep
        if mod(i,100) == 0
            fprintf( '��ǰʱ�䲽��%d\n', i );          % ��ʾ����������ģΪ������
        end
        f1 =f(:,i)+gM*(alpha0*gDisp(:,i-1)+alpha2*gVelo(:,i-1)+alpha3*gAcce(:,i-1)) ...
                  + gC*(alpha1*gDisp(:,i-1)+alpha4*gVelo(:,i-1)+alpha5*gAcce(:,i-1)) ;            
       
        % ��f1���б߽���������, ʩ�����ı߽�����
        [bc1_number,dummy] = size( gBC1 ) ;
        for ibc=1:1:bc1_number
            n = gBC1(ibc, 1 ) ;
            d = gBC1(ibc, 2 ) ;
            m = (n-1)*2 + d ;
        %�������  ��ô��Ҫ��������ʩ�ӱ߽�����
            f1 = f1 - gBC1(ibc,3) * K1im(:,ibc) ;      % �����ʩ�ӱ߽�����    ���û��л��з�ʩ�ӱ߽�����                                          
        end
        y = KL\f1 ;
        gDisp(:,i) = KU\y ;
        gAcce(:,i) = alpha0*(gDisp(:,i)-gDisp(:,i-1)) - alpha2*gVelo(:,i-1) - alpha3*gAcce(:,i-1) ;
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
   
