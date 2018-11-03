function [image_array, frame_categories, checksum] = GaborStimulus(GaborData, trial)
%GABORSTIMULUS(GaborData, trial) create (or recreate) stimulus frames based
%on parameters in GaborData and the seed, contrast, ratio, and noise on the
%given trial. If 'GaborData.iid(trial)' is true, each frame's category is
%drawn iid based on the 'ratio' parameter. Otherwise, exactly
%round(ratio*num_images) frames will match the 'true' category.
%
%This function makes no modifications to GaborData.

% Set RNG state to recreate stimulus for this trail.
rng(GaborData.seed(trial), 'twister');

    stim_fcn = @grating;


if ~isfield(GaborData, 'iid') || GaborData.iid(trial)
    % Randomly set each frame to match (or mismatch) the correct choice
    % for this trail, using the current 'ratio' to decide.
    match_frames = rand(1, GaborData.number_of_images) <= GaborData.ratio(trial);
else
    % Randomly permute whether each frame matches the true category, with
    % 'ratio' percent of them matching.
    n_match = round(GaborData.ratio(trial) * GaborData.number_of_images);
    match_frames = [true(1, n_match) false(1, GaborData.number_of_images - n_match)];
    match_frames = Shuffle(match_frames);
end

frame_categories = zeros(size(match_frames));

% Choose frames based on whether correct answer this trial is Left or Right
if GaborData.correct_answer(trial) == 1
    frame_categories(match_frames) = GaborData.left_category;
    frame_categories(~match_frames) = GaborData.right_category;
else
    frame_categories(~match_frames) = GaborData.left_category;
    frame_categories(match_frames) = GaborData.right_category;
end

% frame_categories = frame_categories/45*pi/4;

% Set random seed again to keep match_frames independent of pixel noise.
rng(GaborData.seed(trial), 'twister');
% image_array = [];
% for i = 1:10
%     i = stim_fcn(frame_categories, GaborData.noise(trial));
%     image_array = [image_array, i];
% end

image_array = stim_fcn(frame_categories, GaborData.noise(trial),  GaborData.contrast(trial), GaborData.number_of_images);

image_array = uint8(image_array + 127);
image_array = min(image_array, 255);
image_array = max(image_array, 0);
disp('contrast ');
disp([trial GaborData.contrast(trial)]);
disp('image array: ');
disp([trial image_array(trial)]);
disp([frame_categories]);
disp('step size')
disp(GaborData.step_size(trial));

checksum = mean(image_array(:));

if isfield(GaborData, 'checksum') && GaborData.checksum(trial) ~= 0 && GaborData.checksum(trial) ~= checksum
    error('Stimulus reconstruction checksum failed!');
end

end