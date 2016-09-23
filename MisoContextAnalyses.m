load('SUB28VHpilotmiso.mat');
load('AudioBlock1_05-Aug-2016_SUB28VH_Miso.mat');
Sub28Data = acq.data;
timings = T;
T.StartTrial(1) = 1; %makes the first cell value = to 1

%floor(T.StartTrial):floor(T.StartClip)
%floor(T.StartClip):floor(T.EndClip)
%floor(T.EndClip):floor(T.EndTrial)

StartTrial = T(:,1);
StartClip = T(:,2);
EndClip = T(:,3);
EndTrial = T(:,4);

ntrials = 18;
%%
GSR = Sub28Data(:,3);
GSRpeak2peakbaseline = [];
GSRpeak2peakclip = [];
GSRpeak2peakbreak = [];

GSRbaselineavg = [];
GSRclipavg = [];
GSRpercentchange = [];

for n = 1:ntrials
GSR5secbaseline = GSR((StartTrial{n,1}*2000):((StartClip{n,1}*2000)));
GSRpeak2peakbaseline(n) = max(GSR5secbaseline)-min(GSR5secbaseline);
GSRbaselineavg(n) = mean(GSR5secbaseline);

GSRclipduration = GSR((StartClip{n,1}*2000):(EndClip{n,1}*2000));
GSRpeak2peakclip(n) = max(GSRclipduration)-min(GSRclipduration);
GSRclipavg(n) = mean(GSRclipduration);

GSRendclipbreak = GSR((EndClip{n,1}*2000):(EndTrial{n,1}*2000));
GSRpeak2peakbreak(n) = max(GSRendclipbreak)-min(GSRendclipbreak);

GSRpercentchange(n) = ((GSRclipavg(n) - GSRbaselineavg(n))/(GSRbaselineavg(n)))*100;
end

%Plot
plot(GSR)
plot(GSRpeak2peakbaseline);
plot(GSRpeak2peakclip);
plot(GSRpeak2peakbreak);


plot(Sub28Data(:,1));

startTrialMatrix=round(2000*table2array(StartTrial));
endTrialMatrix=startTrialMatrix+2000*20;
testSubject = Sub28Data(:,1);
testSubjectGSR = Sub28Data(:,3);
for i=1:18
    testSubjectTrials(i,:)=smooth(abs(testSubject(startTrialMatrix(i):endTrialMatrix(i))),1000);
end
for i=1:18
    testSubjectTrialsGSR(i,:)=smooth(zscore(testSubjectGSR(startTrialMatrix(i):endTrialMatrix(i))),10);
end
x=0:(20/40000):20;
plot(x,testSubjectTrialsGSR(2:end,:))
legend('show')


