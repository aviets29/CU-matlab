%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% readIn Function
% ASEN 2003 Lab 5
%
% Authors: Alec Viets and Thomas Pestolesi
% Date Published: 3/8/2016
% Date Changed: 3/28/2016
%
% Inputs: If balanced? [bool]
% Outputs: time, t [s] ; Theta, Th [rads] ; Omega, w [rad/s]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [t,Th,w] = readIn(balanced)

%Read in data
Data = [];
for i = 1:5
    %Check if balanced
    if balanced
        %Load Data
        daft = load(sprintf('balanced_%u.txt',i));
        %Add data to matrix
        Data = [Data;daft];
    else
        daft = load(sprintf('unbalanced_%u.txt',i));
        Data = [Data;daft];
    end
end

%Find where data is relevent
I = find(Data(:,2) >= .5 & Data(:,2) <= 15);
Data = Data(I,:);
%Sort Data
DataSorted = sortrows(Data,2);

%Outputs
t = DataSorted(:,1);
Th = DataSorted(:,2);
w = DataSorted(:,3);

end

