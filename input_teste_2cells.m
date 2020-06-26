clc;    
close all;
clear all;

%===========================INPUTs================================%
mod=[0 300 1;       
     0 250 2];     
 % matriz com as dimensões da malha
 % A primeira coluna representa as coordenadas da origem.
 % A segunda o tamanho de cada célula nas direções z e x
 % respectivamente. E a terceira representa a quantidade de
 % células nas direções 'z' e 'x' respectivamente.
%===========================FONTE=================================%
ss = [0, 50
      0, 240];   
  
  % Matriz com as coordenadas da fonte
  % cada linha representa uma fonte sendo a primeira coluna
  % a coordenada 'x' e a segunda coluna a coordenada 'z'
                 
%==========================RECEPTOR===============================%
rr = [500, 40
      500, 230];  
  
  % Matriz com as coordenadas dos receptores
  % cada linha representa um receptor sendo a primeira coluna
  % a coordenada 'x' e a segunda coluna a coordenada 'z'           

t=[1.421;1.493;
   1.510;1.421] ;

alfa = 0.00001;
Nint=15;
erro=zeros(1,Nint+1);
V = zeros(); 

%#########################################################
%   Modelo que traça raios retos sem velocidade inicial
% 
% d = raio_reto(mod, ss, rr);
% i=(d'*d)+alfa.*abs(max(diag(d'*d)))*eye(mod(1,3)*mod(2,3));
% s = inv(i)*d'*t;
% v = 1./s;
% [d thetas] = f_ray_tracer_sr(mod,v,ss,rr);
% erro(1) = sum([d*s - t].^2);
% V=v;

%##########################################################
% %   Modelo Inicial Vel. cte 
v = [250;450];
s=1./v;
[d thetas] = f_ray_tracer_sr(mod,v,ss,rr);
erro(1) = sum([d*s - t].^2);
V=v;

 % Figura que mostra distribuição das velocidades na malha
figure(1)
imagesc(v)
v = reshape(v',[mod(1,3)*mod(2,3),1]);

figure(2)
n=1;
for m=1:size(ss,1)
    for j=1:size(rr,1)
        ray = f_ray_tracer(mod,V,ss(m,:),thetas(n));
        plot(ray(:,1),ray(:,2));hold on;
        set(gca,'Ydir','reverse') 
        xlabel('distance(x)','FontSize',24)
        ylabel('Depth(z)','FontSize',24)
        title('Vel. inicial (1 iteracao)')
        set(gca,'XTick',(mod(2,1) : mod(2,2) : mod(2,2)*mod(2,3)));
        set(gca,'YTick',(mod(1,1) : mod(1,2) : mod(1,2)*mod(1,3)));
        ylim([0 mod(1,2)*mod(1,3)])
        xlim([0 mod(2,2)*mod(2,3)])
        grid('on')
        n = n +1;
    end
end

%  ============== 2 iteração ==================
for int=1:Nint
    int
    [D thetas] = f_ray_tracer_sr(mod,V,ss,rr);
    S = inv((D'*D)+alfa.*max(diag(D'*D))*eye(mod(1,3)*mod(2,3)))*D'*t;
    %S=inv(D'*D)*D'*t;
    
    V=1./S 
    erro(1,int+1) = sum([D*S - t].^2);

    figure(3)    
    plot(erro)
    title('Variações do erro')
    xlabel('Numero de iteracoes','FontSize',18)        
    ylabel('erro','FontSize',18)
    
end

 
thetas = f_ray_tracer_sr_thetas_1(mod,V,ss,rr);
 n = 1;
figure(n+3)
for m=1:size(ss,1)
    for j=1:size(rr,1)
        ray = f_ray_tracer(mod,V,ss(m,:),thetas(n));
        plot(ray(:,1),ray(:,2));hold on;
        set(gca,'Ydir','reverse') 
        xlabel('distance(x)','FontSize',24)
        ylabel('Depth(z)','FontSize',24)
        title('Vel. inicial (iteração final)')
        set(gca,'XTick',(mod(2,1) : mod(2,2) : mod(2,2)*mod(2,3)));
        set(gca,'YTick',(mod(1,1) : mod(1,2) : mod(1,2)*mod(1,3)));
        ylim([0 mod(1,2)*mod(1,3)])
        xlim([0 mod(2,2)*mod(2,3)])
        grid('on')
        n=n+1;
    end
end

