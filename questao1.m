% Questao 1

% Analiticamente, concluimos que integral = (exp(4) - exp(1)) / 2 
% Atenção com operações ponto a ponto
%syms x;
%f = x.*exp(x.^2)
%f_integral = int(f) % Expressao da integral
%I = int(f,1,2) % Valor da integral em limites de integracao

% Comparar os métodos trapézio composto e simpson 1/3 composto para a
% seguinte função

integralAnalitica = (exp(4) - exp(1)) / 2;
f = @(x) (x.*exp(x.^2));
a = 1; b = 2; 
erroAbsolutoTrapezioComposta = zeros(50,1);
erroAbsolutoSimpson13Composta = zeros(50,1);
erroEstimadoTrapezioComposta = zeros(50,1);
erroEstimadoSimpson13Composta = zeros(50,1);

for n = 2:2:100
    [I, e] = trapezioComposta(f, a, b, n);
    erroAbsolutoTrapezioComposta(n/2, 1) = abs(integralAnalitica - I);
    erroEstimadoTrapezioComposta(n/2, 1) = abs(e);
    [I, e] = simpson13Composta(f, a, b, n);
    erroAbsolutoSimpson13Composta(n/2, 1) = abs(integralAnalitica - I);
    erroEstimadoSimpson13Composta(n/2, 1) = abs(e);
end
n = 2:2:100;
% Item a
figure;
grid on;
hold on;
plot(n,erroAbsolutoTrapezioComposta);
plot(n,erroAbsolutoSimpson13Composta);
xlabel('n');
ylabel('Erro absoluto');
title('Integração numérica');
legend('Trapezio composta', 'Simpson 1/3 composta'); 

% Item b
figure;
grid on;
hold on;
plot(n,erroAbsolutoTrapezioComposta);
plot(n,erroEstimadoTrapezioComposta);
xlabel('n');
ylabel('Erro');
title('Integração numérica trapézio composta');
legend('Erro absoluto', 'Erro estimado'); 

% Item c
figure;
grid on;
hold on;
plot(n,erroAbsolutoSimpson13Composta);
plot(n,erroEstimadoSimpson13Composta);
xlabel('n');
ylabel('Erro');
title('Integração numérica Simpson 1/3 composta');
legend('Erro absoluto', 'Erro estimado'); 


% Para ficar top, podeiamos plotar os polinomios interpoladores e também 
% podia plotar os erros em escala logarítmica






