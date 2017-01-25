formattype='epsc';
filename='images\exp';
%%  Ex 1
l=[180 100 100]*10^(-6);
d=[12 5 4]*10^(-6);
type=['l' 'k' 's' ];
for i=1:3
Comp(i)=Compartment;
Comp(i).l=l(i);
Comp(i).d=d(i);
Comp(i).type=type(i);
end
Comp(1).R_L=1/(1/Comp(2).R_in+1/Comp(3).R_in);
V_inf=Comp(1).R_in*10^(-9);


l=[180 100 100]*10^(-6);
d=[12 5 4]*10^(-6);
type=['l' 's' 's' ];
for i=1:3
Comp(i)=Compartment;
Comp(i).l=l(i);
Comp(i).d=d(i);
Comp(i).type=type(i);
end
%% Ex 2
l=[200 100 100]*10^(-6);
d=[16 4 2]*10^(-6);
type=['l' 's' 's' ];
for i=1:3
Comp(i)=Compartment;
Comp(i).l=l(i);
Comp(i).d=d(i);
Comp(i).type=type(i);
end

l=[260 140 100]*10^(-6);
d=[4.9207 4 100/49]*10^(-6);
type=['l' 's' 's' ];
for i=1:3
Comp2(i)=Compartment;
Comp2(i).l=l(i);
Comp2(i).d=d(i);
Comp2(i).type=type(i);
end

l=[210 150 100 120]*10^(-6);
d=[16 10.7797 4.791 6.8990]*10^(-6);
type=['l' 's' 's' 's'];
for i=1:4
Comp3(i)=Compartment;
Comp3(i).l=l(i);
Comp3(i).d=d(i);
Comp4(i).type=type(i);
end