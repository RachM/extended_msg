function [ offspringParameters ] = mutate( parameters, type )
%--------------------------------------------------------------------------
% Mutates the parameters according to the type of landscape.
%
%Syntax: [ offspringParameters ] = mutate( parameters, type )
%
%Example: mutate(struct('valleyVariance',0.2),'valley')
%
%Inputs:
%        Parameters to mutate
%        Type of the landscape
%
%Outputs:
%        Mutated landscape parameters
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

offspringParameters.nGaussian = mod(parameters.nGaussian + round(rand())*2-1,9); % Step size of 1
if (offspringParameters.nGaussian == 0)
    offspringParameters.nGaussian = 9;
end
offspringParameters.varianceRange = abs(parameters.varianceRange + round(rand())*0.02 - 0.01); % Step of 0.01

if(strcmp(type,'ridge'))
    
    offspringParameters.typeParameters = struct(...
        'ridgeRotation', mod(abs(parameters.typeParameters.ridgeRotation + round(rand())*2-1),90),...
        'gaussianRotation', mod(abs(parameters.typeParameters.gaussianRotation + round(rand())*2-1),90)); % Step size between 0 and 1

elseif (strcmp(type,'valley'))
    offspringParameters.typeParameters = struct(...
        'valleyVariance',abs(parameters.valleyVariance + round(rand())*0.02 - 0.01)); % Step of 0.01
    
end

end

