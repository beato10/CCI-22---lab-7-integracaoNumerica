function [I, qtdeRec, qtdeDiv] = quadAdaptativa(f, a, b, opcao, epsilon)
[I, qtdeRec, qtdeDiv] = auxiliar(f, a, b, opcao, epsilon, a, b);
% epsilon é erro máximo  permitido
% opcao especifica o método a ser utilizado em toda integração
% qtdeRec é o número de chamadas recursivas e estima o tempo total gasto
% pois funções de cálculo gastam tempo constante
% qtdeDiv é o número de divisões não necessariamente equidistantes no
% intervalo [a,b] original dado até se atingir critério de parada de modo
% a melhorar as aproximações pela quadratura adaptativa
% Na fórmula do erro, a e b são do intervalo original
end

%
% Função recursiva auxiliar
function [I, qtdeRec, qtdeDiv] = auxiliar(f, a, b, opcao, epsilon, a_original, b_original)

%Opcao: 1 -> regra simples do trapezio
%       2 -> regra simples simpson 1/3
%       3 -> regra simples simpson 3/8
%       4 -> newton-cotes de ordem 4
%       5 -> retornar erro
h = b-a; % Intervalo atual
m = (a+b)/2; % Meio do intervalo

if opcao == 1
    %h = b - a;
    % Integro todo intervalo, daí acho P pelo trapézio simples
    P = h*(f(a)+f(b))/2;
    % Divido o intervalo no meio e integro as duas partes separadamente.
    % Daí acho Q
    % Abaixo usei duas vezes trapezio simples. Se preferir pode usar
    % trapezio composto para calcular Q
    Q = (h/2)*(f(a)+f(m))/2 + (h/2)*(f(m)+f(b))/2;
    
    % Fatores especificos da regra do trapezio
    p = 2; % Fator para o criterio de parada
    fator_qtdeDiv = 2; % Fator para o cálculo da qtde de divisões do itervalo original
elseif opcao == 2
    %h = (b-a)/2;
    % Integro todo intervalo, daí acho P pela regra simples de Simpson 1/3
    P = h*(f(a) + 4*f(m) + f(b))/3; % igualmente espaçados
    % Divido o intervalo no meio e integro as duas partes separadamente.
    % Daí acho Q
    % Abaixo usei duas vezes simpson simples. Se preferir pode usar
    % trapezio composto para calcular Q
    % Observação: h/2 é o novo intervalo todo da recursão
    Q = (h/2)*(f(a)+4*f(a+(m-a)/2)+f(m))/3 + (h/2)*(f(m)+4*f(m+(b-m)/2)+f(b))/3;
    
    % Fatores especificos da regra do trapezio
    p = 4; % Fator para o criterio de parada
    fator_qtdeDiv = 4; % Fator para o cálculo da qtde de divisões do itervalo original
elseif opcao == 3
    % Integro todo intervalo, daí acho P pela regra simples de Simpson 3/8
    P = 3*h*(f(a) + 3*f(a+(b-a)/3) + 3*f(a+2*(b-a)/3) + f(b))/8; % igualmente espaçados
    % Divido o intervalo no meio e integro as duas partes separadamente.
    % Daí acho Q
    % Abaixo usei duas vezes simpson simples. Se preferir pode usar
    % trapezio composto para calcular Q
    Q = 3*(h/2)*(f(a)+3*f(a+(m-a)/3) + 3*f(a+2*(m-a)/3) + f(m))/8 + 3*(h/2)*(f(m)+3*f(m+(b-m)/3) + 3*f(m+2*(b-m)/3) + f(b))/8;
    
    % Fatores especificos da regra do trapezio
    p = 4; % Fator para o criterio de parada
    fator_qtdeDiv = 6; % Fator para o cálculo da qtde de divisões do itervalo original
elseif opcao == 4 
    % Integro todo intervalo, daí acho P pela regra simples de Newton-Cotes
    % de ordem 4
    P = 2*h*(7*f(a) + 32*f(a+(b-a)/4) + 12*f(a+2*(b-a)/4) + 32*f(a+3*(b-a)/4) + 7*f(b))/45; % igualmente espaçados
    % Divido o intervalo no meio e integro as duas partes separadamente.
    % Daí acho Q
    % Abaixo usei duas vezes simpson simples. Se preferir pode usar
    % trapezio composto para calcular Q
    Q = 2*h*(7*f(a) + 32*f(a+(m-a)/4) + 12*f(a+2*(m-a)/4) + 32*f(a+3*(m-a)/4) + 7*f(m))/45 + 2*h*(7*f(m) + 32*f(m+(b-m)/4) + 12*f(m+2*(b-m)/4) + 32*f(m+3*(b-m)/4) + 7*f(b))/45;
    
    % Fatores especificos da regra do trapezio
    p = 6; % Fator para o criterio de parada
    fator_qtdeDiv = 8; % Fator para o cálculo da qtde de divisões do itervalo original
else
    sprintf('error')
end

if abs(P-Q) > epsilon*((2^p)-1)*h/(b_original-a_original)
   % Chamo duas recursoes, sendo uma para cada metade do intervalo atual
   % Critério de parada: epsilon no intervalo todo ?
   [I1, qtdeRec1, qtdeDiv1] = auxiliar(f, a, m, opcao, epsilon, a_original, b_original);
   [I2, qtdeRec2, qtdeDiv2] = auxiliar(f, m, b, opcao, epsilon, a_original, b_original);
   qtdeDiv = qtdeDiv1 + qtdeDiv2;
   qtdeRec = qtdeRec1 + qtdeRec2 + 2;
   I = I1 + I2;
else
   qtdeDiv = fator_qtdeDiv;
   qtdeRec = 0;
   I = Q;
end
end