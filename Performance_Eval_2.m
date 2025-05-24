function [RI,VOI,GCE] = Performance_Eval_2(testPath,FileName,sampleLabels)

RI = NaN;
GCE = NaN;
VOI = NaN;

benchPath = 'benchset/';

if ~isfile([benchPath,FileName(1:end-4),'.mat'])
    disp('Reference Lable does not exists ');
    disp(['RI,VOI and GCE evaluation criteria could not be calculated']);
    return
end


temp = FileName(1:end-4);
benchFilename = [benchPath temp '.mat'];
testFilename = [testPath temp 'Lable.mat'];

load(benchFilename);


sumRI = 0;
sumVOI = 0;
sumGCE = 0;

[benchX, benchY] = size(imageLabelCell{1});
[imageX, imageY] = size(sampleLabels);

for benchIndex=1:length(imageLabelCell)
    benchLabels = imageLabelCell{benchIndex};
    benchLabels = imresize(benchLabels,[imageX imageY]);
    
    [curRI,curGCE,curVOI] = compare_segmentations(sampleLabels,benchLabels);
    sumRI = sumRI + curRI;
    sumVOI = sumVOI + curVOI;
    sumGCE = sumGCE + curGCE;
end
RI = sumRI / length(imageLabelCell);
VOI = sumVOI / length(imageLabelCell);
GCE = sumGCE / length(imageLabelCell);

end

