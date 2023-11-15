% Low-light image enhancement

originalImage = imread("bird.jpg");
figure; imshow(originalImage);

% Perform localized brightening
brightenedImage = imlocalbrighten(originalImage);
imwrite(brightenedImage, 'LocalizedBrightening.jpg');

% Display the brightened image
figure, imshow(brightenedImage), title("Localized Brightening");

% Create a histogram comparison
figure, subplot(1,2,1), imhist(originalImage), title("Original Image");
subplot(1,2,2), imhist(brightenedImage), title("Brightened Image");

% Brighten the original image with a smaller amount
brightnessAmount = 0.5;
lessBrightImage = imlocalbrighten(originalImage, brightnessAmount);
imwrite(lessBrightImage, 'ImageWithLessBrightening.jpg');

% Display the image with less brightening
figure, imshow(lessBrightImage), title("Image with Less Brightening");

% Apply alpha blending to reduce oversaturation in bright regions
alphaBlendedImage = imlocalbrighten(originalImage, brightnessAmount, 'AlphaBlend', true);
imwrite(alphaBlendedImage, 'ImageWithAlphaBlending.jpg');

% Display the image with alpha blending
figure, imshow(alphaBlendedImage), title("Image with Alpha Blending");

% Create a montage for comparison
figure, montage({brightenedImage, lessBrightImage, alphaBlendedImage}, 'Size', [1, 3], 'BorderSize', 5, 'BackgroundColor', "w");