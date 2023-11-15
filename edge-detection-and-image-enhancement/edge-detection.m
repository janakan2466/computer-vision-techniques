% Edge detection

originalImage = imread('bird.jpg'); 
figure; imshow(originalImage);
grayImage = rgb2gray(originalImage); 
figure; imshow(grayImage);

edgeMethods = {'roberts', 'prewitt', 'sobel'};
for i = 1:length(edgeMethods)
    edgeImage = edge(grayImage, edgeMethods{i}); 
    figure('Name', [edgeMethods{i}, ' approximation']); 
    imshow(edgeImage);
end

% Blur the image by applying Gaussian filter
blurredImage = imgaussfilt(grayImage, 2);
figure; imshow(blurredImage); imwrite(blurredImage, 'blurred.jpg');
mask = grayImage - blurredImage;
figure; imshow(mask); 

% Where k = 1 
sharpenedImage1 = grayImage + 1 * mask;
figure; imshow(sharpenedImage1); 

% Where k = 5
sharpenedImage5 = grayImage + 5 * mask;
figure; imshow(sharpenedImage5); 

% Add Gaussian noise for 2 different noise levels
noiseLevels = [(25/255)^2, (50/255)^2];
for i = 1:length(noiseLevels)
    noisyImage = imnoise(grayImage, 'gaussian', 0, noiseLevels(i));
    figure; imshow(noisyImage); 

    % Use average filter to remove noise with a good filter size (3 & 5 respectively)
    filteredAvgImage = imfilter(noisyImage, fspecial('average', 3 + 2*(i-1)));
    figure; imshow(filteredAvgImage); 

    % Use Gaussian filter to remove noise with a good filter size (3 & 5 respectively)
    filteredGaussImage = imgaussfilt(noisyImage, 3 + 2*(i-1));
    figure; imshow(filteredGaussImage); 
end