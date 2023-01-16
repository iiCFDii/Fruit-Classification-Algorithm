function output = dilation(image)   % This is the dilation function
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
                           if double_Image(i+x,j+y) == 255  % if any of the near by pixels are equal to 255, we can set the center pixel equal to 255 as well
                               output(i,j) = 255;
                            % This elseif statement is saying if all of
                            % the surrounding pixels are equal to 0
                            % including the center, then we can set the
                            % center pixel to 0. 
                           elseif double_Image(i+1,j) == 0 && double_Image(i,j+1) == 0 && double_Image(i-1,j) == 0 && double_Image(i,j-1) == 0 && double_Image(i,j) == 0
                                output(i,j) = 0;
                           end
                        end
                    end     
                end
            end
        end
    end 
    output = uint8(output);
end

