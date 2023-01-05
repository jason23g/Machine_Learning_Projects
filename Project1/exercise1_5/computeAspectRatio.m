function [aRatio,BoundingBox] = computeAspectRatio(image)
    [num_rows, num_cols] = size(image);

    % Fill your code

    [im_Y, im_X] = find(logical(image));
    width = max(im_X) - min(im_X)+1;
    height = max(im_Y) - min(im_Y)+1;
    
    %The offset 0.5 has been tested with trial and error in order to have a
    %perfect bounding box
    BoundingBox = [(min(im_X)-0.5) (min(im_Y)-0.5) width height];
    
    aRatio = width./height;
    
end

