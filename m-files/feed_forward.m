
function [ result classes ] = feed_forward(data, w1, w2)
    hiddenoutput = sigmoid([data 1]*w1);
    classes = sigmoid([hiddenoutput 1]*w2);
    [m, result] = max(classes);