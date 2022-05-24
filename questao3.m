% Questao 3
%f = @(x) (1./x.^2); a = 1; b = 7;                               % f do quiz

F = @(x) (x.^3 + 2*x.^2 - 5); a = 0; b = 4;                          %%% F1
%F = @(x) (4*x.^6 - 24*x.^5 + 37*x.^4 + 2*x.^2 - 5); a = -7; b = 6;   %%% F2
%F = @(x) (sin(x)^2); a = -pi; b = pi;                                %%% F3
%F = @(x) (exp(x)); a = 0; b = 4;                                     %%% F4
%F = @(x) (sin(exp(x))); a = -5; b = 5;                               %%% F5
%F = @(x) ((sin(1./x).^2)*(cos(1./x))); a = 0.1; b = 0.4;             %%% F6
%F = @(x) (13*(x-x.^2).*exp(-3*x/2)); a = 0; b = 4;                    %%% F7

fprintf('\nRegra do Trapezio Simples\n');
[I, qtdeRec, qtdeDiv] = quadAdaptativa(F, a, b, 1, 10^-6);
fprintf('Integral: %.15f, qtdeRec: %d, qtdeDiv: %d\n', I, qtdeRec, qtdeDiv);

fprintf('\nRegra simples Simpson 1/3\n');
[I, qtdeRec, qtdeDiv] = quadAdaptativa(F, a, b, 2, 10^-6);
fprintf('Integral: %.15f, qtdeRec: %d, qtdeDiv: %d\n', I, qtdeRec, qtdeDiv);

fprintf('\nRegra simples Simpson 3/8\n');
[I, qtdeRec, qtdeDiv] = quadAdaptativa(F, a, b, 3, 10^-6);
fprintf('Integral: %.15f, qtdeRec: %d, qtdeDiv: %d\n', I, qtdeRec, qtdeDiv);

fprintf('\nNewton-Cotes de ordem 4\n');
[I, qtdeRec, qtdeDiv] = quadAdaptativa(F, a, b, 4, 10^-6);
fprintf('Integral: %.15f, qtdeRec: %d, qtdeDiv: %d\n', I, qtdeRec, qtdeDiv);


figure;
grid on;
hold on;
fplot(F,[a,b]);
xlabel('x');
ylabel('f(x)');
title('Integração numérica');
legend('f(x)'); 



