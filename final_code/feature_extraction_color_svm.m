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
    if mod(ii,2)==0
        Target_vector(ii)=1;
    else
        Target_vector(ii)=0;
    end
        
end

        data =[H_100_DATA'];
        groups = [Target_vector'];

        % Use a linear support vector machine classifier
        svmStruct = svmtrain(data,groups);  

        % Classify the test set using svmclassify
        classes = svmclassify(svmStruct,data);
%         disp('Classify output')
%         disp(classes)
        err = classes - groups;
         disp('Error with i/p target values')       
         disp(sum(err))

% store feature 
save color_feature_svm svmStruct H_100_DATA
toc
