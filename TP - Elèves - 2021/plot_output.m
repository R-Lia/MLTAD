function plot_output (dims , pattern , class , val)
% Repr�sente en 2D ou 3D un pattern selon un code de couleur qui
% d�pend de la classe du pattern et un marqueur qui refl�te l'intensit� de
% la sortie du neurone ou du r�seau 
% Param�tres :
%   * dims : Vecteur de 2 ou 3 valeurs stipulant les index � utiliser dans
%               repr�sentation du pattern.
%               Pour dims = [1 5], le pattern [10 20 30 40 50] sera 
%               repr�sent� en 2D par les coordonn�es (10,50)
%   * pattern : Vecteur contenant le pattern � repr�senter
%   * class   : Identifiant de la classe ([0,n[) associ�e au pattern
%   * val     : Valeur de sortie du neurone ou du r�seau
% R�sultats :
%   Le pattern est ajout� � la figure courante avec une couleur d�pendant
% de la classe du pattern et le symbole "^" si la valeur de sortie est 
% sup�rieure � 0.5 (sinon, le symbole "v" est affich�). 
% marqueur qui d�pendent de la classe de chaque pattern.

hold on

% Liste des couleurs utilis�es en fonction des classes de pattern
colors = ['r','g','b','m','c','y','r','v'] ;

% D�termination du marqueur � afficher en fonction de la valeur de sortie
%   du neurone
mm = 'v' ;
if (abs(val) > 0.5)
    mm = '^' ;
end

% Construction de la cha�ne correspondant au marqueur & affichage
cl = strcat(mm,colors(class+1)) ;
if size(dims) == 3
    plot3 (pattern(dims(1)) , pattern(dims(2)) , pattern(dims(3)) , cl) ;
else
    plot (pattern(dims(1)) , pattern(dims(2)) , cl) ;
end
