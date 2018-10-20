function sig = getSignal_grating(im, oriDEG, oriKappa, template)
%BPG.GETSIGNAL(bpg_im, oriDEG, oriKappa) compute the amount of energy there
%is in the given image(s) at the given orientation band. Spatial Frequency
%is integrated out.
%
%BPG.GETSIGNAL(bpg_im, oriDEG, oriKappa, spFreqCPP, spFreqStdCPP) also
%includes a spatial frequency filter.
%
% bpg_im must be an image (a matrix) or a [frames x height x width] array
% of images.
%
% Returns a [frames x 1] vector of signal levels.

if ismatrix(im)
    im = double(reshape(im, [1 size(im)]));
end
[frames, width, ~] = size(im);

%% Get signal of each frame.
sig = zeros(frames, 1);
for f=1:frames
    sig(f) = 1.0/oriKappa^2 * dot(double(reshape(im(f,:,:),[1,width*width])), double(reshape(template,[1,width*width])));
end
end