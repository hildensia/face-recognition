function [ db_part classes_part ] = create_cv_partition( db, classes, k )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    for i=1:floor(size(db,3)/k)
        for n=1:k
            db_part(:,:,n,i)    = db(:,:,(i-1)*k+n);
            classes_part(:,n,i) = classes(:,(i-1)*k+n);
        end
    end
end

