function out = index(P,cellLengthInXDirection,cellLengthInZDirection)
  %  Função que calcula os índices das células nas direções X e Z
  %  P= É um vector de duas componentes. P é a soma da componente dos ultimos 2 pontos, divido por 2

  rowIndex = (fix(P(2)/cellLengthInZDirection)+1);
  collumnIndex = (fix(P(1)/cellLengthInXDirection)+1);

  out=[rowIndex collumnIndex];
end
