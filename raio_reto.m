function D = raio_reto(mod, ss, rr)
 % Esta função tem como entrada as matrizes mod(Configuração da malha), 
 % ss e rr (posições de fonte e receptor respectivamente), e tem como saída a matriz D
 % no qual suas linhas representam os raios de cada par fonte-receptor
 % e as colunas, as distancias do raios em cada célula.
 % Esta função usa a funçao 'raio_unico' - que calcula a distância percorrida pelo
 % raio em cada célula para um único par fonte-receptor - de forma
 % iterativa.  
 % update: 25-05-2017

nx = mod(2,3);       % Número de células na dimensão x
nz = mod(1,3);       % Número de células na dimensão z

nr = length(rr(:,1)); %Quantidade de receptores
ns = length(ss(:,1)); %Quantidade de fontes
D = zeros(ns*nr,nx*nz);  %Matriz output com dimensões 'ns*nr x nx*nz'

i = 1;
for j=1:ns
    for k=1:nr
        D(i,:) = raio_unico(mod,ss(j,:),rr(k,:));
        i = i+1;
    end
end
end
