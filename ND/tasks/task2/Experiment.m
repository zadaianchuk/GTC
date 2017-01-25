classdef Experiment 
    properties
    E_m=0
    current_type='step'
    I_0=-5*10^(-11)
    fr=0.5
    t_start=0
    t_end=10^(-1)
    delta_t=10^(-4)
    end
    properties(Dependent)
    t
    end
    methods
        function t=get.t(obj)
           t=obj.t_start:obj.delta_t:obj.t_end;
        end
        function V = Voltage(obj,N)
            %initial condition
            V(1)=obj.E_m;
            %vector of signal input in dots t
            if strcmp(obj.current_type,'step')
                I_e_t=I_e_step(obj.I_0,obj.t);
            elseif strcmp(obj.current_type,'sin')
                I_e_t=I_e_sin(obj.I_0,obj.fr,obj.t);
            end
            %backward Euler method
            for n=1:(length(obj.t)-1)
                V(n+1)=(V(n)+(obj.delta_t/N.C_m)*(obj.E_m/N.R_m+I_e_t(n+1)))/(1+obj.delta_t/N.tau);                
            end       
        end
    end
end