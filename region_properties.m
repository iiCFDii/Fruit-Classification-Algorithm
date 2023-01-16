% Name: Christopher Ciobanu
% Date: 9/29/22
% ECPE 124 Digital Image Processing
% Program 2 Fruit Classifcation
%
%This is the region_properties function which calculates all the moments
%and central order moments we will need. 

function [zerothM , firstM, secondM, thirdM, fourthM, fifthM, zerothCM, thirdCM, fourthCM, fifthCM, xc, yc] = region_properties(image,L)
    [height,width,depth] = size(image);
    if depth > 1
        image = rgb2gray(image);    % converts rgb image to greyscale
    end   
    
    image = double(image);
    
    zerothM = 0;
    firstM = 0;
    secondM = 0;
    thirdM = 0;     % initalizing variables to 0
    fourthM = 0;
    fifthM = 0;
    
    % Within these for loops, the 0th,first,second, third, fourth, and fifth order moments are calculated 
    for i=1:height
        for j=1:width
            if image(i,j) == L 
                zerothM = zerothM + 1;
                firstM = firstM + i;
                secondM = secondM + j;
                thirdM = thirdM + (i*j);
                fourthM = fourthM + (i^(2));
                fifthM = fifthM + (j^(2));
            end
        end
    end
    
    zerothCM = zerothM; 
    xc = (firstM/zerothM);      % xc and yc are calculated using the moments
    yc = (secondM/zerothM);
    
    thirdCM = thirdM -(xc*secondM);
    fourthCM = fourthM - (xc*firstM);       % the relevent central order moments are clacualted using xc/yc and previous order moments
    fifthCM = fifthM - (yc*secondM);
end