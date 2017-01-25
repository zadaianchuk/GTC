classdef Compartment
   properties
      l=10^(-4)
      d=2*10^(-6)
      r_m_sp=1
      r_a_sp=1
      c_m_sp=10^(-2)
      type
      R_L
   end
   properties(Hidden)
      R_m_explicit=0
      R_a_explicit=0
      C_m_explicit=0
   end
   %Some useful properties we can compute from basic one (as in second pars of task 2)
   properties(Dependent)
      R_m
      R_a
      C_m
      tau
      R_inf
      lambda
      L
      R_in
   end
   methods   
      function R_m=get.R_m(obj)
           if obj.R_m_explicit==0
            R_m=obj.r_m_sp/(pi*obj.d*obj.l);
           else
            R_m=obj.R_m_explicit;
           end
      end
      
      function R_a=get.R_a(obj)       
        if obj.R_a_explicit==0
            R_a=4*obj.r_a_sp*obj.l/(pi*obj.d*obj.d);
        else 
            R_a=obj.R_a_explicit;
        end
      end
      function C_m=get.C_m(obj)   
           if obj.C_m_explicit==0
               C_m=obj.c_m_sp*(pi*obj.d*obj.l);
           else
               C_m=obj.C_m_explicit;
           end
      end
      function tau=get.tau(obj)
          tau=obj.C_m*obj.R_m;
      end 
      function lambda=get.lambda(obj)
           lambda=sqrt(obj.R_m/obj.R_a)*obj.l;
      end
      function R_inf=get.R_inf(obj)
           R_inf=sqrt(obj.R_m*obj.R_a);
      end
      function L=get.L(obj)
           L=obj.l/obj.lambda;
      end
      function R_in=get.R_in(obj)
          switch obj.type
              case 's'
                 R_in=obj.R_inf*coth(obj.L);
              case 'k'
                 R_in=obj.R_inf*tanh(obj.L);
              case 'l'
                 R_in=obj.R_inf*(((obj.R_L/obj.R_inf)*cosh(obj.L)+sinh(obj.L))/((obj.R_L/obj.R_inf)*sinh(obj.L)+cosh(obj.L)));
          end
      end
      
      function obj = set.R_m(obj,val)
      obj.R_m_explicit = val;
      end
      function obj = set.C_m(obj,val)
      obj.C_m_explicit = val;
      end
      function obj = set.R_a(obj,val)
      obj.R_a_explicit = val;
      end
   end
end