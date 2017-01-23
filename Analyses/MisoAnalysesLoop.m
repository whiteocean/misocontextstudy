%% MisoAnalyses.m
clc; close all; clear;


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

Block(1).OL = B1tN(1,12:14);
Block(2).OL = B1tN(2,12:14);
Block(3).OL = B1tN(3,12:14);

clearvars -except Block filenamebase mainmisopath misofigspath datapaths datapath datafile datafiles

datatable = struct;


%% ------------------------------------------------------------------------

ntrials = size(Block(1).StartClip,1);
sps = 2000;  % number of data points per second
musz = 100;  % number of data points to average together in the physio data

% ARM = ARM + abs(mean(ARM));
% NEK = NEK + abs(mean(NEK));
% GSR = GSR + abs(mean(GSR));
% HRT = HRT + abs(mean(HRT));


for b = 1:3

datsecs = floor(numel(Block(b).GSR) / musz);

ARMmu=[];
NEKmu=[];
GSRmu=[];
HRTmu=[];
for nn = 0:datsecs-1
    
    ARMmu(nn+1) = mean(Block(b).ARM(nn*musz+1:nn*musz+musz));
    NEKmu(nn+1) = mean(Block(b).NEK(nn*musz+1:nn*musz+musz));
    GSRmu(nn+1) = mean(Block(b).GSR(nn*musz+1:nn*musz+musz));
    HRTmu(nn+1) = mean(Block(b).HRT(nn*musz+1:nn*musz+musz));
    
end

ARMmuUPct = prctile(ARMmu,99.90);
NEKmuUPct = prctile(NEKmu,99.90);
GSRmuUPct = prctile(GSRmu,99.90);
HRTmuUPct = prctile(HRTmu,99.90);

ARMmuLPct = prctile(ARMmu,00.10);
NEKmuLPct = prctile(NEKmu,00.10);
GSRmuLPct = prctile(GSRmu,00.10);
HRTmuLPct = prctile(HRTmu,00.10);


ARMmu(ARMmu>ARMmuUPct) = ARMmuUPct;
NEKmu(NEKmu>NEKmuUPct) = NEKmuUPct;
GSRmu(GSRmu>GSRmuUPct) = GSRmuUPct;
HRTmu(HRTmu>HRTmuUPct) = HRTmuUPct;

ARMmu(ARMmu<ARMmuLPct) = ARMmuLPct;
NEKmu(NEKmu<NEKmuLPct) = NEKmuLPct;
GSRmu(GSRmu<GSRmuLPct) = GSRmuLPct;
HRTmu(HRTmu<HRTmuLPct) = HRTmuLPct;



Block(b).ARMmu = ARMmu + abs(min(ARMmu));
Block(b).NEKmu = NEKmu + abs(min(NEKmu));
Block(b).GSRmu = GSRmu + abs(min(GSRmu));
Block(b).HRTmu = HRTmu + abs(min(HRTmu));


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





%% --------- PLOT Self-Report Ratings in Auditory, Informed, Visual Blocks --------
clearvars -except Block filenamebase mainmisopath misofigspath datatable datapaths datapath datafile datafiles
close all

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





%% --------- PLOT PREVIEW OF PHYSIO DATA  ----------

close all;

b = 1;

fh1=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax1 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
hax2 = axes('Position',[.52 .05 .42 .42],'Color','none'); 
hax3 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
hax4 = axes('Position',[.52 .52 .42 .42],'Color','none'); 

axes(hax1)
plot(hax1, Block(b).ARMmu, 'LineWidth',2,'Marker','none'); title('ARM')
axis tight

axes(hax2)
plot(hax2, Block(b).NEKmu, 'LineWidth',2,'Marker','none'); title('NECK')
axis tight

axes(hax3)
plot(hax3, Block(b).GSRmu, 'LineWidth',2,'Marker','none'); title('GSR')
axis tight

axes(hax4)
plot(hax4, Block(b).HRTmu, 'LineWidth',2,'Marker','none'); title('HEART')
axis tight





%% --------- GET PHYSIO GSR DATA FOR BASELINE CLIP & ITI  ----------



GSRbasePeak = [];
GSRbaseMean = [];
GSRbaseSEM = [];

GSRclipPeak = [];
GSRclipMean = [];
GSRclipSEM = [];

GSRitiPeak = [];
GSRitiMean = [];
GSRitiSEM = [];

GSRpctChange = [];

sps = 2000;  % samples per second
musz = 100;  % number of data points to average together in the physio data

B1_BASEst = round(Block(1).StartTrial(:).*(sps/musz) );
B1_BASEet = round(Block(1).StartClip(:).*(sps/musz) );
B1_CLIPst = round(Block(1).StartClip(:).*(sps/musz) );
B1_CLIPet = round(Block(1).EndClip(:).*(sps/musz) );
B1_ITIVst = round(Block(1).EndClip(:).*(sps/musz) );
B1_ITIVet = round(Block(1).EndTrial(:).*(sps/musz) );

B2_BASEst = round(Block(2).StartTrial(:).*(sps/musz) );
B2_BASEet = round(Block(2).StartClip(:).*(sps/musz) );
B2_CLIPst = round(Block(2).StartClip(:).*(sps/musz) );
B2_CLIPet = round(Block(2).EndClip(:).*(sps/musz) );
B2_ITIVst = round(Block(2).EndClip(:).*(sps/musz) );
B2_ITIVet = round(Block(2).EndTrial(:).*(sps/musz) );

B3_BASEst = round(Block(3).StartTrial(:).*(sps/musz) );
B3_BASEet = round(Block(3).StartClip(:).*(sps/musz) );
B3_CLIPst = round(Block(3).StartClip(:).*(sps/musz) );
B3_CLIPet = round(Block(3).EndClip(:).*(sps/musz) );
B3_ITIVst = round(Block(3).EndClip(:).*(sps/musz) );
B3_ITIVet = round(Block(3).EndTrial(:).*(sps/musz) );

BASEst = [B1_BASEst B2_BASEst B3_BASEst];
BASEet = [B1_BASEet B2_BASEet B3_BASEet];
CLIPst = [B1_CLIPst B2_CLIPst B3_CLIPst];
CLIPet = [B1_CLIPet B2_CLIPet B3_CLIPet];
ITIVst = [B1_ITIVst B2_ITIVst B3_ITIVst];
ITIVet = [B1_ITIVet B2_ITIVet B3_ITIVet];

clear B1_BASEst B2_BASEst B3_BASEst B1_BASEet B2_BASEet B3_BASEet
clear B1_CLIPst B2_CLIPst B3_CLIPst B1_CLIPet B2_CLIPet B3_CLIPet
clear B1_ITIVst B2_ITIVst B3_ITIVst B1_ITIVet B2_ITIVet B3_ITIVet


% CALCULATE NUMBER OF SECONDS PER TRIAL

GSRbaseS = [BASEet(:,1) - BASEst(:,1)   BASEet(:,2) - BASEst(:,2)    BASEet(:,3) - BASEst(:,3)      ];
GSRclipS = [CLIPet(:,1) - CLIPst(:,1)   CLIPet(:,2) - CLIPst(:,2)    CLIPet(:,3) - CLIPst(:,3)      ];
GSRitivS = [ITIVet(:,1) - ITIVst(:,1)   ITIVet(:,2) - ITIVst(:,2)    ITIVet(:,3) - ITIVst(:,3)      ];



BASEef = BASEst + min(min(GSRbaseS(2:end,:)))-1;
CLIPef = CLIPst + min(min(GSRclipS(2:end,:)));
ITIVef = ITIVst + min(min(GSRitivS(2:end,:)))-1;


GSRbframes = [];
GSRfbase = {};
GSRcframes = [];
GSRfclip = {};
GSRiframes = [];
GSRfitiv = {};


% GET MEANS AND STACK LINES FOR ALL BLOCKS [BASE] [CLIP] [ITI]

%%
for b = 1:3
for n = 1:size(Block(b).StartClip,1);
    
    
    GSRbase         = Block(b).GSRmu(  BASEst(n,b) : BASEet(n,b)  );
    GSRbframes      = [GSRbframes     Block(b).GSRmu(  BASEst(n,b) : BASEef(n,b)  )'   ];
    GSRbasePeak(n)  = max(GSRbase) - min(GSRbase);
    GSRbaseMean(n)  = median(GSRbase);
    GSRbaseSEM(n)   = std(GSRbase) ./ sqrt(numel(GSRbase));


    GSRclip         = Block(b).GSRmu(  CLIPst(n,b) : CLIPet(n,b)  );
    GSRcframes      = [GSRcframes     Block(b).GSRmu(  CLIPst(n,b) : CLIPef(n,b)  )'   ];
    GSRclipPeak(n)  = max(GSRclip) - min(GSRclip);
    GSRclipMean(n)  = mean(GSRclip);
    GSRclipSEM(n)   = std(GSRclip) ./ sqrt(numel(GSRclip));


    GSRiti          = Block(b).GSRmu(  ITIVst(n,b) : ITIVet(n,b)  );
    GSRiframes      = [GSRiframes     Block(b).GSRmu(  ITIVst(n,b) : ITIVef(n,b)  )'   ];
    GSRitiPeak(n)   = max(GSRiti) - min(GSRiti);
    GSRitiMean(n)   = mean(GSRitiPeak);
    GSRitiSEM(n)    = std(GSRiti) ./ sqrt(numel(GSRiti));
    

    GSRpctChange(n) = ((GSRclipMean(n) - GSRbaseMean(n)) / (GSRbaseMean(n)));


end

    GSRfbase{b} = GSRbframes;
    GSRbframes = [];
    GSRfclip{b} = GSRcframes;
    GSRcframes = [];
    GSRfitiv{b} = GSRiframes;
    GSRiframes = [];    

    GSRpctChangeUPct = prctile(GSRpctChange,95);

    GSRpctChangeLPct = prctile(GSRpctChange,5);

    GSRpctChange(GSRpctChange>GSRpctChangeUPct) = GSRpctChangeUPct;

    GSRpctChange(GSRpctChange<GSRpctChangeLPct) = GSRpctChangeLPct;




    Block(b).GSRbaseMean  = GSRbaseMean;
    Block(b).GSRbaseSEM   = GSRbaseSEM;
    
    Block(b).GSRclipMean  = GSRclipMean;
    Block(b).GSRclipSEM   = GSRclipSEM;
    
    Block(b).GSRitiMean   = GSRitiMean;
    Block(b).GSRitiSEM    = GSRitiSEM;
    
    Block(b).GSRdF        = GSRpctChange;
        
end





%% ------------------------------------------------------------------------

for b = 1:3
Block(b).GSRbaseMuHu = mean(Block(b).GSRbaseMean(Block(b).Humn));
Block(b).GSRbaseMuAn = mean(Block(b).GSRbaseMean(Block(b).Anim));
Block(b).GSRbaseMuMi = mean(Block(b).GSRbaseMean(Block(b).Misc));

Block(b).GSRclipMuHu = mean(Block(b).GSRclipMean(Block(b).Humn));
Block(b).GSRclipMuAn = mean(Block(b).GSRclipMean(Block(b).Anim));
Block(b).GSRclipMuMi = mean(Block(b).GSRclipMean(Block(b).Misc));

Block(b).GSRitiMuHu = mean(Block(b).GSRitiMean(Block(b).Humn));
Block(b).GSRitiMuAn = mean(Block(b).GSRitiMean(Block(b).Anim));
Block(b).GSRitiMuMi = mean(Block(b).GSRitiMean(Block(b).Misc));


Block(b).GSRbaseSE = std(Block(b).GSRbaseMean) ./ sqrt(numel(Block(b).GSRbaseMean));
Block(b).GSRclipSE = std(Block(b).GSRclipMean) ./ sqrt(numel(Block(b).GSRclipMean));
Block(b).GSRitiSE = std(Block(b).GSRitiMean) ./ sqrt(numel(Block(b).GSRitiMean));


Block(b).GSRbars = [Block(b).GSRbaseMuHu Block(b).GSRbaseMuAn Block(b).GSRbaseMuMi;...
                    Block(b).GSRclipMuHu Block(b).GSRclipMuAn Block(b).GSRclipMuMi;...
                    Block(b).GSRitiMuHu  Block(b).GSRitiMuAn  Block(b).GSRitiMuMi];
                
                
Block(b).GSRbarsSe = [Block(b).GSRbaseSE Block(b).GSRclipSE Block(1).GSRitiSE;...
                      Block(b).GSRclipSE Block(b).GSRclipSE Block(1).GSRclipSE;...
                      Block(b).GSRitiSE  Block(b).GSRitiSE  Block(1).GSRitiSE];                


                  
                  
     
                


Block(b).GSRclipMuHuTF0 = mean(Block(b).GSRclipMean(Block(b).HumnFoil));
Block(b).GSRclipMuAnTF0 = mean(Block(b).GSRclipMean(Block(b).AnimFoil));
Block(b).GSRclipMuMiTF0 = mean(Block(b).GSRclipMean(Block(b).MiscFoil));

Block(b).GSRclipMuHuTF1 = mean(Block(b).GSRclipMean(Block(b).HumnTarg));
Block(b).GSRclipMuAnTF1 = mean(Block(b).GSRclipMean(Block(b).AnimTarg));
Block(b).GSRclipMuMiTF1 = mean(Block(b).GSRclipMean(Block(b).MiscTarg));


Block(b).GSRclipSeHuTF0 = std(Block(b).GSRclipMean(Block(b).HumnFoil)) ./ sqrt(numel( Block(b).GSRclipMean(Block(b).HumnFoil) ));
Block(b).GSRclipSeAnTF0 = std(Block(b).GSRclipMean(Block(b).AnimFoil)) ./ sqrt(numel( Block(b).GSRclipMean(Block(b).AnimFoil) ));
Block(b).GSRclipSeMiTF0 = std(Block(b).GSRclipMean(Block(b).MiscFoil)) ./ sqrt(numel( Block(b).GSRclipMean(Block(b).MiscFoil) ));

Block(b).GSRclipSeHuTF1 = std(Block(b).GSRclipMean(Block(b).HumnTarg)) ./ sqrt(numel( Block(b).GSRclipMean(Block(b).HumnTarg) ));
Block(b).GSRclipSeAnTF1 = std(Block(b).GSRclipMean(Block(b).AnimTarg)) ./ sqrt(numel( Block(b).GSRclipMean(Block(b).AnimTarg) ));
Block(b).GSRclipSeMiTF1 = std(Block(b).GSRclipMean(Block(b).MiscTarg)) ./ sqrt(numel( Block(b).GSRclipMean(Block(b).MiscTarg) ));




Block(b).GSRclipHAMFT_MEAN = [Block(b).GSRclipMuHuTF0 Block(b).GSRclipMuHuTF1;...
                              Block(b).GSRclipMuAnTF0 Block(b).GSRclipMuAnTF1;...
                              Block(b).GSRclipMuMiTF0 Block(b).GSRclipMuMiTF1];

Block(b).GSRclipHAMFT_SEM = [Block(b).GSRclipSeHuTF0 Block(b).GSRclipSeHuTF1;...
                             Block(b).GSRclipSeAnTF0 Block(b).GSRclipSeAnTF1;...
                             Block(b).GSRclipSeMiTF0 Block(b).GSRclipSeMiTF1];               

end
% ------------------------------------------------------------------------
%%

%% REMOVE OUTLIERS FROM GSR DATASET


OLs = [Block(1).OL; Block(2).OL; Block(3).OL];


B1muBASE = mean(mean(GSRfbase{1}));
B1muCLIP = mean(mean(GSRfclip{1}));
B1muITIV = mean(mean(GSRfitiv{1}));
B2muBASE = mean(mean(GSRfbase{2}));
B2muCLIP = mean(mean(GSRfclip{2}));
B2muITIV = mean(mean(GSRfitiv{2}));
B3muBASE = mean(mean(GSRfbase{3}));
B3muCLIP = mean(mean(GSRfclip{3}));
B3muITIV = mean(mean(GSRfitiv{3}));
B1mu = mean([B1muBASE B1muCLIP B1muITIV]);
B2mu = mean([B2muBASE B2muCLIP B2muITIV]);
B3mu = mean([B3muBASE B3muCLIP B3muITIV]);


B1maxEachTrialDuringBASE = max(abs(GSRfbase{1} - B1mu));
B1maxEachTrialDuringCLIP = max(abs(GSRfclip{1} - B1mu));
B1maxEachTrialDuringITIV = max(abs(GSRfitiv{1} - B1mu));
B2maxEachTrialDuringBASE = max(abs(GSRfbase{2} - B2mu));
B2maxEachTrialDuringCLIP = max(abs(GSRfclip{2} - B2mu));
B2maxEachTrialDuringITIV = max(abs(GSRfitiv{2} - B2mu));
B3maxEachTrialDuringBASE = max(abs(GSRfbase{3} - B3mu));
B3maxEachTrialDuringCLIP = max(abs(GSRfclip{3} - B3mu));
B3maxEachTrialDuringITIV = max(abs(GSRfitiv{3} - B3mu));



[B,B1baseREI] = sort(B1maxEachTrialDuringBASE,'descend');
[B,B1clipREI] = sort(B1maxEachTrialDuringCLIP,'descend');
[B,B1itivREI] = sort(B1maxEachTrialDuringITIV,'descend');
[B,B2baseREI] = sort(B2maxEachTrialDuringBASE,'descend');
[B,B2clipREI] = sort(B2maxEachTrialDuringCLIP,'descend');
[B,B2itivREI] = sort(B2maxEachTrialDuringITIV,'descend');
[B,B3baseREI] = sort(B3maxEachTrialDuringBASE,'descend');
[B,B3clipREI] = sort(B3maxEachTrialDuringCLIP,'descend');
[B,B3itivREI] = sort(B3maxEachTrialDuringITIV,'descend');


if OLs(1,1)>0 || OLs(1,2)>0 || OLs(1,3)>0
    
    B1baseRE = B1baseREI(1:OLs(1,1));
    B1clipRE = B1clipREI(1:OLs(1,2));
    B1itivRE = B1itivREI(1:OLs(1,3)); 
    
    mu = mean([GSRfbase{1}(:); GSRfclip{1}(:); GSRfitiv{1}(:)]);
    GSRfbase{1}(:,[B1baseRE B1clipRE B1itivRE])= mu;
    GSRfclip{1}(:,[B1baseRE B1clipRE B1itivRE])= mu;
    GSRfitiv{1}(:,[B1baseRE B1clipRE B1itivRE])= mu;

end



if OLs(2,1)>0 || OLs(2,2)>0 || OLs(2,3)>0
    
    B2baseRE = B2baseREI(1:OLs(2,1)); 
    B2clipRE = B2clipREI(1:OLs(2,2));
    B2itivRE = B2itivREI(1:OLs(2,3));
    
    mu = mean([GSRfbase{2}(:); GSRfclip{2}(:); GSRfitiv{2}(:)]);
    GSRfbase{2}(:,[B2baseRE B2clipRE B2itivRE])= mu;
    GSRfclip{2}(:,[B2baseRE B2clipRE B2itivRE])= mu;
    GSRfitiv{2}(:,[B2baseRE B2clipRE B2itivRE])= mu;

end



if OLs(3,1)>0 || OLs(3,2)>0 || OLs(3,3)>0
    
    B3baseRE = B3baseREI(1:OLs(3,1)); 
    B3clipRE = B3clipREI(1:OLs(3,2)); 
    B3itivRE = B3itivREI(1:OLs(3,3)); 
    
    mu = mean([GSRfbase{3}(:); GSRfclip{3}(:); GSRfitiv{3}(:)]);
    GSRfbase{3}(:,[B3baseRE B3clipRE B3itivRE])= mu;
    GSRfclip{3}(:,[B3baseRE B3clipRE B3itivRE])= mu;
    GSRfitiv{3}(:,[B3baseRE B3clipRE B3itivRE])= mu;

end;





% %###################################
% 
% for bb = 1:3
%     
%     GSRfbase{bb} = GSRfbase{bb} + .1;
%     GSRfclip{bb} = GSRfclip{bb} + .1;
%     GSRfitiv{bb} = GSRfitiv{bb} + .1;
%     
%     muBase = mean(GSRfbase{bb});
%     muB = repmat(muBase,size(GSRfbase{bb},1),1);
%     muC = repmat(muBase,size(GSRfclip{bb},1),1);
%     muI = repmat(muBase,size(GSRfitiv{bb},1),1);
%     
% 
%     GSRdfbase{bb} = (  GSRfbase{bb} - muB  ) ./ muB;
%     GSRdfclip{bb} = (  GSRfclip{bb} - muC  ) ./ muC;
%     GSRdfitiv{bb} = (  GSRfitiv{bb} - muI  ) ./ muI;
% 
% end
% 
% GSRfbase = GSRdfbase;
% GSRfclip = GSRdfclip;
% GSRfitiv = GSRdfitiv;
% 
% %###################################





%% PLOT 6 AXES LINE GRAPH
%
%   B1-BASE   B1-CLIP   B1-ITIV
%   B2-BASE   B2-CLIP   B2-ITIV
%   B3-BASE   B3-CLIP   B3-ITIV
%




fh34=figure('Units','normalized','OuterPosition',[.01 .04 .95 .91],'Color','w','MenuBar','none');
hax1 = axes('Position',[.03 .68 .30 .29],'Color','none','FontSize',12);               axis tight; hold on;
hax2 = axes('Position',[.35 .68 .30 .29],'Color','none','FontSize',12,'YTick',[]);    axis tight; hold on;
hax3 = axes('Position',[.68 .68 .30 .29],'Color','none','FontSize',12,'YTick',[]);    axis tight; hold on;
hax4 = axes('Position',[.03 .35 .30 .29],'Color','none','FontSize',12);               axis tight; hold on;
hax5 = axes('Position',[.35 .35 .30 .29],'Color','none','FontSize',12,'YTick',[]);    axis tight; hold on;
hax6 = axes('Position',[.68 .35 .30 .29],'Color','none','FontSize',12,'YTick',[]);    axis tight; hold on;
hax7 = axes('Position',[.03 .03 .30 .29],'Color','none','FontSize',12);               axis tight; hold on;
hax8 = axes('Position',[.35 .03 .30 .29],'Color','none','FontSize',12,'YTick',[]);    axis tight; hold on;
hax9 = axes('Position',[.68 .03 .30 .29],'Color','none','FontSize',12,'YTick',[]);    axis tight; hold on;


axes(hax1); title('BASELINE')
axes(hax2); title('CLIP')
axes(hax3); title('ITI')

lwA = 2; lwB = 1.5;

ph1 = plot(hax1, GSRfbase{1}(:,Block(1).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph1 = plot(hax1, GSRfbase{1}(:,Block(1).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph1 = plot(hax1, GSRfbase{1}(:,Block(1).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
ph2 = plot(hax2, GSRfclip{1}(:,Block(1).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph2 = plot(hax2, GSRfclip{1}(:,Block(1).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph2 = plot(hax2, GSRfclip{1}(:,Block(1).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
ph3 = plot(hax3, GSRfitiv{1}(:,Block(1).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph3 = plot(hax3, GSRfitiv{1}(:,Block(1).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph3 = plot(hax3, GSRfitiv{1}(:,Block(1).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 

ph4 = plot(hax4, GSRfbase{2}(:,Block(2).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph4 = plot(hax4, GSRfbase{2}(:,Block(2).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph4 = plot(hax4, GSRfbase{2}(:,Block(2).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
ph5 = plot(hax5, GSRfclip{2}(:,Block(2).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph5 = plot(hax5, GSRfclip{2}(:,Block(2).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph5 = plot(hax5, GSRfclip{2}(:,Block(2).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
ph6 = plot(hax6, GSRfitiv{2}(:,Block(2).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph6 = plot(hax6, GSRfitiv{2}(:,Block(2).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph6 = plot(hax6, GSRfitiv{2}(:,Block(2).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 

ph7 = plot(hax7, GSRfbase{3}(:,Block(3).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph7 = plot(hax7, GSRfbase{3}(:,Block(3).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph7 = plot(hax7, GSRfbase{3}(:,Block(3).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
ph8 = plot(hax8, GSRfclip{3}(:,Block(3).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph8 = plot(hax8, GSRfclip{3}(:,Block(3).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph8 = plot(hax8, GSRfclip{3}(:,Block(3).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
ph9 = plot(hax9, GSRfitiv{3}(:,Block(3).Humn), 'Color', [.60 .01 .01],'LineWidth',lwA); 
ph9 = plot(hax9, GSRfitiv{3}(:,Block(3).Anim), 'Color', [.70 .99 .70],'LineWidth',lwB); 
ph9 = plot(hax9, GSRfitiv{3}(:,Block(3).Misc), 'Color', [.70 .85 .85],'LineWidth',lwB); 
    

YL = [
hax1.YLim hax2.YLim hax3.YLim;
hax4.YLim hax5.YLim hax6.YLim;
hax7.YLim hax8.YLim hax9.YLim;
];


maxYL = max(YL');
minYL = min(YL');
hax1.YLim = [minYL(1) maxYL(1)];
hax2.YLim = [minYL(1) maxYL(1)];
hax3.YLim = [minYL(1) maxYL(1)];
hax4.YLim = [minYL(2) maxYL(2)];
hax5.YLim = [minYL(2) maxYL(2)];
hax6.YLim = [minYL(2) maxYL(2)];
hax7.YLim = [minYL(3) maxYL(3)];
hax8.YLim = [minYL(3) maxYL(3)];
hax9.YLim = [minYL(3) maxYL(3)];



% clear S
% S.type='.';
% S.subs='Color';
% S = repmat(S,1,size(Block(1).Humn,1));
% ph1(Block(b).Humn).Color = {S(Block(b).Humn).color,':'};
% S = substruct('()',num2cell(Block(1,1).Humn'),'.','Color');
% B = subsref({ph1(Block(b).Humn).Color},S);
% ph1(Block(b).Humn).Color = S;
% subsref(ph1(Block(b).Humn).Color,S);


cd(misofigspath);
set(fh34, 'PaperPositionMode', 'auto');
saveas(fh34,[filenamebase '__physio_line_charts'],'png');
cd(mainmisopath);




%% PLOT FANCY CI-95 LINE GRAPHS
% keyboard
%%

GSRfbaseB1H = GSRfbase{1}(:,Block(1).Humn);
GSRfbaseB1A = GSRfbase{1}(:,Block(1).Anim);
GSRfbaseB1M = GSRfbase{1}(:,Block(1).Misc);
GSRfclipB1H = GSRfclip{1}(:,Block(1).Humn);
GSRfclipB1A = GSRfclip{1}(:,Block(1).Anim);
GSRfclipB1M = GSRfclip{1}(:,Block(1).Misc);
GSRfitivB1H = GSRfitiv{1}(:,Block(1).Humn);
GSRfitivB1A = GSRfitiv{1}(:,Block(1).Anim);
GSRfitivB1M = GSRfitiv{1}(:,Block(1).Misc);

GSRfbaseB2H = GSRfbase{2}(:,Block(2).Humn);
GSRfbaseB2A = GSRfbase{2}(:,Block(2).Anim);
GSRfbaseB2M = GSRfbase{2}(:,Block(2).Misc);
GSRfclipB2H = GSRfclip{2}(:,Block(2).Humn);
GSRfclipB2A = GSRfclip{2}(:,Block(2).Anim);
GSRfclipB2M = GSRfclip{2}(:,Block(2).Misc);
GSRfitivB2H = GSRfitiv{2}(:,Block(2).Humn);
GSRfitivB2A = GSRfitiv{2}(:,Block(2).Anim);
GSRfitivB2M = GSRfitiv{2}(:,Block(2).Misc);

GSRfbaseB3H = GSRfbase{3}(:,Block(3).Humn);
GSRfbaseB3A = GSRfbase{3}(:,Block(3).Anim);
GSRfbaseB3M = GSRfbase{3}(:,Block(3).Misc);
GSRfclipB3H = GSRfclip{3}(:,Block(3).Humn);
GSRfclipB3A = GSRfclip{3}(:,Block(3).Anim);
GSRfclipB3M = GSRfclip{3}(:,Block(3).Misc);
GSRfitivB3H = GSRfitiv{3}(:,Block(3).Humn);
GSRfitivB3A = GSRfitiv{3}(:,Block(3).Anim);
GSRfitivB3M = GSRfitiv{3}(:,Block(3).Misc);



GSR_B1_H = [GSRfbaseB1H; GSRfclipB1H; GSRfitivB1H];
GSR_B1_A = [GSRfbaseB1A; GSRfclipB1A; GSRfitivB1A];
GSR_B1_M = [GSRfbaseB1M; GSRfclipB1M; GSRfitivB1M];

GSR_B2_H = [GSRfbaseB2H; GSRfclipB2H; GSRfitivB2H];
GSR_B2_A = [GSRfbaseB2A; GSRfclipB2A; GSRfitivB2A];
GSR_B2_M = [GSRfbaseB2M; GSRfclipB2M; GSRfitivB2M];

GSR_B3_H = [GSRfbaseB3H; GSRfclipB3H; GSRfitivB3H];
GSR_B3_A = [GSRfbaseB3A; GSRfclipB3A; GSRfitivB3A];
GSR_B3_M = [GSRfbaseB3M; GSRfclipB3M; GSRfitivB3M];

GSR_B1_H_mu = mean(GSR_B1_H,2);
GSR_B1_A_mu = mean(GSR_B1_A,2);
GSR_B1_M_mu = mean(GSR_B1_M,2);

GSR_B2_H_mu = mean(GSR_B2_H,2);
GSR_B2_A_mu = mean(GSR_B2_A,2);
GSR_B2_M_mu = mean(GSR_B2_M,2);

GSR_B3_H_mu = mean(GSR_B3_H,2);
GSR_B3_A_mu = mean(GSR_B3_A,2);
GSR_B3_M_mu = mean(GSR_B3_M,2);

GSR_B1_H_se = (std(GSR_B1_H') ./ sqrt(size(GSR_B1_H,2)))';
GSR_B1_A_se = (std(GSR_B1_A') ./ sqrt(size(GSR_B1_A,2)))';
GSR_B1_M_se = (std(GSR_B1_M') ./ sqrt(size(GSR_B1_M,2)))';

GSR_B2_H_se = (std(GSR_B2_H') ./ sqrt(size(GSR_B2_H,2)))';
GSR_B2_A_se = (std(GSR_B2_A') ./ sqrt(size(GSR_B2_A,2)))';
GSR_B2_M_se = (std(GSR_B2_M') ./ sqrt(size(GSR_B2_M,2)))';

GSR_B3_H_se = (std(GSR_B3_H') ./ sqrt(size(GSR_B3_H,2)))';
GSR_B3_A_se = (std(GSR_B3_A') ./ sqrt(size(GSR_B3_A,2)))';
GSR_B3_M_se = (std(GSR_B3_M') ./ sqrt(size(GSR_B3_M,2)))';


%%


fh31=figure('Units','normalized','OuterPosition',[.01 .04 .95 .91],'Color','w','MenuBar','none');
hax1 = axes('Position',[.03 .68 .95 .29],'Color','none','FontSize',12); axis tight; hold on;
hax2 = axes('Position',[.03 .35 .95 .29],'Color','none','FontSize',12); axis tight; hold on;
hax3 = axes('Position',[.03 .03 .95 .29],'Color','none','FontSize',12); axis tight; hold on;



B1xMx = [1:length(GSR_B1_H_mu); 1:length(GSR_B1_H_mu); 1:length(GSR_B1_H_mu)]';
B1yMx = [GSR_B1_H_mu GSR_B1_A_mu GSR_B1_M_mu];
B1sMx(:,:,1) = [GSR_B1_H_se GSR_B1_H_se];
B1sMx(:,:,2) = [GSR_B1_A_se GSR_B1_A_se];
B1sMx(:,:,3) = [GSR_B1_M_se GSR_B1_M_se];

axes(hax1)
[ph1, po1] = cifan(B1xMx, B1yMx, B1sMx,'alpha','transparency', 0.4);


B2xMx = [1:length(GSR_B2_H_mu); 1:length(GSR_B2_H_mu); 1:length(GSR_B2_H_mu)]';
B2yMx = [GSR_B2_H_mu GSR_B2_A_mu GSR_B2_M_mu];
B2sMx(:,:,1) = [GSR_B2_H_se GSR_B2_H_se];
B2sMx(:,:,2) = [GSR_B2_A_se GSR_B2_A_se];
B2sMx(:,:,3) = [GSR_B2_M_se GSR_B2_M_se];

axes(hax2)
[ph2, po2] = cifan(B2xMx, B2yMx, B2sMx,'alpha','transparency', 0.4);


B3xMx = [1:length(GSR_B3_H_mu); 1:length(GSR_B3_H_mu); 1:length(GSR_B3_H_mu)]';
B3yMx = [GSR_B3_H_mu GSR_B3_A_mu GSR_B3_M_mu];
B3sMx(:,:,1) = [GSR_B3_H_se GSR_B3_H_se];
B3sMx(:,:,2) = [GSR_B3_A_se GSR_B3_A_se];
B3sMx(:,:,3) = [GSR_B3_M_se GSR_B3_M_se];

axes(hax3)
[ph3, po3] = cifan(B3xMx, B3yMx, B3sMx,'alpha','transparency', 0.4);



YL = [hax1.YLim hax2.YLim hax3.YLim];
maxYL = max(YL');
minYL = min(YL');
hax1.YLim = [minYL maxYL];
hax2.YLim = [minYL maxYL];
hax3.YLim = [minYL maxYL];

    axes(hax1)
    title(datafile,'Interpreter','none')

    leg1 = legend([ph1],{' Human ',' Animal ', ' Other '});
    set(leg1, 'Location','NorthWest', 'Color', [1 1 1],'FontSize',16,'Box','off');
    % set(leg1, 'Position', leg1.Position .* [1 .92 1 1.5])

cd(misofigspath);
set(fh31, 'PaperPositionMode', 'auto');
saveas(fh31,[filenamebase '__physio_CI_charts'],'png');
cd(mainmisopath);



%###################################
%{
for bb = 1:3
    
    muBase = mean(GSRfbase{bb});
    muB = repmat(muBase,size(GSRfbase{bb},1),1);
    muC = repmat(muBase,size(GSRfclip{bb},1),1);
    muI = repmat(muBase,size(GSRfitiv{bb},1),1);
    

    GSRdfbase{bb} = (  GSRfbase{bb} - muB  ) ./ muB;
    GSRdfclip{bb} = (  GSRfclip{bb} - muC  ) ./ muC;
    GSRdfitiv{bb} = (  GSRfitiv{bb} - muI  ) ./ muI;

end


%###################################

GSRbB1H = GSRfbase{1}(:,Block(1).Humn) ;
GSRbB1A = GSRfbase{1}(:,Block(1).Anim) ;
GSRbB1M = GSRfbase{1}(:,Block(1).Misc) ;
GSRcB2H = GSRfclip{1}(:,Block(1).Humn) ;
GSRcB2A = GSRfclip{1}(:,Block(1).Anim) ;
GSRcB2M = GSRfclip{1}(:,Block(1).Misc) ;
GSRiB3H = GSRfitiv{1}(:,Block(1).Humn) ;
GSRiB3A = GSRfitiv{1}(:,Block(1).Anim) ;
GSRiB3M = GSRfitiv{1}(:,Block(1).Misc) ;

GSRbB1H = GSRfbase{2}(:,Block(2).Humn) ;
GSRbB1A = GSRfbase{2}(:,Block(2).Anim) ;
GSRbB1M = GSRfbase{2}(:,Block(2).Misc) ;
GSRcB2H = GSRfclip{2}(:,Block(2).Humn) ;
GSRcB2A = GSRfclip{2}(:,Block(2).Anim) ;
GSRcB2M = GSRfclip{2}(:,Block(2).Misc) ;
GSRiB3H = GSRfitiv{2}(:,Block(2).Humn) ;
GSRiB3A = GSRfitiv{2}(:,Block(2).Anim) ;
GSRiB3M = GSRfitiv{2}(:,Block(2).Misc) ;

GSRbB1H = GSRfbase{3}(:,Block(3).Humn) ;
GSRbB1A = GSRfbase{3}(:,Block(3).Anim) ;
GSRbB1M = GSRfbase{3}(:,Block(3).Misc) ;
GSRcB2H = GSRfclip{3}(:,Block(3).Humn) ;
GSRcB2A = GSRfclip{3}(:,Block(3).Anim) ;
GSRcB2M = GSRfclip{3}(:,Block(3).Misc) ;
GSRiB3H = GSRfitiv{3}(:,Block(3).Humn) ;
GSRiB3A = GSRfitiv{3}(:,Block(3).Anim) ;
GSRiB3M = GSRfitiv{3}(:,Block(3).Misc) ;


GSRfbB1h = GSRfbase{1}(:,Block(1).Humn);
GSRfbB1a = GSRfbase{1}(:,Block(1).Anim);
GSRfbB1m = GSRfbase{1}(:,Block(1).Misc);
GSRfcB1h = GSRfclip{1}(:,Block(1).Humn);
GSRfcB1a = GSRfclip{1}(:,Block(1).Anim);
GSRfcB1m = GSRfclip{1}(:,Block(1).Misc);
GSRfiB1h = GSRfitiv{1}(:,Block(1).Humn);
GSRfiB1a = GSRfitiv{1}(:,Block(1).Anim);
GSRfiB1m = GSRfitiv{1}(:,Block(1).Misc);

GSRfbB1h = GSRfbase{2}(:,Block(2).Humn);
GSRfbB1a = GSRfbase{2}(:,Block(2).Anim);
GSRfbB1m = GSRfbase{2}(:,Block(2).Misc);
GSRfcB1h = GSRfclip{2}(:,Block(2).Humn);
GSRfcB1a = GSRfclip{2}(:,Block(2).Anim);
GSRfcB1m = GSRfclip{2}(:,Block(2).Misc);
GSRfiB1h = GSRfitiv{2}(:,Block(2).Humn);
GSRfiB1a = GSRfitiv{2}(:,Block(2).Anim);
GSRfiB1m = GSRfitiv{2}(:,Block(2).Misc);

GSRfbB1h = GSRfbase{3}(:,Block(3).Humn);
GSRfbB1a = GSRfbase{3}(:,Block(3).Anim);
GSRfbB1m = GSRfbase{3}(:,Block(3).Misc);
GSRfcB1h = GSRfclip{3}(:,Block(3).Humn);
GSRfcB1a = GSRfclip{3}(:,Block(3).Anim);
GSRfcB1m = GSRfclip{3}(:,Block(3).Misc);
GSRfiB1h = GSRfitiv{3}(:,Block(3).Humn);
GSRfiB1a = GSRfitiv{3}(:,Block(3).Anim);
GSRfiB1m = GSRfitiv{3}(:,Block(3).Misc);

B1xMx
B1yMx
B1sMx
B2xMx
B2yMx
B2sMx
B3xMx
B3yMx
B3sMx

%}


keyboard
%##################################################################################
%##################################################################################
end
%##################################################################################
%###################             MAIN LOOP END           ########################
%##################################################################################
return
%%

close all

fh4=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax5 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
hax6 = axes('Position',[.52 .52 .42 .42],'Color','none'); 
hax7 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
hax8 = axes('Position',[.52 .05 .42 .42],'Color','none'); 


axes(hax5)
bar(Block(1).GSRbars); 

hax5.XTickLabel = {'Baseline', 'Clip', 'ITI'};
legend('Human','Animal','Other','Location','northeast')
title(['GSR in Block-1 (SUB: ' filenamebase ')'],'Interpreter','none')
hold on

errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22], ...
         Block(1).GSRbars,...
         Block(1).GSRbarsSe,...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','none')




axes(hax6)
bar(Block(2).GSRbars); 

hax6.XTickLabel = {'Baseline', 'Clip', 'ITI'};
legend('Human','Animal','Other','Location','northeast')
title(['GSR in Block-2 (SUB: ' filenamebase ')'],'Interpreter','none')
hold on

errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22], ...
         Block(2).GSRbars,...
         Block(2).GSRbarsSe,...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','none')



axes(hax7)
bar(Block(3).GSRbars); 

hax7.XTickLabel = {'Baseline', 'Clip', 'ITI'};
legend('Human','Animal','Other','Location','northeast')
title(['GSR in Block-3 (SUB: ' filenamebase ')'],'Interpreter','none')
hold on

errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22], ...
         Block(3).GSRbars,...
         Block(3).GSRbarsSe,...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','none')
    
    

    
axes(hax8)
bar(Block(2).GSRclipHAMFT_MEAN); 

hax8.XTickLabel = {'Human', 'Animal', 'Other'};
legend('Foil','Target','Location','northeast')
title(['GSR in Block-2 Clips Foil vs Target (SUB: ' filenamebase ')'],'Interpreter','none')
hold on

errorbar([1-.15 1+.15; 2-.15 2+.15; 3-.15 3+.15], ...
         Block(2).GSRclipHAMFT_MEAN,...
         Block(2).GSRclipHAMFT_SEM,...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','none')    



cd(misofigspath);
set(fh4, 'PaperPositionMode', 'auto');
saveas(fh4,[filenamebase '__GSR_by_Block' ],'png');
cd(mainmisopath);






%% ------------------------------------------------------------------------

for b = 1:3

Block(b).GSRdFMuHu = mean(Block(b).GSRdF(Block(b).Humn));
Block(b).GSRdFMuAn = mean(Block(b).GSRdF(Block(b).Anim));
Block(b).GSRdFMuMi = mean(Block(b).GSRdF(Block(b).Misc));

Block(b).GSRdFSeHu = std(Block(b).GSRdF(Block(b).Humn)) ./ sqrt(numel(Block(b).GSRdF(Block(b).Humn)));
Block(b).GSRdFSeAn = std(Block(b).GSRdF(Block(b).Anim)) ./ sqrt(numel(Block(b).GSRdF(Block(b).Anim)));
Block(b).GSRdFSeMi = std(Block(b).GSRdF(Block(b).Misc)) ./ sqrt(numel(Block(b).GSRdF(Block(b).Misc)));



Block(b).GSRdFMuHuTF0 = mean(Block(b).GSRdF(Block(b).HumnFoil));
Block(b).GSRdFMuAnTF0 = mean(Block(b).GSRdF(Block(b).AnimFoil));
Block(b).GSRdFMuMiTF0 = mean(Block(b).GSRdF(Block(b).MiscFoil));

Block(b).GSRdFMuHuTF1 = mean(Block(b).GSRdF(Block(b).HumnTarg));
Block(b).GSRdFMuAnTF1 = mean(Block(b).GSRdF(Block(b).AnimTarg));
Block(b).GSRdFMuMiTF1 = mean(Block(b).GSRdF(Block(b).MiscTarg));


Block(b).GSRdFSeHuTF0 = std(Block(b).GSRdF(Block(b).HumnFoil)) ./ sqrt(numel(Block(b).GSRdF(Block(b).HumnFoil)));
Block(b).GSRdFSeAnTF0 = std(Block(b).GSRdF(Block(b).AnimFoil)) ./ sqrt(numel(Block(b).GSRdF(Block(b).AnimFoil)));
Block(b).GSRdFSeMiTF0 = std(Block(b).GSRdF(Block(b).MiscFoil)) ./ sqrt(numel(Block(b).GSRdF(Block(b).MiscFoil)));

Block(b).GSRdFSeHuTF1 = std(Block(b).GSRdF(Block(b).HumnTarg)) ./ sqrt(numel(Block(b).GSRdF(Block(b).HumnTarg)));
Block(b).GSRdFSeAnTF1 = std(Block(b).GSRdF(Block(b).AnimTarg)) ./ sqrt(numel(Block(b).GSRdF(Block(b).AnimTarg)));
Block(b).GSRdFSeMiTF1 = std(Block(b).GSRdF(Block(b).MiscTarg)) ./ sqrt(numel(Block(b).GSRdF(Block(b).MiscTarg)));




Block(b).GSRdFHAM_MEAN   = [Block(b).GSRdFMuHu Block(b).GSRdFMuAn Block(b).GSRdFMuMi];

Block(b).GSRdFHAM_SEM    = [Block(b).GSRdFSeHu Block(b).GSRdFSeAn Block(b).GSRdFSeMi];



Block(b).GSRdFHAMFT_MEAN = [Block(b).GSRdFMuHuTF0 Block(b).GSRdFMuAnTF0 Block(b).GSRdFMuMiTF0;...
                            Block(b).GSRdFMuHuTF1 Block(b).GSRdFMuAnTF1 Block(b).GSRdFMuMiTF1];

Block(b).GSRdFHAMFT_SEM    = [Block(b).GSRdFSeHuTF0 Block(b).GSRdFSeAnTF0 Block(b).GSRdFSeMiTF0;...
                              Block(b).GSRdFSeHuTF1 Block(b).GSRdFSeAnTF1 Block(b).GSRdFSeMiTF1];             



end


%% ------------------------------------------------------------------------


close all

fh5=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax1 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
hax2 = axes('Position',[.52 .52 .42 .42],'Color','none'); 
hax3 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
hax4 = axes('Position',[.52 .05 .42 .42],'Color','none'); 



axes(hax1)
% bar(Block(1).GSRdFHAM_MEAN); 
bar(reshape([Block(1:3).GSRdFHAM_MEAN],[3,3])'); 

hax1.XTickLabel = {'Block-1 Audio', 'Block-2 Context', 'Block-3 Video'};
legend('Human','Animal','Other','Location','northeast')
title(['Normalized GSR Change in Block-1   (' filenamebase ')'],'Interpreter','none')
hold on


errorbar([1-.22 1 1+.22; 2-.22 2 2+.22; 3-.22 3 3+.22],...
         reshape([Block(1:3).GSRdFHAM_MEAN],[3,3])',...
         reshape([Block(1:3).GSRdFHAM_SEM],[3,3])',...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','none')


    
    
    
    
axes(hax2)
bar([Block(2).GSRdFHAMFT_MEAN]'); 

hax2.XTickLabel = {'Human', 'Animal', 'Other'};
legend('Foil','Target','Location','northeast')
title(['Normalized GSR Change in Block-2 Foils vs Targets   (' filenamebase ')'],'Interpreter','none')
hold on


errorbar([1-.15 1+.15; 2-.15 2+.15; 3-.15 3+.15], ...
         [Block(2).GSRdFHAMFT_MEAN]',...
         [Block(2).GSRdFHAMFT_SEM]',...
        'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','none')




cd(misofigspath);
set(fh5, 'PaperPositionMode', 'auto');
saveas(fh5,[filenamebase '__GSR_dF'],'png');
cd(mainmisopath);




Block(b).GSRdFHAMFT_MEAN = [Block(b).GSRdFMuHuTF0 Block(b).GSRdFMuAnTF0 Block(b).GSRdFMuMiTF0;...
                            Block(b).GSRdFMuHuTF1 Block(b).GSRdFMuAnTF1 Block(b).GSRdFMuMiTF1];

Block(b).GSRdFHAMFT_SEM    = [Block(b).GSRdFSeHuTF0 Block(b).GSRdFSeAnTF0 Block(b).GSRdFSeMiTF0;...
                              Block(b).GSRdFSeHuTF1 Block(b).GSRdFSeAnTF1 Block(b).GSRdFSeMiTF1];  

datatable.GSRdfMuHu = [Block(1:3).GSRdFMuHu]';
datatable.GSRdfMuAn = [Block(1:3).GSRdFMuAn]';
datatable.GSRdfMuMi = [Block(1:3).GSRdFMuMi]';

datatable.GSRdfSeHu = [Block(1:3).GSRdFSeHu]';
datatable.GSRdfSeAn = [Block(1:3).GSRdFSeAn]';
datatable.GSRdfSeMi = [Block(1:3).GSRdFSeMi]';


datatable.GSRB2dfMuHuAnMiF = [Block(2).GSRdFMuHuTF0 Block(2).GSRdFMuAnTF0 Block(2).GSRdFMuMiTF0]';
datatable.GSRB2dfMuHuAnMiT = [Block(2).GSRdFMuHuTF1 Block(2).GSRdFMuAnTF1 Block(2).GSRdFMuMiTF1]';

datatable.GSRB2dfSeHuAnMiF = [Block(2).GSRdFSeHuTF0 Block(2).GSRdFSeAnTF0 Block(2).GSRdFSeMiTF0]';
datatable.GSRB2dfSeHuAnMiT = [Block(2).GSRdFSeHuTF1 Block(2).GSRdFSeAnTF1 Block(2).GSRdFSeMiTF1]';


datatab = struct2table(datatable);

disp(datatab)

cd(misofigspath);
save(['datatab_' filenamebase],'datatab');
cd(mainmisopath);


%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
%% ------------------------------------------------------------------------
