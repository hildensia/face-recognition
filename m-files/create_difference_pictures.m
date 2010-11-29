function [ diffFaces ] = create_difference_pictures( db, average )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    for i=1:size(db,3)
        diffFaces(:,:,i) = db(:,:,i) - average;
    end
end

