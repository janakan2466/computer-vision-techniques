% Basic intensity transformation algorithms

originalImage = imread('bird.jpg');
grayImage = rgb2gray(originalImage);

figure, imshow(originalImage), title('Original Image');
figure, imshow(grayImage), title('Grayscale Image');

% Log transformation
logTransformedImage = log(1 + im2double(grayImage));
figure, imshow(logTransformedImage), title('Log Transformed Image');

% Inverse log transformation
inverseLogTransformedImage = exp(logTransformedImage) - 1;
figure, imshow(inverseLogTransformedImage), title('Inverse Log Transformed Image');

% Power law transformations
gammaValues = [0.5, 2, 5, 0.3, 3];
powerLawTransformedImages = arrayfun(@(gamma) im2double(grayImage).^gamma, gammaValues, 'UniformOutput', false);
figure, imshow(cat(2, powerLawTransformedImages{:})), title('Power-law Transformed Images');

% Bit plane slicing
bitPlanes = arrayfun(@(bit) bitget(grayImage, bit), 1:8, 'UniformOutput', false);
figure, imshow(cat(2, bitPlanes{:})*255), title('Bit Planes');

% Highest 4 and 2 bit planes
highest4BitPlanes = sum(cellfun(@(bitPlane, bit) bitPlane*(2^bit), bitPlanes(5:8), num2cell(5:8)));
highest2BitPlanes = sum(cellfun(@(bitPlane, bit) bitPlane*(2^bit), bitPlanes(7:8), num2cell(7:8)));
figure, imshow(highest4BitPlanes), title('Highest 4 Bit Planes');
figure, imshow(highest2BitPlanes), title('Highest 2 Bit Planes');

% Histogram equalization
equalizedHistogram = histeq(grayImage);
figure, imhist(grayImage), title('Histogram of Original Grayscale Image');
figure, imhist(equalizedHistogram), title('Equalized Histogram');
figure, imshow(equalizedHistogram), title('Equalized Image');

% Histogram equalization for a 3-bit image
threeBitImage = [1 2 4 7 3; 2 4 7 3 1; 5 6 2 1 1; 4 7 1 1 1];
equalizedThreeBitImage = [2 4 5 7 4; 4 5 7 4 2; 6 6 4 2 2; 5 7 2 2 2];
figure, histogram(threeBitImage, 8), title('Histogram of 3-bit Image');
figure, histogram(equalizedThreeBitImage, 8), title('Equalized Histogram of 3-bit Image');