function [ meanDiff ] = experiment( fn1, fn2, numberLandscapeRetrials, numberAlgorithmRetrails, type, parameters )
%--------------------------------------------------------------------------
% Compare the performance of two algorithms on multiple landscapes with the
% same parameterisation.
%
% Syntax: [ meanDiff ] = experiment( fn1, fn2, numberLandscapeRetrials,
% numberAlgorithmRetrails, type, parameters )
%
% Example: experiment(@wrapper_direct,@wrapper_emna,30,30,
%               'valley',struct('valleyVariance',0.2'))
%
% Inputs:
%        Algorithm 1 handler
%        Algorithm 2 handler
%        Number of landscape instances
%        Number of trials for each landscape instance
%        Type of the landscape to test on
%        Parameterisation of the landscape type to test on
%
% Outputs:
%        Mean difference between the two algorithms
%
% Copyright (C) 2014 Rachael Morgan (rachael.morgan8@gmail.com)
% 
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------

numGaussArray = [1,5,10,50,100,500,1000,5000,10000];

% These parameters can change for the experiments
nGaussian = numGaussArray(parameters.nGaussian);
varianceRange = parameters.varianceRange;
typeParameters = parameters.typeParameters;

meanAlg1 = zeros(numberLandscapeRetrials, numberAlgorithmRetrails);
meanAlg2 = zeros(numberLandscapeRetrials, numberAlgorithmRetrails);

% Run for each of the landscapes
for i=1:numberLandscapeRetrials
    % Initialise the landscape
    wrapper_initialize(nGaussian, varianceRange, type, typeParameters);

    % Run each algorithm on it for a set number of runs
    meanAlg1(i,:) = fn1(numberAlgorithmRetrails);
    meanAlg2(i,:) = fn2(numberAlgorithmRetrails);
end

totalMeanAlg1 = mean(mean(meanAlg1));
totalMeanAlg2 = mean(mean(meanAlg2));

meanDiff = totalMeanAlg1 - totalMeanAlg2;

end

