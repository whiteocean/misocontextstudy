%% Block 3 Audio Visual 
%remember: command . and "sca" to stop and get out of psyc toolbox
rng('shuffle')
clc; clear; clear functions;
cd('/Users/Miren/Documents/MATLAB/GIT/misocontextstudy')




%SubConfig = input('Enter in initials: ','s');
SubConfig = inputdlg('Enter in initials','Input',1,{'MHE'});

%%

filedir = ['/Users/Miren/Documents/MATLAB/GIT/misocontextstudy/Video36']; 
avFiles = dir([filedir,'/*.mp4']);
avFileNames = {avFiles(:).name}';

for n = 1:length(avFileNames)

avF{n} = [filedir '/' avFileNames{n}];

end


timings = [];
ordering = [];

Screen('Preference', 'SkipSyncTests', 1); 
screenNum=0; % setting a variable, which is the screen number
res=[1300 700]; % use this in debugging pass [] to use full window
win = Screen('OpenWindow',screenNum,0, [0 0 res(1) res(2)]);
black = BlackIndex(win);

Screen('DrawText', win,'Press any key when you are ready to begin Block 3', 420, 300, [50 205 105]);
Screen('Flip',win);
pause
tic %experiment begins


vo3 = randperm(length(avFileNames));


%{.
for nn = 1:length(avFileNames)
    timings(end+1) = toc; %trial starts
    
    Screen('FillRect',win,black);
    Screen('Flip',win);
    pause(5) %5 seconds before movie starts
    
    moviename = [avF{vo3(nn)}];

    % Open movie file:
    movie = Screen('OpenMovie', win, moviename);
    
    % Start playback engine:
    timings(end+1) = toc; %clip starts
    Screen('PlayMovie', movie, 1);
     while ~KbCheck || KbCheck
        % Wait for next movie frame, retrieve texture handle to it
        tex = Screen('GetMovieImage', win, movie);
        
        % Valid texture returned? A negative value means end of movie reached:
        if tex<=0
            % We're done, break out of loop:
            break;
        end   
    % Draw the new texture immediately to screen:
        Screen('DrawTexture', win, tex);
        
        % Update display:
        Screen('Flip', win);
        
        % Release texture:
        Screen('Close', tex);
     end
    timings(end+1) = toc; %clip ends

    Screen('DrawText', win,'Please rate the video you just watched from 1-10', 420, 300, [50 205 105]);
    Screen('Flip', win);
    pause(10);   % wait for 10 seconds
    
    % save timings
    timings(end+1) = toc; %trial ends
   
end
%}
Screen('CloseAll');

%% Output Data

timingsarray{1} = timings;
orderingarray = avFileNames(vo3);

timingsarraycells = [timingsarray{1}]';


T = table(timings(1:4:end)',timings(2:4:end)',timings(3:4:end)',timings(4:4:end)',orderingarray,...
     'VariableNames',{'StartTrial' 'StartClip' 'EndClip' 'EndTrial' 'Ordering'}); %writes into a table

save(sprintf('AVBlock3_%s_%s.mat',date,[SubConfig{1}]),'T'); %write as mat file
writetable(T,sprintf('AVBlock3_%s_%s.csv',date,[SubConfig{1}])); %write as csv file

