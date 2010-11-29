% trains a neural network, represented as two weight matrices with the
% standard backprop algorithm
function [mW1, mW2] = train_neural_network(train, classes, cycles, eta, hidden_size)
    % default value for the number of train cycles
    if nargin<3
        cycles = 30;
    end
    % default value for the number of learning rate
    if nargin<4
        eta = 0.7;
    end
    
    if nargin<5
        hidden_size = 200;
    end
    
    
    % initialize the weights randomly in [-1,1]
    mW1 = 2*rand(size(train,1)+1, hidden_size)-1;
    mW2 = 2*rand(hidden_size+1, size(classes,1))-1;
    
    % train #cycles
    for t=1:cycles
        % this is the backprop algorithm in matrix notation. hard to 
        % explain from the code 
        % It actually computes the partial derivative of the error function
        % with respect to the weights
        for i=1:size(train,2)
            output1 = sigmoid([train(:,i)' 1]*mW1);
            output2 = sigmoid([output1 1]*mW2);
            delta2 = output2.*(1-output2).*(output2-classes(:,i)');
            for j=1:size(output1,2)
                delta1(j) = output1(j)*(1-output1(j))*sum(mW2(j,:).*delta2);
            end
            % update weights online
            mW1 = mW1 - eta*[train(:,i); 1]*delta1;
            mW2 = mW2 - eta*[output1 1]'*delta2;
        end
    end