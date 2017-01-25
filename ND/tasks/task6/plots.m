A=[-1/2 -1/2 0;-1/2 -1/2 0;0 0 2 ];
[V,D]=eig(A);


%x_3 plane
x=-2:.2:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            vel=A*[x(i);y(j);0];
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)

title('x_3 plane')
saveas(gcf,'1_2_x_3.png');
%x_2 plane
x=-2:.2:2;
z=x;
v=zeros(length(x),length(z));
u=zeros(length(x),length(z));

for i=1:length(x)
    for j=1:length(z)
            vel=A*[x(i);0;z(j)];
            v(i,j)=vel(1);
            u(i,j)=vel(3);
    end
end
figure
quiver(x,z,u,v)
title('x_2 plane')
saveas(gcf,'1_2_x_2.png');
%x1 plane
y=-2:.2:2;
z=y;

v=zeros(length(y),length(z));
u=zeros(length(y),length(z));

for i=1:length(y)
    for j=1:length(z)
            vel=A*[0;y(i);z(j)];
            v(i,j)=vel(2);
            u(i,j)=vel(3);
    end
end
figure
quiver(x,y,u,v)

title('x_1 plane')
saveas(gcf,'1_2_x_1.png');
%Ex_2

x=-2:.2:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            vel=-[x(i);y(j)]-2*[0 1;1 0]*[max(0,x(i));max(0,y(j))]+[1;1];
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)
title('2.2')

saveas(gcf,'2_2.png');

x=-2:.2:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            vel=-[x(i);y(j)]-2*[0 1;1 0]*[max(0,x(i));max(0,y(j))]+[1.2;1];
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)
title('2.5.1')
saveas(gcf,'2_5_1.png');

x=-2:.2:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            vel=-[x(i);y(j)]-2*[0 1;1 0]*[max(0,x(i));max(0,y(j))]+[1;1.2];
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)
title('2.5.2')

saveas(gcf,'2_5_2.png');


x=-2:.2:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            vel=-[x(i);y(j)]+2*[0 1;1 0]*[max(0,x(i));max(0,y(j))]+[1;1];
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)
title('2.6')

saveas(gcf,'2_6.png');

x=-2:.2:2;
y=x;
v=zeros(length(x),length(y));
u=zeros(length(x),length(y));
for i=1:length(x)
    for j=1:length(y)
            
            vel=-[x(i);y(j)]+2*[0 1;1 0]*[step(x(i));step(y(j))]+[1;1];
            v(i,j)=vel(1);
            u(i,j)=vel(2);
    end
end
figure
quiver(x,y,u,v)
title('2.7')

saveas(gcf,'2_7.png');
