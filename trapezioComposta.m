function [I, e] = trapezioComposta(f, a, b, n)
% Para n=1 temos a regra do trapezio simples
% Intervalos igualmente espaçados
h = (b-a)/n;
I = f(a)/2+f(b)/2;
for i=1 : n-1
   I = I + f(a+i*h); 
end
I = I*h;

% Criar o vetor com valores de x
if n == 1 
    x = [a,(a+b)/2,b];
    % Pode-se até criar vários pontos, assim poderemos escolher o máximo dos módulos
    % das diferenças divididas da ordem 2, mas assim não faz sentido para
    % mim, pois está estimando erro de um trapézio compsto e não do simples
else
    % Tem que garantir que n > 1 ??? Porque se passar n < 0 dá ruim
    x = a:((b-a)/n):b; % De a até b com passo estabelecido igualmente espaçado
end
    x = x'; % Vetor coluna
    y = f(x);
    T = TabelaDiferencasDivididas(x,y);
    % Pegar de T o maior valor em módulo da coluna 3(na verdade ordem 2) 
    % Isso porque queremos estimar a derivada segunda f''
    maxDD = max(abs(T(:,3)));
    f2zeta=maxDD*2; % Ajuste 2!
    e = abs(-(b-a)*((h^2)/12)*f2zeta);
end