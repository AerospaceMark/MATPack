% Purpose: take all of the packages in the userpath and set them to the
% master branch

function setAllToMain()

    disp(' ')
    disp("Setting all packages to 'main'...")
    disp(' ')

    directoryInfo = dir(userpath);
    
    for i = 1:length(directoryInfo)
        
        path = strcat(userpath,filesep,directoryInfo(i).name,filesep,'.git');
        
        if isfolder(path)
            disp(strcat("Setting the '",directoryInfo(i).name,"' package to main."))
            
            command = strcat("git -C ",userpath,filesep,directoryInfo(i).name," checkout main");
            
            [successFlag, output] = runSystemCommand(command,false);
            
            % Perhaps the main branch is called "master" (old notation)
            if ~successFlag
                
                command = strcat("git -C ",userpath,filesep,directoryInfo(i).name," checkout master");
            
                [successFlag, output] = runSystemCommand(command,false);
                
            end
                
            % If still not successful
            if ~successFlag

                disp('Error while updating the package. System output is:')
                disp(output)

            end
            
        end
        
    end
    
    disp(' ')
    disp("Done setting all packages to 'master'.")
    disp(' ')

end