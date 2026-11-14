function [outPFD, pfdBackground, pfdHistory] = persistentFrameDiff(frame, background, history, gamma, threshold)
    % Args:
    % frame: grayscale video frame at time t
    % background: grayscale reference frame at time t-1
    % history: motion history image from the previous frame
    % gamma: decay value for motion history at each frame
    % threshold: intensity difference threshold used to detect significant pixel changes
    % Output:
    % outPFD: Frame with persistent frame differencing applied
    % pfdBackground: Updated reference frame B(T) for the next iteration
    % pfdHistory: updated motion history image
    
    frameDifference = abs(background - frame);
    outPFD = frameDifference > threshold;

    tmp = max(history-gamma, 0);
    pfdHistory = max(255*outPFD, tmp);

    pfdBackground = frame;
end