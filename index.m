function calculateCellIndexInXAndZDirections = index(P,cellLengthInXDirection,cellLengthInZDirection)
  %  P= É um vector de duas componentes. P é a soma da componente dos ultimos 2 pontos, divido por 2

  indexInZDirection = (fix(P(2)/cellLengthInZDirection)+1);
  indexInXDirection = (fix(P(1)/cellLengthInXDirection)+1);

  calculateCellIndexInXAndZDirections=[indexInZDirection indexInXDirection];
end
