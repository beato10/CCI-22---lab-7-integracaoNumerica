function T = TabelaDiferencasDivididas(x, y)
    n = length(x);
    % Definir T inicialmente como matriz nula (de zeros)
    T = zeros(n);
    % Preencher a primeira coluna de T
    for i=1 : n
       T(i,1) = y(i); 
    end
    % Preencher as demais colunas de T
    k = 0; % Usado para controlar até onde vamos em cada coluna (linha maxima)
    for j=2 : n % coluna
        for i=1 : n-1-k
            T(i,j) = (T(i+1,j-1)-T(i,j-1))/(x(i+1+k)-x(i));
        end
        k = k + 1;
    end 
end