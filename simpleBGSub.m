function [outSBG, sbgBackground] = simpleBGSub(frame, background, threshold)

    outSBG = frame/255;
    sbgBackground = background;
end