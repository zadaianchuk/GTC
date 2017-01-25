%Ex_1

x=0:.1:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            v(i,j)=-x(i);
            u(i,j)=-y(j);
    end
end
figure
quiver(x,y,u,v)
title('1.3')

saveas(gcf,'1_3.png');

x=0:.1:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            v(i,j)=-x(i)+ (3/4)*(1/(1+y(j)));
            u(i,j)=-y(j)+(3/4)*(1/(1+x(i)));
    end
end
figure
quiver(x,y,u,v)
title('1.3_2')

saveas(gcf,'1_3_2.png');

x=-2:.1:2;
y=x;
z=zeros(1,length(x));
M=[1 -0.1 -0.1;-0.1 1 -0.1;-0.1 -0.1 -0.1];
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            vec=[x(i);y(j);0];
            vel=linstep(M*vec)-vec;
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)
title('1.3_2')

saveas(gcf,'1_3_2.png');


x=-2:.1:2;
z=x;
y=zeros(1,length(x));
M=[1 -0.1 -0.1;-0.1 1 -0.1;-0.1 -0.1 -0.1];
v=zeros(length(x),length(z));
u=zeros(length(x),length(z));
for i=1:length(x)
    for j=1:length(z)
            vec=[x(i);0;z(j)];
            vel=linstep(M*vec)-vec;
            v(i,j)=vel(1);
            u(i,j)=vel(3);
    end
end
figure
quiver(x,y,u,v)
title('2.x2=0')

saveas(gcf,'2_1_2.png');

y=-2:.1:2;
z=y;
x=zeros(1,length(y));
M=[1 -0.1 -0.1;-0.1 1 -0.1;-0.1 -0.1 -0.1];
v=zeros(length(y),length(z));
u=zeros(length(y),length(z));
for i=1:length(y)
    for j=1:length(z)
            vec=[0;y(i);z(j)];
            vel=linstep(M*vec)-vec;
            v(i,j)=vel(2);
            u(i,j)=vel(3);
    end
end
figure
quiver(x,y,u,v)
title('2.x1=0')

saveas(gcf,'2_1_3.png');