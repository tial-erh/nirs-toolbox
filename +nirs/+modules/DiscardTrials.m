classdef DiscardTrials < nirs.modules.AbstractModule
%% DiscardStims - Removes specified stim conditions from design.
% Written by TIAL and of course it doesn't work 
% 
% Options: 
%     listOfStims - array of trials to be removed

    properties
        listOfTrials = []; % cell array of stim names
        CondNum = []; % Condition index (should be improved to label) 
    end
    
    methods
        function obj = DiscardStims( prevJob )
         	if nargin > 0, obj.prevJob = prevJob; end
            obj.name = 'Discard Trial Number';
        end
        
        function data = runThis( obj, data )
            
            for i = 1:numel(data)
                
                conds = data(i).stimulus.keys;
                stim = data(i).stimulus(conds{obj.CondNum});

                stim.onset(obj.listOfTrials) = []; 
                stim.dur(obj.listOfTrials) = [];  
                stim.amp(obj.listOfTrials) = []; 

                data(i).stimulus(conds{obj.CondNum}) = stim;
                
            end
        
        end
    end
    
end

