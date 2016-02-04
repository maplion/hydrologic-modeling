function [ DeltaSecond ] = CreateSecondDifferenceMatrix(N)
%CREATESECONDDIFFERENCEMATRIX Creates Second Difference Matrix of size
%NxN

    DeltaSecond = diag(ones(N-1,1), 1) + diag(ones(N-1,1), -1) +...
        diag(ones(N,1))*(-2)    

    return
end

