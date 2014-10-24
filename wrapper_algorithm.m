function [fitnessValues] = wrapper_algorithm(numberTests)
%--------------------------------------------------------------------------
% This is a wrapper function for an algorithm called 'algorithm'.
% This is an examle. Wrappers should be built for each algorithm you want
% to use.
%
% Syntax: test_algorithm(numberTrials)
%
% Example: test_algorithm(30)
%
% Inputs: 
%        numberTrials: the number of algorithm trials
%
% Outputs:
%        fitnessValues: the fitness values of the trials
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
% Hold results
fitnessValues = zeros(1, numberTests);

for i=1:numberTests
    fitnessValues(i) = algorithm();
end

end