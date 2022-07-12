function create_dataset_from_image ( filename_img , arr , filename , comment)
%create_dataset_from_image : Cr�ation d'un jeu de donn�es (apprentissage ou
%test) � partir de portion d'une image (classe par classe)
% [IN] :
%   filename_img : Fichier contenant l'image brute
%   arr : Ensemble de cellules contenant les zones d'apprentissage �tiquet�es
%   filename : Fichier contenant le dataset produit
%   comment : Commentaire � ins�rer dans le fichier du dataset
%
% Remarques :
%   - Les classes sont num�rot�es de 0 � k : le nombre de classes est donc de k+1
%   - Le format d'entr�e des zones s�lectionn�es est le suivant :
%       { {[10 20 40 50] , 1} , {[100 200 140 250] , 0} , {[1 2 4 5] , 2} }
%       1�re zone (classe 1) : colonne 10 � colonne 40, ligne 20 � ligne 50
%       2�re zone (classe 0) : colonne 100 � colonne 140, ligne 200 � ligne 250
%       3�re zone (classe 2) : colonne 1 � colonne 4, ligne 2 � ligne 5.

% Lecture de l'image
img = imread(filename_img) ;

% Dimensions de l'image (la toisi�me dimension donne la dimension d'un
% vecteur d'entr�e)
nDimInput = size(img,3) ;
fprintf ('Dimension des samples = %d\n' , nDimInput) ;

% Calcul du nombre de samples
nSamples = 0 ;
nClasses = 0 ;
for k = 1:length(arr)
    rc = arr{k}{1} ;
    nSamples = nSamples + (rc(3)-rc(1)+1)*(rc(4)-rc(2)+1) ;
    if nClasses < arr{k}{2}
        nClasses = arr{k}{2} ;
    end
end
nClasses = nClasses + 1 ;
fprintf ('Nombre de samples     = %d\n' , nSamples) ;
fprintf ('Nombre de classes     = %d\n' , nClasses) ;

% Affichage de l'image et des zones
figure(100) ;
set (gcf , 'Name' , 'Zones d''apprentissage' , 'Position' , [0 0 800 800]) ;
imagesc(img) ;
axis square ;
hold on ;
for k = 1:length(arr)

    rc = arr{k}{1} ;
    plot ([rc(1) rc(3) rc(3) rc(1) rc(1)] , [rc(2) rc(2) rc(4) rc(4) rc(2)] , 'r', ...
        'LineWidth' , 2) ;
    comment = sprintf ('%s - (%d %d - %d %d) : %d' , comment , rc(1) , rc(2) , rc(3) , rc(4) , arr{k}{2}) ;
    %fprintf ('%d\n' , arr{k}{2}) ;
    text (rc(1), rc(2), sprintf ('%d' , arr{k}{2}), ...
        'Color' , 'black' , 'BackgroundColor', [.7 .7 .7] , 'FontSize' , 12 , ...
        'EdgeColor' ,'white' , 'HorizontalAlignment' , 'right') ;
end

% Production du dataset
fid = fopen (filename , 'wt') ;

% Ligne de commentaire
fprintf (fid , '%s\n' , comment) ;

% Dimension d'un pattern
fprintf (fid , '%d\n' , nDimInput) ;

% Nombre de classes
fprintf (fid , '%d\n' , nClasses) ;

% Ecriture des patterns (zone par zone)
for k = 1:length(arr)
    rc = arr{k}{1} ;
    cl = arr{k}{2} ;
    
    for col = rc(1):rc(3)
        for lig = rc(2):rc(4)
            for d = 1:nDimInput
                fprintf (fid , '%g ' , double(img(lig,col,d))/256) ;
            end
            fprintf (fid , '%d\n' , cl) ;
            %img(lig,col,:) = [0 0 0] ;
        end
    end
end

% Fermeture du fichier
fclose (fid) ;

%imagesc(img) ;
