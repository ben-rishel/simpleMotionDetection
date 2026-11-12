function [outSFD, sfdBackground] = simpleBGSub(frame, background, threshold)

    outSFD = frame/255;
    sfdBackground = background;
end