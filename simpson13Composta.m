function [I, e] = simpson13Composta(f, a, b, n)
% n é o número de divisões do intervalo que deve ser par para funcionar

% Para n=2 temos a regra de simpson simples
if rem(n,2) ~= 0
    sprintf('error')
    I = Inf; % Tem como sair daqui sem atribuir valores
    e = Inf;
else
    % Intervalos igualmente espaçados
    h = (b-a)/n;
    I = f(a)+f(b);
    for i=1 : n-1
        if rem(i,2) == 0
            I = I + 2*f(a+i*h); 
        else
            I = I + 4*f(a+i*h); 
        end
    end
    I = I*h/3;

    % Criar o vetor com valores de x para o caso simples e composto
    % Estimativa de erro da integração numérica
    if n == 2 
        x = [a,a+(b-a)/4,a+2*(b-a)/4,a+3*(b-a)/4,b];
    else
        % Precisa garantir n > 2 ??? Porque N < 0 dá ruim
        x = a:((b-a)/n):b; % De a até b com passo estabelecido
    end
    x = x'; % Vetor coluna, por que vetor coluna ?
    y = f(x);
    T = TabelaDiferencasDivididas(x,y);
    % Pegar de T o maior valor em módulo da coluna 5(na verdade ordem 4) 
    % Isso porque queremos a derivada quarta f''''
    maxDD = max(abs(T(:,5)));
    f4zeta=maxDD*24; % Ajuste 4!
    % Erro nos interessa em módulo
    e = abs(-(b-a)*((h^4)/180)*f4zeta);
 
end

end