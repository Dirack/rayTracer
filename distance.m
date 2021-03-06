%%   Function Distance
%%      It calculates the distance between two points in a 2-d euclidean
%%      space.
%%      Inputs: 2 components vectors A e B
%%      Output: distance between the points A e B
function s = distance(A,B)

if length(A)==2 && length(B)==2                     % Comprimento dos vetores A e B devem ser iguais
    s = sqrt((A(1)-B(1)).^2 + (A(2)-B(2)).^2);      % ou seja, devem ter um par de coordenadas
else                                                % X e Z.
    error('Wrong input format')
end
