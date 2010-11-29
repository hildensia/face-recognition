function [ eigenfaces ] = create_eigenfaces( train_db, m )
%CREATE_EIGENFACES This function computes the m first Eigenfaces of a
% Training Database train_db
% The format of all pictures must always be a graylevel picture with values
% in the interval [0;1] with double precision

    % Calculate the average face of the training database
    averageFace = sum(train_db, 3)/size(train_db, 3);
    
    % Create a difference picture of all training pictures
    differencePictures = create_difference_pictures(train_db, averageFace);
    
    % Create a matrix, where each column is a difference picture
    colDiff = reshape(differencePictures, size(differencePictures,1)*size(differencePictures,2),size(differencePictures,3));
    
    % Calculate the matrix A^T * A
    ATA = transpose(colDiff) * colDiff;
    
    % Calculate the Eigenvalues and -vectors of A^T * A
    [eigenvector, eigenvalue] = eig(ATA);
    
        
    %Calculate the Eigenfaces
    eigenfaces = colDiff * eigenvector;
    
    % Normalize Eigenfaces
    for i=1:size(eigenfaces,2)
        eigenfaces(:,i) = eigenfaces(:,i)/norm(eigenfaces(:,i));
    end

    
    % Drop all Eigenfaces after m
    
    eigenfaces = fliplr(eigenfaces);
    eigenfaces = eigenfaces(:,1:m);
end

