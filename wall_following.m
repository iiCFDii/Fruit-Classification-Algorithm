% Name: Christopher Ciobanu
% Date: 9/29/22
% ECPE 124 Digital Image Processing
% Program 2 Fruit Classifcation
%
% This is the wall_following function which draws and finds the edge of
% each fruit/object in the image

function output = wall_following(o_image,l_image,label)
    [height,width,depth] = size(o_image);
    if depth > 1
        o_image = rgb2gray(o_image);    %converts rgb image to greyscale
    end   
    
    % This for loop finds the first pixel of each fruit and marks the edge
    % with a white pixel
     for i=1:height
        for j=1:width
            if l_image(i,j) == label
                ion = i;
                jon = j;
                istart = i;
                jstart = j;
                o_image(i,j) = 255;
                break
            end
        end
         if l_image(i,j) == label
             break
         end
     end
     
     % This while loop looks for the first on pixel and continues to turn
     % right until it finds one
     direction = 0;
     while(isFrontOn(l_image,ion,jon,direction)) 
        direction = turnRight(direction);
     end
     
     % turns right again
     direction = turnRight(direction);
     check1 = true; 
        
     % This is the main while loop that goes all the way around the edge of
     % the fruit, it will check if the left pixel is on and then turn left
     % and move forward, if the front pixel is on instad, it will turn
     % right, and if none of those parameters are met it will move forward
     
     % I also have checks in place that checks if the algorithm has made it
     % all the way around the object, and if it has, then to stop the whioe
     % loop
     while(check1 || ~(ion == istart && jon == jstart))
         if isLeftOn(l_image,ion,jon,direction)
             [ion,jon,direction] = turnLeftMoveFwd(ion,jon,direction); 
              if o_image(ion,jon) == 255
                check1 = false; 
              end
              o_image(ion,jon) = 255;
         elseif ~(isFrontOn(l_image,ion,jon,direction))
             direction = turnRight(direction);  
         else
             [ion,jon] = moveFwd(ion,jon,direction);
             if o_image(ion,jon) == 255
                check1 = false;
             end
             o_image(ion,jon) = 255;

         end
         
     end
    
     output = o_image;
     
end


%
%        0
%   3    x   1      %% I used this as my reference for direction
%        2
%
%
    
% This function checks if the pixel in front is on or not 
function output = isFrontOn(image,i,j,direction)
   switch direction
       case 0 
           output = (image(i-1,j) == image(i,j));
       case 1
           output = (image(i,j+1) == image(i,j));
       case 2
           output = (image(i+1,j) == image(i,j));
       case 3 
           output = (image(i,j-1) == image(i,j));
           
   end

end

% This funcion turns the direction to the right
function output = turnRight(direction)
    switch direction
       case 0 
           output = 1;
       case 1
           output = 2;
       case 2
           output = 3;
       case 3 
           output = 0;  
    end
end

% This function checks if the left pixel is on
function output = isLeftOn(image,i,j,direction)
     switch direction
       case 0 
           output = (image(i,j-1) == image(i,j));
       case 1
           output = (image(i-1,j) == image(i,j));
       case 2
           output = (image(i,j+1) == image(i,j));
       case 3 
           output = (image(i+1,j) == image(i,j));   
     end
end

% This function turns the direction to the left and then moves the current pixel forward
function [inew,jnew,directionNew] = turnLeftMoveFwd(i,j,direction)
    switch direction
       case 0 
           directionNew = 3;
           jnew = j - 1;
           inew = i; 
       case 1
            directionNew = 0;
            inew = i - 1;
            jnew = j;
       case 2
           directionNew = 1;
           jnew = j+1;
           inew = i;
       case 3 
           directionNew = 2;
           jnew = j;
           inew = i + 1;   
    end
end

% This function moves our current position forward, depending on the
% direction
function [inew,jnew] = moveFwd(i,j,direction)
    switch direction
       case 0 
           inew = i - 1;
           jnew = j;
       case 1
           jnew = j+1;
           inew = i;          
       case 2
           jnew = j;
           inew = i + 1;
       case 3 
           jnew = j - 1;
           inew = i;           
    end
end