% Name: Christopher Ciobanu
% Date: 9/29/22
% ECPE 124 Digital Image Processing
% Program 2 Fruit Classifcation
%
%This is the PCA function which calculates all the values needed to
% draw major and minor axis on the fruits, as well as information needed to
% classify the fruits

function [eigen1,eigen2,direction,major,minor,eccentricity,majorPX,majorPY,minorPX,minorPY,majorPXN,majorPYN,minorPXN,minorPYN] = PCA(zerothCM, thirdCM, fourthCM, fifthCM, xc, yc,color)
    C = [fourthCM thirdCM; thirdCM fifthCM]/zerothCM;   % covariance matrix
    e = eig(C);     % eigen values of covariance matrix
    
    eigen1 = max(e);       
    eigen2 = min(e);
    
    major = 2*sqrt(eigen1);     % major axis length
    minor = 2*sqrt(eigen2);     % minor axis length
    
    direction = 0.5*atan2(2*thirdCM,fourthCM-fifthCM);  % theta of axis
    eccentricity = sqrt((eigen1-eigen2)/eigen1);        % eccentricity of fruit/object
    
    majorPX = xc + cos(direction) * sqrt(eigen1);       % major axis end x point
    majorPY = yc + sin(direction) * sqrt(eigen1);       % major axis end y point
    
    majorPXN = xc - cos(direction) * sqrt(eigen1);      % major axis end x point opposite
    majorPYN = yc - sin(direction) * sqrt(eigen1);      % major axis end y point opposite
    
    minorPX = xc + cos(direction-(pi/2)) * sqrt(eigen2);    % minor axis end x point
    minorPY = yc + sin(direction-(pi/2)) * sqrt(eigen2);    % minor axis end y point
    
    minorPXN = xc - cos(direction-(pi/2)) * sqrt(eigen2);   % minor axis end x point opposite
    minorPYN = yc - sin(direction-(pi/2)) * sqrt(eigen2);   % minor axis end y point opposite
end