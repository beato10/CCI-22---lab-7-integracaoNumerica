function [I, qtdeRec, qtdeDiv] = quadAdaptativaTeste(f, a, b, opcao, epsilon)
[I, qtdeRec, qtdeDiv] = auxiliarTeste(f, a, b, opcao, epsilon, a, b);
end

%
% Função recursiva auxiliar
function [I, qtdeRec, qtdeDiv] = auxiliarTeste(f, a, b, opcao, epsilon, a_original, b_original)

if opcao == 1
    h = b - a; 
    m = (a + b)/2; 
    P = h*(f(a) + f(b))/2;
    Q = (h/2)*(f(a) + f(m))/2 + (h/2)*(f(m) + f(b))/2;
    p = 2; 
    fator_qtdeDiv = 2; 
    
elseif opcao == 2
    h = (b - a)/2;
    m = (a + b)/2;
    P = h*(f(a) + 4*f(a + h) + f(b))/3; 
    Q = (h/2)*(f(a) + 4*f(a + h/2) + f(m))/3 + (h/2)*(f(m) + 4*f(m + h/2) + f(b))/3;
    p = 4;  
    fator_qtdeDiv = 4;
    
elseif opcao == 3
    h = (b - a)/3;
    m = (a + b)/2;
    P = 3*h*(f(a) + 3*f(a + h) + 3*f(a+ 2*h) + f(b))/8; 
    Q = 3*(h/2)*(f(a) + 3*f(a + h/2) + 3*f(a + h) + f(m))/8 + 3*(h/2)*(f(m) + 3*f(m + h/2) + 3*f(m + h) + f(b))/8;
    p = 4; 
    fator_qtdeDiv = 6; 
    
elseif opcao == 4 
    h = (b - a)/4;
    m = (a + b)/2;
    P = 2*h*(7*f(a) + 32*f(a + h) + 12*f(a + 2*h) + 32*f(a + 3*h) + 7*f(b))/45; 
    Q = h*(7*f(a) + 32*f(a + h/2) + 12*f(a + h) + 32*f(a + 3*h/2) + 7*f(m))/45 + h*(7*f(m) + 32*f(m + h/2) + 12*f(m + h) + 32*f(m + 3*h/2) + 7*f(b))/45;
    p = 6; 
    fator_qtdeDiv = 8; 

else
    sprintf('Opção inválida!')
    P = 0; Q = 0;
    p = 1; h = 0; m = 0; fator_qtdeDiv = 0;
end

if abs(P-Q) > epsilon*((2^p)-1)*h/(b_original-a_original)
   [I1, qtdeRec1, qtdeDiv1] = auxiliarTeste(f, a, m, opcao, epsilon, a_original, b_original);
   [I2, qtdeRec2, qtdeDiv2] = auxiliarTeste(f, m, b, opcao, epsilon, a_original, b_original);
   qtdeDiv = qtdeDiv1 + qtdeDiv2;
   qtdeRec = qtdeRec1 + qtdeRec2 + 2;
   I = I1 + I2;
else
   qtdeDiv = fator_qtdeDiv;
   qtdeRec = 0;
   I = Q;
end
end