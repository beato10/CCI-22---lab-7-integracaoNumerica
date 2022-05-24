% Questao 2
% Testar com um exemplo do quiz

%F = @(x) (1./(x.^3 - 2*x - 5)); a = 0; b = 2;                          %%% F1
%F = @(x) (exp(3*x).*(sin(2*x))); a = 0; b = pi/4;                      %%% F2
%F = @(x) (13*(x-x.^2).*exp(-3*x/2)); a = 0; b = 4;                     %%% F3

% observacao na F3 tem que ter .* tambem ?????

t = zeros(5,1);
fprintf('\nquad MatLab\n');
for j = 1 : 5
    tic;
    I = quad(F, a, b);
    t(j,1) = toc;
end
tempoQuad = mean(t(3:5, 1));
fprintf('Integral: %.15f, tempo: %f s\n', I,tempoQuad);


t = zeros(5,1);
fprintf('\nQuadratura Adaptativa Regra simples Simpson 1/3\n');
for j = 1 : 5
    tic;
    [I, qtdeRec, qtdeDiv] = quadAdaptativa(F, a, b, 2, 10^-6);
    t(j,1) = toc;
end
tempoQuadAdaptativa = mean(t(3:5, 1));
fprintf('Integral: %.15f, qtdeRec: %d, qtdeDiv: %d, tempo: %f s\n', I, qtdeRec, qtdeDiv, tempoQuadAdaptativa);


t = zeros(5,1);
fprintf('\nRegra composta Simpson 1/3 com n = qtdeDiv\n');
for j = 1 : 5
    tic;
    [I, e] = simpson13Composta(F, a, b, qtdeDiv);
    t(j,1) = toc;
end
tempoSimpson13Composta = mean(t(3:5, 1));
fprintf('Integral: %.15f, erro: %.15f, tempo: %f s\n', I, e, tempoSimpson13Composta);


t = zeros(5,1);
fprintf('\nRegra composta Simpson 1/3 com n = nNecessario\n');
nNecessario = qtdeDiv; 
for j = 1 : 5
    tic;
    [I, e] = simpson13Composta(F, a, b, nNecessario);
    t(j,1) = toc;
end
tempoSimpson13Composta = mean(t(3:5, 1));
fprintf('Integral: %.15f, erro: %.15f\n', I, e);

figure;
grid on;
hold on;
fplot(F,[a,b]);
xlabel('x');
ylabel('f(x)');
title('Integração numérica');
legend('f(x)'); 







