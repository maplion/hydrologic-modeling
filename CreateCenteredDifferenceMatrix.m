function [ DeltaCentered ] = CreateCenteredDifferenceMatrix(N)
%CREATECENTEREDDIFFERENCEMATRIX Creates Centered Difference Matrix of size
%NxN

    DeltaCentered = diag(ones(N-1,1), 1) + diag(-ones(N-1,1), -1);    

    return
end

