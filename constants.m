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

clear global covmatrix_inv;
clear global meanvector;
clear global optimumvalue;
clear global constants;

global constants;
constants = struct(...
    'dimensionality', 2, ...
    'bounds', [-1, 1], ...
    'globalValue', 1, ...
    'localGlobalRatio', 0.5 ...
);

constants.maxFunEval = 10^3;
constants.population = 50;
constants.selection = 0.8;