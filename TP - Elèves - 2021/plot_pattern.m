function plot_pattern (dims , pattern , class)
% Repr�sente en 2D ou 3D une s�rie de patterns
% Param�tres :
%   * dims : Vecteur de 2 ou 3 valeurs stipulant les index � utiliser dans
%               repr�sentation du pattern.
%               Pour dims = [1 5], le pattern [10 20 30 40 50] sera 
%               repr�sent� en 2D par les coordonn�es (10,50)
%   * pattern : Matrice contenant l'ensemble des patterns � repr�senter
%               [n_pattern x dim_pattern]
%   * class : Vecteur contenant l'identifiant de la classe ([0,n[) 
%               associ�e � chaque pattern
%               [n_pattern x 1]
% R�sultats :
%   Les patterns sont ajout�s � la figure courante avec une couleur et un 
% marqueur qui d�pendent de la classe de chaque pattern.

hold on

% Liste des marqueurs utilis�s en fonction des classes
markers = ['+','o','*','x','s','d','p','h'] ;
colors = ['r','g','b','m','c','y','r','v'] ;

% Si 3 dimensions du pattern sont s�lectionn�es, l'affichage est en 3D
if (size(dims) == 3)
    for i = 1:size(pattern,1)
        % Cha�ne construisant le marqueur avec la couleur ad�quate
        cl = strcat(markers(class(i)+1),colors(class(i)+1)) ;
        
        % Affichage du marqueur
        plot3 (pattern(i,dims(1)) , pattern(i,dims(2)) , pattern(i,dims(3)) , cl) ;
    end
else
    for i = 1:size(pattern,1)
        % Cha�ne construisant le marqueur avec la couleur ad�quate
        cl = strcat(markers(class(i)+1),colors(class(i)+1)) ;

        % Affichage du marqueur
        plot (pattern(i,dims(1)) , pattern(i,dims(2)) , cl) ;
    end
end

grid on


