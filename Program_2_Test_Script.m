% Name: Christopher Ciobanu
% Date: 9/29/22
% ECPE 124 Digital Image Processing
% Program 2 Fruit Classifcation
% How to Use Testing Script: Hit Run at the Top of Malab and select the
% input image
% The 'Classified Objects' figure takes a bit longer to run, so
% give it some time to load in after running the program.

[FileName,FilePath]=uigetfile('*');          % Reads in File  
image1 = imread(strcat(FilePath,FileName));  % Reads in File
image2 = image1;
out_image0 = ThresholdDouble(image1);        % Creates double Thresholded Image

erode1 = erosion(out_image0);
erode2 = erosion(erode1);
dilate1 = dilation(erode2);
dilate2 = dilation(dilate1);                 % Erodes and dilates image to get cleaner thresholded image 
dilate3 = dilation(dilate2);
dilate4 = dilation(dilate3);
erode3 = erosion(dilate4);
erode4 = erosion(erode3);        
figure
imshow(erode4)
title('Clean Threshold Image')

erodeX = out_image0;
for i=1:4
    erodeX = erosion(erodeX);
end

for i=1:4
    erodeX = dilation(erodeX);
end

[out_image, num] = connected_components(erode4);        % Calls connected_omponents and returns the number of fruits identified
[out_image2,num2] = connected_components(erodeX);
figure
imshow(out_image)
title('Connected Components')

properties = zeros(num,12);
PCAproperties = zeros(num,14);              % Pre Allocates arrays for region_property outputs and PCA outputs
color = 20;

properties1 = zeros(num2,12);
PCAproperties1 = zeros(num2,14);              % Pre Allocates arrays for region_property outputs and PCA outputs
color1 = 20;

for i=1:num                                 % For loop which identifies the edge of the fruits and draws the wall around each fruit
    image1 = wall_following(image1,out_image,color);
    color = color + 20;
end

for i=1:num2                                 % For loop which identifies the edge of the fruits and draws the wall around each stem
    image2 = wall_following(image2,out_image2,color1);
    color1 = color1 + 20;
end
color = 20;
color1 = 20;
figure
imshow(image1)
title('Classified Objects')
hold on

for i=1:num                                 % For loop which calls region_properties and PCA for each object/fruit recgonized in the image
    
    % properties(i,1),properties(i,2),properties(i,3),properties(i,4),properties(i,5),properties(i,6),properties(i,7),properties(i,8),properties(i,9),properties(i,10),properties(i,11),properties(i,12)
    %     zerothM ,     firstM,         secondM,            thirdM,         fourthM,    fifthM,         zerothCM,       thirdCM,         fourthCM,       fifthCM,           xc,             yc
    
    % PCAproperties(i,1),PCAproperties(i,2),PCAproperties(i,3),PCAproperties(i,4),PCAproperties(i,5),PCAproperties(i,6),PCAproperties(i,7),PCAproperties(i,8),PCAproperties(i,9),PCAproperties(i,10),PCAproperties(i,11),PCAproperties(i,12),PCAproperties(i,13),PCAproperties(i,14)
    %     eigen1,               eigen2,         direction,          major,              minor,          eccentricity,           majorPX,        majorPY,            minorPX,            minorPY,            majorPXN,           majorPYN,           minorPXN,           minorPYN
    [properties(i,1),properties(i,2),properties(i,3),properties(i,4),properties(i,5),properties(i,6),properties(i,7),properties(i,8),properties(i,9),properties(i,10),properties(i,11),properties(i,12)] = region_properties(out_image,color);
    [PCAproperties(i,1),PCAproperties(i,2),PCAproperties(i,3),PCAproperties(i,4),PCAproperties(i,5),PCAproperties(i,6),PCAproperties(i,7),PCAproperties(i,8),PCAproperties(i,9),PCAproperties(i,10),PCAproperties(i,11),PCAproperties(i,12),PCAproperties(i,13),PCAproperties(i,14)] = PCA(properties(i,7),properties(i,8),properties(i,9),properties(i,10),properties(i,11),properties(i,12), color);
   
    % These if else statements check the eccentricity and the 0th moment
    % (area) of each figure to determine which fruit it is
    
    if PCAproperties(i,6) > 0.9    
        fruit = 1; %%bannna
    elseif PCAproperties(i,6) < 0.4 && PCAproperties(i,6) > 0.2 && properties(i,1) > 5500
        fruit = 2; %%tangerine
    else 
        fruit = 3; %%apple
    end
    
    % This for loops replaces the white pixels that wall_following
    % produced, with the appropriate color for each fruit
    [height,width,depth] = size(image1);    
    for j=1:height
        for k=1:width
            if fruit == 1 && image1(j,k) == 255 && out_image(j,k) == color
                plot(k,j,'y.')
                hold on
            elseif fruit == 2 && image1(j,k) == 255 && out_image(j,k) == color
                plot(k,j,'.k','MarkerEdgeColor', '#D95319', 'MarkerFaceColor','#D95319')
                hold on
            elseif fruit == 3 && image1(j,k) == 255 && out_image(j,k) == color
                plot(k,j,'r.')
                hold on
            end
        end        
    end

    % These set of line plots, are the major and minor axis being plotted
    % on each fruit using the major and minor calculations done in PCA
    x1 = [properties(i,11) PCAproperties(i,7)];
    y1 = [properties(i,12) PCAproperties(i,8)];
    line(y1,x1,'color','black'); 
    hold on
    x2 = [properties(i,11) PCAproperties(i,9)];
    y2 = [properties(i,12) PCAproperties(i,10)];
    line(y2,x2,'color','black'); 
    hold on
    x3 = [properties(i,11) PCAproperties(i,11)];
    y3 = [properties(i,12) PCAproperties(i,12)];
    line(y3,x3,'color','black'); 
    hold on
    x4 = [properties(i,11) PCAproperties(i,13)];
    y4 = [properties(i,12) PCAproperties(i,14)];
    line(y4,x4,'color','black'); 
    hold on
    color = color + 20;

end

% Within this for loop, the stem of the bannana is detected and outlined
% onto the image using the area of the stem.  
for i=1:num2
    [properties1(i,1),properties1(i,2),properties1(i,3),properties1(i,4),properties1(i,5),properties1(i,6),properties1(i,7),properties1(i,8),properties1(i,9),properties1(i,10),properties1(i,11),properties1(i,12)] = region_properties(out_image2,color1);
    if properties1(i,1) < 300
        fruit1 = 4;
    else
        fruit1 = 0;
    end

    
     [height,width,depth] = size(image2);    
    for j=1:height
        for k=1:width
            if fruit1 == 4 && image2(j,k) == 255 && out_image2(j,k) == color1
                plot(k,j,'m.')
                hold on
            end
        end
    end
     color1 = color1 + 20;

end
 