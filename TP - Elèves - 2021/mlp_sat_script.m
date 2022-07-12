% Chargement des chiffres pour l'apprentissage
filename = 'sat4_learn.txt' ;
learning_set = read_input (filename) ;

% Définition de l'architecture du MLP
net = [] ;
net.dim_input  = learning_set.dim_input ;
net.dim_hidden = 10 ;
net.dim_output = learning_set.n_class ;

% Lancement de l'apprentissage
n_epochs      = 1000 ;
mse           = 0.001 ;
learning_rate = 0.1 ;
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
title (sprintf('Statistiques d''apprentissage pour %s' , filename)) ;
grid on

stat(end).mat_conf


% Chargement des chiffres pour le test
testing_set = read_input ('sat_test.txt') ;

% Lancement du test
[stat] = mlp_test (net , testing_set) ;
stat
stat.mat_conf

