function x=linstep(x)
for i=1:length(x)
    if x(i)<0 
        x(i)=0;
    end
end
