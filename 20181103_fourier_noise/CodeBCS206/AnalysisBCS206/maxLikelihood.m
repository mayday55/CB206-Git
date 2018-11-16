function alpha = maxLikelihood()

% fun = @subjectDataLikelihood(filename, phase, fun_regression)

alpha = fminsearch(@subjectDataLikelihood,0.01); 

disp(alpha);

end

