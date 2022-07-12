function [stat] = mlp_test (net , dataset) ;
% Assure la phase de test d'un MLP
% MLP_TEST (net, pattern, output) compare les résultats du MLP 'net' pour 
% chaque pattern 'pattern' présenté avec les sorties 'output' attendues.
% Paramètres :
%   net      : Réseau MLP dont l'apprentissage est déjà effectué
%   patterns : Matrice contenant les patterns du jeu d'apprentissage
%                [n_pattern x dim_pattern] avec dim_pattern = net.dim_input
%   output   : Matrice contenant les classes correspondant aux patterns
%                [n_pattern x n_class] avec n_class = net.dim_output
% Résultats :
%   stat : Structure contenant les statistiques en test
%       stat.error       : Erreur quadratique moyenne
%       stat.err_pattern : Nombre de patterns mal classifiés
%       stat.mat_conf    : Matrice de confusion

% Initialisation des statistiques pour la présentation
stat.error        = 0.0 ;
stat.err_pattern  = 0 ;
stat.mat_conf     = zeros (net.dim_output,net.dim_output) ;

% Test de chaque pattern
%n_pattern = size(pattern,1) ;
for i = 1:dataset.n_pattern
    
    % Propagation du pattern au travers du MLP
    net_output = mlp_propagation(net , dataset.pattern(i,:)) ;
    
    %
    % Analyse de la sortie
    %
    
    % Erreur quadratique moyenne
    error_output = dataset.output(i,:) - net_output ;
    stat.error = stat.error + sum(error_output.^2) ;
        
    % Erreur de classification : 
    %   recherche de la sortie maximale --> classe attribuée
    [v , cl] = max(net_output) ;
    stat.err_pattern = stat.err_pattern + 1*(cl~=dataset.class(i)+1) ;
        
    % Matrice de confusion
    stat.mat_conf(dataset.class(i)+1,cl) = stat.mat_conf(dataset.class(i)+1,cl) + 1 ;

end