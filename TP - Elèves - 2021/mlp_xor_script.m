% Chargement du jeu de pattern pour l'apprentissage
filename = 'data/set_xor.txt' ;
learning_set = read_input (filename) ;

% Définition de l'architecture du MLP
net = [] ;
net.dim_input  = learning_set.dim_input ;
net.dim_hidden = 2 ;
net.dim_output = learning_set.n_class ;

% Lancement de l'apprentissage
n_epochs      = 1000 ;
mse           = 0.01 ;
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
title (sprintf('Statistiques d''apprentissage pour %s' , filename)) ;
grid on

stat(end).mat_conf

% Affichage de l'ensemble d'apprentissage
figure(2) ;
axis ([0 1 0 1]) ;
axes = [1 2] ;
plot_pattern (axes , learning_set.pattern , learning_set.class) ;

% Génération de points dans l'espace d'entrée [0,1]x[0,1]
n_points = 100 ;
pt = rand(n_points,learning_set.dim_input);

% Présentation de ces points au neurone
for i = 1:n_points
    o = mlp_propagation(net , pt(i,:)) ;
    [v cl] = max(o) ;
    plot_output (axes , pt(i,:) , cl-1 , max(o)) ;
end

% Affichage des hyperplans séparateurs
for (i = 1:net.dim_hidden)
    plot_hyperplane (net.IH(:,i) , [0 1] , [0 1]) ;
end


