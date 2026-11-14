function [outABG, abgBackground] = adaptiveBGSub(frame, background, alpha, threshold)
    % Args:
    % frame: grayscale video frame at time t
    % background: grayscale background model from the previous frame
    % alpha: scalar for blending in current image to background model, between 0 and 1
    % threshold: intensity difference threshold used to detect significant pixel changes
    % Output:
    % outABG: Frame with adaptive background subtraction applied
    % abgBackground: Updated background model for the next frame

    frameDifference = abs(background - frame);
    outABG = frameDifference > threshold;
    abgBackground = alpha * frame + (1 - alpha) * background;
end