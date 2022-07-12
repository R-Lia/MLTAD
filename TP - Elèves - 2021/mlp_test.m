function [stat] = mlp_test (net , dataset) ;
% Assure la phase de test d'un MLP
% MLP_TEST (net, pattern, output) compare les r�sultats du MLP 'net' pour 
% chaque pattern 'pattern' pr�sent� avec les sorties 'output' attendues.
% Param�tres :
%   net      : R�seau MLP dont l'apprentissage est d�j� effectu�
%   patterns : Matrice contenant les patterns du jeu d'apprentissage
%                [n_pattern x dim_pattern] avec dim_pattern = net.dim_input
%   output   : Matrice contenant les classes correspondant aux patterns
%                [n_pattern x n_class] avec n_class = net.dim_output
% R�sultats :
%   stat : Structure contenant les statistiques en test
%       stat.error       : Erreur quadratique moyenne
%       stat.err_pattern : Nombre de patterns mal classifi�s
%       stat.mat_conf    : Matrice de confusion

% Initialisation des statistiques pour la pr�sentation
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
    %   recherche de la sortie maximale --> classe attribu�e
    [v , cl] = max(net_output) ;
    stat.err_pattern = stat.err_pattern + 1*(cl~=dataset.class(i)+1) ;
        
    % Matrice de confusion
    stat.mat_conf(dataset.class(i)+1,cl) = stat.mat_conf(dataset.class(i)+1,cl) + 1 ;

end