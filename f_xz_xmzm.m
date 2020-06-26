function [xm, zm, x, z] = f_xz_xmzm(x0,z0,theta0, mod)
% Função que calcula os ponto na borda da célula a partir da propagação do
% raio  partindo de um ponto inicial e uma direcao inicial
%
% Inputs:
% x0 = posicao em x inicial     [x z] = P2;           % Ele guarda esse ponto na matriz points

% z0 = posicao em z incial  

% theta0 = angulo inicial (-180 < theta0 <= 180


P0=[x0 z0];

dx = mod(2,2);  %Comprimento da célula em X
dz = mod(1,2);  %Comprimento da célula em Z
    if theta0>0 && theta0<90 
        xm = (fix(x0/dx)+1)*dx;  %x multiplo do grid em X
        zm = (fix(z0/dz)+1)*dz;  %z multiplo do grid em Z
    elseif theta0>90 && theta0<180 
        xm = (fix(x0/dx)+1)*dx;  %x multiplo do grid em X
        zm = (ceil(z0/dz)-1)*dz;  %z multiplo do grid em Z
    elseif theta0>-90 && theta0<0 
        xm = (ceil(x0/dx)-1)*dx;  %x multiplo do grid em X
        zm = (fix(z0/dz)+1)*dz;   %z multiplo do grid em Z
    elseif theta0>-180 && theta0<-90 
        xm = (ceil(x0/dx)-1)*dx;  %x multiplo do grid em X
        zm = (ceil(z0/dz)-1)*dz;  %z multiplo do grid em Z
    elseif theta0==0 
        xm = NaN;                 %x multiplo do grid em X
        zm = (fix(z0/dz)+1).*dz;  %z multiplo do grid em Z
    elseif theta0==90
        xm = (fix(x0/dx)+1)*dx;  %x multiplo do grid em X
        zm = NaN;                %z multiplo do grid em Z
    elseif theta0==-90
        xm = (ceil(x0/dx)-1)*dx;  %x multiplo do grid em X
        zm = NaN;                %z multiplo do grid em Z
    
    else theta0==180 || theta0==-180; 
        xm = NaN;                %x multiplo do grid em X
        zm = (ceil(z0/dz)-1)*dz;  %z multiplo do grid em Z
     
% else
%     print('Erro: theta não está em um intervalo valido.')
%    break
    end
  
    P1 = [xm z_tr(xm,x0,z0,theta0)]; % Ponto que intercepta o Grid em x
    P2 = [x_tr(zm,z0,x0,theta0) zm]; % Ponto que intercepta o Grid em z

    if distance(P0,P1) - distance(P0,P2) > 0 || isnan(P1(1))
    %disp('f_xz_xmzm int. z');
       
        x = P2(1);
        z = P2(2);
    %[x z] = P2;           % Ele guarda esse ponto na matriz points 
    else % distance(P0,P1) - distance(P0,P2) > 0 || isnan(P2(1))
    %disp('f_xz_xmzm int. x');
        
        x = P1(1);
        z = P1(2);
    end  
    %A SAÍDA DESSA FUNÇÃO DEVE SER [x z] e [xm zm]  
end
         