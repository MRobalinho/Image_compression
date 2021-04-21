%% Check that user has the specified Toolbox installed and licensed.
hasLicenseForToolbox = license('test', 'image_toolbox');   % license('test','Statistics_toolbox'), license('test','Signal_toolbox')
if hasLicenseForToolbox
  % User does not have the toolbox installed, or if it is, there is no available license for it.
  % For example, there is a pool of 10 licenses and all 10 have been checked out by other people already.
  ver % List what toolboxes the user has licenses available for.
  message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
  reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
  if strcmpi(reply, 'No')
    % User said No, so exit.
    return;
  end
end
