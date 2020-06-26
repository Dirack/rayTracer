function ans = cell_number(in,Nx)
%  Função que enumera a célula em questão, necessária quando for realizado a lei de snell
%  Tem como saída o número da n-ésima célula 
%   INPUT's:  
%   Tem como entrada as cordenadas da célula in=(i,j) e o número de colunas nx.
%      in(1) = índice da linha da célula
%      in(2) = índice da coluna da célula
%    Nx = Número de células na direção X.


ans = (in(1)-1)*Nx + in(2);


end
