%% MisoAnalyses.m

clc; close all; clear;


global mainmisopath 
thisfile = 'MisoAnalysesEMG.m';
mainmisopath = fileparts(which(thisfile));
cd(mainmisopath);

fprintf('\n\n Current working path set to: \n % s \n', mainmisopath)

    

subfilespath = [mainmisopath '/SubFiles'];
misofigspath = [mainmisopath '/misofigs'];
gpath = [mainmisopath ':' subfilespath ':' misofigspath];
addpath(gpath)

fprintf('\n\n Added folders to path: \n % s \n % s \n % s \n\n',...
        mainmisopath,subfilespath,misofigspath)




[datafile, datapath, ~] = uigetfile({'*.mat'}, 'Select Block 1 Physio Dataset.');
filenamebase = datafile(1:13);


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
clear thisfile gpath datafile datapath
clear block1physiopath block2physiopath block3physiopath
clear block1timingpath block2timingpath block3timingpath


% ------------------------------------------------------------------------


% StartTrial	StartClip	EndClip	EndTrial	SoundPresented	HumanAnimalNon	Rating	ControlMiso
% StartTrial	StartClip	EndClip	EndTrial	SoundPresented	HumanAnimalNon	Rating	ControlMiso	TextPresented	FoilTarget	SoundTextOrder
% StartTrial	StartClip	EndClip	EndTrial	SoundPresented	HumanAnimalNon	Rating	ControlMiso


% if isnan(B1tN(1))
%     B1tN = B1tN(2:end,:);
% end
% if isnan(RATEDxlsN(1))
%     RATEDxlsN = RATEDxlsN(2:end,:);
% end




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


clearvars -except Block filenamebase mainmisopath misofigspath

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
clearvars -except Block filenamebase mainmisopath misofigspath datatable
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

hold on;

errorbar([1-.15 1+.15; 2-.15 2+.15; 3-.15 3+.15], ...
         RatingFTMu,...
         RatingFTSe,...
    'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)
title([filenamebase ' Self-Report Ratings in Informed Block(2) Compairing Foil vs Target'],'Interpreter','none')
hax6b.YLim = [1 10];

cd(misofigspath);
set(fh3, 'PaperPositionMode', 'auto');
saveas(fh3,['Self_Report_Ratings_by_Block_' filenamebase],'png');
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
for b = 1:3; Block(b).GSRmu = Block(b).NEKmu; end


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

sps = 2000;
musz = 100;  % number of data points to average together in the physio data

for b = 1:3
for n = 1:size(Block(b).StartClip,1);
    
    GSRbase = Block(b).GSRmu(  round(Block(b).StartTrial(n)*(sps/musz) ) : round(Block(b).StartClip(n)*(sps/musz) )  );
    GSRbasePeak(n) = max(GSRbase) - min(GSRbase);
    GSRbaseMean(n) = mean(GSRbase);
    GSRbaseSEM(n) = std(GSRbase) ./ sqrt(numel(GSRbase));


    GSRclip = Block(b).GSRmu(  round((Block(b).StartClip(n)*(sps/musz) ))  :  round((Block(b).EndClip(n)*(sps/musz) ))  );
    GSRclipPeak(n) = max(GSRclip) - min(GSRclip);
    GSRclipMean(n) = mean(GSRclip);
    GSRclipSEM(n) = std(GSRclip) ./ sqrt(numel(GSRclip));


    GSRiti = Block(b).GSRmu(  round((Block(b).EndClip(n)*(sps/musz) ))  :  round((Block(b).EndTrial(n)*(sps/musz) ))  );
    GSRitiPeak(n) = max(GSRiti) - min(GSRiti);
    GSRitiMean(n) = mean(GSRitiPeak);
    GSRitiSEM(n) = std(GSRiti) ./ sqrt(numel(GSRiti));
    

    GSRpctChange(n) = ((GSRclipMean(n) - GSRbaseMean(n)) / (GSRbaseMean(n)));


end

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


%% ------------------------------------------------------------------------


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
saveas(fh4,['GSR_by_Block_' filenamebase],'png');
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
saveas(fh5,['GSR_dF_' filenamebase],'png');
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
