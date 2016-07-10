alpha = 0.86; % thermal diffusivity of aluminium cm^2/sec
l = 10;
dx = 0.2;
dt = 0.01;

%r = alpha*dt/dx^2
r = (alpha*dt)/(dx^2);
disp(r); %only stable if r<= 0.5
% Explicit difference scheme
% u = [0,0.75,1,0.75,0]; 

% initial conditions
u = [0];
cols = (l/dx);
for i=1:cols
    fdx = i*dx;
    if i==cols
       u = [u,0];
    else
        u = [u, fdx*(l-fdx)];
    end
end

temp = [];
for i=0:cols
    temp = [temp,0];
end

% other time steps
n = 0;
while n < 2000

    for i=1:cols
        prevj = i-1;
        forwj = i+1;
        if prevj==0
            prevj = 0;
        else
            prevj = u(end,i-1);
        end
        j = 0.68*u(end,i)+0.16*(prevj+u(end,i+1));
        temp(end,i) = j;
    end

    u = [u;temp];
    if size(temp,1)>1
        temp(end,:) = [];
    end
    n = n+1;
end

colormap('jet');
imagesc(u);
colorbar;