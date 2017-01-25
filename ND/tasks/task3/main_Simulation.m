formattype='epsc';
filename='report\images\exp';
%% Ex 3.2
Comp=Compartment;
Comp.R_m=265*10^(6);
Comp.R_a=7*10^(6);
Comp.C_m=75*10^(-12);

Exp1=Experiment;
Exp1.E_m=0;
Exp1.I_0=-100*10^(-12);
Exp1.t_e=0.4;
Exp1.t_s=0.44;
[V_1,V_2]=Exp1.Voltage2Comp(Comp);

figure
plot(Exp1.t*1000,V_1*10^(3),Exp1.t*1000,V_2*10^(3));
xlabel('time, ms','FontSize',12)
ylabel('Voltage, mV','FontSize',12)
legend('V_1(t)','V_2(t)')
h = gcf;
saveas(h,[filename '1_1'],formattype)

Comp.R_a=265*10^(6);

[V_1,V_2]=Exp1.Voltage2Comp(Comp);

figure
plot(Exp1.t*1000,V_1*10^(3),Exp1.t*1000,V_2*10^(3));
xlabel('time, ms','FontSize',12)
ylabel('Voltage, mV','FontSize',12)
legend('V_1(t)','V_2(t)')
h = gcf;
saveas(h,[filename '1_2'],formattype)

Comp.R_a=30*10^(9);

[V_1,V_2]=Exp1.Voltage2Comp(Comp);

figure
fig=plot(Exp1.t*1000,V_1*10^(3),Exp1.t*1000,V_2*10^(3));

xlabel('time, ms','FontSize',12)
ylabel('Voltage, mV','FontSize',12)
legend('V_1(t)','V_2(t)')
h = gcf;
saveas(h,[filename '1_3'],formattype)



%%  3.3
Comp.R_a=300*10^(6);
Exp3=Experiment;
%changing of defualt type of current 
Exp3.current_type='sin';
Exp3.I_0=10^(-10);
Exp3.t_end=3;
fr=[1 2 5 10 20 50 100 200 500 1000 2000 3000 5000];
for i=1:length(fr) 
Exp3.fr=fr(i);

if Exp3.fr>2000 
    Exp3.delta_t=10^(-5);
end
[V_1,V_2]=Exp3.Voltage2Comp(Comp);

% look for amplitude in converged state
ampl_1(i)=max(V_1(20000:end));
ampl_2(i)=max(V_2(20000:end));
end


%Bode diagram
figure
h=plot(log(fr),log(ampl_1*10^(3)),log(fr),log(ampl_2*10^(3)));
xlabel('log frequency, log(Hz)','FontSize',12)
ylabel('log Amplitude, log(mV)','FontSize',12)
saveas(h,[filename '2_V_1_new'],formattype)
% figure
% h=scatter();
% xlabel('log frequency, log(Hz)','FontSize',12)
% ylabel('log Amplitude, log(mV)','FontSize',12)
% saveas(h,[filename '2_V_2'],formattype)





