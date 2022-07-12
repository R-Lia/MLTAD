function plot_hyperplane (weights , xr , yr)
% Trace l'hyperplan de séparation correspondant aux poids synaptiques d'un
%   neurone dans une répresentation en 2 dimensions
% Paramètres :
%   * weights  : Vecteur contenant les poids synaptiques correspondant à 
%                   l'hyperplan de séparation à représenter (taille de
%                   vecteur : dim_input+1 >= 3)
%   * xr : Bornes de la représentation (en X)
%   * yr : Bornes de la représentation (en Y)

% Tracé de l'hyperplan en utilisant les bornes comme support
if (weights(2) == 0)
    % Hyperplan "vertical"
    plot ([-weights(3)/weights(1) -weights(3)/weights(1)] , [yr(1) yr(2)]) ;
else
    % Cas général
    plot ([xr(1) xr(2)] , [(-weights(3)-weights(1)*xr(1))/weights(2) (-weights(3)-weights(1)*xr(2))/weights(2)]) ;    
end

