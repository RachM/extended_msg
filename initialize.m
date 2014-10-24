function [covMat, meanVec, optVal] = initialize(dimension,nGaussian,upper,lower,globalvalue,ratio,...
    varianceRange,type,typeParameters)

%--------------------------------------------------------------------------
%This is the initialization function of the Gaussian landscape generator
%
%Syntax: initialize(dimension,nGaussian,upper,lower,globalvalue,ratio,
%           variangeRange, type, typeParameters)
%
%Example:
%       initialize(2,10,5,-5,1,0.8,1,'valley',struct('valleyVariance',0.2))
%
%Inputs: 
%        dimensionality
%        number of Gaussian components
%        upper and lower boundaries
%        value of the global optimum
%        values of local optima ([0,ratio*globalvalue])
%        variance of Gaussian components ([10^-15, varianceRange])
%        type of the landscape (ridge, valley or random)
%        parameters for the landscape type
%
%Note: typeParameters should have the following fields:
%        Random: no fields required
%        Ridge: 'gaussianRotation' and 'ridgeRotation'
%        Valley: 'varianceRange'
%
%Outputs:
%        inverse covariance matrix
%        meanvector
%        component peak value
%
%Original Author: Bo Yuan (boyuan@itee.uq.edu.au)
%Edited: Rachael Morgan (r.morgan4@uq.edu.au)
%--------------------------------------------------------------------------

clear global covmatrix_inv;
clear global meanvector;
clear global optimumvalue;

global covmatrix_inv;   %the inverse covariance matrix of each component
global meanvector;      %the mean of each component
global optimumvalue;    %the peak value of each component

if nargin<8
    
    disp('Usage: initialize(initialize(dimension,nGaussian,upper,lower,globalvalue,ratio,varianceRange,type,typeParameters)');
    return;    
    
end

if dimension<=1|nGaussian<=0|upper<=lower|globalvalue<=0|ratio<=0 ...
    |ratio>=1|varianceRange<=0
    
    disp('Incorrect parameter values!');
    return;
    
end

if (strcmp(type,'ridge') && dimension ~= 2) 
    disp('Ridges are currently for 2 dimensions only.');
    return;
end

if (~(strcmp(type,'ridge') || strcmp(type,'random') || strcmp(type,'valley'))) 
    disp('Landscape type must be ridge, valley or random.');
    return;
end

% Generate rotation matrix

e=diag(ones(1,dimension));   % unit diagonal matrix

for i=1:nGaussian
    
   rotation{i}=e;            % initial rotation matrix for each Gaussian
   
end

for i=1:nGaussian            

  for j=1:dimension-1        % totally n(n-1)/2 rotation matrice
      
      for k=j+1:dimension
          
        r=e;
        
        if (strcmp(type,'ridge'))
             alpha = (typeParameters.gaussianRotation + (5 - round(rand())*10)) * (pi / 180); % rotation angle +- noise (5 degrees)
        else
            alpha=rand*pi/2-pi/4;% random rotation angle [-pi/4,pi/4]
        end
        
        r(j,j)=cos(alpha);
        r(j,k)=sin(alpha);
        r(k,j)=-sin(alpha);
        r(k,k)=cos(alpha);
    
        rotation{i}=rotation{i}*r;
    
     end
    
  end
  
end

% Generate covariance matrix

variance=rand(nGaussian,dimension)*varianceRange+10e-15;  % add to avoid zero variance

for i=1:nGaussian

      covmatrix=diag(variance(i,:));
      covmatrix=rotation{i}'*covmatrix*rotation{i};
      covmatrix_inv{i}=inv(covmatrix);
      
end

% Generate mean vectors randomly within [lower, upper]
switch(type)
    case 'valley'
        % Use gaussian distribute (mean = 0, variance = given)
        meanvector=typeParameters.valleyVariance*randn(nGaussian,dimension);
    case 'ridge'
        % NOTE: currently for 2D only
        % Pick a random point in the search space
        points = zeros(dimension, dimension);
        points(1,:) = [(upper-lower)*rand()+lower,(upper-lower)*rand()+lower];

        coefficient = 1 + (round(rand()) * -2);
        if (typeParameters.ridgeRotation == 90)
            points(2,:) = points(1,:) + coefficient * [0, 1];
            m = (points(2,2) - points(1,2)) / 0.0001;
        else
            points(2,:) = points(1,:) + coefficient * [1, tan(typeParameters.ridgeRotation/180*pi)];
            m = (points(2,2) - points(1,2)) / (points(2,1)-points(1,1));
        end

        c = points(1,2) - m*points(1,1);

        if (m ~= 0)
            xLower = (lower - c)/m;
            xUpper = (upper - c)/m;
        else
            xLower = lower;
            xUpper = upper;
        end

        if (xLower < lower)
            xLower = lower;
        end
        if (xUpper > upper)
            xUpper = upper;
        end

        % Generate random points on the line and find corresponding y
        meanvector=rand(nGaussian,1)*(xUpper-xLower)+xLower;
        
        meanvector(:,2) = m * meanvector(:,1) + c;
        
    otherwise
        meanvector=rand(nGaussian,dimension)*(upper-lower)+lower;
end

% assign values to components
optimumvalue(1)=globalvalue;     % the first Gaussian is set to be the global optimum
optimumvalue(2:nGaussian)=rand(1,nGaussian-1)*globalvalue*ratio;

covMat = covmatrix_inv;
meanVec = meanvector;
optVal = optimumvalue;