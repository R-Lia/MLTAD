% Structure de sortie
learning_set = [] ;
learning_set.filename    = '' ;
learning_set.dim_input   = 2 ;   % Fonction bi-dimensionnelle
learning_set.n_class     = 1 ;   % Une valeur en sortie
learning_set.n_pattern   = 64 ;  % Nombre de points de sonde
learning_set.pattern     = zeros (learning_set.n_pattern , learning_set.dim_input) ;
learning_set.class       = zeros (learning_set.n_pattern , 1) ;
learning_set.output      = zeros (learning_set.n_pattern , 1) ;

%
% Remplissage de la structure
%

nPatternPerDim = sqrt(learning_set.n_pattern) ;
x = linspace (0 , 2*pi , nPatternPerDim) ;
y = linspace (0 , 2*pi , nPatternPerDim) ;
pt = zeros (nPatternPerDim , nPatternPerDim) ;
i_pattern = 1 ;
for i = 1 : nPatternPerDim
    for j = 1 : nPatternPerDim
        learning_set.pattern(i_pattern , 1) = x(i) ;
        learning_set.pattern(i_pattern , 2) = y(j) ;
        pt(i,j) = (sin(x(i))+cos(y(j)))/2 ;
        learning_set.output (i_pattern , 1) = pt(i,j) ; 
        i_pattern = i_pattern + 1 ;
    end
end

%
% Affichage
%

figure (10) ;
mesh (x , y , pt) ;

pause (0.5) ;

% Définition de l'architecture du MLP
net = [] ;
net.dim_input  = learning_set.dim_input ;
net.dim_hidden = 6 ;
net.dim_output = learning_set.n_class ;

% Lancement de l'apprentissage
n_epochs      = 20000 ;
mse           = 0.0001 ;
learning_rate = 0.01 ;
disp ('Lancement Apprentissage MLP :') ;
disp (sprintf('  * Jeu      : %s', learning_set.filename)) ;
disp (sprintf('  * Patterns : %d', learning_set.n_pattern)) ;
disp (sprintf('  * Classes  : %d', learning_set.n_class)) ;
disp (sprintf('  * Arrêt    : %d ou %f', n_epochs , mse)) ;
disp (sprintf('  * Réseau   : %d / %d / %d', net.dim_input , net.dim_hidden , net.dim_output)) ;
[net stat] = mlp_learning (net , learning_set , learning_rate , mse , n_epochs) ;

% Affichage des statistiques
figure(1) ;
[ax,h1,h2] = plotyy (1:net.n_epochs,[stat(:).mse] ,1:net.n_epochs,[stat(:).err_pattern],'plot') ;
set(get(ax(1),'Ylabel'),'String','Erreur quadratique moyenne') ;
set(get(ax(2),'Ylabel'),'String','Erreur de classification') ;
xlabel ('Nombre de run') ;
title (sprintf('Statistiques d''apprentissage pour %s' , learning_set.filename)) ;
grid on

stat(end).mat_conf



% Génération de points dans l'espace d'entrée [0,2pi]x[0,2pi]
nPatternPerDim = 512 ;
x = linspace (0 , 2*pi , nPatternPerDim) ;
y = linspace (0 , 2*pi , nPatternPerDim) ;
pt = zeros (nPatternPerDim , nPatternPerDim) ;
for i = 1 : nPatternPerDim
    for j = 1 : nPatternPerDim
        pt(i,j) = mlp_propagation(net , [x(i) y(j)]) ;
    end
end

figure (11) ;
mesh (x , y , pt) ;
