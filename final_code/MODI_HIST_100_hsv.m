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
% H_100_DATA(:,ii)=[(counts1)./(m*n) ;counts2./(m*n); counts3./(m*n)];
    
    H_100_DATA(:,ii)=[counts1 ;counts2; counts3];
end


 filename=input('Enter the name as HISTO_DATABASE_100(color): ','s');
 [fid,msg]=fopen(filename,'w');
    if fid>0
        count=fwrite(fid,H_100_DATA,'integer*4');
        disp([int2str(count),'values written...']);
        status=fclose(fid);
    else
        disp(msg);
    end
toc
