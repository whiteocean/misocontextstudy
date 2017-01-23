%% MisoAnalyses.m
clc; close all; clear all;

doGraphs = 0;


global mainmisopath subfilespath misofigspath analysisfilepath helperfunxpath
thisfile = 'MisoAnalyses.m';
analysisfilepath = fileparts(which(thisfile));
cd(analysisfilepath); cd('../');
mainmisopath = pwd;

fprintf('\n\n Current working path set to: \n % s \n', mainmisopath)



subfilespath = [mainmisopath '/SubFiles'];
misofigspath = [mainmisopath '/misofigs'];
helperfunxpath = [mainmisopath '/helperfunx'];
gpath = [mainmisopath ':' subfilespath ':' misofigspath ':' analysisfilepath ':' helperfunxpath];
addpath(gpath)

fprintf('\n\n Added folders to path: \n % s \n % s \n % s \n % s \n\n',...
        mainmisopath,subfilespath,misofigspath,analysisfilepath)

    

%---------------
cd(subfilespath)

allfileinfo = dir(subfilespath);
allfilenames = {allfileinfo.name};
allfilenames = allfilenames';
datafiles = allfilenames(~cellfun('isempty',regexp(allfilenames,'((SUB+))')));
datapaths = fullfile(subfilespath,datafiles);
 
disp(' '); fprintf('   %s \r',  datafiles{:} ); disp(' ')
disp(' '); fprintf('   %s \r',  datapaths{:} ); disp(' ')
cd(analysisfilepath)
%---------------



%%
%##################################################################################
%###################             MAIN LOOP START           ########################
%##################################################################################
for nf = 1:size(datapaths,1)
%##################################################################################
%##################################################################################
    
    
    
datapath = [datapaths{nf} '/'];
datafile = datafiles{nf};

filenamebase = datafile(1:13);

disp(datafile); disp(nf); 

% [datafile, datapath, ~] = uigetfile({'*.mat'}, 'Select Block 1 Physio Dataset.');
% filenamebase = datafile(1:13);

block1physiopath = [datapath filenamebase '_block1_physio.mat'];
block1timingpath = [datapath filenamebase '_block1_timings.xlsx'];

block2physiopath = [datapath filenamebase '_block2_physio.mat'];
block2timingpath = [datapath filenamebase '_block2_timings.xlsx'];


block3physiopath = [datapath filenamebase '_block3_physio.mat'];
block3timingpath = [datapath filenamebase '_block3_timings.xlsx'];


[B1tN,B1tT,~] = xlsread(block1timingpath);
[B2tN,B2tT,~] = xlsread(block2timingpath);
[B3tN,B3tT,~] = xlsread(block3timingpath);


load(block1physiopath);
block1acq = acq;
load(block2physiopath);
block2acq = acq;
load(block3physiopath);
block3acq = acq;


clear acq;
clear thisfile gpath datapath
clear block1physiopath block2physiopath block3physiopath
clear block1timingpath block2timingpath block3timingpath


% ------------------------------------------------------------------------

% We don't need acq struct for anything other than .data
SubDataB1 = block1acq.data; 
SubDataB2 = block2acq.data;
SubDataB3 = block3acq.data;


B1tN(1,1) = 1; %makes the first cell value = to 1
B2tN(1,1) = 1; %makes the first cell value = to 1
B3tN(1,1) = 1; %makes the first cell value = to 1


StartTrialB1 = B1tN(:,1);
StartClipB1 = B1tN(:,2);
EndClipB1 = B1tN(:,3);
EndTrialB1 = B1tN(:,4);

StartTrialB2 = B2tN(:,1);
StartClipB2 = B2tN(:,2);
EndClipB2 = B2tN(:,3);
EndTrialB2 = B2tN(:,4);

StartTrialB3 = B3tN(:,1);
StartClipB3 = B3tN(:,2);
EndClipB3 = B3tN(:,3);
EndTrialB3 = B3tN(:,4);

HumanAnimalNonB1 = B1tN(:,6);
HumanAnimalNonB2 = B2tN(:,6);
HumanAnimalNonB3 = B3tN(:,6);

RatingB1 = B1tN(:,7);
RatingB2 = B2tN(:,7);
RatingB3 = B3tN(:,7);

ContMisoB1 = B1tN(:,8);
ContMisoB2 = B2tN(:,8);
ContMisoB3 = B3tN(:,8);

FoilTarget = B2tN(:,10);


B1sounds = {B1tT{2:37,5}}';
B2sounds = {B2tT{2:37,5}}';
B3sounds = {B3tT{2:37,5}}';

for nn = 1:size(B1sounds,1)
    B1sounds{nn} = B1sounds{nn}(1:end-4);
    B2sounds{nn} = B2sounds{nn}(1:end-4);
    B3sounds{nn} = B3sounds{nn}(1:end-4);
end

SoundFiles = [B1sounds B2sounds B3sounds];

[C,soB1,soB2] = intersect(B1sounds,B2sounds,'stable');
[C,soB1,soB3] = intersect(B1sounds,B3sounds,'stable');

SoundO = [soB1 soB2 soB3];


%{
SoundO = zeros(36,3);
SoundO(:,1) = 1:36;

for sb1 = 1:size(B1sounds,1)
    
    B1S = B1sounds{sb1};
    
    for sb2 = 1:size(B1sounds,1)
        
        B2S = B2sounds{sb2};
        B3S = B3sounds{sb2};

        if strcmp(B1S,B2S)
            SoundO(sb2,2) = sb1;
        end
        if strcmp(B1S,B3S)
            SoundO(sb2,3) = sb1;
        end
    end
end


if nf == 4
    keyboard
end

%}
% -------------------------------------------------





Block(1).SubData    = SubDataB1;
Block(1).ARM        = SubDataB1(:,1);
Block(1).NEK        = SubDataB1(:,2);
Block(1).GSR        = SubDataB1(:,3);
Block(1).HRT        = SubDataB1(:,4);
Block(1).StartTrial = StartTrialB1;
Block(1).StartClip  = StartClipB1;
Block(1).EndClip    = EndClipB1;
Block(1).EndTrial   = EndTrialB1;
Block(1).HumanAnimalNon = HumanAnimalNonB1;
Block(1).Rating     = RatingB1;
Block(1).ContMiso   = ContMisoB1;
Block(1).FoilTarget = FoilTarget;
Block(1).Humn       = [];
Block(1).Anim       = [];
Block(1).Misc       = [];
Block(1).Foil       = [];
Block(1).Targ       = [];
Block(1).HumnFoil   = [];
Block(1).AnimFoil   = [];
Block(1).MiscFoil   = [];
Block(1).HumnTarg   = [];
Block(1).AnimTarg   = [];
Block(1).MiscTarg   = [];
Block(1).ARMmu      = [];
Block(1).NEKmu      = [];
Block(1).GSRmu      = [];
Block(1).HRTmu      = [];
Block(1).RatingMu   = [];
Block(1).RatingSe   = [];



Block(2).SubData = SubDataB2;
Block(2).ARM = SubDataB2(:,1);
Block(2).NEK = SubDataB2(:,2);
Block(2).GSR = SubDataB2(:,3);
Block(2).HRT = SubDataB2(:,4);
Block(2).StartTrial = StartTrialB2;
Block(2).StartClip = StartClipB2;
Block(2).EndClip = EndClipB2;
Block(2).EndTrial = EndTrialB2;
Block(2).HumanAnimalNon = HumanAnimalNonB2;
Block(2).Rating = RatingB2;
Block(2).ContMiso = ContMisoB2;
Block(2).FoilTarget = FoilTarget;

Block(3).SubData = SubDataB3;
Block(3).ARM = SubDataB3(:,1);
Block(3).NEK = SubDataB3(:,2);
Block(3).GSR = SubDataB3(:,3);
Block(3).HRT = SubDataB3(:,4);
Block(3).StartTrial = StartTrialB3;
Block(3).StartClip = StartClipB3;
Block(3).EndClip = EndClipB3;
Block(3).EndTrial = EndTrialB3;
Block(3).HumanAnimalNon = HumanAnimalNonB3;
Block(3).Rating = RatingB3;
Block(3).ContMiso = ContMisoB3;
Block(3).FoilTarget = FoilTarget;


if nf == 28
    doGraphs = 1;
end

Block(1).OL = B1tN(1,12:14);
Block(2).OL = B1tN(2,12:14);
Block(3).OL = B1tN(3,12:14);


clearvars -except nf ratingData Block filenamebase mainmisopath misofigspath ...
                  datapaths datapath datafile datafiles doGraphs SoundO SoundFiles

datatable = struct;


%% ------------------------------------------------------------------------

% SoundFiles{SoundO(1,1),1}
% SoundFiles{SoundO(1,2),2}
% SoundFiles{SoundO(1,3),3}

% GET SOUND ORDERINGS AND DELTA RATINGS AROSS SAME SOUNDS
B1soundratings = Block(1).Rating(SoundO(:,1));

B2soundratings = Block(2).Rating(SoundO(:,2));

B3soundratings = Block(3).Rating(SoundO(:,3));

B2minusB1rats = B2soundratings - B1soundratings;
B3minusB1rats = B3soundratings - B1soundratings;
B1minusB3rats = B1soundratings - B3soundratings;

SoundRatings = [B1soundratings B2soundratings B3soundratings];
DeltaRatings = [B1minusB3rats B2minusB1rats B3minusB1rats];

% T = table(SoundFiles,SoundO,'RowNames',{SoundFiles{:,1}}')

fnb = repmat(filenamebase,36,1);
fnbn = cellstr(strcat(fnb,'_',num2str((1:36)')));
T = table(SoundFiles,SoundO,SoundRatings,'RowNames',fnbn);

cd(misofigspath);
writetable(T,[filenamebase '__SoundOrderRatings.csv'])
cd(mainmisopath);



% GET HUMAN ANIMAL MISC TRIAL INFORMATION

ntrials = size(Block(1).StartClip,1);
sps = 2000;  % number of data points per second
musz = 100;  % number of data points to average together in the physio data


for b = 1:3

Block(b).RatingMu = mean(Block(b).Rating);
Block(b).RatingSe = std(Block(b).Rating) / sqrt(numel(Block(b).Rating));


[Humn, c, v] = find((Block(b).HumanAnimalNon == 1));
[Anim, c, v] = find((Block(b).HumanAnimalNon == 2));
[Misc, c, v] = find((Block(b).HumanAnimalNon == 3));

[Foil, c, v] = find((Block(b).FoilTarget == 0));
[Targ, c, v] = find((Block(b).FoilTarget == 1));

HumnFoil = intersect(Foil,Humn);
AnimFoil = intersect(Foil,Anim);
MiscFoil = intersect(Foil,Misc);
HumnTarg = intersect(Targ,Humn);
AnimTarg = intersect(Targ,Anim);
MiscTarg = intersect(Targ,Misc);




Block(b).Humn = Humn;
Block(b).Anim = Anim;
Block(b).Misc = Misc;
Block(b).Foil = Foil;
Block(b).Targ = Targ;

Block(b).HumnFoil = HumnFoil;
Block(b).AnimFoil = AnimFoil;
Block(b).MiscFoil = MiscFoil;
Block(b).HumnTarg = HumnTarg;
Block(b).AnimTarg = AnimTarg;
Block(b).MiscTarg = MiscTarg;


end




DFsoundHumnB1 = mean(DeltaRatings(Block(1).Humn , 1 ));
DFsoundHumnB2 = mean(DeltaRatings(Block(1).Humn , 2 ));
DFsoundHumnB3 = mean(DeltaRatings(Block(1).Humn , 3 ));

DFsoundAnimB1 = mean(DeltaRatings(Block(1).Anim , 1 ));
DFsoundAnimB2 = mean(DeltaRatings(Block(1).Anim , 2 ));
DFsoundAnimB3 = mean(DeltaRatings(Block(1).Anim , 3 ));

DFsoundMiscB1 = mean(DeltaRatings(Block(1).Misc , 1 ));
DFsoundMiscB2 = mean(DeltaRatings(Block(1).Misc , 2 ));
DFsoundMiscB3 = mean(DeltaRatings(Block(1).Misc , 3 ));




if nf == 4
    keyboard
end

%% --------- PLOT Self-Report Ratings in Auditory, Informed, Visual Blocks --------
clearvars -except nf ratingData Block filenamebase mainmisopath misofigspath ...
         datatable datapaths datapath datafile datafiles doGraphs SoundO SoundFiles DeltaRatings
close all

if doGraphs

    fh2=figure('Units','normalized','OuterPosition',[.05 .05 .5 .7],'Color','w','MenuBar','none');
    hax5 = axes('Position',[.05 .05 .9 .9],'Color','none'); 

    axes(hax5)
    bar([Block(1).RatingMu Block(2).RatingMu Block(3).RatingMu]); hold on;
    errorbar([Block(1).RatingMu Block(2).RatingMu Block(3).RatingMu],...
             [Block(1).RatingSe Block(2).RatingSe Block(3).RatingSe],...
             'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)
    title(['Self-Report Ratings in Auditory, Informed, Visual Blocks (SUB: ' filenamebase ')'],'Interpreter','none')
    hax5.YLim = [0 10];
    pause(2)
    % axis tight

end

datatable.RatingMu = [Block.RatingMu]';
datatable.RatingSe = [Block.RatingSe]';



%% --------------  GET RATINGS FOR HUMAN ANIMAL MISC/OTHER -----------------


for b = 1:3

    RatingMuHumn(b) = mean(Block(b).Rating(Block(b).Humn));
    RatingMuAnim(b) = mean(Block(b).Rating(Block(b).Anim));
    RatingMuMisc(b) = mean(Block(b).Rating(Block(b).Misc));
    
    RatingSeHumn(b) = std(Block(b).Rating(Block(b).Humn)) ./ sqrt(numel(Block(b).Rating(Block(b).Humn)));
    RatingSeAnim(b) = std(Block(b).Rating(Block(b).Anim)) ./ sqrt(numel(Block(b).Rating(Block(b).Anim)));
    RatingSeMisc(b) = std(Block(b).Rating(Block(b).Misc)) ./ sqrt(numel(Block(b).Rating(Block(b).Misc)));

end


%% -----------  GET SELF-REPORT RATINGS FOR BLOCK-2 FOIL VS TARGET --------------


RatingMuHumnFoil = mean(Block(2).Rating(Block(2).HumnFoil));
RatingMuAnimFoil = mean(Block(2).Rating(Block(2).AnimFoil));
RatingMuMiscFoil = mean(Block(2).Rating(Block(2).MiscFoil));

RatingMuHumnTarg = mean(Block(2).Rating(Block(2).HumnTarg));
RatingMuAnimTarg = mean(Block(2).Rating(Block(2).AnimTarg));
RatingMuMiscTarg = mean(Block(2).Rating(Block(2).MiscTarg));

RatingSeHumnFoil = std(Block(2).Rating(Block(2).HumnFoil)) / sqrt(numel(Block(2).Rating(Block(2).HumnFoil)));
RatingSeAnimFoil = std(Block(2).Rating(Block(2).AnimFoil)) / sqrt(numel(Block(2).Rating(Block(2).AnimFoil)));
RatingSeMiscFoil = std(Block(2).Rating(Block(2).MiscFoil)) / sqrt(numel(Block(2).Rating(Block(2).MiscFoil)));

RatingSeHumnTarg = std(Block(2).Rating(Block(2).HumnTarg)) / sqrt(numel(Block(2).Rating(Block(2).HumnTarg)));
RatingSeAnimTarg = std(Block(2).Rating(Block(2).AnimTarg)) / sqrt(numel(Block(2).Rating(Block(2).AnimTarg)));
RatingSeMiscTarg = std(Block(2).Rating(Block(2).MiscTarg)) / sqrt(numel(Block(2).Rating(Block(2).MiscTarg)));


RatingFTMu = [RatingMuHumnFoil RatingMuHumnTarg;...
              RatingMuAnimFoil RatingMuAnimTarg;...
              RatingMuMiscFoil RatingMuMiscTarg];

RatingFTSe = [RatingSeHumnFoil RatingSeHumnTarg;...
              RatingSeAnimFoil RatingSeAnimTarg;...
              RatingSeMiscFoil RatingSeMiscTarg]; 



%% --------- PLOT SELF-REPORT RATINGS FOR HUMAN ANIMAL MISC & FOIL TARGET ----------

if doGraphs
    
    fh3=figure('Units','normalized','OuterPosition',[.05 .05 .8 .7],'Color','w','MenuBar','none');
    hax6a = axes('Position',[.05 .05 .4 .9],'Color','none');
    hax6b = axes('Position',[.51 .05 .4 .9],'Color','none'); 

    axes(hax6a)
    bh1 = bar([RatingMuHumn' RatingMuAnim' RatingMuMisc']); 

    legend('Human','Animal','Other','Location','northwest')

    hold on;

    errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22], ...
             [RatingMuHumn' RatingMuAnim' RatingMuMisc'],...
             [RatingSeHumn' RatingSeAnim' RatingSeMisc'],...
             'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2,...
             'Marker','.', 'MarkerSize',20)

    title(['Self-Report Ratings in Auditory, Informed, Visual Blocks (SUB: ' filenamebase ')'],'Interpreter','none')
    hax6a.YLim = [1 10];

    pause(1)


    axes(hax6b)
    bh1 = bar(RatingFTMu); 

    legend('Foil','Target','Location','northwest')
    hax6b.XTickLabel = {'Human', 'Animal', 'Other'};

    hold on;

    errorbar([1-.15 1+.15; 2-.15 2+.15; 3-.15 3+.15], ...
             RatingFTMu,...
             RatingFTSe,...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)
    title([filenamebase ' Self-Report Ratings in Informed Block(2) Compairing Foil vs Target'],'Interpreter','none')
    hax6b.YLim = [1 10];

    cd(misofigspath);
    set(fh3, 'PaperPositionMode', 'auto');
    saveas(fh3,[filenamebase '__Self_Report_Ratings'],'png');
    cd(mainmisopath);

end

datatable.RatingMuHumn = RatingMuHumn';

datatable.RatingMuAnim = RatingMuAnim';

datatable.RatingMuMisc = RatingMuMisc';

datatable.RatingSeHumn = RatingSeHumn';

datatable.RatingSeAnim = RatingSeAnim';

datatable.RatingSeMisc = RatingSeMisc';



datatable.RatingMuHAMF = [RatingMuHumnFoil RatingMuAnimFoil RatingMuMiscFoil]';
datatable.RatingMuHAMT = [RatingMuHumnTarg RatingMuAnimTarg RatingMuMiscTarg]';

datatable.RatingSeHAMF = [RatingSeHumnFoil RatingSeAnimFoil RatingSeMiscFoil]';
datatable.RatingSeHAMT = [RatingSeHumnTarg RatingSeAnimTarg RatingSeMiscTarg]';



ratingData{nf} = datatable;

%##################################################################################
%##################################################################################
end
%##################################################################################
%###################             MAIN LOOP END           ########################
%##################################################################################
% keyboard
%%

doGraphs = 1;

IsMiso = zeros(1,size(datafiles,1))>1;
for f = 1:size(datafiles,1)
    IsMiso(f) = strcmp(datafiles{f}(end-3:end),'Miso');    
end


MISO_ALLMU=[];
MISO_HUMU=[];
MISO_ANMU=[];
MISO_MIMU=[];
MISO_HAMF=[];
MISO_HAMT=[];
CONT_ALLMU=[];
CONT_HUMU=[];
CONT_ANMU=[];
CONT_MIMU=[];
CONT_HAMF=[];
CONT_HAMT=[];

for f = 1:size(datafiles,1)

    if IsMiso(f)

    MISO_ALLMU = [MISO_ALLMU ratingData{f}.RatingMu];
    MISO_HUMU = [MISO_HUMU ratingData{f}.RatingMuHumn];
    MISO_ANMU = [MISO_ANMU ratingData{f}.RatingMuAnim];
    MISO_MIMU = [MISO_MIMU ratingData{f}.RatingMuMisc];
    MISO_HAMF = [MISO_HAMF ratingData{f}.RatingMuHAMF];
    MISO_HAMT = [MISO_HAMT ratingData{f}.RatingMuHAMT];
    
    else
        
    CONT_ALLMU = [CONT_ALLMU ratingData{f}.RatingMu];
    CONT_HUMU = [CONT_HUMU ratingData{f}.RatingMuHumn];
    CONT_ANMU = [CONT_ANMU ratingData{f}.RatingMuAnim];
    CONT_MIMU = [CONT_MIMU ratingData{f}.RatingMuMisc];
    CONT_HAMF = [CONT_HAMF ratingData{f}.RatingMuHAMF];
    CONT_HAMT = [CONT_HAMT ratingData{f}.RatingMuHAMT];
        
    
    end

end


%%
close all
if doGraphs
    
    fh91=figure('Units','normalized','OuterPosition',[.05 .05 .8 .7],'Color','w','MenuBar','none');
    hax91a = axes('Position',[.05 .05 .4 .9],'Color','none');
    hax91b = axes('Position',[.51 .05 .4 .9],'Color','none'); 

    axes(hax91a)
    bh1 = bar(sort(MISO_HUMU,2,'descend'));
    title('Miso Group - Human Sounds')

    axes(hax91b)
    bh1 = bar(sort(CONT_HUMU,2,'descend'));
    title('Cont Group - Human Sounds')

    hax91a.YLim = [0 10];
    hax91b.YLim = [0 10];




    fh92=figure('Units','normalized','OuterPosition',[.05 .05 .8 .7],'Color','w','MenuBar','none');
    hax92a = axes('Position',[.05 .05 .4 .9],'Color','none');
    hax92b = axes('Position',[.51 .05 .4 .9],'Color','none'); 

    axes(hax92a)
    bh1 = bar(sort(MISO_ANMU,2,'descend'));
    title('Miso Group - Animal Sounds')

    axes(hax92b)
    bh1 = bar(sort(CONT_ANMU,2,'descend'));
    title('Cont Group - Animal Sounds')

    hax92a.YLim = [0 10];
    hax92b.YLim = [0 10];




    fh93=figure('Units','normalized','OuterPosition',[.05 .05 .8 .7],'Color','w','MenuBar','none');
    hax93a = axes('Position',[.05 .05 .4 .9],'Color','none');
    hax93b = axes('Position',[.51 .05 .4 .9],'Color','none'); 

    axes(hax93a)
    bh1 = bar(sort(MISO_MIMU,2,'descend'));
    title('Miso Group - Other Sounds')

    axes(hax93b)
    bh1 = bar(sort(CONT_MIMU,2,'descend'));
    title('Cont Group - Other Sounds')

    hax93a.YLim = [0 10];
    hax93b.YLim = [0 10];
end

%%
close all

Nmiso = size(MISO_HUMU,2);
Ncont = size(CONT_HUMU,2);

MISOHU = mean(MISO_HUMU,2);
CONTHU = mean(CONT_HUMU,2);
MISOAN = mean(MISO_ANMU,2);
CONTAN = mean(CONT_ANMU,2);
MISOMI = mean(MISO_MIMU,2);
CONTMI = mean(CONT_MIMU,2);

MISOHUse = std(MISO_HUMU,0,2) ./ sqrt(Nmiso);
CONTHUse = std(CONT_HUMU,0,2) ./ sqrt(Ncont);
MISOANse = std(MISO_ANMU,0,2) ./ sqrt(Nmiso);
CONTANse = std(CONT_ANMU,0,2) ./ sqrt(Ncont);
MISOMIse = std(MISO_MIMU,0,2) ./ sqrt(Nmiso);
CONTMIse = std(CONT_MIMU,0,2) ./ sqrt(Ncont);



if doGraphs
    
    fh91=figure('Units','normalized','OuterPosition',[.05 .05 .8 .7],'Color','w','MenuBar','none');
    hax91a = axes('Position',[.05 .05 .4 .9],'Color','none');
    hax91b = axes('Position',[.51 .05 .4 .9],'Color','none'); 

    axes(hax91a)
    bh1 = bar([MISOHU MISOAN MISOMI]);
    legend('Human','Animal','Other','Location','northwest')

    hold on;

    errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22], ...
             [MISOHU MISOAN MISOMI],...
             [MISOHUse MISOANse MISOMIse],...
             'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2,...
             'Marker','.', 'MarkerSize',20)
    title('MISO GROUP RATINGS');     

    axes(hax91b)
    bh2 = bar([CONTHU CONTAN CONTMI]);
    legend('Human','Animal','Other','Location','northwest')

    hold on;

    errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22], ...
             [CONTHU CONTAN CONTMI],...
             [CONTHUse CONTANse CONTMIse],...
             'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2,...
             'Marker','.', 'MarkerSize',20)
    title('CONTROL GROUP RATINGS');

    hax91a.YLim = [1 8];
    hax91b.YLim = [1 8];

end
%%


MISO_HAMFmu = mean(MISO_HAMF,2);
MISO_HAMTmu = mean(MISO_HAMT,2);
CONT_HAMFmu = mean(CONT_HAMF,2);
CONT_HAMTmu = mean(CONT_HAMT,2);

MISO_HAMFse = std(MISO_HAMF,0,2) ./ sqrt(Nmiso);
MISO_HAMTse = std(MISO_HAMT,0,2) ./ sqrt(Ncont);
CONT_HAMFse = std(CONT_HAMF,0,2) ./ sqrt(Nmiso);
CONT_HAMTse = std(CONT_HAMT,0,2) ./ sqrt(Ncont);




if doGraphs
    fh91=figure('Units','normalized','OuterPosition',[.05 .05 .8 .7],'Color','w','MenuBar','none');
    hax91a = axes('Position',[.05 .05 .4 .9],'Color','none');
    hax91b = axes('Position',[.51 .05 .4 .9],'Color','none'); 

    axes(hax91a)
    bh1 = bar([MISO_HAMTmu MISO_HAMFmu]);
    legend('Foil','Target','Location','northwest')

    hold on;

    eb = .14;
    errorbar([1-eb 1+eb; 2-eb 2+eb; 3-eb 3+eb], ...
             [MISO_HAMTmu MISO_HAMFmu],...
             [MISO_HAMTse MISO_HAMFse]./2,...
             'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2,...
             'Marker','.', 'MarkerSize',20)
    hax91a.XTickLabel = {'Human','Animal','Other'};
    title('MISO GROUP RATINGS BLOCK-2');




    axes(hax91b)
    bh2 = bar([CONT_HAMFmu CONT_HAMTmu]);
    legend('Foil','Target','Location','northwest')

    hold on;

    errorbar([1-eb 1+eb; 2-eb 2+eb; 3-eb 3+eb], ...
             [CONT_HAMFmu CONT_HAMTmu],...
             [CONT_HAMFse CONT_HAMTse]./2,...
             'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2,...
             'Marker','.', 'MarkerSize',20)
    hax91b.XTickLabel = {'Human','Animal','Other'};
    title('CONTROL GROUP RATINGS BLOCK-2');

    hax91a.YLim = [1 8];
    hax91b.YLim = [1 8];
end


