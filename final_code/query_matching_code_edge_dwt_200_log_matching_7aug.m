% code to display relevant images using color,shape and dwt


clc;
clear all;%clf;
close all

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
  ref_i=i;  
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
        for jj=1:197
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
%         display(ii);
        ij=ij+1;
        ii=ii+1;
       end
       ij=1;
       fignum=fignum+1;
       xx=xx+1;
   end

   % for relevance logic for user input log based
   clc
   disp('Select the index for log relevance')
     if i1 ==1
        disp(IX(1:15))
    end        
for i11=1:5 % for 3 time log iteration loop for sorting images
    in2=input('Enter Relevant image from graph its index : ')
      i=imread([num2str(in2) '.jpg']);
        fignum=i11+1;
        figure(fignum)
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

    for ii=1:200
        E=0;
        for jj=1:197
            % Euclidean distance
                E = E + (querry_featu_100(jj,ii)-MASTER_DATA(jj,ii))^2;
        end
         final1(ii) = sqrt(E);
    end

    [B,IX] = sort(final1);
    if i11 ==1
       disp(IX(1:20))
       B1=B(1:20);
       IX1 = IX(1:20);
       l1=IX1;
       cnt_disp=20;
    elseif i11==2
       disp(IX(1:20))
       B1=B(1:20);
       IX1 = IX(1:20);        
       l2=IX1;
       cnt_disp=20;
    elseif i11==3
       disp(IX(1:20))
       B1=B(1:20);
       IX1 = IX(1:20);        
       l3=IX1;
       cnt_disp=20;
    elseif i11==4
       disp(IX(1:20))
       B1=B(1:20);
       IX1 = IX(1:20);        
       l4=IX1;
       cnt_disp=20;
    else
       disp(IX(1:20))
       B1=B(1:20);
       IX1 = IX(1:20);        
       l5=IX1;
       cnt_disp=20;
    end        
%         E=0;
%         for jj=1:197
%             % Euclidean distance
%                 E = E + (querry_featu_100(jj,in2)-MASTER_DATA(jj,in2))^2;
%         end
%          final1 = sqrt(E);      
         
%  ------------------------------------This code gives top  similar images 
temp=100.0;
ii=1;
ij=1;
count=0;
%   subplot(5,5,[1:5]);
%   imshow(i);title('QUERY IMAGE');

while(temp >=97.0 && ii<=cnt_disp)
%         temp=100-(B(ii);
          temp=100-(B1(ii)/10000);
%         temp=((100*(1.0e+004))-(B(ii)));
          ii = ii +1;
          count=count+1;
   end
   totalfignum = ceil(count/25);
   xx=1;
   ii=1;
   while(xx <= totalfignum)
       while(ij<=20 && ii<=count)
        name=strcat(int2str(IX1(ii)),'.jpg');
        figure(fignum),subplot(5,5,ij+5)
        imshow(name);
%       temp=100-(B(ii)-B(1));
       % temp=(100*(1.0e+004))-(B(ii)-B(1));
%          title(['Dist= ',num2str(B(ii)/10000),'  Ind= ',num2str(IX(ii))],'Color','B')
         title(['Ind= ',num2str(IX1(ii))],'Color','B');
%         display(ii);
        ij=ij+1;
        ii=ii+1;
       end
       ij=1;
       fignum=fignum+1;
       xx=xx+1;
   end
         
end

% final log based logic started
disp('8888888888888888888888888888888888888888888888888888888')

  % final log output
  t1_log=log(l1);
  t2_log=log(l2);
  t3_log=log(l3);
  t4_log=log(l4);
  t5_log=log(l5);
  
  t1_s=sort(t1_log);
  t2_s=sort(t2_log);
  t3_s=sort(t3_log);
  t4_s=sort(t4_log);
  t5_s=sort(t5_log);
  t1_s1=sort(l1);
  t2_s1=sort(l2);
  t3_s1=sort(l3);
  t4_s1=sort(l4);
  t5_s1=sort(l5);

  a=[t1_s;t2_s;t3_s;t4_s;t5_s];
  a1=[t1_s1;t2_s1;t3_s1;t4_s1;t5_s1];
%   a=[t1_s;t2_s;t3_s;t1_s;t2_s;t3_s];%;t1_s;t2_s;t3_s;t1_s;t2_s;t3_s];
  cnt=1;
  [m n]=size(a);
  len=m;
  flag_cnt=[];
for i=1:len-1
    for j=1:n
        if a(i,j)==a(i+1,j)
           flag_cnt(cnt)=a(i,j);
           flag_id(cnt)=a1(i,j);
           cnt=cnt+1
        end
    end
end

  final_cnt = sort(flag_cnt);
  flag_id = sort(flag_id);
  [m n]=size(final_cnt);
  cnt=1;
  f_id=[];
for i=1:n-1
    if final_cnt(i)~=final_cnt(i+1)       
        f_sort(cnt)=final_cnt(i);
        f_id(cnt)=flag_id(i);
        cnt=cnt+1;
    end
end
% f_sort
 f_id
 tm=sort(l1);
if length(f_id)<=20
    for i=1:length(f_id)
        if f_id(i)~=tm(i)
            f_id(cnt)=tm(i);
            cnt=cnt+1;
            if cnt>=20
                break
            end
        end
    end
end
        
f_id
% % final log output
%   t1_log=log(l1);
%   t2_log=log(l2);
%   t3_log=log(l3);
%   
%   t1_s=sort(t1_log);
%   t2_s=sort(t2_log);
%   t3_s=sort(t3_log);
%   
%   % log relevance result
%   cnt=1;
%   cnt1=1;
%   cnt2=1;
%   for i3=1:20
%       for i2=1:20     
%           if t1_s(i3)==t2_s(i2) 
%               f_list(cnt)=l1(i2);
%               cnt=cnt+1;              
%           end
%           if t1_s(i3)==t3_s(i2) 
%               f_list1(cnt1)=l3(i2);
%               cnt1=cnt1+1;              
%           end
%           if t3_s(i3)==t2_s(i2) 
%               f_list(cnt2)=l2(i2);
%               cnt2=cnt2+1;              
%           end
%       end
%   end
      
%  ------------------------------------This code gives top  similar images 
temp=100.0;
ii=1;
ij=1;
if length(f_id)<=20
    count=length(f_id);
else
    count=20;
end
figure(fignum)
subplot(5,5,[1:5]);
imshow(ref_i);title('QUERY IMAGE');

%   subplot(5,5,[1:5]);
%   imshow(i);title('QUERY IMAGE');
% final sorted result
IX1 = f_id;
   xx=1;
   ii=1;
   while(xx <= totalfignum)
       while(ij<=20 && ii<=count)
        name=strcat(int2str(IX1(ii)),'.jpg');
        figure(fignum),subplot(5,5,ij+5)
        imshow(name);
         title(['Ind= ',num2str(IX1(ii))],'Color','B');
%         display(ii);
        ij=ij+1;
        ii=ii+1;
       end
       ij=1;
       fignum=fignum+1;
       xx=xx+1;
   end
  