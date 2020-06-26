%versão 1.1: encontrado erro no loop: fonte e receptor na mesma
%profundidade estava gerando wrong output.
% update: 23-05-17
function d = raio_unico(mod,S,R)

%=================REDEFININDO AS VARIAVEIS========================%
dx=mod(2,2);         % Comprimento de cada célula na dimensão x
dz=mod(1,2);         % comprimento de cada célula na dimensão z
nx = mod(2,3);       % Número de células na dimensão x
nz = mod(1,3);       % Número de células na dimensão z
o = mod(:,1);        % Origem da malha

%%=====================COEF. ANGULAR E LINEAR%======================%
% CASO 1 %
%       Caso em que a FONTE está MAIS a ESQUERDA e MAIS ACIMA que o RECEPTOR.
%       xm e zm são representam os ultimos pontos multiplos de dx e dz,
%                mais próximos da fonte, respectivamente.
%       OBS:.Até o momento só valem para estes 2 casos

if S(1) <= R(1) && S(2) <= R(2)
    
    m = (R(2)-S(2))/(R(1)-S(1));    % Coef. angular
    b = S(2) - m*S(1);              % Coef. linear
    xm = (fix(S(1)/dx) +1)*dx;      %       xs<xr
    zm = (fix(S(2)/dz) +1)*dz;      %       zs<zr
    
    
    %%Essas expressões de xm e zm só valem para
    %%essa configuração fonte-receptor.
    %%é importante notar isto, pois um par de
    %%expressão errado pode extrapolar o raio
    %%para a direção errada, resultando em
    %%pontos além da fonte ou do receptor.
    
    points = [S;R]; % Inicializando a matriz points com as coordenadas
                    % da fonte e do receptor.
                    % No fim das interações abaixo, essa matriz conterá
                    % todos os pontos do receptor à fonte que interceptam a
                    % malha.
    
    i=3; % Inicializando i com '3' porque a matriz points
         % já possui duas linhas. O próximo ponto se encontrará
         % na linha 3.
    
    while xm < R(1)   %
        points(i,:) = [xm zrr(xm,m,b)];
        
        xm = xm+dx;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    
    while zm < R(2)   %
        points(i,:) = [xrr(zm,m,b) zm];
        
        zm = zm+dz;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    %=========================FINAL DO CASO 1=================================
    
    %======================COEF. ANGULAR E LINEAR%======================%
    %==============================CASO 2===============================%
    %       Caso em que a FONTE está MAIS a ESQUERDA e MAIS ABAIXO que o RECEPTOR.
    
elseif S(1)<=R(1) && S(2)>=R(2)
    m = (R(2)-S(2))/(R(1)-S(1));            %Coef. angular
    b = S(2) - m*S(1);                      %Coef. linear
    xm = (fix(S(1)/dx) +1)*dx;              %   xs<xr
    zm = (fix(S(2)/dz))*dz;                 %   zs>zr
    
    points = [S;R];
    
    i=3;
    while xm < R(1)   %
        p1 = [xm zrr(xm,m,b)];
        points(i,:) = p1;
        
        xm = xm+dx;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    
    while zm > R(2)   %
        p2 = [xrr(zm,m,b) zm];
        points(i,:) = p2;
        
        zm = zm-dz;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    %=====================COEF. ANGULAR E LINEAR%======================%
    %===========================CASO 3=================================%
    
    %       Caso em que a FONTE está MAIS a DIREITA e MAIS ACIMA que o RECEPTOR.
    
elseif S(1)>=R(1) && S(2)<=R(2)
    m = (R(2)-S(2))/(R(1)-S(1));            % Coef. angular
    b = S(2) - m*S(1);                      % Coef. linear
    xm = (fix(S(1)/dx))*dx;                 %    xs>xr
    zm = (fix(S(2)/dz) +1)*dz;              %    zs<zr
    
    points = [S;R];
    
    i=3;
    while xm > R(1)   %
        p1 = [xm z(xm,m,b)];
        points(i,:) = p1;
        
        xm = xm-dx;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    
    while zm < R(2)   %
        p2 = [x(zm,m,b) zm];
        points(i,:) = p2;
        
        zm = zm+dz;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    
else
    
    %=====================COEF. ANGULAR E LINEAR%======================%
    %%============================CASO 4===============================%
    %       Caso em que a FONTE está MAIS a DIREITA e MAIS ABAIXO que o RECEPTOR.
    
    m = (R(2)-S(2))/(R(1)-S(1)); %  Coef. angular
    b = S(2) - m*S(1);           %  Coef. linear
    xm = (fix(S(1)/dx))*dx;      %      xs>xr
    zm = (fix(S(2)/dz))*dz;      %      zs>zr
    
    points = [S;R];
    
    i=3;
    while xm > R(1)   %
        p1 = [xm z(xm,m,b)];
        points(i,:) = p1;
        
        xm = xm-dx;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    
    while zm > R(2)   %
        p2 = [x(zm,m,b) zm];
        points(i,:) = p2;
        
        zm = zm-dz;  %Contador para sair do loop
        i = i+1;     %index da matriz de pontos
    end
    %=======================FINAL DO CASO 4 =======================%
end

%   O cálculo começa a  partir daqui, o código anterior foi apenas pra levar em conta
%  as diferentes situações de posições relativas entre fonte e receptor.

points = sortrows(points,1); % Organizando em ordem crescente de x
                             % todos os pontos do raio que interceptam
                             % a malha.


%================ CRIANDO UM VETOR DE ZEROS ================================%
d= zeros(1,nx*nz);   % Esse vetor tem 1 linha para cada raio de uma mesma fonte
                     % e o número de colunas é o número de células
                     % na malha

for i=1:length(points(:,1))-1
    pm = (points(i,:)+points(i+1,:))/2;  % Ponto médio auxiliar: utilizado
                                         % para se obter o índice
                                         % da célula na qual o raio está
                                         % passando.
    
    n = cell_numberrr(indexrr(pm,dx,dz),nx); % Índice da célula.
    
    d(n) = distancerr(points(i,:),points(i+1,:)); % Cálculo do tamanho do raio
                                                % dentro da n-ésima célula.
end

end