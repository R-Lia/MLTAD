function output = mlp_propagation (net , pattern)
% Propagation d'un pattern au travers d'un MLP.
% MLP_PROPAGATION (net,pattern) retourne la sortie du r�seau 'net' quand le
% pattern 'pattern' est pr�sent� � son entr�e.
% Param�tres :
%   net     : Structure contenant la d�finition et les poids du MLP
%   pattern : Pattern en entr�e [1 x net.dim_input]
% R�sultats :
%   output  : R�sultat du r�seau [1 x net.dim_output]
% Contraintes :
%   Les poids synaptiques du r�seau doivent �tre initialis�s (en g�n�ral,
%   suite � un apprentissage).

% Propagation du pattern au travers de la couche cach�e
hidden_output = layer_propagation (pattern , net.IH) ;

% Propagation du r�sultat de la couche cach�e au travers de la couche de
% sortie
output = layer_propagation (hidden_output , net.HO) ;
    
end