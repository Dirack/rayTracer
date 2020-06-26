  clear ;
  close all;
  clc;
  
%Descrições do código
% mod: Contém a matriz com as dimensões da malha
%   A primeira coluna representa as coordenadas da origem.
%   A segunda coluna representa o TAMANHO DE CADA CÉLULA nas direções z e x
%   E a terceira representa o NÚMERO DE CÉLULAS nas direções 'z' e 'x'
  
% ss: Fonte
%   Matriz com as coordenadas da fonte
%   cada linha representa UMA FONTE sendo:
%   A PRIMEIRA COLUNA a coordenada 'x'
%   A SEGUNDA COLUNA a coordenada 'z'

% rr: Receptor
%   Matriz com as coordenadas da fonte
%   cada linha representa UM RECEPTOR sendo:
%   A PRIMEIRA COLUNA a coordenada 'x'
%   A SEGUNDA COLUNA a coordenada 'z' 
% 
% V: Modelo de Velocidade
%   Vetor linha com o modelo de velocidade do meio
%   Esse vetor tem a velocidade de cada célula do modelo em questão 
%   A distribuição das velocidades no modelo se dá no seguinte critério 
%   1: DA ESQUERDA PARA DIREITA
%   2: DE CIMA PARA BAIXO

% MODELOS TESTES

mod=[0 500 2;       
     0 1000 2];    
 % Fonte
 ss =  [ 0,0 ;
        0,180;
        0,400;
        0,670;
        0,850;
        0,999];

% Receptor
rr = [2000, 80;
      2000, 250;
      2000, 430;
      2000, 650;
      2000, 730;
      2000, 951];
  
V=1000*[2.1039;
    2.2622;
    2.4313;
    2.2494];

% 
% figure(1)
% imagesc(V); colorbar
% 
% v = reshape(V',[mod(1,3)*mod(2,3),1])
% Nint=1;
% alfa = 0.0001;
% 
%     for int=1:Nint
%         int
%         [D2 thetas] = f_ray_tracer_sr(mod,v,ss,rr);
%         S2 = inv((D2'*D2)+alfa.*max(diag(D2'*D2))*eye(mod(1,3)*mod(2,3)))*D2'*t
%         V=1./S2;
%     end


%###################### Traçador ########################


% 
% 
% figure(2)
% for iss=1:length(ss(:,1));
%     for theta= 10:1:170   %180:-1:-180
%        ss(iss,:);
%        ray = f_ray_tracer(mod,V,ss(iss,:),theta);
%        plot(ray(:,1),ray(:,2));hold on;
%        set(gca,'Ydir','reverse');
%        xlabel('x','FontSize',24);
%        ylabel('z','FontSize',24);
%        set(gca,'XTick',(mod(2,1) : mod(2,2) : mod(2,2)*mod(2,3)));
%        set(gca,'YTick',(mod(1,1) : mod(1,2) : mod(1,2)*mod(1,3)));
%        ylim([0 mod(1,2)*mod(1,3)]);
%        xlim([0 mod(2,2)*mod(2,3)]);
%        grid('on');
%        
%     end
% end
% % % 
% % ##################### Traçador Fonte-Receptor #######################
% 
n = 2;
figure(3)
for m=1:size(ss,1)
    for j=1:size(rr,1)
        theta_sr = f_ray_tracer_sr_thetas(mod,V,ss(m,:),rr(j,:))
        ray = f_ray_tracer(mod,V,ss(m,:),theta_sr);
        plot(ray(:,1),ray(:,2));hold on;
        set(gca,'Ydir','reverse') 
        xlabel('x','FontSize',24)
        ylabel('z','FontSize',24)
        set(gca,'XTick',(mod(2,1) : mod(2,2) : mod(2,2)*mod(2,3)));
        set(gca,'YTick',(mod(1,1) : mod(1,2) : mod(1,2)*mod(1,3)));
        ylim([0 mod(1,2)*mod(1,3)])
        xlim([0 mod(2,2)*mod(2,3)])
        grid('on')
        
    end
 end
% 
% Vv1 = reshape(V,mod(2,3),mod(1,3)); % Distribuição de velocidades em grid de cores
% v2 = Vv1';                           % Velocidade Inicial INPUT-Modelo Final
% imagesc(v2)
% title('Modelo Final - Vel Cte','FontSize',15)

 



% imagesc(v)
% % 
% % figure(2)
% % 
% % plot(erro)
% % title('Variações do erro')
% % xlabel('Numero de iteracoes')        
% % ylabel('erro')