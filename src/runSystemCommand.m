%{
Purpose: This function runs system commands and checks to make sure that
there are no attempts to do anything that shouldn't be done
%}

function [successFlag, output] = runSystemCommand(command,showOutput)

    if nargin < 2
        showOutput = false;
    end

    % If no bad/dangerous symbols are contained, then go ahead and run the
    % command
    if ~containsBadSymbol(command)
        
        % Running the command
        [successFlag, output] = system(command);
        
        % Making a "true" value be the case where the command was
        % successful
        successFlag = ~successFlag;
        
        % Showing the output
        if showOutput
            
            disp(output)
            
        end
        
    else % if a bad symbol was found in the command string
        
        successFlag = false;
        output = 'Bad symbol used in command, command not run.';

    end

end

function badSymbol = containsBadSymbol(command)

    if contains(command,'!')
        badSymbol = true;
    elseif contains(command,'&')
        badSymbol = true;
    elseif contains(command," . ") % period with spaces around it
        badSymbol = true;
    elseif contains(command,'..')
        badSymbol = true;
    elseif contains(command,';')
        badSymbol = true;
    elseif contains(command,'#')
        badSymbol = true;
    elseif contains(command,'?')
        badSymbol = true;
    elseif contains(command,'`')
        badSymbol = true;
    elseif contains(command,'~')
        badSymbol = true;
    elseif contains(command,'$')
        badSymbol = true;
    elseif contains(command,'|')
        badSymbol = true;
    else
        badSymbol = false;
    end


end