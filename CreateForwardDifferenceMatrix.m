function [ DeltaPlus ] = CreateForwardDifferenceMatrix(N)
%CREATEFORWARDDIFFERENCEMATRIX Creates a Forward Difference Matrix of size
%NxN.

    DiagMain = -ones(N,1);    
    DiagOff = ones(N-1, 1);
    
    DeltaPlus = diag(DiagMain) + diag(DiagOff, 1);

    return
end

