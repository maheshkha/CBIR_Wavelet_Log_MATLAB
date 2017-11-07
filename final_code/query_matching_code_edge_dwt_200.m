% code to display relevant images using color,shape and dwt


clc;
clear all;%clf;

disp('Image Retrieval');


% load color_feature;
load color_feature_svm;
    for ii=1:200
        for jj=1:197
            MASTER_DATA(jj,ii)=H_100_DATA(jj,ii);
        end
    end

% This routine gives feature for Querry image.

  filename=input('Enter the Query Image name : ','s');
  i=imread(filename);
  subplot(5,5,[1:5]);
  imshow(i);title('QUERY IMAGE');
  [m,n]=size(i(:,:,1));
  
 % RGB to HSV conversion
  i=rgb2hsv(i);
    [counts1,x1]=imhist(i(:,:,1),64); 
    [counts2,x2]=imhist(i(:,:,2),64); 
    [counts3,x3]=imhist(i(:,:,3),64); 

%     querry_feature=[(counts1)./(m*n) ;counts2./(m*n); counts3./(m*n)];
 i1=rgb2gray(i);
    iedge = edge(i1,'canny');
    [ca cd ch cv] = dwt2(i1,'haar');
    fet_edge = sum(sum(iedge));
    fet_ca = sum(sum(ca));
    fet_cd = sum(sum(cd));
    fet_cv = sum(sum(cv));
    fet_ch = sum(sum(ch));
    
    
    querry_feature=[counts1 ;counts2; counts3;fet_edge;fet_ca;fet_cd;fet_cv;fet_ch];
    
%     querry_feature=[counts1 ;counts2; counts3];

 %This routine convert the querry_feature into 192x100 size
 %for easy & fast subtraction from MASTER_DATA array
    for jj=1:200 %  100  database image
        for ii=1:197 %192=64 for red+64 for green+64 for blue
             querry_featu_100(ii,jj)=(querry_feature(ii,1));
        end
    end
  
%This code subtact the querry_featu_100 from MASTER_DATA
 %   SUB_RESULT =((abs(querry_featu_100 -   MASTER_DATA)/(1+querry_featu_100 + MASTER_DATA)));
    for ii=1:200
        E=0;
        for jj=1:192
            % Euclidean distance
                E = E + (querry_featu_100(jj,ii)-MASTER_DATA(jj,ii))^2;
        end
         final1(ii) = sqrt(E);
    end

    [B,IX] = sort(final1);
        display(IX);
        display(B);
    for ii=1:200
        % Classify the test set using svmclassify
        classes(ii) = svmclassify(svmStruct,querry_featu_100(:,ii)');
    end
%     [B,IX] = sort(classes);
%         display(IX);
%         display(B);
        
%  ------------------------------------This code gives top  similar images 
   temp=100.0;
   ii=1;
   ij=1;
   fignum=1;
   count=0;
   while(temp >=97.0 && ii<=20)
%         temp=100-(B(ii);
          temp=100-(B(ii)/10000);
%         temp=((100*(1.0e+004))-(B(ii)));
          ii = ii +1;
          count=count+1;
   end
   totalfignum = ceil(count/25);
   xx=1;
   ii=1;
   while(xx <= totalfignum)
       while(ij<=20 && ii<=count)
        name=strcat(int2str(IX(ii)),'.jpg');
        figure(fignum),subplot(5,5,ij+5)
        imshow(name);
%       temp=100-(B(ii)-B(1));
       % temp=(100*(1.0e+004))-(B(ii)-B(1));
%          title(['Dist= ',num2str(B(ii)/10000),'  Ind= ',num2str(IX(ii))],'Color','B')
         title(['Ind= ',num2str(IX(ii))],'Color','B')
        display(ii);
        ij=ij+1;
        ii=ii+1;
       end
       ij=1;
       fignum=fignum+1;
       xx=xx+1;
   end
