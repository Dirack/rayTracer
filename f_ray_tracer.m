function out = f_ray_tracer(mod,velocity_model,ss,theta)
%  Função ray_tracer
%  Inputs: matriz mod que define o grid.
%          velocity_model [vector 1X(Nx*Nz)] 
%          ss -> posição da fonte Vetor (1x2)
%          theta -> angulo com a vertical
%
% 
% disp('traçador raios')
% pause
s = 1./velocity_model;  %modelo de vagarosidade
% =======================================================================


Nx = mod(2,3); %Número de células na dir x
Nz = mod(1,3); %Número de células na dir z
%delta = 0.1;     %Delta incremento para condição de distancias iguais entre P1 e P2
if length(s) ~= Nx*Nz
    error('Wrong number of components for velocity model')
end

x0 = ss(1,1);   %Posição inicial da fonte em X
z0 = ss(1,2);   %Posição inicial da fonte em z
dx = mod(2,2);  %Comprimento da célula em X
dz = mod(1,2);  %Comprimento da célula em Z
ox = mod(1,1);  %origem em X
oz = mod(2,1);  %origem em Z
% ========================INICIALIZANDO A MATRIZ POINTS============================
                            %A matriz points cria uma matriz de zeros com 
points = zeros(Nx*Nz+1,2);  % Nx*Nz+1 Núm. de linhas e 2 colunas.
                            %Essa matriz será preenchida pelos pontos em
                            %que os raios tocam o Grid da malha.
                            
for i = 1:(Nx*Nz+1)             % Este loop substitui os zeros da matriz points inicial
    points(i,:) = [NaN NaN];    % por NaN, porém com a mesma dimensão que a anterior
end
 
P0 = [x0 z0];            %O primeiro ponto no grid a ser destacado é a 
points(1,:) = P0;        %própria posição da fonte. E será a primeira linha

  i=2;

     [xm zm x z] = f_xz_xmzm(x0,z0,theta, mod); % proximo multiplo do grid em X e Y

    while (xm <= Nx*dx || isnan(xm) && zm <= Nz*dz || isnan(zm) && xm >= ox && zm >= oz );  % Condicional pra não ultrapassar os limites da malha
    
        [xm zm x z] = f_xz_xmzm(x0,z0,theta, mod); % proximo multiplo do grid em X e Y

        P1 = [xm z_tr(xm,x0,z0,theta)]; %Ponto que intercepta em um multiplo de X
        P2 = [x_tr(zm,z0,x0,theta) zm]; %Ponto que intercepta em um multiplo de z

%%%%%%%%%%%%%% INTERCEPTA O GRID EM UM MULTIPLO DE Z %%%%%%%%%%%%%%%%%%%%%%
        if distance(P0,P1) - distance(P0,P2) > 0 || theta == 0 || theta == 180 || theta == -180
%theta == 180
%       disp('f_ray_tracer - int. z')
            points(i,:) = P2;            % Ele guarda esse ponto na matriz points
            in = index((P0+P2)/2,dx,dz); % Índice(Linha e Coluna) da célula
            cn = cell_number(in,Nx);     % Enumera a célula em questão
            if zm >= Nz*dz || zm <= 0 || cn - Nx < 1 && theta > 90 || ...
               theta >= 180 ;
                break                               % dentro da malha.
            end                                     %este if ainda precisa de ajustes
        % Fórmula da lei de Snell                   
        
        
            theta = f_theta_snell(mod,velocity_model,theta,cn,P0,P1,P2);
              
            P0 = P2;                    % O ponto P2 calculado será o novo P0
            x0 = P0(1);                 % Assim, a "COMPONENTE X" do novo P0 será o novo x0
            z0 = P0(2);                 % Assim, a "COMPONENTE Z" do novo P0 será o novo z0
                   
%%%%%%%%%%%%%%% INTERCEPTA O GRID EM UM MULTIPLO DE X %%%%%%%%%%%%%%%%%%%%%
        else distance(P0,P2) - distance(P0,P1) > 0 ;
%       disp('f_ray_tracer - int. x'); 

            points(i,:) = P1;         % Ele guarda esse ponto na matriz points
            in = index((P0+P1)/2,dx,dz);% Índice(Linha e Coluna) da célula
            cn = cell_number(in,Nx);    % Enumera a célula em questão
           
            if xm >= Nx*dx || zm > Nz*dz || xm <= 0 || cn == 1 && theta <= 0 || ...
               theta >= 180 ; % Este If garante que a lei de snell será feita apenas
                                        % dentro da malha.(NÃO FUNCIONA PARA MODELOS COM 4 CÉLULAS
                                        % NEM QUANDO OS RAIOS PARTEM DA 1 COLUNA DE CÉLULAS)
                break
            end
            
%            Fórmula da lei de Snell   
            theta = f_theta_snell(mod,velocity_model,theta,cn,P0,P1,P2,in);
            
            P0 = P1;                    % O ponto P1 calculado será o novo P0
            x0 = P0(1);                 % Assim, a "COMPONENTE X" do novo P0 será o novo x0
            z0 = P0(2);                 % Assim, a "COMPONENTE Z" do novo P0 será o novo z0
            
        end     
            i = i + 1;
  
    end
    out = points;
end



