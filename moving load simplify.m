
    %%  �������ƶ��غ��µļ������⣬ ģ���ƶ��غ��µļ�������
       
    % �����κ��������ƶ��غɷֽ⵽�ڵ��Ч����
    % ���غ�λ�ý��г����ж�
    t= input('�����غ��˶�ʱ��:    ');
    v=input('�����غ��ƶ����ٶȣ�');
    Force_moving=input('�����ƶ��غ����Ĵ�С��');
    delta_t=input('����ʱ�䲽����');
    if (L/N) < (delta_t*v)
        printf('���㲽��̫������С����');
    end
    delta_t=input('����ʱ�䲽���� ');
    tau=mod(t,delta_t);                                        %  ����tau��ֵ����A��B֮���˶���ʱ��
    S_moving=v*t;                                               %  tʱ���ڣ��˶���λ��
    j=floor(S_moving/p);                                    %  �˶����Ľڵ���
    Element_x=mod(S_moving,p);                      %  �ƶ��غ���΢Ԫ���ڵ�λ�ã�������ڵ�i �ľ��롣
    S_time=floor(t/delta_t)*v;                             %  �����������ƶ��ľ���
    S_element=gNode(j,2);                                  %   j ���ڵ����ڵ�����
    % ---------------------------------------------------------------------------------------------------------------------------
    % ΢Ԫ����λ�õ��ж�, ��i �ڵ�Ϊ�ֽ��
  if S_time > S_element                                     %  �ж�A���Ƿ���΢Ԫ����
       sigma_1=S_time -S_element;                     %  A �㵽�ڵ�i �ľ���
    % ΢Ԫ����λ�õ��ж�����i+1�ڵ�Ϊ�ֽ��
         if ceil(t/delta_t)*v>(j+1)*p
        sigma_2=p;                                                % �����һ��ʱ�䲽�����ƶ�������΢Ԫ��i, ��ôsigma_2 �͵���΢Ԫ�峤��
         else
        sigma_2=sigma_1+delta_t*v;                    % �����һ��ʱ�䲽�����ƶ�����Ȼ��΢Ԫ��j�ڣ���ôsigma_2������sigma_1 + delta_t *v
         end
    else 
        sigma_1=0;
        sigma_2 = ceil(t/delta_t)*v-i*p;
  end
    b1=1-3*sigma_1^2+2*sigma_1^3;
    b2=(6*sigma_1^2 - 6*sigma_1)*(sigma_2 - sigma_1);
    b3=(6*sigma_1 - 3)*(sigma_2 - sigma_1)^2;
    b4=2*(sigma_2 - sigma_1)^3;
    b5=(sigma_1 - 2*sigma_1^2 + sigma_1^3)*p;
    b6=(1-4*sigma_1+3*sigma_1^2)*(sigma_2 - sigma_1)*p;
    b7=(3*sigma_1 - 2 )*(sigma_2 - sigma_1)^2*p;
    b8=(sigma_2 - sigma_1)^3*p;
    b9=1-b1;
    b10=-b2;
    b11=-b3;
    b12=-b4;
    b13=(sigma_1^3 - sigma_1^2)*p;
    b14=(sigma_2 - sigma_1)*(3*sigma_1^2 - 2* sigma_1)* p;
    b15=(sigma_2-sigma_1)^2*(3*sigma_1 - 1)* p;
    b16=b8;
    
  % ����Hermite ��ֵ��������Force_moving������ɢ��
   a0=[b1;b2;b3;b4];
   a1=[b5;b6;b7;b8];
   a2=[b9;b10;b11;b12];
   a3=[b13;b14;b15;b16];
   F=(a0+a1*(tau/delta_t)+a2*(tau/delta_t)^2 +a3*(tau/delta_t)^3)*Force_moving;       % �ƶ��غ���ɢ�󿴳��ǳ�ʼ��������ʼʩ�ӵ���