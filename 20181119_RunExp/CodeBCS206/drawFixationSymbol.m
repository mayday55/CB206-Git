function drawFixationSymbol(wPtr, settings)
xc = settings.screenSize(3)/2; %	Gets the middle of the horizontal axis
yc = settings.screenSize(4)/2; % Gets the middle of the vertical axis
xw = 15;
yh = 15;
fixation_bbox = [xc - xw/2, yc - yh/2, xc + xw/2, yc + yh/2];

Screen('DrawLine', wPtr, [180 180 180], fixation_bbox(1), yc, fixation_bbox(3), yc);
Screen('DrawLine', wPtr, [180 180 180], xc, fixation_bbox(2), xc, fixation_bbox(4));

% if strcmpi(tracker_info.fixationSymbol, 'r')
%     % Rectangular monochromatic symbol.
%     Screen('FillRect', wPtr, tracker_info.fixationSymbolColors(1, :), fixation_bbox);
% elseif strcmpi(tracker_info.fixationSymbol, 'c')
%     % Circular monochromatic symbol.
%     Screen('FillOval', wPtr, tracker_info.fixationSymbolColors(1, :), fixation_bbox);
% elseif strcmpi(tracker_info.fixationSymbol, 'b')
%     % Bulls-eye symbol.
%     outer_size = tracker_info.fixationSymbolSize(1);
%     inner_size = round(0.3 * outer_size);
%     Screen('DrawDots', wPtr, tracker_info.fixationCenter, outer_size, tracker_info.fixationSymbolColors(2, :), [0 0], 1);
%     Screen('DrawDots', wPtr, tracker_info.fixationCenter, inner_size, tracker_info.fixationSymbolColors(1, :), [0 0], 1);
%     Screen('DrawLine', wPtr, tracker_info.fixationSymbolColors(1, :), xc-outer_size/2, yc, xc+outer_size/2, yc, 1);
%     Screen('DrawLine', wPtr, tracker_info.fixationSymbolColors(1, :), xc, yc-outer_size/2, xc, yc+outer_size/2, 1);
% elseif strcmpi(tracker_info.fixationSymbol, '+')
%     % Fixation cross.
%     Screen('DrawLine', wPtr, tracker_info.fixationSymbolColors(1, :), fixation_bbox(1), yc, fixation_bbox(3), yc);
%     Screen('DrawLine', wPtr, tracker_info.fixationSymbolColors(1, :), xc, fixation_bbox(2), xc, fixation_bbox(4));
% elseif strcmpi(tracker_info.fixationSymbol, 'c+')
%     % Fixation cross (90% size) inside a circle.
%     Screen('FillOval', wPtr, tracker_info.fixationSymbolColors(1, :), fixation_bbox);
%     cross_bbox = ptbCenteredRect([xc yc], [xw yh]*0.9);
%     Screen('DrawLine', wPtr, tracker_info.fixationSymbolColors(2, :), cross_bbox(1), yc, cross_bbox(3), yc);
%     Screen('DrawLine', wPtr, tracker_info.fixationSymbolColors(2, :), xc, cross_bbox(2), xc, cross_bbox(4));
end