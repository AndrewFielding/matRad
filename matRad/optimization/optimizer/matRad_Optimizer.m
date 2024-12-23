classdef (Abstract) matRad_Optimizer < handle
% matRad_Optimizer. This is the superclass for all optimizer 
% to be used within matRad
%
% References
%   -
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Copyright 2019 the matRad development team. 
% 
% This file is part of the matRad project. It is subject to the license 
% terms in the LICENSE file found in the top-level directory of this 
% distribution and at https://github.com/e0404/matRad/LICENSE.md. No part 
% of the matRad project, including this file, may be copied, modified, 
% propagated, or distributed except according to the terms contained in the 
% LICENSE file.
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    
    properties (Abstract)
        options %options struct
    end

    properties (Abstract,SetAccess = protected)
        wResult
        resultInfo
    end
    
   
    %These should be abstract methods, however Octave can't parse them. As soon 
    %as Octave is able to do this, they should be made abstract again 
    methods %(Abstract)        
        function obj = optimize(obj,w0,optiProb,dij,cst)
            throw(MException('MATLAB:class:AbstractMember','Abstract function optimize needs to be implemented!'));
        end
        
        function [msg,statusflag] = GetStatus(obj)
            throw(MException('MATLAB:class:AbstractMember','Abstract function GetStatus needs to be implemented!'));
        end
    end
    
    methods (Static)
        function available = IsAvailable(obj)
          throw(MException('MATLAB:class:AbstractMember','Abstract function IsAvailable needs to be implemented!'));
        end
    end
end

