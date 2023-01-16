% Name: Christopher Ciobanu
% Date: 9/29/22
% ECPE 124 Digital Image Processing
% Program 2 Fruit Classifcation
%
%This is the connected_components function
function [output,num] = connected_components(image)     
    [height,width,depth] = size(image);
    if depth > 1
        image = rgb2gray(image);    %converts image from rgb to greyscale
    end    
    color = 20;    
    output = image;
    num = 0;
    
    % This for loops effectively checks if the thresholded image pixel is
    % 255, and if it is, to flood fill that area with a selected color, and
    % each time fruit is flood filled, we change the color, so the next
    % frui is filled with a different color, etc. 
    for i=1:height
        for j=1:width
            if output(i,j) == 255
                output = Floodfillinput([i,j],output,color);
                color = color + 20;
                num = num + 1;
            end
        end
    end
end