clc;
clear all;
close all
tic
disp( 'single Color Feature Extraction code');
pp=input('Enter the no of database images :');
for ii=1:pp

    filename=strcat(int2str(ii),'.jpg'); 
    i=imread(filename);

    % RGB to HSV conversion
    i=rgb2hsv(i);
    [m,n]=size(i(:,:,1));
    [counts1,x1]=imhist(i(:,:,1),64); 
    [counts2,x2]=imhist(i(:,:,2),64); 
    [counts3,x3]=imhist(i(:,:,3),64); 
    
    H_100_DATA(:,ii)=[counts1 ;counts2; counts3];
    
end

% store feature 
save color_feature H_100_DATA 
toc
