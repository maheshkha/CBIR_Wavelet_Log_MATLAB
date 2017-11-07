% code to display relevant images using color


clc;
clear all;%clf;

disp('Single testing color code');

% reading feature files
filename=input('Enter the name HISTO_DATABASE_100(color) : ','s');

[fid,msg]=fopen(filename,'r');
if fid>0
    [in_array1,count]=fread(fid,Inf,'integer*4');
    status=fclose(fid);
else
    disp(msg);
end

yyy=0;

    for ii=1:100
        for jj=1:192
            MASTER_DATA(jj,ii)=in_array1((jj+yyy),1);
        end
        yyy=yyy+192;
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
    
    querry_feature=[counts1 ;counts2; counts3];

 %This routine convert the querry_feature into 192x100 size
 %for easy & fast subtraction from MASTER_DATA array
    for jj=1:100 %  100  database image
        for ii=1:192 %192=64 for red+64 for green+64 for blue
             querry_featu_100(ii,jj)=(querry_feature(ii,1));
        end
    end
  
%This code subtact the querry_featu_100 from MASTER_DATA
 %   SUB_RESULT =((abs(querry_featu_100 -   MASTER_DATA)/(1+querry_featu_100 + MASTER_DATA)));
    for ii=1:100
        G=0;
        E=0;
        E1=0;
        for jj=1:192
            %canberra distance
                G= G + (abs(querry_featu_100(jj,ii) - MASTER_DATA(jj,ii)))/((1+querry_featu_100(jj,ii) + MASTER_DATA(jj,ii)));
            % Euclidean distance
                E = E + (querry_featu_100(jj,ii)-MASTER_DATA(jj,ii))^2;
             % city block
                E1 = E1 + abs(querry_featu_100(jj,ii)-MASTER_DATA(jj,ii));
        end
                 
         final(ii) = G;
         final1(ii) = sqrt(E);
        % dist(ii) = uint8(final1(ii));
         final2(ii) = sqrt((E1));
   end
        [B,IX] = sort(final1);
         %[B,IX] = sort(dist);
        display(IX);
        display(B);
        
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
        title(['Dist= ',num2str(B(ii)/10000),'  Ind= ',num2str(IX(ii))],'Color','B')
        display(ii);
        ij=ij+1;
        ii=ii+1;
       end
       ij=1;
       fignum=fignum+1;
       xx=xx+1;
   end
%    temp=100.0;
%    ii=1;
% %    t=0.0;
%    while(temp>=90.0 && ii<=42)
%          name=strcat(int2str(IX(ii)),'.jpg');
%          subplot(7,7,ii+7);  
%          imshow(name);
%          %t=B(ii)/100;
%          temp=(100*(1.0e+004))-(B(ii)-B(1)); 
%          title(['Dt= ',num2str(B(ii)/100000),' Id= ',num2str(IX(ii))],'Color','B')
%          ii=ii+1;
%          display(ii);
%    end        