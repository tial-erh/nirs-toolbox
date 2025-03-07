function data=readMOXY_XLMS(filename)

[data,headers,celldata]=xlsread(filename,'Parsed Data');

time=data(:,find(ismember(headers,'Time')))*60*60*24;
time=time-time(1);

lst=find(ismember(headers,'SmO2'));
SmO2=nan(length(time),length(lst));
for i=1:length(lst)
    SmO2(:,i)=data(:,lst(i));
end
SmO2=nanmax(SmO2,[],2);

lst=find(ismember(headers,'THb'));
THb=nan(length(time),length(lst));
for i=1:length(lst)
    THb(:,i)=data(:,lst(i));
end
THb=nanmax(THb,[],2);




SmO2(SmO2==0)=NaN;
SmO2(SmO2==-9999)=NaN;
THb(THb==0)=NaN;
THb(THb==-9999)=NaN;

data=nirs.core.Data;
data.time=time;
data.data=[SmO2 THb];
data.description=filename;
data.probe=nirs.core.ProbeROI({'Leg:SmO2','Leg:THb'});
