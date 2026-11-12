function proj3main(dirstring, maxframenum, abs_diff_threshold, alpha_parameter, gamma_parameter)
    % dirstring: directory where numbered input image files are read from
    % maxframenum: frame number of the last image file in the sequence
    % abs_diff_threshold: lambda threshold for intensity values
    % alpha_parameter: blending param in adaptive background sub algo
    % gamma_parameter: decay param in persistent frame diff
    
    % Remove trailing slashes (both Windows and Unix styles)
    dirstring = strip(dirstring, "right", "/");
    dirstring = strip(dirstring, "right", "\");

    % Extract sequence name from input directory
    [~, sequenceName, ~] = fileparts(dirstring);

    % Create output folder name using sequence and parameters
    outputFolderName = sprintf("%s_L%g_a%g_g%g", ...
        sequenceName, abs_diff_threshold, alpha_parameter, gamma_parameter);

    % Create full output path
    outputFolder = fullfile("Results", outputFolderName);

    % Create output folder if it doesn't exist
    if ~isfolder(outputFolder)
        mkdir(outputFolder);
    end

    % read first image (convert to greyscale and double) to establish background and history
    firstImagePath = fullfile(dirstring, sprintf("f%04d.jpg", 1));
    img1 = imread(firstImagePath);
    img1Gray = rgb2gray(img1);
    img1GrayDouble = double(img1Gray);
    
    sbgBackground = img1GrayDouble; % simple BG subtraction background
    sfdBackground = img1GrayDouble; % simple frame differencing background
    abgBackground = img1GrayDouble; % adaptive BG subtraction background
    pfdBackground = img1GrayDouble; % persistent frame differencing background
    pfdHistory = zeros(size(img1GrayDouble)); % persistent frame differncing history
    

    % loop through images starting with the first to have fully black start
    for t = 1:maxframenum
        % read frame t
        framePath = fullfile(dirstring, sprintf("f%04d.jpg", t));
        frameT = imread(framePath);
        frameTGray = double(rgb2gray(frameT));
        
        % calculate frames and backgrounds for 4 algorithms
        [outSBG, sbgBackground] = simpleBGSub(frameTGray, sbgBackground, abs_diff_threshold);
        [outSFD, sfdBackground] = simpleFrameDiff(frameTGray, sfdBackground, abs_diff_threshold);
        [outABG, abgBackground] = adaptiveBGSub(frameTGray, abgBackground, alpha_parameter, abs_diff_threshold);
        [outPFD, pfdBackground, pfdHistory] = persistentFrameDiff(frameTGray, pfdBackground, pfdHistory, gamma_parameter, abs_diff_threshold);

        % Convert PFD grayscale from 0-255 to 0-1
        outPFD = outPFD / 255;

        % write output to folder
        outImage = [outSBG outSFD ; outABG outPFD];
        
        outputPath = fullfile(outputFolder, sprintf("out%04d.png", t));
        imwrite(outImage, outputPath);
    end

end