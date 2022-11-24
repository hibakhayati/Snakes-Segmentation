%% LAB2: Snakes Segmentation by Hiba khayati
%% Cleaning the window
clc;
clear all;
close all;
%% Reading the image
image=imread('D:\irm_1.jpg');
firstPlane = im2double(image(:,:,1));
imshow(firstPlane), figure;
%% Initialization of the weighting parameters
alpha = 0.1; % elasticity : the ability of an object or material to resume its normal shape after being stretched or compressed
beta = 0.5; % rigidity : the inability to be to bent or be forced out of shape.
gamma = 10; % viscosity : Viscosity is a measure of a fluid's resistance to flow.
kappa = 2; % external force weighting parameter :  pressure forces and the potential forces 
kappap = 0.2; % balloon force weighting parameter : is a force to balance the equation to add flexibility to snake model
Niter = 20; % resampling frequency parameter 
ITER = 30; % total number of iterations (to optimize) 
dmax = 2; % max and min distances for contour resampling 
dmin = 0.5;
delta = 0.3; % sampling step
%% Gaussian filtering
gaussFilter = fspecial('gaussian',3,0.3);
gaussFiltered = imfilter(firstPlane, gaussFilter);
subplot(1,2,1), imshow(firstPlane);
subplot(1,2,2), imshow(gaussFiltered), figure;
%% Gradient forces
[px, py] = gradient(gaussFiltered);
normegrad = (sqrt(px.^2+py.^2));
quiver(px(1:3:end,1:3:end), py(1:3:end,1:3:end));
quiver(px, py), figure;
%% Snake deformation
subplot(1,2,1), imshow(image);
subplot(1,2,2), imshow(gradient(gaussFiltered)), figure;
delta = 1;
[x,y] = snakeinit(delta);
alpha = 4; 
beta = 4;  
gamma = 20; 
kappa = 0.2;
kappap=2.5; 
ITER=20;    
Niter = 35; 
dmin=1;   
dmax=4;
compteur = 0;
x = [x, x(1)];
y = [y, y(1)];
x = x'
y = y'
for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa,kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end
