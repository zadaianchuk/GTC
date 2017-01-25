classdef Neuron
   properties
      L=10^(-4)
      d=2*10^(-6)
      r_m_sp=1
      r_a_sp=1
      c_m_sp=10^(-2)
   end
   %Some useful properties we can compute from basic one (as in second pars of task 2)
   properties(Dependent)
      R_m
      R_a
      C_m
      tau
   end
   methods   
      function R_m=get.R_m(obj)
           R_m=obj.r_m_sp/(pi*obj.d*obj.L);
      end
      function R_a=get.R_a(obj)
           R_a=4*obj.r_a_sp*obj.L/(pi*obj.d*obj.d);
      end
      function C_m=get.C_m(obj)
           C_m=obj.c_m_sp*(pi*obj.d*obj.L);
      end
      function tau=get.tau(obj)
          tau=obj.C_m*obj.R_m;
      end      
   end
end