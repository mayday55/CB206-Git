function temporal_kernel = PlotSubject(filename, phase, fun)
% filename: string, the name of the .mat file
% phase: 0 or 1, 'contrast' or 'noise'

% if nargin < 3, datadir = fullfile(pwd, '..', 'RawData'); end
% catdir = fullfile(datadir, '..', 'RawData');


gd = load(filename);
% data = gd.GaborData; % for individual raw data
data = gd.results{1, 1};

% disp(data);

if phase == 0
    stair_var = 'contrast';
    stair_var_name = 'contrast';
elseif phase == 1
    stair_var = 'true_ratio';
    stair_var_name = 'ratio';
elseif phase == 2
    stair_var = 'noise';
    stair_var_name = 'noise';
else
    error('Expected phase 0 for Contrast or 1 for Ratio or 2 for Noise');
end


%disp(gd.GaborData);

% recode 0 to be -1 in response
% data.choice = data.choice.*2-1;

temporal_kernel = zeros(3, 10);
figure(1)
for i=1:10
    % disp(size(data.choice(:))); 
    % disp(size(data.ideal_frame_signals(:, 1))); 
    % plot(data.ideal_frame_signals(:, i),data.choice(:), 'd'); hold on;
    [b, ~, stats] = glmfit(data.ideal_frame_signals(:, i),data.choice(:), 'binomial','link',fun); 
    disp(b);
    temporal_kernel(1:2, i) = b;
    temporal_kernel(3, i) = stats.se(2);
    
    
    logfit = glmval(b, -5.0:5.0, fun); 
    %plot(-5.0:5.0, logfit);
    %yfit = glmval(b, data.ideal_frame_signals(:, i), fun);
    %plot(data.ideal_frame_signals(:, i), yfit, 'd');
    xlabel('Frame signal'); ylabel('P(choice=right)');
    hold on;
    
    disp(temporal_kernel(:, i));
    
end   

hold off;
figure(2)
%plot(1:10, temporal_kernel(2, :)); 
errorbar(1:10, temporal_kernel(2, :), temporal_kernel(3,:)); 
    
end