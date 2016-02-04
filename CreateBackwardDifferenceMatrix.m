function [ DeltaMinus ] = CreateBackwardDifferenceMatrix(N)
%CREATEBACKWARDDIFFERENCEMATRIX Creates a Backward Difference Matrix of
%size NxN

    DeltaMinus = diag(ones(N,1)) + diag(-ones(N-1,1), -1);
    
    return
end

