function likelihood = subjectDataLikelihood(alpha)
% alpha: lapse rate 

filename='gaborV2-subject03-Contrast'

gd = load(filename);
data = gd.results{1, 1};

temporal_kernel = PlotSubject(filename, 0, 'probit');

data_log_l = zeros(10, size(data.choice, 2));
for i = 1:10
    fit = glmval(temporal_kernel(1:2, i), data.ideal_frame_signals(:, i), 'probit');
    for j = 1:size(data.choice, 2)
        prediction = (fit(j)*(1-alpha) + rand*alpha) > 0.5;
        if prediction == data.choice(j) % using a criterion rule?
            data_log_l(i,j) = log(fit(j));
        else
            data_log_l(i,j) = log(1-fit(j)); 
        end
    end
end

likelihood = sum(data_log_l(:));

end

         


