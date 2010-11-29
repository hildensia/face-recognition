function [ omega projection ] = project_to_facespace( image, eigenfaces, average )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    image = double(image(:));
    average = double(average(:));
    phi = image - average;
    projection = zeros(size(image));
    omega = zeros(size(eigenfaces,2),1);
    for i=1:size(eigenfaces,2)
        omega(i) = transpose(eigenfaces(:,i))*phi;
        projection = projection + omega(i)*eigenfaces(:,i);
    end
end

