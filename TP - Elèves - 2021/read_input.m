function jeu = read_input (filename)
% Remplit une structure contenant un jeu de données (patterns) pour 
% l'apprentissage ou le test, à partir d'un fichier texte au format
% suivant :
%   Ligne 1 : Commentaire sur le jeu de données
%   Ligne 2 : Dimension d'un pattern (dim_input)
%   Ligne 3 : Nombre de classes dans le jeu (n_class) : [0,n_class-1]
%   Ligne 4 : Pattern 1 = dim_input 'double' + id de la classe
%   Ligne 5 : Pattern 2 ...
% Paramètres :
%   * filename  : Nom du fichier contenant les patterns & les classes
% Résultats :
%   * jeu : Structure contenant les caractéristiques & patterns
%       - filename  : Nom du fichier contenant le jeu de données
%       - dim_input : Dimension d'un pattern
%       - n_class   : Nombre de classes dans le jeu de patterns
%       - n_pattern : Nombre de patterns dans le jeu
%       - pattern   : Matrice des patterns (1 pattern / ligne)
%                       [n_pattern x dim_input]
%       - class     : Matrice des identifiants de classe (1 id / ligne)
%                       [n_pattern x 1]
%       - output    : Matrice des classes de chaque pattern (1 pattern / ligne)
%                       classe 1 ==> (0.0 1.0 0.0 0.0) avec n_class = 4
%                       [n_pattern x n_class]

% Structure de sortie
jeu = [] ;
jeu.filename = filename ;

%
% Lecture du fichier d'entrée
%

% Ouverture du fichier d'entrée
fid = fopen (filename , 'rt') ;

% Lecture d'une ligne de commentaire
comment = fgetl (fid) ;
disp (comment) ;

% Lecture des paramètres du jeu de données :
%   - dimension d'un pattern
%   - nombre de classes
line = fgetl(fid) ;
jeu.dim_input = str2num(line) ;
line = fgetl(fid) ;
jeu.n_class = str2num (line) ;

% Lecture des patterns
%a = fscanf (fid , '%g' , [jeu.dim_input+1 inf]) ;
%[a, count, errmsg] = fscanf (fid , '%g' , [jeu.dim_input+1 inf]) ;
fmt = repmat('%g ',[1 jeu.dim_input]) ;
fmt = [fmt '%d'] ;
a = fscanf (fid , fmt , [inf]) ;

% Fermeture du fichier
fclose (fid) ;

% Estimation du nombre de patterns
jeu.n_pattern = length(a) / (jeu.dim_input+1) ;
disp (sprintf ('Nombre de patterns  : %d' , jeu.n_pattern)) ;
disp (sprintf ('Dimension en entrée : %d' , jeu.dim_input)) ;
disp (sprintf ('Nombre de classes   : %d' , jeu.n_class)) ;

% Formatage des données pour l'apprentissage et le test
%jeu.n_pattern = size(a,2) ;
%jeu.pattern = a(1:jeu.dim_input,:)' ;
%jeu.class = a(jeu.dim_input+1,:)' ;
jeu.pattern = zeros(jeu.n_pattern,jeu.dim_input) ;
jeu.class = zeros(jeu.n_pattern,1) ;
jeu.output = -ones(jeu.n_pattern,jeu.n_class) ;
for k = 1:jeu.n_pattern
  o = 1 + (k-1)*(jeu.dim_input+1) ;
  jeu.pattern(k,:) = a(o:o+jeu.dim_input-1) ;
  jeu.class(k) = a(o+jeu.dim_input) ;
  jeu.output(k,jeu.class(k)+1) = 1 ;
end

% Passage i_class = 1 --> (-1.0 1.0 -1.0 -1.0)
%jeu.output = zeros(jeu.n_pattern,jeu.n_class) ;
%for (k = 1:jeu.n_pattern)
%    jeu.output(k,:) = 2*((1:1:jeu.n_class)==(ones(1,jeu.n_class)*(a(jeu.dim_input+1,k)+1)))-1 ;
%end
