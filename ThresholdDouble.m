function output = ThresholdDouble(image)    % Threshold Function
    [height,width,depth] = size(image);
    if depth > 1
        image = rgb2gray(image);
    end
    output = zeros(height,width);    
    parts = []; % This is used to collect all the seperate floodfill outputs
    image_tlow = ThresholdSingle(image,100);    % Low threshold image
    image_thigh = ThresholdSingle(image,200);   % High threshold image
    check = 0;  % Used to count how many different output images there are
    for i=1:height
        for j=1:width 
            % This if statement checks for where in the high threshold
            % image there is a pixel that is 254 as well as if the low
            % threshold image is not 255. This is so that only the parts of
            % the picture we want will get flood filled
             if image_thigh(i,j) == 254 && image_tlow(i,j) ~= 255 
                 image_thigh = Floodfillinput([i,j],image_thigh,255); % I flood filled the high thresh so that it changes the values from 254 to 255 indicating that the object in the picture has been found, so we don't have to flood fill it again
                 output = Floodfilloutput([i,j],image_tlow,255);   % flood fills the low threshold image, and takes the output of that.   
                 image_tlow = Floodfillinput([i,j],image_tlow,255); % flood fills the low threshold input image to indicate that the object we found is checked off.
                 parts = [parts,output];    % adds the output image of the object we found to the parts array to keep track of all objects found in the image
                 check = check + 1;
            end
        end  
    end
    
    
    % Since we captured each object from the original image and added it in a seperate
    % array, we have to re combine all the objects back into their original
    % coordinates
    [height1,width1] = size(parts); % gets the parameter of parts array
    for i=1:height1
        for j=1:width1
            if parts(i,j) == 255    % if the pixel is white aka 255
                if ((j/width)>1.0)  % and if the width is greater than the origianl width
                    output(i,j-((width)*fix(j/width))) = parts(i,j); % we can essentially redraw the object back onto its original coordinate, expcept now we have the double thresholded version of it
                elseif ((j/width)<=1.0) % if this value is less than or equal to 1, then the object is already in its original spot and can stay as such.
                    output(i,j) = parts(i,j);
                end
            end
        end
    end
end