function output = erosion(image) % This is the erosion function
[height,width,depth] = size(image); % Sets parameters based off of image
    if depth > 1
        image = rgb2gray(image);    % If depth is greater than 2, this means it has 3 layers and needs to be converted to a greyscale image.
    end
    double_Image = double(image);
    output = zeros(height,width);
    
    % 4 for loops to traverse through the image as well as the 4 nearest
    % neighbors of a pixel
    for i=1:height
        for j=1:width
            for x=-1:1
                for y=-1:1
                    if ((i-1)>0 &&  (i+1)<=height && (j-1)>0 && (j+1)<=width)   % Checks to make sure we are not over stepping boundaries
                        if(~((x==1 && y==1) || (x==-1 && y==-1) || (x==1 && y==-1) || (x==-1 && y==1))) % Skips the nearby corners of the pixel.
                           if double_Image(i+x,j+y) == 0    % if any of the 4 neighbors or itself is equal to 0, then we can set the output pixel to 0.
                               output(i,j) = 0;
                           % This elseif statement says if all of the neighbors of the pixel and itself are equal to 255, then we can set the cetner pixel to 255.   
                           elseif double_Image(i+1,j) == 255 && double_Image(i,j+1) == 255 && double_Image(i-1,j) == 255 && double_Image(i,j-1) == 255 && double_Image(i,j) == 255
                                output(i,j) = 255;
                           end
                        end
                    end     
                end
            end
        end
    end 
    output = uint8(output);
end

