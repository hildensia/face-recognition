function [ recognition_rate ] = cross_validation( traindb, k_db, k_classes )
%CROSS_VALIDATION Summary of this function goes here
%   Detailed explanation goes here
    theta = 0.4;
    m = 200;

    eigenfaces = create_eigenfaces(traindb, m);
    average = average_face(traindb);
    
    

    test_right = 0;
    test_all   = 0;
    k=1;
    % We have to train and test everything k times
    for k=1:size(k_db, 3)
        %create train and test db
        test = [];
        test_classes = [];
        train = [];
        train_classes = [];
        for t=1:size(k_db, 3)
            if t==k
                test = reshape(k_db(:,:,t,:), size(k_db,1), size(k_db,2),size(k_db,4));
                test_classes = reshape(k_classes(:,t,:), size(k_classes,1), size(k_classes,3));
            else
                train = cat(3,train,reshape(k_db(:,:,t,:), size(k_db,1), size(k_db,2),size(k_db,4)));
                train_classes = cat(2, train_classes, reshape(k_classes(:,t,:), size(k_classes,1), size(k_classes,3)));
            end
        end
        
        %The training
        % First: project to face space
        for i=1:size(train,3)
            [ omega(:,i) ~] = project_to_facespace(train(:,:,i),eigenfaces,average);
        end
        
        % Second: train neural network with face space vectors
        [ w1 w2 ] = train_neural_network(omega,train_classes,100);
        
        %The testing
        for t=1:size(test,3)
            [ omega ~ ] = project_to_facespace(test(:,:,t),eigenfaces,average);
            [ result classes ] = feed_forward(transpose(omega), w1, w2);
            test_all = test_all + 1;
            % is this a face?
            if(max(classes) > theta)
                [ p right ] = max(test_classes(:,t));
                if right==result
                    test_right = test_right + 1;
                end
            end
        end
    end
    
    recognition_rate = double(test_right)/double(test_all);

end

