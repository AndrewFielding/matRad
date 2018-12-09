classdef matRad_MeanDose < DoseObjectives.matRad_DoseObjective
    %MATRAD_MEANDOSE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Constant)
        name = 'Mean Dose';
        parameterNames = {'d^{ref}'};
        parameterTypes = {'dose'};
        %parameterNames = {};
        %parameterIsDose = [];
    end
    
    properties
        parameters = {0};        
        penalty = 1;
    end
    
    methods 
        function obj = matRad_MeanDose(penalty,dMeanRef)
           
            if nargin == 2 && isscalar(dMeanRef)
                obj.parameters{1} = dMeanRef;
            end
            
            if nargin >= 1 && isscalar(penalty)
                obj.penalty = penalty;
            end
        end       
        
        %% Calculates the Objective Function value
        function fDose = computeDoseObjectiveFunction(obj,dose)
            %fDose = obj.penalty * abs(mean(dose(:)) - obj.parameters{1});
            fDose = obj.penalty * (mean(dose(:)) - obj.parameters{1})^2;
        end
        
        %% Calculates the Objective Function gradient
        function fDoseGrad   = computeDoseObjectiveGradient(obj,dose)
            %fDoseGrad = (obj.penalty/numel(dose))*sign(dose(:)-obj.parameters{1});
            fDoseGrad = obj.penalty*2*(mean(dose(:))-obj.parameters{1}) * ones(size(dose(:)))/numel(dose);
        end
    end
    
end
