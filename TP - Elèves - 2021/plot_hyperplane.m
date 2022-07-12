function plot_hyperplane (weights , xr , yr)
% Trace l'hyperplan de s�paration correspondant aux poids synaptiques d'un
%   neurone dans une r�presentation en 2 dimensions
% Param�tres :
%   * weights  : Vecteur contenant les poids synaptiques correspondant � 
%                   l'hyperplan de s�paration � repr�senter (taille de
%                   vecteur : dim_input+1 >= 3)
%   * xr : Bornes de la repr�sentation (en X)
%   * yr : Bornes de la repr�sentation (en Y)

% Trac� de l'hyperplan en utilisant les bornes comme support
if (weights(2) == 0)
    % Hyperplan "vertical"
    plot ([-weights(3)/weights(1) -weights(3)/weights(1)] , [yr(1) yr(2)]) ;
else
    % Cas g�n�ral
    plot ([xr(1) xr(2)] , [(-weights(3)-weights(1)*xr(1))/weights(2) (-weights(3)-weights(1)*xr(2))/weights(2)]) ;    
end

