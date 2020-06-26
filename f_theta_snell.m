function theta = f_theta_snell(mod,velocity_model,theta,cn,P0,P1,P2,in)
% Esta função realiza a lei de snell do raio que se propaga entre duas
% células(REFRAÇÃO), ou REFLETE este com um mesmo ângulo de incidência com
% a NORMAL, e tem como saída o ângulo que o raio refratado/refletido faz
% com o ângulo 0 de referência(vertical para baixo), devidamente atualizado.
%INPUT's:.
%   mod: matriz com as características da malha
%   velocity_model: modelo de velocidade
%   theta: ângulo com a vertical a partir do ponto inicial
%   cn: função que enumera a célula em questão
Nx = mod(2,3); %Número de células na dir x
s=1./velocity_model;
% disp('theta_snell')
% theta
% pause
% % Intercepto em um múltiplo de zm 
    if distance(P0,P1) - distance(P0,P2) > 0 || theta == 0 || theta == 180;
%disp('f_theta_snell int. z')

        if 0 < theta && theta < 90 % =====================================================================
%           disp('0<theta <90')
    
           theta_aux = asin((s(cn)./s(cn+Nx)).*sin(theta*pi./180)).*(180/pi); %theta em graus
        
           if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01 %Condição para refração
                theta=theta_aux;
        
           else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01 %Condição para reflexão
                theta = 180 - theta;
           end
                
        elseif 90 < theta && theta < 180 %===============================================================
        %   disp('90<theta <180')
     
            theta_aux = asin((s(cn)./s(cn-Nx)).*sin((180-theta).*pi/180))*(180/pi); %theta em graus
        
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = 180 - theta_aux;
                      
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01;
                theta = 180 - theta;
            end
           
        elseif -180<theta && theta<-90 %=============================================================
%            disp('-180<theta <-90');
            
            theta_aux = asin((s(cn)./s(cn-Nx))*sin((180 - abs(theta))*pi/180))*(180/pi); %theta em graus
       
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = -(180-theta_aux);
        
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01
                theta = -(180 - abs(theta));
            end
        
        elseif 0>theta && theta> -90 %===============================================================
%            disp(' 0>theta >-90');
            theta_aux = asin((s(cn)./s(cn+Nx))*sin((abs(theta))*pi/180))*(180/pi); %theta em graus
        
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = -theta_aux;
        
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01
                theta = - (180 - abs(theta));
            end
            
        else theta == 0 ;%====================================================================
            %disp(' theta = 0');
            
            theta_aux = asin((s(cn)./s(cn+Nx))*sin((theta-theta)*pi/180))*(180/pi);
            theta = theta;
        end
%================== INTERCEPTA UM MULTIPLO DE XM ========================================
    else %distance (P0,P2) - distance(P0,P1) > EPS 
%disp('f_theta_snell int. x')

        if 0 < theta && theta < 90 || theta == -90
        %   disp('0<theta<90') 
            
            theta_aux = asin(s(cn)./s(cn+1)*sin((90-theta)*pi/180))*(180/pi); %theta em graus
        
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = 90-theta_aux;
        
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01
                theta = -theta;
            end
            
        elseif 90<theta && theta<180 %===========================================================
        %   disp('90<theta <180')
            theta_aux = asin((s(cn)./s(cn+1))*sin((theta-90)*pi/180))*(180/pi); %theta em graus
        
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = 90+theta_aux;      
        
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01
                theta = -theta;
            end
        
        elseif -180<theta && theta<-90 %==============================================
        %   disp('-180<theta <-90')
            theta_aux = asin((s(cn)./s(cn-1))*sin((abs(theta)-90)*pi/180))*(180/pi); 
        
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = -(90+theta_aux); 
        
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01
                theta = abs(theta);
            end
                      
        elseif -90 < theta && theta < 0 %================================================
        %   disp('-90<theta && theta<0')
            theta_aux = asin((s(cn)./s(cn-1)).*sin((90-abs(theta))*pi/180)).*(180/pi); %theta em graus
            
            if isreal(theta_aux) == 1 && abs((theta_aux-90)) > 0.01
                theta = -(90 - abs(theta_aux));
        
            else %isreal(theta_aux) == 0 || abs((theta_aux-90)) < 0.01
                theta = abs(theta);
            end
            
        elseif theta == 90
            theta_aux = asin((s(cn)./s(cn+1)).*sin(theta-theta).*(pi/180))*(180/pi);
            theta = theta;
        

        elseif theta == -90

            theta_aux = asin((s(cn)./s(cn-1)).*sin(theta-theta).*(pi/180))*(180/pi);
            theta=theta;
        
        else %theta=180 pq n quer entrar no loop certo
           
            theta_aux = asin((s(cn)./s(cn-Nx))*sin((theta-theta)*pi/180))*(180/pi);
            theta = theta;
        end
    end
    out = theta;
end