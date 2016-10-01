%% MisoAnalyses.m
%{.
clc; close all; clear;


global thisfilepath
thisfile = 'MisoAnalyses.m';
thisfilepath = fileparts(which(thisfile));
cd(thisfilepath);

fprintf('\n\n Current working path set to: \n % s \n', thisfilepath)

    
pathdir0 = thisfilepath;
pathdir1 = [thisfilepath '/SubFiles'];
gpath = [pathdir0 ':' pathdir1];
addpath(gpath)

fprintf('\n\n Added folders to path: \n % s \n % s \n\n',...
        pathdir0,pathdir1)




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
clear thisfile pathdir0 pathdir1 gpath datafile datapath thisfilepath
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

SubDataB1 = block1acq.data;
SubDataB2 = block2acq.data;
SubDataB3 = block3acq.data;


B1tN(1,1) = 1; %makes the first cell value = to 1
B2tN(1,1) = 1; %makes the first cell value = to 1
B3tN(1,1) = 1; %makes the first cell value = to 1


StartTrial = B1tN(:,1);
StartClip = B1tN(:,2);
EndClip = B1tN(:,3);
EndTrial = B1tN(:,4);

ntrials = size(B1tN,1);



HumanAnimalNon = B1tN(:,6);

Rating = B1tN(:,7);

FoilTarget = B2tN(:,10);



sps = 2000;
musz = 20;
BlockNum = 1;


% ------------------------------------------------------------------------


ARM = SubDataB1(:,1);
NEK = SubDataB1(:,2);
GSR = SubDataB1(:,3);
HRT = SubDataB1(:,4);

ARM = ARM + abs(mean(ARM));
NEK = NEK + abs(mean(NEK));
GSR = GSR + abs(mean(GSR));
HRT = HRT + abs(mean(HRT));




datsecs = floor(numel(GSR) / musz);

ARMmu=[];
NEKmu=[];
GSRmu=[];
HRTmu=[];
for nn = 0:datsecs-1
    
    ARMmu(nn+1) = mean(ARM(nn*musz+1:nn*musz+musz));
    NEKmu(nn+1) = mean(NEK(nn*musz+1:nn*musz+musz));
    GSRmu(nn+1) = mean(GSR(nn*musz+1:nn*musz+musz));
    HRTmu(nn+1) = mean(HRT(nn*musz+1:nn*musz+musz));
    
end

ARMmuUPct = prctile(ARMmu,99.99);
NEKmuUPct = prctile(NEKmu,99.99);
GSRmuUPct = prctile(GSRmu,99.99);
HRTmuUPct = prctile(HRTmu,99.99);

ARMmuLPct = prctile(ARMmu,00.01);
NEKmuLPct = prctile(NEKmu,00.01);
GSRmuLPct = prctile(GSRmu,00.01);
HRTmuLPct = prctile(HRTmu,00.01);


ARMmu(ARMmu>ARMmuUPct) = ARMmuUPct;
NEKmu(NEKmu>NEKmuUPct) = NEKmuUPct;
GSRmu(GSRmu>GSRmuUPct) = GSRmuUPct;
HRTmu(HRTmu>HRTmuUPct) = HRTmuUPct;

ARMmu(ARMmu<ARMmuLPct) = ARMmuLPct;
NEKmu(NEKmu<NEKmuLPct) = NEKmuLPct;
GSRmu(GSRmu<GSRmuLPct) = GSRmuLPct;
HRTmu(HRTmu<HRTmuLPct) = HRTmuLPct;



ARMmu = ARMmu + abs(min(ARMmu));
NEKmu = NEKmu + abs(min(NEKmu));
GSRmu = GSRmu + abs(min(GSRmu));
HRTmu = HRTmu + abs(min(HRTmu));



% SELF REPORT RATINGS BLOCK 1, 2, 3

SubRatingB1 = B1tN(:,7);
SubRatingB2 = B2tN(:,7);
SubRatingB3 = B3tN(:,7);


% HumanAnimalNon = B1tN(:,6);
% HumanAnimalNon = B1tN(:,6);
% HumanAnimalNon = B1tN(:,6);

TrialTypeB1 = B1tN(:,6);
TrialTypeB2 = B2tN(:,6);
TrialTypeB3 = B3tN(:,6);



SubRatingB1mu = mean(SubRatingB1)
SubRatingB2mu = mean(SubRatingB2)
SubRatingB3mu = mean(SubRatingB3)
SubRatingB1se = std(SubRatingB1) / sqrt(numel(SubRatingB1))
SubRatingB2se = std(SubRatingB2) / sqrt(numel(SubRatingB2))
SubRatingB3se = std(SubRatingB3) / sqrt(numel(SubRatingB3))



[TThumn, c, v] = find((HumanAnimalNon == 1));
[TTanim, c, v] = find((HumanAnimalNon == 2));
[TTmisc, c, v] = find((HumanAnimalNon == 3));

[TF0, c, v] = find((FoilTarget == 0));
[TF1, c, v] = find((FoilTarget == 1));

TThumnTF0 = intersect(TF0,TThumn);
TTanimTF0 = intersect(TF0,TTanim);
TTmiscTF0 = intersect(TF0,TTmisc);
TThumnTF1 = intersect(TF1,TThumn);
TTanimTF1 = intersect(TF1,TTanim);
TTmiscTF1 = intersect(TF1,TTmisc);


close all

% fh2=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
% hax5 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
% hax6 = axes('Position',[.52 .05 .42 .42],'Color','none'); 
% hax7 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
% hax8 = axes('Position',[.52 .52 .42 .42],'Color','none'); 



fh2=figure('Units','normalized','OuterPosition',[.05 .05 .5 .7],'Color','w','MenuBar','none');
hax5 = axes('Position',[.05 .05 .9 .9],'Color','none'); 

axes(hax5)
bar([SubRatingB1mu SubRatingB2mu SubRatingB3mu]); hold on;
errorbar([SubRatingB1mu SubRatingB2mu SubRatingB3mu],[SubRatingB1se SubRatingB2se SubRatingB3se],...
    'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)
title([filenamebase ' Self-Report Ratings in Auditory, Informed, Visual Blocks'],'Interpreter','none')
hax5.YLim = [0 10];

pause(2)

% axis tight


% axes(hax6)
% bar([GSRbaseMuHu GSRbaseMuAn GSRbaseMuMi]); hold on;
% errorbar([GSRbaseMuHu GSRbaseMuAn GSRbaseMuMi],[GSRbaseSE GSRbaseSE GSRbaseSE],...
%     'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)
% 
% title('BASELINE: TrialStart to ClipStart Per Trial')
% % axis tight
% 
% axes(hax7)
% bar([GSRclipMuHu GSRclipMuAn GSRclipMuMi]); hold on;
% errorbar([GSRclipMuHu GSRclipMuAn GSRclipMuMi],[GSRclipSE GSRclipSE GSRclipSE],...
%     'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)









% ------------------------------------------------------------------------

close all;

fh1=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax1 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
hax2 = axes('Position',[.52 .05 .42 .42],'Color','none'); 
hax3 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
hax4 = axes('Position',[.52 .52 .42 .42],'Color','none'); 

axes(hax1)
plot(hax1, ARMmu, 'LineWidth',2,'Marker','none'); title('ARM')
axis tight

axes(hax2)
plot(hax2, NEKmu, 'LineWidth',2,'Marker','none'); title('NECK')
axis tight

axes(hax3)
plot(hax3, GSRmu, 'LineWidth',2,'Marker','none'); title('GSR')
axis tight

axes(hax4)
plot(hax4, HRTmu, 'LineWidth',2,'Marker','none'); title('HEART')
axis tight





% ------------------------------------------------------------------------



GSRbasePeak = [];
GSRbaseMean = [];
GSRbaseSEM = [];

GSRclipPeak = [];
GSRclipMean = [];
GSRclipSEM = [];

GSRbreakPeak = [];
GSRbreakMean = [];
GSRbreakSEM = [];

GSRpctChange = [];

for n = 1:ntrials
    
    GSRbase = GSRmu(  round(StartTrial(n)*(sps/musz) ) : round(StartClip(n)*(sps/musz) )  );
    GSRbasePeak(n) = max(GSRbase) - min(GSRbase);
    GSRbaseMean(n) = mean(GSRbase);
    GSRbaseSEM(n) = std(GSRbase) ./ sqrt(numel(GSRbase));


    GSRclip = GSRmu(  round((StartClip(n)*(sps/musz) ))  :  round((EndClip(n)*(sps/musz) ))  );
    GSRclipPeak(n) = max(GSRclip) - min(GSRclip);
    GSRclipMean(n) = mean(GSRclip);
    GSRclipSEM(n) = std(GSRclip) ./ sqrt(numel(GSRclip));


    GSRbreak = GSRmu(  round((EndClip(n)*(sps/musz) ))  :  round((EndTrial(n)*(sps/musz) ))  );
    GSRbreakPeak(n) = max(GSRbreak) - min(GSRbreak);
    GSRbreakMean(n) = mean(GSRbreakPeak);
    GSRbreakSEM(n) = std(GSRbreak) ./ sqrt(numel(GSRbreak));
    

    GSRpctChange(n) = ((GSRclipMean(n) - GSRbaseMean(n)) / (GSRbaseMean(n)));


end



GSRpctChangeUPct = prctile(GSRpctChange,95);

GSRpctChangeLPct = prctile(GSRpctChange,5);

GSRpctChange(GSRpctChange>GSRpctChangeUPct) = GSRpctChangeUPct;

GSRpctChange(GSRpctChange<GSRpctChangeLPct) = GSRpctChangeLPct;



% ------------------------------------------------------------------------


[TThumn, c, v] = find((HumanAnimalNon == 1));
[TTanim, c, v] = find((HumanAnimalNon == 2));
[TTmisc, c, v] = find((HumanAnimalNon == 3));

[TF0, c, v] = find((FoilTarget == 0));
[TF1, c, v] = find((FoilTarget == 1));




TThumnTF0 = intersect(TF0,TThumn);
TTanimTF0 = intersect(TF0,TTanim);
TTmiscTF0 = intersect(TF0,TTmisc);
TThumnTF1 = intersect(TF1,TThumn);
TTanimTF1 = intersect(TF1,TTanim);
TTmiscTF1 = intersect(TF1,TTmisc);





GSRbaseMuHu = mean(GSRbaseMean(TThumn));
GSRbaseMuAn = mean(GSRbaseMean(TTanim));
GSRbaseMuMi = mean(GSRbaseMean(TTmisc));

GSRclipMuHu = mean(GSRclipMean(TThumn));
GSRclipMuAn = mean(GSRclipMean(TTanim));
GSRclipMuMi = mean(GSRclipMean(TTmisc));

GSRbreakMuHu = mean(GSRbreakMean(TThumn));
GSRbreakMuAn = mean(GSRbreakMean(TTanim));
GSRbreakMuMi = mean(GSRbreakMean(TTmisc));

GSRpctChHu = mean(GSRpctChange(TThumn));
GSRpctChAn = mean(GSRpctChange(TTanim));
GSRpctChMi = mean(GSRpctChange(TTmisc));


GSRbaseSE = std(GSRbaseMean) ./ sqrt(numel(GSRbaseMean));
GSRclipSE = std(GSRclipMean) ./ sqrt(numel(GSRclipMean));
GSRbreakSE = std(GSRbreakMean) ./ sqrt(numel(GSRbreakMean));





GSRclipMuHuTF0 = mean(GSRclipMean(TThumnTF0));
GSRclipMuAnTF0 = mean(GSRclipMean(TTanimTF0));
GSRclipMuMiTF0 = mean(GSRclipMean(TTmiscTF0));

GSRclipMuHuTF1 = mean(GSRclipMean(TThumnTF1));
GSRclipMuAnTF1 = mean(GSRclipMean(TTanimTF1));
GSRclipMuMiTF1 = mean(GSRclipMean(TTmiscTF1));


TFbars = [GSRclipMuHuTF0 GSRclipMuHuTF1;...
          GSRclipMuAnTF0 GSRclipMuAnTF1;...
          GSRclipMuMiTF0 GSRclipMuMiTF1];




% ------------------------------------------------------------------------


close all

fh2=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax5 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
hax6 = axes('Position',[.52 .05 .42 .42],'Color','none'); 
hax7 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
hax8 = axes('Position',[.52 .52 .42 .42],'Color','none'); 

axes(hax5)
% bar([GSRpctChHu GSRpctChAn GSRpctChMi])
bar(TFbars); hold on;
title('PLAYING: ClipStart to ClipEnd Per Trial - Foil vs True')
% axis tight

axes(hax6)
bar([GSRbaseMuHu GSRbaseMuAn GSRbaseMuMi]); hold on;
errorbar([GSRbaseMuHu GSRbaseMuAn GSRbaseMuMi],[GSRbaseSE GSRbaseSE GSRbaseSE],...
    'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)

title('BASELINE: TrialStart to ClipStart Per Trial')
% axis tight

axes(hax7)
bar([GSRclipMuHu GSRclipMuAn GSRclipMuMi]); hold on;
errorbar([GSRclipMuHu GSRclipMuAn GSRclipMuMi],[GSRclipSE GSRclipSE GSRclipSE],...
    'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)

title('PLAYING: ClipStart to ClipEnd Per Trial')
% axis tight

axes(hax8)
bar([GSRbreakMuHu GSRbreakMuAn GSRbreakMuMi]); hold on;
errorbar([GSRbreakMuHu GSRbreakMuAn GSRbreakMuMi],[GSRbreakSE GSRbreakSE GSRbreakSE],...
    'Color', [.2 0 .6], 'LineStyle','none','LineWidth',2, 'Marker','.', 'MarkerSize',20)

title('ITI: ClipEnd to Break Per Trial')
% axis tight




bardata = [GSRbaseMuHu GSRbaseMuAn GSRbaseMuMi;...
           GSRclipMuHu GSRclipMuAn GSRclipMuMi;...
           GSRbreakMuHu GSRbreakMuAn GSRbreakMuMi];

figure       
bar(bardata)
% plot(hax8, GSRendclipbreakavg, 'LineWidth',2,'Marker','none'); 
title('Human(Blue) Animal(Green) Misc(Yellow)')
axis tight


pause(2)





%%



GSRbasePeak = [];
GSRbaseMean = [];

GSRclipPeak = [];
GSRclipMean = [];

GSRbreakPeak = [];
GSRbreakMean = [];

GSRpctChange = [];

for n = 1:ntrials
    
    GSRbase = GSR(  round(StartTrial{n,1}*sps) : round(StartClip{n,1}*sps)  );

    GSRbasePeak(n) = max(GSRbase) - min(GSRbase);

    GSRbaseMean(n) = mean(GSRbase);


    GSRclip = GSR(  round((StartClip{n,1}*sps))  :  round((EndClip{n,1}*sps))  );

    GSRclipPeak(n) = max(GSRclip) - min(GSRclip);

    GSRclipMean(n) = mean(GSRclip);


    GSRbreak = GSR(  round((EndClip{n,1}*sps))  :  round((EndTrial{n,1}*sps))  );

    GSRbreakPeak(n) = max(GSRbreak) - min(GSRbreak);
    
    GSRbreakMean(n) = mean(GSRbreakPeak);
    
    

    GSRpctChange(n) = ((GSRclipMean(n) - GSRbaseMean(n)) / (GSRbaseMean(n)));


end

GSRpctChangeUPct = prctile(GSRpctChange,95);
GSRpctChangeLPct = prctile(GSRpctChange,5);
GSRpctChange(GSRpctChange>GSRpctChangeUPct) = GSRpctChangeUPct;
GSRpctChange(GSRpctChange<GSRpctChangeLPct) = GSRpctChangeLPct;


%%
close all

fh2=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax5 = axes('Position',[.05 .05 .42 .42],'Color','none'); 
hax6 = axes('Position',[.52 .05 .42 .42],'Color','none'); 
hax7 = axes('Position',[.05 .52 .42 .42],'Color','none'); 
hax8 = axes('Position',[.52 .52 .42 .42],'Color','none'); 

axes(hax5)
bar(GSRpctChange)
% plot(hax5, GSRpercentchange, 'LineWidth',2,'Marker','none'); 
title('GSR Fold Change Per Trial')
axis tight

axes(hax6)
bar(GSRbaseMean)
% plot(hax6, GSRbaselineavg, 'LineWidth',2,'Marker','none'); 
title('BASELINE: TrialStart to ClipStart Per Trial')
axis tight

axes(hax7)
bar(GSRclipMean)
% plot(hax7, GSRclipavg, 'LineWidth',2,'Marker','none');
title('PLAYING: ClipStart to ClipEnd Per Trial')
axis tight

axes(hax8)
bar(GSRbreakMean)
% plot(hax8, GSRendclipbreakavg, 'LineWidth',2,'Marker','none'); 
title('ITI: ClipEnd to Break Per Trial')
axis tight




%%


TT = repmat(HumanAnimalNon',5,1);
SR = repmat(Rating',5,1);


axGRID5 = axes('Position',[.05 .05 .42 .42],'Color','none'); axis off; hold on;
axGRID6 = axes('Position',[.52 .05 .42 .42],'Color','none'); axis off; hold on;
axGRID7 = axes('Position',[.05 .52 .42 .42],'Color','none'); axis off; hold on;
axGRID8 = axes('Position',[.52 .52 .42 .42],'Color','none'); axis off; hold on;


map = [1 0 0;
       0 1 0;
       0 0 1];

axes(axGRID5)
colormap(axGRID5,map)
phR = imagesc(TT,'Parent',axGRID5,...
      'CDataMapping','scaled','AlphaData',0.4);
axis tight;


axes(axGRID6)
colormap(axGRID6,map)
phR = imagesc(TT,'Parent',axGRID6,...
      'CDataMapping','scaled','AlphaData',0.4);
axis tight;


axes(axGRID7)
colormap(axGRID7,map)
phR = imagesc(TT,'Parent',axGRID7,...
      'CDataMapping','scaled','AlphaData',0.4);
axis tight;


axes(axGRID8)
colormap(axGRID8,map)
phR = imagesc(TT,'Parent',axGRID8,...
      'CDataMapping','scaled','AlphaData',0.4);
axis tight;


%%


























%%



testSubjectTrials = [];
testSubjectTrialsGSR = [];

startTrialMatrix = round(sps*table2array(StartTrial));
endTrialMatrix = startTrialMatrix+sps*20;
testSubject = SubDataB1(:,1);
testSubjectGSR = SubDataB1(:,3);


for i=1:ntrials
    testSubjectTrials(i,:)=smooth(abs(testSubject(startTrialMatrix(i):endTrialMatrix(i))),1000);
end

for i=1:ntrials
    testSubjectTrialsGSR(i,:)=smooth(zscore(testSubjectGSR(startTrialMatrix(i):endTrialMatrix(i))),100);
end
x = 0:(20/40000):20;


fh3=figure('Units','normalized','OuterPosition',[.05 .05 .9 .8],'Color','w','MenuBar','none');
hax9 = axes('Position',[.05 .05 .9 .9],'Color','none'); 

axes(hax9)
plot(x,testSubjectTrialsGSR(1:end,:))
axis tight
legend('show')


