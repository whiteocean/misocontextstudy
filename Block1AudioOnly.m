%% Block 1 Audio Only
%remember: command . and "sca" to stop and get out of psyc toolbox
rng('shuffle') %prevents code from repeating only certain "randomly" generated sequences. 
clc; clear; clear functions;
cd('/Users/Miren/Documents/MATLAB/GIT/misocontextstudy')
%% Get Subject Initials

SubConfig = inputdlg('Enter in initials','Input',1,{'MHE'});


%% SELECT DIRECTORY CONTAINING ONLY M4A AUDIO FILES
filedir = ['/Users/Miren/Documents/MATLAB/GIT/misocontextstudy/Audio36']; 
aFiles = dir([filedir,'/*.m4a']);
aFileNames = {aFiles(:).name}';

%% IMPORT ALL M4A FILES FROM CHOSEN DIRECTORY
for nn = 1:length(aFileNames)
    [ReadAudio,FpS] = audioread([filedir '/' aFileNames{nn}],'native');
    audioPlayerObj(nn) = audioplayer(ReadAudio,FpS);
    audioPlayerObjFpS{nn} = audioPlayerObj.SampleRate;
end
 
%% PRESET VARIABLES
playThisManySeconds = 15;%make 15
timings = [];
ordering = [];


%% MAIN EXPERIMENTAL LOOP

Screen('Preference', 'SkipSyncTests', 1); 
screenNum=0; % setting a variable, which is the screen number
res=[1300 700]; % use this in debugging pass [] to use full window
[w,rect] = Screen('OpenWindow',screenNum,0, [0 0 res(1) res(2)]);
black = BlackIndex(w);

Screen('DrawText', w,'Press any key when you are ready to begin Block 1', 420, 300, [50 205 105]);
Screen('Flip',w);

vo1 = randperm(length(aFileNames));

pause
tic
for nn = 1:length(aFileNames) 
    timings(end+1) = toc; %trial starts
    Screen('FillRect',w,black);
    Screen('Flip',w);
    pause(5) %5 seconds before next sound starts
    Screen('DrawText', w,'Please listen to the sound', 420, 300, [50 205 105]);
    Screen('Flip',w);
    
    timings(end+1) = toc; %clip starts
    playblocking(audioPlayerObj(vo1(nn)),...
        [1,audioPlayerObj(vo1(nn)).SampleRate*playThisManySeconds])
    timings(end+1) = toc; %clip ends
    Screen('DrawText', w,'Please rate the sound you just heard from 1-10', 420, 300, [50 205 105]);
    Screen('Flip', w);
    pause(10);   % wait for 10 seconds
    
    % save timings
    timings(end+1) = toc; %trial ends
    %ordering = [ordering, aFileNames(nn)];
end

Screen('CloseAll');

%% Export the timing and ordering data
timingsarray{1} = timings;
orderingarray = aFileNames(vo1);

timingsarraycells = [timingsarray{1}]';
%orderingarraycells = [orderingarray{1}]';

T = table(timings(1:4:end)',timings(2:4:end)',timings(3:4:end)',timings(4:4:end)',orderingarray,...
     'VariableNames',{'StartTrial' 'StartClip' 'EndClip' 'EndTrial' 'Ordering'}); %writes into a table

save(sprintf('AudioBlock1_%s_%s.mat',date,[SubConfig{1}]),'T'); %write as mat file
writetable(T,sprintf('AudioBlock1_%s_%s.csv',date,[SubConfig{1}])); %write as csv file


