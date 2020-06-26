function ans = index(A,deltax,deltaz)
%%  Função específica para quando xr>xs e zr>zs
%%  'A' é um vector de duas componentes.
%%

i = (fix(A(2)/deltaz)+1);
j = (fix(A(1)/deltax)+1);

ans=[i j];
end
