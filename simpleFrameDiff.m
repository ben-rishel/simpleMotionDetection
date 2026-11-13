function [outSFD, sfdBackground] = simpleFrameDiff(frame, background, threshold)
    % Args:
    % frame: grayscale video frame at time t
    % background: grayscale reference frame at time t-1
    % threshold: intensity difference threshold used to detect significant pixel changes
    % Output:
    % outSFD: Frame with frame differencing applied
    % sfdBackground: Updated reference frame B(T) for the next iteration 
    
    frameDifference = abs(background - frame); % Compute absolute difference of equal dimension arrays
    outSFD = frameDifference > threshold; % Apply threshold
    sfdBackground = frame; % Current frame will become the background in t+1 
end