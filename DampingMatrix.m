function gC=DampingMatrix(ie)
global gNode gElement  mf Ui gK  gM w1 w2 ma
   xi=gNode(gElement(ie,2),2);
   xj=gNode(gElement(ie,3),2);
   yi=gNode(gElement(ie,2),3);
   yj=gNode(gElement(ie,3),3);
   p= ( (xj-xi)^2 + (yj-yi)^2 )^(1/2);
%�����������
	cb=-(2*mf*Ui + ma*Uo)*...
    [0          -p/10       -1/2          p/10;...
    p/10       0           -p/10         p^2/60;...
    1/2        p/10           0            -p/10;...
    -p/10     -p^2/60     p/10         0];      

     
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
    
    %No.9 ˮ�ཬ�����΢Ԫ��ճ��������� 
    dRatio=0.008;                                               % �ṹ����ȣ��ֲ�ˮ��ѡȡ0.008
    % Rayleigh Damping                                     % ճ�����ᣬ���ñ������᷽ʽ
    alpha=2*(w1*w2)*dRatio/(w1+w2);            % w1��w2�ǹܲĵĹ�����Ƶ��
    beta= 2*dRatio/(w1+w2);
    Ca=alpha*gM+beta*gK;                               % rayleigh ����ȷ���Ľṹ�������
     % ���������rayleigh �����ó���
     % �ܹ�����������ǣ�  
     gC=Cb+Ca;
     T = TransformMatrix( ie ) ;
    gC = T*gC*transpose(T) ;
     return
     
     % �Ѽ�飬û������
     