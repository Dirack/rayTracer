function ans = x_tr(z,z0,x0,theta)

% theta=315;
% z=20;
% z0=40;
% x0=40;
% 
% z=[40:-1:20]
ans = tan(theta*(pi/180))*(z-z0) + x0;
end

% plot(X,z)
% 
% 
% xlabel('x','FontSize',24)
% ylabel('z','FontSize',24)
