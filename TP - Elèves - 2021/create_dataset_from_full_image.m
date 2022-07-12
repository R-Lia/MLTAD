function create_dataset_from_full_image (filename_img , filename_lbl , filename , comment)
%create_dataset_from_full_image : Création d'un jeu de données (apprentissage ou
%test) à partir d'une image brute & d'une image des étiquettes de classe
% [IN] :
%   filename_img : Fichier contenant l'image brute
%   filename_lbl : Fichier contenant l'image des étiquettes (classes) = réalité terrain ?
%   filename     : Fichier contenant le dataset produit
%   comment      : Commentaire à insérer dans le fichier du dataset
%
% Remarques :
%   - Les classes sont numérotées de 0 à k : le nombre de classes est donc de k+1

% Lecture de l'image
img = imread(filename_img) ;

% Dimensions de l'image (la toisième dimension donne la dimension d'un
% vecteur d'entrée)
nDimInput = size(img,3) ;
fprintf ('Dimension des samples = %d\n' , nDimInput) ;

% Calcul du nombre de samples
nLig = size(img,1) ;
nCol = size(img,2) ;
nSamples = nLig*nCol ;
fprintf ('Nombre de samples     = %d\n' , nSamples) ;

% Lecture du fichier des labels (autant de labels que de pixels)
lbl = zeros(nLig,nCol) ;
fid_labels = fopen (filename_lbl , 'rt') ;
for k = 1:nLig
    [lbl(k,:) , count] = fscanf (fid_labels , '%g,' , [1 nCol]) ;
    if count ~= nCol
        fprintf ('Erreur : %d sur %d étiquettes lues\n' , count , nCol) ;
        return ;
    end
end
fclose (fid_labels) ;
nClasses = max(lbl(:)) + 1 ;
fprintf ('Nombre de classes     = %d\n' , nClasses) ;

% Affichage de l'image et des zones
figure(110) ;
set (gcf , 'Name' , 'Images de test') ;
subplot(1,2,1) ;
imagesc(img) ;
title ('Image satellite') ;
subplot(1,2,2) ;
imagesc(lbl) ;
title ('Réalité terrain') ;

% Production du dataset
fid = fopen (filename , 'wt') ;

% Ligne de commentaire
fprintf (fid , '%s\n' , comment) ;

% Dimension d'un pattern
fprintf (fid , '%d\n' , nDimInput) ;

% Nombre de classes
fprintf (fid , '%d\n' , nClasses) ;

% Ecriture des patterns (zone par zone)
for lig = 1:nLig
    for col = 1:nCol
        for d = 1:nDimInput
            fprintf (fid , '%g ' , double(img(lig,col,d))/256) ;
        end
        fprintf (fid , '%d\n' , lbl(lig,col)) ;            
        %img(lig,col,:) = [0 0 0] ;
    end
end

% Fermeture du fichier
fclose (fid) ;

%imagesc(img) ;


