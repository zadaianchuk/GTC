classdef Experiment 
    properties
    E_m=0
    current_type='step'
    I_0=-5*10^(-11)
    t_e=0
    t_s=0.5
    fr=0.5
    t_start=0.3
    t_end=0.7
    delta_t=10^(-4)
    end
    properties(Dependent)
    t
    end
    methods
        function t=get.t(obj)
           t=obj.t_start:obj.delta_t:obj.t_end;
        end
        function [V_1,V_2] = Voltage2Comp(obj,Comp)
            %initial condition
            V_1(1)=obj.E_m;
            V_2(1)=obj.E_m;
            %vector of signal input in dots t
            if strcmp(obj.current_type,'step')
                I_e_t=I_e_step(obj.I_0,obj.t_e,obj.t)+I_e_step(-obj.I_0,obj.t_s,obj.t);
            elseif strcmp(obj.current_type,'sin')
                I_e_t=I_e_sin(obj.I_0,obj.fr,obj.t);
            end
            %backward Euler method
            for n=1:(length(obj.t)-1)
                V_1(n+1)=(obj.delta_t/Comp.C_m)*((obj.E_m-V_1(n))/Comp.R_m+(V_2(n)-V_1(n))/(Comp.R_a)+I_e_t(n))+V_1(n);
                V_2(n+1)=(obj.delta_t/Comp.C_m)*((obj.E_m-V_2(n))/Comp.R_m+(V_1(n)-V_2(n))/(Comp.R_a))+V_2(n);
            end       
        end
    end
end