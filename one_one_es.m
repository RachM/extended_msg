function [ fitnessDifference, parameters ] = one_one_es( ...
alg1, alg2, numberLandscapeTrials, numberAlgorithmTrials, type, reqFitDiff)

%--------------------------------------------------------------------------
%A (1+1)-ES that finds a landscape parameterisation for a specified fitness
%difference.
%
%Syntax: [ fitnessDifference, parameters ] = active_search_local_ridge(
%    alg1, alg2, numberLandscapeTrials, numberAlgorithmTrials )
%
%Example: active_search_local_ridge(@wrapper_direct,@wrapper_emna,30,30)
%
%Inputs:
%        Algorithm 1 handler
%        Algorithm 2 handler
%        Number of landscape instances
%        Number of trials for each landscape instance
%
%Outputs:
%        Fitness difference between Algorithm 1 and 2
%        Landscape parameterisation found
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

% Initialise variables
run init;

% Landscape parameters, initialised randomly
parameters = struct(...
    'nGaussian', ceil(rand()*9), ...
    'varianceRange', rand()*0.25, 'typeParameters', struct());

if(strcmp(type,'ridge'))
    parameters.typeParameters = struct( 'ridgeRotation', rand()*90, ... 
        'gaussianRotation', rand()*90);
elseif(strcmp(type,'valley'))
    parameters.typeParameters = struct( 'valleyVariance', rand()*0.1);
end

offspringParameters = parameters;
fitnessDifference = 0; % Current fitness difference

% 1 + 1 ES
while fitnessDifference < reqFitDiff
    
    % Perform experiment to determine the fitness difference
    offspringFitnessDifference = experiment(alg1, alg2, ...
        numberLandscapeTrials, numberAlgorithmTrials, ...
        type, offspringParameters);
    
    if (offspringFitnessDifference > fitnessDifference)
        % Accept point if better
        fitnessDifference = offspringFitnessDifference;
        parameters = offspringParameters;
    end
    
    % Mutation
    offspringParameters = mutate(parameters, type);
    
end
end
