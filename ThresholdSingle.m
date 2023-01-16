function output = ThresholdSingle(image,threshold) % Single Threshold
    [height,width,depth] = size(image);
    if depth > 1
        image = rgb2gray(image);
    end
    double_Image = double(image);
    output = zeros(height,width);
    
    % If the pixels in the image are above the set threshold they will be
    % set to 254, if not than they will be set to 0. I chose to set them to
    % 254 instead of 255, for the later functions that will use this. If we
    % tried to floodfill an image that was single thresholded, it would not
    % work since all the values would already be 255, but if we set them to
    % 254, we can track will part of the image was flood filled by checking
    % if the pixels are 254 (untouched) or 255 (the floodfilled value) 
    for i=1:height
        for j=1:width
            if double_Image(i,j) > threshold
                output(i,j) = 254;
            else
                output(i,j) = 0;
            end
        end
    end
    output = uint8(output);
end

