function [net , stat] = mlp_learning (net , dataset , learning_rate , mse , n_epochs)
% Assure l'apprentissage d'un MLP via une rétropropagation classique
% MLP_LEARNING (net, pattern, class, n_epochs, learning_rate) utilise les
% patterns 'patterns' en entrée et les classes 'classes' associées à ces 
% patterns pour réaliser un apprentissage supervisé du réseau MLP 'net'.
% L'apprentissage est paramétré par le nombre de présentation du jeu
% complet de patterns ainsi que par le taux d'apprentissage initial.
% Paramètres :
%   * net     : Réseau MLP dont l'apprentissage est à réaliser
%   * dataset : Jeu de patterns servant à l'apprentissage
%       - pattern  : Matrice contenant les patterns du jeu d'apprentissage
%                       [n_pattern x dim_pattern] avec dim_pattern = net.dim_input
%       - class    : Matrice contenant les classes correspondant aux patterns
%                       [n_pattern x n_class] avec n_class = net.dim_output
%   * learning_rate : Taux d'apprentisage initial
%   * mse           : Erreur quadratique moyenne à attendre
%   * n_epochs      : Nombre maximum de présentation du jeu d'apprentissage
% Résultats :
%   net  : Réseau mis à jour par l'apprentissage
%           - IH : Poids synaptiques entre couche d'entrée et couche cachée
%                   [dim_pattern+1 x n_hidden_neurons]
%           - HO : Poids synaptiques entre couche cachée et couche de sortie
%                   [n_hidden_neurons+1 x n_class]
%   stat : Structure contenant les statistiques d'apprentissage de chaque
%   epoch
%       stat(epoch).mse         : Erreur quadratique moyenne
%       stat(epoch).err_pattern : Nombre de patterns mal classifiés
%       stat(epoch).mat_conf    : Matrice de confusion

% Vérification de la taille des données proposées pour l'apprentissage
if dataset.dim_input ~= net.dim_input
    disp ('ERROR : Incohérence entre dimension des patterns et nombre de neurones de la couche d''entrée') ;
    return ;
end   
if dataset.n_class ~= net.dim_output
    disp ('ERROR : Incohérence entre dimension des classes et nombre de neurones de la couche de sortie') ;
    return ;
end

% Stockage des paramètres d'apprentissage du réseau
net.learning_rate = learning_rate ;

% Paramètres internes de l'algorithme
pattern_order = 'random' ;      % Ordre de présentation des patterns ('random')

% Allocation & Initialisation aléatoire des poids synaptiques du réseau
net.IH = rand([net.dim_input+1 net.dim_hidden]) ;
net.HO = rand([net.dim_hidden+1 net.dim_output]) ;

% Initialisation des statistiques d'apprentissage
stat = [] ;

% Boucle de présentation du jeu d'apprentissage
% Critères d'arrêt : epoch > n_epochs ou stat_epoch.mse <= mse
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
    stat_epoch.mat_conf     = zeros (net.dim_output,net.dim_output) ;
    
    %
    % Présentation d'un pattern
    %
    for i = 1:dataset.n_pattern
    
        % Sélection du pattern à présenter
        p = tab(i) ;
        
        % Pattern en entrée & sortie souhaitée
        patt_in = dataset.pattern(p,:) ;
        patt_out = dataset.output(p,:) ;
       
        % Propagation complète du pattern (entrée --> cachée --> sortie)
        hidden_output = layer_propagation (patt_in , net.IH) ;
        net_output = layer_propagation (hidden_output , net.HO) ;

        % Calcul de l'erreur constatée en sortie
        error_output = patt_out - net_output ;
        
        % Calcul de l'ajustement des poids de HO (couche cachée -> couche de sortie)
        delta_HO = ...
              
        % Calcul de l'ajustement des poids de IH (couche d'entrée -> couche cachée)
        delta_IH = ...
        
        % Ajustement effectif des poids
        net.HO = ...
        net.IH = ...
        
        %
        % Mise à jour des statistiques
        %
        
        % Erreur quadratique moyenne
        stat_epoch.mse = stat_epoch.mse + sum(error_output.^2) ;
        
        % Erreur de classification
        [v , cl] = max(net_output) ;
        stat_epoch.err_pattern = stat_epoch.err_pattern + 1*(cl~=dataset.class(p)+1) ;
        
        % Matrice de confusion
        stat_epoch.mat_conf(dataset.class(p)+1,cl) = stat_epoch.mat_conf(dataset.class(p)+1,cl) + 1 ;

    end

    % Erreur quadratique moyenne
    stat_epoch.mse = stat_epoch.mse / dataset.n_pattern ;

    stat = [stat ; stat_epoch] ;

    % Affichage (pour un apprentissage long)
    if (mod(epoch,50) == 0)
        disp(sprintf('Epoch : %d/%d (%d/%d) %f\n' , epoch , n_epochs , stat_epoch.err_pattern , dataset.n_pattern , stat_epoch.mse)) ;
    end
    
    % Critère d'arrêt basé sur l'erreur quadratique moyenne
    if (stat_epoch.mse <= mse)
        break ;
    end
    
end
    
% Stockage de l'état des paramètres relatifs aux critères d'arrêt
net.n_epochs = epoch ;
net.mse      = stat_epoch.mse ;
