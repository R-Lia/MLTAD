function [neuron , stat] = neuron_learning (neuron , dataset , learning_rate , mse , n_epochs)
% Assure l'apprentissage d'un neurone.
% NEURON_LEARNING (neuron, pattern, class, n_epochs, learning_rate) utilise le
% jeu de données 'dataset' en entrée pour réaliser un apprentissage 
% supervisé du neurone 'neuron'.
% L'apprentissage est paramétré par le nombre de présentation du jeu
% complet de patterns ainsi que par le taux d'apprentissage initial.
% Paramètres :
%   * neuron  : Neurone dont l'apprentissage est à réaliser
%   * dataset : Jeu de patterns servant à l'apprentissage
%       - pattern  : Matrice contenant les patterns du jeu d'apprentissage
%                       [n_pattern x dim_pattern] avec dim_pattern = net.dim_input
%       - class    : Matrice contenant les classes correspondant aux patterns
%                       [n_pattern x n_class] avec n_class = net.dim_output
%   * learning_rate : Taux d'apprentisage initial
%   * mse           : Erreur quadratique moyenne à attendre
%   * n_epochs      : Nombre maximum de présentation du jeu d'apprentissage
% Résultats :
%   neuron : Neurone mis à jour par l'apprentissage
%           - weights : Poids synaptiques du neurone
%                   [dim_pattern+1 x 1]
%   stat : Structure contenant les statistiques d'apprentissage de chaque
%   epoch
%       stat(epoch).mse         : Erreur quadratique moyenne
%       stat(epoch).err_pattern : Nombre de patterns mal classifiés
%       stat(epoch).mat_conf    : Matrice de confusion

% Nombre de classes en sortie = 2 (neurone séparateur)
n_class = 2 ;

% Vérification de la taille des données proposées pour l'apprentissage
if dataset.dim_input ~= neuron.dim_input
    disp ('ERROR : Incohérence de dimensions en entrée') ;
    return ;
end   
if dataset.n_class ~= n_class
    disp ('ERROR : Incohérence de dimensions en sortie') ;
    return ;
end

% Stockage des paramètres d'apprentissage du réseau
neuron.learning_rate = learning_rate ;

% Paramètres internes de l'algorithme
pattern_order = 'random' ;      % Ordre de présentation des patterns ('random')

% Allocation & Initialisation aléatoire des poids synaptiques du réseau
neuron.weights = rand([neuron.dim_input+1 1]) ;

% Initialisation des statistiques d'apprentissage
stat = [] ;

% Boucle de présentation du jeu d'apprentissage
for epoch = 1:n_epochs
   
    % Ordre de présentation des patterns
    if (pattern_order == 'random')
        tab = randperm(dataset.n_pattern) ;
    else
        tab = 1:dataset.n_pattern ;
    end
    
    % Initialisation des statistiques pour la présentation
    stat_epoch.mse          = 0.0 ;
    stat_epoch.err_pattern  = 0 ;
    stat_epoch.mat_conf     = zeros (n_class,n_class) ;
    
    %
    % Présentation d'un pattern
    %
    for i = 1:dataset.n_pattern
    
        % Sélection du pattern à présenter
        p = tab(i) ;
        
        % Pattern à présenter en entrée 
        patt_in  = dataset.pattern(p,:) ;
        
        % Sortie désirée (neurone séparateur : classe 0 -> -1, classe 1 -> 1
        patt_out = dataset.class(p,:)*2-1 ;
       
        %
        % Propagation complète du pattern (entrée --> sortie)
        %
        
        % Propagation avec tanh ou sigmoide ou seuil 
        net_output = ...
        
        % Calcul de l'erreur constatée en sortie
        error_output = patt_out - net_output ;
               
        % Ajustement effectif des poids
        neuron.weights = ...
        
        %
        % Mise à jour des statistiques
        %
        
        % Erreur quadratique moyenne
        stat_epoch.mse = stat_epoch.mse + sum(error_output.^2) ;
        
        % Erreur de classification
        cl = (net_output >= 0.0)*1 ;
        stat_epoch.err_pattern = stat_epoch.err_pattern + 1*(cl~=dataset.class(p)) ;
        
        % Matrice de confusion
        stat_epoch.mat_conf(dataset.class(p)+1,cl+1) = stat_epoch.mat_conf(dataset.class(p)+1,cl+1) + 1 ;

    end


    % Erreur quadratique moyenne
    stat_epoch.mse = stat_epoch.mse / dataset.n_pattern ;

    stat = [stat ; stat_epoch] ;

    % Affichage (pour un apprentissage long)
    if (mod(epoch,10) == 0)
        disp(sprintf('Epoch : %d/%d (%d/%d) %f\n' , epoch , n_epochs , stat_epoch.err_pattern , dataset.n_pattern , stat_epoch.mse)) ;
    end
    
    % Critère d'arrêt basé sur l'erreur quadratique moyenne
    if (stat_epoch.mse <= mse)
        break ;
    end
    
end
    
% Stockage de l'état des paramètres relatifs aux critères d'arrêt
neuron.n_epochs = epoch ;
neuron.mse      = stat_epoch.mse ;
