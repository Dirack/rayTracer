function ans = z_tr(x,x0,z0,theta)
% 
% theta=10;
% x=250;
% x0=50;
% z0=250;
% 
% x=[40:-1:20]
ans = cot(theta*(pi/180))*(x-x0) + z0;
end
% 
% plot(x,Z)
% 
% xlabel('x','FontSize',24)
% ylabel('z','FontSize',24)