%% Block 2 Audio Context
%remember: command . and "sca" to stop and get out of psyc toolbox

clc; clear all; clear functions;
cd('/Users/Miren/Documents/MATLAB/MisoContextStudy/')
 
%% Get Subject Initials

SubConfig = inputdlg('Enter in initials','Input',1,{'MHE'});

Order.Sound = listdlg('PromptString','Select SOUND order:',...
                'SelectionMode','single','ListSize',[150 100],...
                'ListString',num2str((1:6)'));

Order.Text = listdlg('PromptString','Select TEXT order:',...
                'SelectionMode','single','ListSize',[150 100],...
                'ListString',num2str((1:6)'));


%% SELECT DIRECTORY CONTAINING ONLY M4A AUDIO FILES
filedir = ['/Users/Miren/Documents/MATLAB/MisoContextStudy/Audio36']; %change to big folder when ready
acFiles = dir([filedir,'/*.m4a']);
acFileNames = {acFiles(:).name}';


%% IMPORT XLS DATA FOR ORDERINGS AND TEXT DESCRIPTIONS

[xlsNums, xlsTxt, xlsRaw] = xlsread('/Users/Miren/Documents/MATLAB/MisoContextStudy/MisoSoundsOrder.xlsx');
xlsTxt(1,:) = [];


%{ 

When importing the xls sheet info, the TEXT (aka foil) display orderings will start on
column 3 in 'xlsNums' and go through column 8. So xlsNums(:,3:8) would
represent all 6 different TEXT orderings.


When importing the xls sheet info, the SOUND orderings will start on
column 9 in 'xlsNums' and go through column 14. So xlsNums(:,9:14) would
represent all 6 different SOUND orderings

%}

textDispColumn = Order.Text + 2;
soundDispColumn = Order.Sound + 8;

dispcorrect = xlsNums(:,textDispColumn);

nStims = size(xlsNums,1);

for nn = 1:nStims

    
    if dispcorrect(nn)
        % DISPLAY CORRECT TEXT DESCRIPTION
    
        correctItem = xlsNums(nn,2);
        disptxt = xlsTxt(nn,correctItem);
        
    else
        % DISPLAY INCORRECT TEXT DESCRIPTION
        
        itemoptions = 1:3;
        correctItem = xlsNums(nn,2);
        itemoptions(correctItem) = [];
        dispitem = itemoptions( (rand > .5)+1 );
        disptxt = xlsTxt(nn,dispitem);
    
    end
    
    
    
    txtlist{nn} = disptxt;

end



%% IMPORT ALL M4A FILES FROM CHOSEN DIRECTORY
for nn = 1:length(acFileNames)
    [ReadAudio,FpS] = audioread([filedir '/' acFileNames{nn}],'native');
    audioPlayerObj(nn) = audioplayer(ReadAudio,FpS);
    audioPlayerObjFpS{nn} = audioPlayerObj.SampleRate;
end
 



%% PRESET VARIABLES
stimOrder = xlsNums(:,soundDispColumn);
[throw,sortOrderTrans]=sort(stimOrder);

playThisManySeconds = 15; %change to 15
timings = [];

%% MAIN EXPERIMENTAL LOOP

Screen('Preference', 'SkipSyncTests', 1); 
screenNum=0; % setting a variable, which is the screen number
res=[1300 700]; % use this in debugging pass [] to use full window
[w,rect] = Screen('OpenWindow',screenNum,0, [0 0 res(1) res(2)]);
black = BlackIndex(w);

Screen('DrawText', w,'Press any key when you are ready to begin Block 2', 420, 300, [50 205 105]);
Screen('Flip',w);
pause

tic %expt starts
for nn = 1:nStims
    timings(end+1) = toc; %trial starts
    
    ss = sortOrderTrans(nn);
    
    Screen('FillRect',w,black);
    Screen('Flip',w);
    pause(1)
    Screen('DrawText', w, txtlist{ss}{:} , 420, 300, [50 205 105]); % controls which text is shown
    Screen('Flip',w);
    pause(3) %should be 3 seconds
    Screen('FillRect',w,black);
    Screen('Flip',w);
    pause(1)
    
    timings(end+1) = toc; %clip starts
    
    playblocking(audioPlayerObj(ss),...
        [1,audioPlayerObj(ss).SampleRate*playThisManySeconds])

    timings(end+1) = toc; %clip ends
    
    Screen('DrawText', w,'Please rate the sound you just heard from 1-10', 420, 300, [50 205 105]);
    Screen('Flip', w);
    pause(10);   % should be 10 seconds
    
    timings(end+1) = toc; %trial ends
    
end

Screen('CloseAll');

%% Export the timing and ordering data

timingsarray{1} = timings;
timingsarraycells = [timingsarray{1}]';

orderingarray = [acFileNames(sortOrderTrans)];

OrderStructToCell = struct2cell(Order)';
OrderSound = OrderStructToCell{1};
OrderText = OrderStructToCell{2};

for nn = 1:nStims
    ss = find(stimOrder == nn);
    textpresarray{nn} = txtlist{ss}{:};
    targetORfoil(nn) = dispcorrect(ss);
    
end

textpresarray = textpresarray';
targetfoil = targetORfoil';

T = table(timings(1:4:end)',timings(2:4:end)',timings(3:4:end)',timings(4:4:end)', ...
    orderingarray, textpresarray, targetfoil,...
     'VariableNames',{'StartTrial' 'StartClip' 'EndClip' 'EndTrial' 'SoundPresented' 'TextPresented' 'TargetFoil'}); %writes into a table

save(sprintf('ACBlock2_%s_%s_SoundOrder%d_TextOrder%d.mat',date,[SubConfig{1}], OrderSound, OrderText),'T'); %write as mat file
writetable(T,sprintf('ACBlock2_%s_%s_SoundOrder%d_TextOrder%d.csv',date,[SubConfig{1}],OrderSound, OrderText)); %write as csv file
