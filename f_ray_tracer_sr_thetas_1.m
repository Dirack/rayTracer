function thetas = f_ray_tracer_sr_thetas_1(mod,velocity_model,ss,rr)
%   Traçador de raio fonte-receptor.
%   
%   Inputs: mod           --> matriz que define o grid.
%           velocity_model--> vetor com modelo de velocidade.
%           ss            --> matriz (Ns x 2) com as coordenadas das fontes.
%           rr            --> matriz (Nr x 2) com as coordenadas dos receptores.
% 
%    
%
%
% disp('traçador_fonte_teceptor')
% pause
Nz = mod(1,3); %Número de células em Z
dx = mod(2,2);
dz = mod(1,2);

Ns = size(ss,1);  %Número de fontes
Nr = size(rr,1);  %Número de fontes

Nrays = Ns*Nr;    %Número de raios

thetas = zeros(1,length(Nrays));

n = 1; %contador relacionado ao raio de angulo thetas(n)

for p = 1: size(ss,1);  
    for q = 1: size(rr,1);
      
        if ss(p,1) < rr(q,1) %Este if pegará casos de fonte a esquerda e receptor a direita 
            l = 0.01 ;         
            while ( l < (Nz*dz)/2)
  
               
            theta_f = 180;  %theta final
            theta_i = 0;    %theta inicial
         
        %while loop para calcular o angulo do raio que chega ao receptor
        %a condição para sair do loop é de que a diferença entre os raios
        %testes é muito pequena
        
            %while (theta_f-theta_i > 0.002)
                 dtheta = (theta_f-theta_i)/10000; %calculo de delta-theta
                 thetas(n) = theta_i;             
           
                 while (thetas(n) <= theta_f)
                %traçamento dos raios testes ray1 e ray2 usando a função
                %ray_tracer:
                
                   
                    ray1 = f_ray_tracer(mod,velocity_model,ss(p,:),thetas(n));
                    
                    ray2 = f_ray_tracer(mod,velocity_model,ss(p,:),thetas(n)+dtheta);

                %esse for pega a última entrada diferente de NaN nos raios:
                %é necessário devido a forma como a função ray_tracer foi construída
                    for i=1:length(ray1)
                        if isnan(ray1(i,1))
                        
                        else
                        x1 = ray1(i,1);  %coordenada x não necessária
                        z1 = ray1(i,2); %adquirindo coordenada z onde o raio1 sai do grid
                        end
                    
                        if isnan(ray2(i,1))
                        
                        else
                        x2 = ray2(i,1);  %coordenada x não necessária
                        z2 = ray2(i,2); %adquirindo coordenada z onde o raio2 sai do grid
                        end                    
                    end                         
                %condicional para sair do while loop interno
                %a saida acontece quando a coordenada z do receptor está
                %entre os dois raios traçados
%                 rr(q,2) >= z2 && rr(q,2) <= z1 && abs(z2-rr(q,2)) < 0.5
                    %tes = abs(z2-rr(q,2))
                                
                    if rr(q,2) >= z2 && rr(q,2) <= z1 && ss(p,1) < x2 && ...
                       ss(p,1) < x1 && ss(p,1) < x2 && abs(z2-rr(q,2)) < l || ... 
                       rr(q,2) >= z1 && rr(q,2) <= z2 && ss(p,1) <= x2 && ...
                       ss(p,1) < x1 && ss(p,1) < x2 && abs(z2-rr(q,2)) < l ; 
%                       
                        l = Nz*dz ;
                        break 
                    end
%                     end
%                     end
                %se a saida não acontece há um incremento do valor de thetas
                %para o traçamento de dois novos raios:
                    thetas(n) = thetas(n) + dtheta;
                                        

                 end
            %atribuição dos novos valores de theta_i e theta_f para a
            %continuação do while loop externo
                        theta_i = thetas(n);
                        theta_f = thetas(n)+dtheta; 
                    l = l + 1;
              end
                   %end
        %incremento do contador do número do raio de angulo theta:
            n = n+1;
        end
    end
end

end