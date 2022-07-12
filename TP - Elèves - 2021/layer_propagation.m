function output = layer_propagation (input , weights)
% Propage l'entrée 'input' au travers de la couche définie par les poids
% synaptiques 'weights'. La fonction d'activation utilisée est la fonction
% 'tanh'.
% Paramètres :
%   * input   : Vecteur ligne contenant les données à propager (par
%               exemple, un pattern ou les sorties d'une couche)
%               [1 x dim_input]
%   * weights : Matrice contenant les poids synaptiques correspondant à la
%               couche dans laquelle doit s'opérer la propagation
%               [(dim_input+1) x dim_output]
% Résultats :
%   * output : Vecteur ligne de sortie de la couche après propagation
%

% Au vecteur d'entrée doit être ajoutée une entrée supplémentaire mise à 1 
% correspondant au neurone de biais  
output = ...