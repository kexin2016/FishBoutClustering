function peakout=findPeaks(data)

diffs=sign(diff(data));

allflat=find(diffs==0);

peaks=[0; (diff(diffs)==-2); 0];

inde=1:length(diffs);
if any(allflat)
    inde(allflat)=[];
    
    y=diffs(inde);
    
    
    flatmax=(diff(y)==-2);


x=inde(find(flatmax))+1;

 %x(1:10)
peaks(inde(find(flatmax))+1)=1;

end

peakout=data.*peaks;
