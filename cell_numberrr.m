function ans = cell_number(A,nx)
%%  Function cell_number: tem como saída o número da enésima célula 
%%       tendo como entrada as cordenadas da célula A=(i,j) e o número
%%       de colunas nx.

ans = (A(1)-1)*nx + A(2);
end