% Sphere data fitting with outliers 

data = load("object3d.mat");
pointCloud = data.ptCloud;

% Display the point cloud
figure, pcshow(pointCloud), title("Detect a sphere in a point cloud");

% Set the maximum point-to-sphere distance for sphere fitting to 1 cm
maxDistance = 0.01;

% Set the region of interest to constrain the search
roi = [-inf, 0.5; 0.2, 0.4; 0.1, inf];
sampleIndices = findPointsInROI(pointCloud, roi);

% Detect the globe in the point cloud and extract it
[model, inlierIndices] = pcfitsphere(pointCloud, maxDistance, 'SampleIndices', sampleIndices);
globe = select(pointCloud, inlierIndices);

figure, pcshow(globe), title("Globe Point Cloud");