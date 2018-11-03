function [img, aperture] = grating(rotation, noise, contrast, frames)
% rotation: clockwise in radian
% noise: level of Gaussian mask
%rotation = rotation/pi*4;
sf=12; % spatial freq in cycles per image
width = 121;
annulusPix = 25;



% Create separate [-1, 1] range meshgrid for pixel-space filters.
[px, py] = meshgrid(linspace(-1, 1, width));
pr = sqrt(px.^2 + py.^2);

% cut out annulus
aperture = exp(-4 * pr.^2);
aperture = aperture .* (1 + erf(10 * (pr - annulusPix / width)));



img = zeros(frames, width, width);

for f=1:frames
    % Times contrast here because we do not want the noise change with the contrast
    Z = sin(sf*(px+py*rotation(f)))*contrast; 
    nz = bpg.genImages(1,width,sf/width,noise,0,0);
    Z = Z + squeeze(nz);
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