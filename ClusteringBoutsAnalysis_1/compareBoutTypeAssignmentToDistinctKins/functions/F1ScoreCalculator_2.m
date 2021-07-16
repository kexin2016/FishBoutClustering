
function [F1,TP,FP,FN,TN] = F1ScoreCalculator_2(binaryOrigianlMatrix,binaryMatrixThis)



indOneOrig = find(binaryOrigianlMatrix == 1);
indZeroOrig = find(binaryOrigianlMatrix == 0);

indOneThis = find(binaryMatrixThis == 1);
indZeroThis = find(binaryMatrixThis == 0);


TP = length(intersect(indOneOrig,indOneThis));
FP = length(intersect(indZeroOrig,indOneThis));
FN =  length(intersect(indOneOrig,indZeroThis));
TN =  length(intersect(indZeroOrig,indZeroThis));

precision = (TP)/(TP + FP);
recall = (TP)/(TP + FN);

F1 = 2*((precision*recall)/(precision + recall));
