clc;
clear;
h = figure;
axis tight manual % this ensures that getframe() returns a consistent size
filename = 'Tugas2_No1.gif';
%Terdapat 2 muatan q1 pada posisi r1 dan q2 pada posisi r2
% %Masukkan nilai masing-masing variable
Lx=2;Ly=2;%ukuran gambar
xf(1)=-1;yf(1)=-1;
xf(2)=0;yf(2)=1;
xf(3)=1;yf(3)=-1;
xu=0.3;yu=0;%posisi muatan uji
mu=1;vxu=1;vyu=1;
t=0;dt=0.05;T=30;
q(1)=1;q(2)=2;q(3)=1;%muatan fix
qu=1;%nilai muatan uji
k=3*10^-1;%konstanta coulomb
grid=0.1;
[x,y] = meshgrid(-Lx:grid:Lx,-Ly:grid:Ly);
Nx=2*Lx/grid;
%F di setiap titik di ruang (dari muatan fix)
Fxsp=0;Fysp=0;
for i=1:3
    Fxsp = Fxsp+q(i)*(x-xf(i))./(( (x-xf(i)).^2+(y-yf(i) ).^2).^(1.5));
    Fysp = Fysp+q(i)*(y-yf(i))./(( (x-xf(i)).^2+(y-yf(i) ).^2).^(1.5));
    %membuang data yang tak hingga
%     if(x==xf(i))
%     Fxsp(
%     end
end
Fsp=sqrt(Fxsp.^2+Fysp.^2);
while(t<T)    
%F pada muatan uji (muatan q1,q2,q3 fix)
Fxu=0;Fyu=0;
for i=1:3
    Fxu = Fxu+k*q(i)*qu*(xu-xf(i))/((xu-xf(i))^2+(yu-yf(i))^2)^(1.5);
    Fyu = Fyu+k*q(i)*qu*(yu-yf(i))/((xu-xf(i))^2+(yu-yf(i))^2)^(1.5);
end
%Perhitungan kinematika muatan (dengan metode trapesium)
    vxu=vxu+Fxu*dt/mu;
    vyu=vyu+Fyu*dt/mu;
    xu=xu+vxu*dt;
    yu=yu+vyu*dt;
%Pemantulan ketika mengenai dinding    
    if(xu<=-Lx)
        xu=-Lx;
        vxu=-vxu;
    end
    if(xu>=Lx)
        xu=Lx;
        vxu=-vxu;
    end
    if(yu<=-Ly)
        yu=-Ly;
        vyu=-vyu;
    end
    if(yu>=Ly)
        yu=Ly;
        vyu=-vyu;
    end
%plot posisi muatan uji   
plot(xu,yu,'O');
hold on;
%plot posisi muatan fix 
for i=1:3
    plot(xf(i),yf(i),'square');
    hold on;
end
%menggambar vektor di ruang yang panjangnya ternormalisasi
%     colorvfield(x,y,Fxsp,Fysp,16);
%     quiver(x,y,Fxsp./Fsp,Fysp./Fsp);
     quiver(x,y,Fxsp*0.007,Fysp*0.007,'autoscale','off');
    % colormap hsv;
    % q.AutoScale = 'off';
    xlim([-Lx Lx]);
    ylim([-Ly Ly]);
    drawnow;
    hold off;
% Capture the plot as an image 
%       frame = getframe(h); 
%       im = frame2im(frame); 
%       [imind,cm] = rgb2ind(im,256); 
% % Write to the GIF File
% if t == 0 
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
%       else 
%           imwrite(imind,cm,filename,'gif','WriteMode','append'); 
%       end 
    t=t+dt;     
end