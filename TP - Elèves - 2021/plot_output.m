function plot_output (dims , pattern , class , val)
% Représente en 2D ou 3D un pattern selon un code de couleur qui
% dépend de la classe du pattern et un marqueur qui reflète l'intensité de
% la sortie du neurone ou du réseau 
% Paramètres :
%   * dims : Vecteur de 2 ou 3 valeurs stipulant les index à utiliser dans
%               représentation du pattern.
%               Pour dims = [1 5], le pattern [10 20 30 40 50] sera 
%               représenté en 2D par les coordonnées (10,50)
%   * pattern : Vecteur contenant le pattern à représenter
%   * class   : Identifiant de la classe ([0,n[) associée au pattern
%   * val     : Valeur de sortie du neurone ou du réseau
% Résultats :
%   Le pattern est ajouté à la figure courante avec une couleur dépendant
% de la classe du pattern et le symbole "^" si la valeur de sortie est 
% supérieure à 0.5 (sinon, le symbole "v" est affiché). 
% marqueur qui dépendent de la classe de chaque pattern.

hold on

% Liste des couleurs utilisées en fonction des classes de pattern
colors = ['r','g','b','m','c','y','r','v'] ;

% Détermination du marqueur à afficher en fonction de la valeur de sortie
%   du neurone
mm = 'v' ;
if (abs(val) > 0.5)
    mm = '^' ;
end

% Construction de la chaîne correspondant au marqueur & affichage
cl = strcat(mm,colors(class+1)) ;
if size(dims) == 3
    plot3 (pattern(dims(1)) , pattern(dims(2)) , pattern(dims(3)) , cl) ;
else
    plot (pattern(dims(1)) , pattern(dims(2)) , cl) ;
end
