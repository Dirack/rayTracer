function out = index(P,deltax,deltaz)
%  Função que calcula os índices das células nas direções X e Z

%INPUT's:
%  P= É um vector de duas componentes. P é a soma da componente dos ultimos 2 pontos, divido por 2
% deltax= comprimento da célula na direção X
% deltaz= comprimento da célula na direção Z

i1 = (fix(P(2)/deltaz)+1);
i2 = (fix(P(1)/deltax)+1);

out=[i1 i2]; % Saídas i1 e i2 representam respectivamente linha e coluna do ponto em questão
end
