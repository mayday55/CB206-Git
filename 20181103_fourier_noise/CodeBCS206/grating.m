function [img, aperture] = grating(rotation, phase, contrast, frames)
% rotation: clockwise in radian
% noise: level of Gaussian mask
sf = 12; % spatial freq in cycles per image
width = 121;
annulusPix = 25;

% Create separate [-1, 1] range meshgrid for pixel-space filters.
[px, py] = meshgrid(linspace(-1, 1, width));
pr = sqrt(px.^2 + py.^2);

% cut out annulus
aperture = exp(-4 * pr.^2);
aperture = aperture .* (1 + erf(10 * (pr - annulusPix / width)));

% blur = 20;
% [xx, yy] = meshgrid(linspace(-2,2,blur));
% kernel = normpdf(sqrt(xx.^2 + yy.^2));

img = zeros(frames, width, width);

for f=1:frames
    % Times contrast here because we do not want the noise change with the contrast
    Z = sin(sf*(px+py*rotation(f))+phase)*contrast; 
    %add the noise first then cut out annulus
%     white_noise = randn(width);
%     blurred_noise = conv2(white_noise, kernel, 'same'); 
%     Z = Z + noise*blurred_noise;
%    Z = reshape(Z,[width,width]);

    temp = 0;
    Z = Z + squeeze(bpg.genImages(1,width,sf/width,0.03,temp,0.0))*50;
    img(f, :, :) = squeeze(aperture .* Z);
end

%colormap(gray); %axis image; axis('off'); imagesc(img);  


end