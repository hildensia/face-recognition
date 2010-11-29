function [ omega w1 w2 ] = eigenfaces_with_nn( traindb, classes, m )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    if nargin<3
        m=50;
    end

    eigenfaces = create_eigenfaces(traindb, m);
    average = average_face(traindb);
    
    for i=1:size(traindb,3)
        [ omega(:,i) ~] = project_to_facespace(traindb(:,:,i),eigenfaces,average);
    end
    
    [ w1 w2 ] = train_neural_network(omega,classes,100);
    


end

