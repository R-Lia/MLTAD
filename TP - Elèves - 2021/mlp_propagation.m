function output = mlp_propagation (net , pattern)
% Propagation d'un pattern au travers d'un MLP.
% MLP_PROPAGATION (net,pattern) retourne la sortie du réseau 'net' quand le
% pattern 'pattern' est présenté à son entrée.
% Paramètres :
%   net     : Structure contenant la définition et les poids du MLP
%   pattern : Pattern en entrée [1 x net.dim_input]
% Résultats :
%   output  : Résultat du réseau [1 x net.dim_output]
% Contraintes :
%   Les poids synaptiques du réseau doivent être initialisés (en général,
%   suite à un apprentissage).

% Propagation du pattern au travers de la couche cachée
hidden_output = layer_propagation (pattern , net.IH) ;

% Propagation du résultat de la couche cachée au travers de la couche de
% sortie
output = layer_propagation (hidden_output , net.HO) ;
    
end