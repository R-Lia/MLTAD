% Chargement du jeu de patterns
filename = 'set1.txt' ;
learning_set = read_input (filename) ;

% Définition du neurone
neuron = [] ;
neuron.dim_input  = learning_set.dim_input ;

% Lancement de l'apprentissage
n_epochs      = 200 ;
mse           = 0.0001 ;
learning_rate = 0.1 ;
disp ('Lancement Apprentissage Neurone :') ;
disp (sprintf('  * Jeu      : %s', learning_set.filename)) ;
disp (sprintf('  * Patterns : %d', learning_set.n_pattern)) ;
disp (sprintf('  * Classes  : %d', learning_set.n_class)) ;
disp (sprintf('  * Arrêt    : %d ou %f', n_epochs , mse)) ;
disp (sprintf('  * Neurone  : %d / 1', neuron.dim_input)) ;
[neuron stat] = neuron_learning (neuron , learning_set , learning_rate , mse , n_epochs) ;

% Affichage des statistiques
figure(1) ;
[ax,h1,h2] = plotyy (1:neuron.n_epochs,[stat(:).mse] ,1:neuron.n_epochs,[stat(:).err_pattern],'plot') ;
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
    o = neuron_propagation(neuron , pt(i,:)) ;
    plot_output (axes , pt(i,:) , (o >= 0.0)*1 , o) ;
end

% Affichage de l'hyperplan séparateur
plot_hyperplane (neuron.weights , [0 1] , [0 1]) ;





