function pi_per_frame_normalized = proximity_index(referent_gaze, comparison_gaze, n_frames, k)

% This function calculates the Proximity Index (PI) per frame for a given
% set of reference gaze data (referent_gaze) and a specific group's gaze data (comparison_gaze)
% across a specified number of frames (n_frames). The PI is normalized within
% the range of 0 to 1. Higher values denote more "referent-like" gaze patterns in the comparison group.
%
% Inputs:
%   referent_gaze   - Reference gaze data for a standard or control group
%   comparison_gaze - Gaze data for a specific comparison group (e.g., ASD or other)
%   n_frames        - Number of frames to process
%   k               - Index of the current subject in the comparison group
%
% Outputs:
%   pi_per_frame_normalized - Array containing normalized PI for each frame

% Reference:
% "Unraveling the Developmental Dynamic of Visual Exploration of Social Interactions in Autism"
% N. Kojovic, S. Cekic, S.H. Castañón, M. Franchini, H.F. Sperdin, C. Sandini,
% R.K. Jan, D. Zöller, L. Ben Hadid, D. Bavelier, M. Schaer
% bioRxiv 2020.09.14.290106; doi: https://doi.org/10.1101/2020.09.14.290106
%



% Initialize the output array
pi_per_frame_normalized = zeros(1, n_frames);

% Parallel loop over each frame
parfor s = 1:n_frames
    % Extract gaze data for all subjects for the current frame
    allgaze_per_frame = squeeze(referent_gaze(:, s, :))';
    % Remove rows with NaN values
    allgaze_per_frame = allgaze_per_frame(~any(isnan(allgaze_per_frame), 2), :);

    % Extract gaze data for the current subject in the comparison group for the current frame
    subjects_gaze_per_frame = squeeze(comparison_gaze(:, s, k))';

    % Calculate the density distribution of gaze points
    [~, density, X, Y] = kde2d(allgaze_per_frame);

    % Generate contour data from the density distribution
    [C, ~] = contour(X, Y, density, 100, 'LineWidth', 2.5);

    % Process contour data
    S = contourdata(C);
    n_contours = size(S, 2);
    levels = zeros(1, n_contours);
    in_contour_per_level = zeros(size(subjects_gaze_per_frame, 1), n_contours);

    % Determine which contour level each gaze point falls into
    for kk = 1:n_contours
        levels(kk) = S(1, kk).level;
        in_contour_per_level(:, kk) = inpolygon(subjects_gaze_per_frame(:, 1), subjects_gaze_per_frame(:, 2), S(1, kk).xdata, S(1, kk).ydata);
    end

    % Calculate the normalized proximity index for each gaze point
    level_for_each_point = zeros(size(subjects_gaze_per_frame, 1), 1);
    if isnan(subjects_gaze_per_frame)
        pi_per_frame_normalized(1, s) = NaN;
    else
        for kkk = 1:size(subjects_gaze_per_frame, 1)
            level_for_each_point(kkk) = max(in_contour_per_level(kkk, :) .* levels);
            pi_per_frame_normalized(1, s) = level_for_each_point / max(levels);
        end
    end
end
end
