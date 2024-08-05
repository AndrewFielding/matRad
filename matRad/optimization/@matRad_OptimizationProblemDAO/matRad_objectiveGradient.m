function g = matRad_objectiveGradient(optiProb,apertureInfoVec,dij,cst)
% matRad IPOPT callback: gradient function for direct aperture optimization
%
% call
%   g = matRad_objectiveGradient(optiProb,apertureInfoVec,dij,cst)
%
% input
%   optiProb:           option struct defining the type of optimization
%   apertureInfoVect:   aperture info in form of vector
%   dij:                matRad dij struct as generated by bixel-based dose calculation
%   cst:                matRad cst struct
%
% output
%   g: gradient
%
% References
%   [1] http://dx.doi.org/10.1118/1.4914863
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright 2015 the matRad development team. 
% 
% This file is part of the matRad project. It is subject to the license 
% terms in the LICENSE file found in the top-level directory of this 
% distribution and at https://github.com/e0404/matRad/LICENSE.md. No part 
% of the matRad project, including this file, may be copied, modified, 
% propagated, or distributed except according to the terms contained in the 
% LICENSE file.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% update apertureInfo, bixel weight vector an mapping of leafes to bixels
if ~isequal(apertureInfoVec,optiProb.apertureInfo.apertureVector)
    optiProb.apertureInfo = optiProb.matRad_daoVec2ApertureInfo(optiProb.apertureInfo,apertureInfoVec);
end
apertureInfo = optiProb.apertureInfo;

% bixel based gradient calculation
bixelG = matRad_objectiveGradient@matRad_OptimizationProblem(optiProb,apertureInfo.bixelWeights,dij,cst);
    
% allocate gradient vector for aperture weights and leaf positions
g = NaN * ones(size(apertureInfoVec,1),1);

% 1. calculate aperatureGrad
% loop over all beams
offset = 0;
for i = 1:numel(apertureInfo.beam)

    % get used bixels in beam
    ix = ~isnan(apertureInfo.beam(i).bixelIndMap);

    % loop over all shapes and add up the gradients x openingFrac for this shape
    for j = 1:apertureInfo.beam(i).numOfShapes            
        g(j+offset) = apertureInfo.beam(i).shape(j).shapeMap(ix)' ...
                        * bixelG(apertureInfo.beam(i).bixelIndMap(ix));
    end

    % increment offset
    offset = offset + apertureInfo.beam(i).numOfShapes;

end

% 2. find corresponding bixel to the leaf Positions and aperture 
% weights to calculate the gradient
g(apertureInfo.totalNumOfShapes+1:end) = ...
        apertureInfoVec(apertureInfo.mappingMx(apertureInfo.totalNumOfShapes+1:end,2)) ...
     .* bixelG(apertureInfo.bixelIndices(apertureInfo.totalNumOfShapes+1:end)) / apertureInfo.bixelWidth;

% correct the sign for the left leaf positions
g(apertureInfo.totalNumOfShapes+1:apertureInfo.totalNumOfShapes+apertureInfo.totalNumOfLeafPairs) = ...
    -g(apertureInfo.totalNumOfShapes+1:apertureInfo.totalNumOfShapes+apertureInfo.totalNumOfLeafPairs);
