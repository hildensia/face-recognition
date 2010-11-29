function [ averageFace ] = average_face( train_db )
% AVERAGE_FACE Computes the average face of a given training database.
% Which is 1/M * sum_{i=1}^{n} (face_i)
    averageFace = sum(train_db, 3)/size(train_db, 3);
end

