function plan = buildfile
    plan = buildplan(localfunctions);
end

function packageTask(~, buildOptions)
    arguments
        ~

        buildOptions.VersionNumber (1,1) string = missing;

        % By default, set the maximum compatible MATLAB release to the
        % current release.
        buildOptions.MaximumMatlabRelease (1,1) string = matlabRelease.Release;
    end

    toolboxPackagingFile = fullfile(pwd, "toolboxPackaging.prj");

    toolboxOptions = matlab.addons.toolbox.ToolboxOptions(toolboxPackagingFile);

    % If buildOptions.VersionNumber is set, override the version number
    % set in toolboxPackaging.prj.
    if ~ismissing(buildOptions.VersionNumber)
        toolboxOptions.ToolboxVersion = buildOptions.VersionNumber;
    end

    toolboxOptions.MaximumMatlabRelease = buildOptions.MaximumMatlabRelease;

    % Set the package file name.
    outputFileName = sprintf( ...
        "%s-%s.mltbx", ...
        strrep(toolboxOptions.ToolboxName, " ", ""), ...
        toolboxOptions.ToolboxVersion ...
    );

    toolboxOptions.OutputFile = fullfile(pwd, "release", outputFileName);

    % Create the mltbx file.
    matlab.addons.toolbox.packageToolbox(toolboxOptions);
end