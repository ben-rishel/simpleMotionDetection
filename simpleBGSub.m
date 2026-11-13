function [outSBG, sbgBackground] = simpleBGSub(frame, background, threshold)
    % Args:
    % frame: grayscale video frame at time t
    % background: grayscale background image of scene
    % threshold: intensity difference threshold used to detect significant pixel changes
    % Output:
    % outSBG: Frame with simple background subtraction applied
    % sbgBackground: Return background to main

    frameDifference = abs(background - frame); % Compute absolute difference of equal dimension arrays
    outSBG = frameDifference > threshold; % Apply threshold
    sbgBackground = background; % Return background
end