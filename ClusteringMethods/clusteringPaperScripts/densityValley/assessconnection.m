for n=1:400
   alljumpsoutside=maxjump(n,clusterAssignment~= clusterAssignment(n));
   allsmallestjumps(n)=min(alljumpsoutside);
    
end