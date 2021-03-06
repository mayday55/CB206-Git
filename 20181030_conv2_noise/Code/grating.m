function [img, aperture] = grating(rotation, noise, contrast, frames)
% rotation: clockwise in radian
% noise: level of Gaussian mask
%rotation = rotation/pi*4;
sf=12; % spatial freq in cycles per image
width = 121;
annulusPix = 25;
%noise = noise* 0.3;


% Create separate [-1, 1] range meshgrid for pixel-space filters.
[px, py] = meshgrid(linspace(-1, 1, width));
pr = sqrt(px.^2 + py.^2);

% cut out annulus
aperture = exp(-4 * pr.^2);
aperture = aperture .* (1 + erf(10 * (pr - annulusPix / width)));

blur = 20;
[xx, yy] = meshgrid(linspace(-2,2,blur));
kernel = normpdf(sqrt(xx.^2 + yy.^2));

img = zeros(frames, width, width);

for f=1:frames
    % Times contrast here because we do not want the noise change with the contrast
    Z = sin(sf*(px+py*rotation(f)))*contrast; 
    %add the noise first then cut out annulus
    white_noise = randn(width);
    blurred_noise = conv2(white_noise, kernel, 'same'); 
    Z = Z + noise*blurred_noise;
%    Z = reshape(Z,[width,width]);
    img(f, :, :) = squeeze(aperture .* Z);
end

% add noise
% noise_img = (noise) .* (normrnd(0, 1, frames, width, width));
% img = img + noise_img;

% Normalize into range [-1, 1]
% img = img / max(abs(img(:)));

%colormap(gray);
%axis image;
%axis('off');
%imagesc(img);  


end