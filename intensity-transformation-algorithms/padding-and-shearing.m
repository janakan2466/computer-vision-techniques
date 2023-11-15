% Principles of padding and shearing

originalImage = imresize(imread('bird.jpg'), [320, 256]);
shearFactor = 0.45;
affineTransform = maketform('affine', [1 0 0; shearFactor 1 0; 0 0 1] );
orange = [255 127 0]';

resampler = makeresampler({'cubic','nearest'},'fill');
shearedImage = imtransform(originalImage, affineTransform, resampler, 'FillValues', orange); 

figure, imshow(originalImage), title('Original Image');
figure, imshow(shearedImage), title('Sheared Image');

[U,V] = meshgrid(0:64:320,0:64:256);
[X,Y] = tformfwd(affineTransform, U, V);
gray = 0.65 * [1 1 1];

figure, imshow(originalImage), hold on, line(U, V, 'Color', gray), line(U', V', 'Color', gray);
figure, imshow(shearedImage), hold on, line(X, Y, 'Color', gray), line(X', Y', 'Color', gray);

for u = 0:64:320
    for v = 0:64:256
        theta = (0 : 32)' * (2 * pi / 32);
        uc = u + 20*cos(theta);
        vc = v + 20*sin(theta);
        [xc,yc] = tformfwd(affineTransform, uc, vc);
        figure, imshow(originalImage), hold on, line(uc, vc, 'Color', gray);
        figure, imshow(shearedImage), hold on, line(xc, yc, 'Color', gray);
    end
end

padMethods = {'fill', 'replicate', 'bound', 'circular', 'symmetric'};
for i = 1:length(padMethods)
    resampler = makeresampler({'cubic','nearest'}, padMethods{i});
    transformedImage = imtransform(originalImage, affineTransform, resampler, 'XData', [-49 500], 'YData', [-49 400], 'FillValues', orange);
    figure, imshow(transformedImage), title(['Pad Method = ', padMethods{i}]);
end

resamplerFill = makeresampler({'cubic','nearest'}, 'fill');
resamplerBound = makeresampler({'cubic','nearest'}, 'bound');
transformedImageFill = imtransform(originalImage, affineTransform, resamplerFill, 'XData', [423 439], 'YData', [245 260], 'FillValues', orange);
transformedImageBound = imtransform(originalImage, affineTransform, resamplerBound, 'XData', [423 439], 'YData', [245 260], 'FillValues', orange);

transformedImageFill = imresize(transformedImageFill, 12, 'nearest');
transformedImageBound = imresize(transformedImageBound, 12, 'nearest');

figure;
subplot(1,2,1), imshow(transformedImageFill), title('Pad Method = ''fill''');
subplot(1,2,2), imshow(transformedImageBound), title('Pad Method = ''bound''');