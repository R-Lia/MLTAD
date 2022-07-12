function out = sigmoid (x)
% Fonction sigmoïde (retour entre -1 et 1)

% Pente
lambda = 1.0 ;

out = (1/(1+exp(-lambda*x)))*2-1 ;