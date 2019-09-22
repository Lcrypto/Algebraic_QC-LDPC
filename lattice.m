%Copyright(c) 2012, USAtyuk Vasiliy 
%All rights reserved.
%
%Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are met :
%*Redistributions of source code must retain the above copyright
%notice, this list of conditions and the following disclaimer.
%* Redistributions in binary form must reproduce the above copyright
%notice, this list of conditions and the following disclaimer in the
%documentation and / or other materials provided with the distribution.
%* Neither the name of the <organization> nor the
%names of its contributors may be used to endorse or promote products
%derived from this software without specific prior written permission.
%
%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
%ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%DISCLAIMED.IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
%DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
%ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% Application generate QC-LDPC parity-check matrix QRCx(Q*R)^2 size, (QR)^2 code lenght 
% and rate 1-C/QR, girth 6 from  3-D semi ideal lattice based on the projecting of parallel lines (defined by it slopes)
%column weight C, row weight equal QR
%to Z axis (if C=2,R=3, Q=5) we get matrix 2 - columns, 5 -rows and 3-layer , 2x5x3
% in future shall improve to girth 10 codes  QRCxQ*R^2 size, Q*R^2 code
% lenght (for Q>8(R-1))
% 
%   ^z(Q)  ^y(R)
%   |     /                     
%   |    /                5 10 | 15 20 | 25 30
%   |   /                 4 9  | 14 19 | 24 29
%   |  /                  3 8  | 13 18 | 23 28
%   | /                   2 7  | 12 17 | 22 27
%   |/                    1 6  | 11 16 | 21 26
%   --------> x(C)  

clear all;

%0.971, 12x423, extender 47, 19881
%C=uint32(4); % number of elements of the x-axis
%R=uint32(3); % number of elements of the y-axis prime
%Q=uint32(47); % number of elements of the z-axis prime

%0.96, 15x405, extender 45, 18225
%C=uint32(5); % number of elements of the x-axis
%R=uint32(3); % number of elements of the y-axis prime
%Q=uint32(45); % number of elements of the z-axis prime

%0.96, 15x405, extender 45, 18225
%C=uint32(5); % number of elements of the x-axis
%R=uint32(5); % number of elements of the y-axis prime
%Q=uint32(43); % number of elements of the z-axis prime


%C=uint32(4); % number of elements of the x-axis
%R=uint32(7); % number of elements of the y-axis prime
%Q=uint32(21); % number of elements of the z-axis prime

%type 2
% 0.87, 69x529, extender 137, lenght 72473                         
%C=uint32(3); % number of elements of the x-axis
%R=uint32(23); % number of elements of the y-axis prime
%Q=uint32(137); % number of elements of the z-axis prime

% 0.82, 51x289, extender 97, lenght 28033
%C=uint32(3); % number of elements of the x-axis
%R=uint32(17); % number of elements of the y-axis prime
%Q=uint32(97); % number of elements of the z-axis prime

% 0.82, 51x289, extender 97, lenght 28033
C=uint32(13); % number of elements of the x-axis
R=uint32(7); % number of elements of the y-axis prime
Q=uint32(13); % number of elements of the z-axis prime

% 0.842, 57x361, extender 109, lenght 39349
%C=uint32(4); % number of elements of the x-axis
%R=uint32(19); % number of elements of the y-axis prime
%Q=uint32(109); % number of elements of the z-axis prime


%type 1
% 0.84, 15x99, extender 11, lenght 1089
%C=uint32(5); % number of elements of the x-axis
%R=uint32(3); % number of elements of the y-axis prime
%Q=uint32(11); % number of elements of the z-axis prime
%0.901, 15x153, extender 17, lenght 2601


%
%C=uint32(3); % number of elements of the x-axis
%R=uint32(23); % number of elements of the y-axis prime
%Q=uint32(71); % number of elements of the z-axis prime

% 0.87, 69x529, extender 57, lenght 30153
%C=uint32(3); % number of elements of the x-axis
%R=uint32(23); % number of elements of the y-axis prime
%Q=uint32(57); % number of elements of the z-axis prime

% 20339, 0.9302, 129x 1849, 11
%C=uint32(3); % number of elements of the x-axis
%R=uint32(43); % number of elements of the y-axis prime
%Q=uint32(11); % number of elements of the z-axis prime

% 0.93, 22743, 7 , 228,3249
%C=uint32(4); % number of elements of the x-axis
%R=uint32(57); % number of elements of the y-axis prime
%Q=uint32(7); % number of elements of the z-axis prime

%0.97, 19881, 47, 12x423
%C=uint32(4); % number of elements of the x-axis
%R=uint32(3); % number of elements of the y-axis prime
%Q=uint32(47); % number of elements of the z-axis prime



%0.93, 19881, 47, 12x423
%C=uint32(4); % number of elements of the x-axis
%R=uint32(3); % number of elements of the y-axis prime
%Q=uint32(47); % number of elements of the z-axis prime

%0.87, 96100, 100, 124x961
%C=uint32(4); % number of elements of the x-axis
%R=uint32(31); % number of elements of the y-axis prime
%Q=uint32(100); % number of elements of the z-axis prime

%0.77, 32379, 191, 39x169
%C=uint32(3); % number of elements of the x-axis
%R=uint32(13); % number of elements of the y-axis prime
%Q=uint32(191); % number of elements of the z-axis prime

% 0.87, 29791, 31 , 124x961
%C=uint32(4); % number of elements of the x-axis
%R=uint32(31); % number of elements of the y-axis prime
%Q=uint32(31); % number of elements of the z-axis prime

% 0.875, 32256, 56, x576
%C=uint32(3); % number of elements of the x-axis
%R=uint32(24); % number of elements of the y-axis prime
%Q=uint32(56); % number of elements of the z-axis prime


% 0.82, 51x289, extender 97, lenght 28033
%C=uint32(3); % number of elements of the x-axis
%R=uint32(17); % number of elements of the y-axis prime
%Q=uint32(97); % number of elements of the z-axis prime



% 0.977, 31329, 59, 12x531
%C=uint32(4); % number of elements of the x-axis
%R=uint32(3); % number of elements of the y-axis prime
%Q=uint32(59); % number of elements of the z-axis prime


%C=uint32(3); % number of elements of the x-axis
%R=uint32(57); % number of elements of the y-axis prime
%Q=uint32(5); % number of elements of the z-axis prime
%C=uint32(5); % number of elements of the x-axis
%R=uint32(57); % number of elements of the y-axis prime
%Q=uint32(5); % number of elements of the z-axis prime

% 1 is girth 6 codes Rate 1-C/QR, lenght (QR)^2
% 2 is girth 8 and 10 codes  1-C/R, lenght Q*(R)^2
% 3 is girth 6 with some addition properties (in debug)

Type_of_LDPC=1; % what type of LDPC code shall generate
Lattice(Q,C,R)=uint32(0);%Lattice(5,2,3)=0;
m=1; 
%create semi ideal Lattice, don't forget that start point upper left corner
% it because array writing in reverse order 
for k = 1:R
for j = 1:C
for i = 1:Q
  Lattice(i,j,k)=m;  % place semi ideal lattice element in 3d grid
  m=m+1;
end
end
end

if Type_of_LDPC==1 

% Line on the top face which generate class of the parallel lines from
% planes projected by z-axis
% R classes of slopes with R lines in each class and C dots in every lines
Top_faces_lines(R, C, R )=uint32(0);
for slopes = 1:R
for y = 1:R  % lines in top face with defined slopes
for x = 1:C 
    Top_faces_lines(y,x,slopes)=Lattice(Q,x,mod(y+(slopes)*x,R)+1);
    
end
end  
end

% generate  projecting of this line by consider slopes in z axis
% we shall generate (Q*R)^2 lines which content C points 
% R class of R lines which content Q planes with Q lines in each
Z_project_lines(R, C, R, Q,Q)=uint32(0);
%    first R is defined numbers of line in  class of line with slopes in top
%    face and  in Z-axis
%    second lattice node which contain (include) in this line
%    third define class on lines (defined by slopes in top face(RC) )
%    fourth define class of slopes in Z-axis (QC)
%    five (index) number of lines in Z-axis slope class

%for slope_QC= 1:Q

%for y = 1:R  
%for x = 1:C
%for z = 1:Q 
 for slope_top_face= 1:R
for slope_QC= 1:Q 
for y = 1:R 
for z = 1:Q  
for x = 1:C
    
%for slope_top_face= 1:R
%for y = 1:R  
%for x = 1:C
%for z = 1:Q 
%for slope_QC= 1:Q
   Z_project_lines(y, x, slope_top_face, slope_QC,z)=Lattice(mod(z+slope_QC*x,Q)+1,x,mod(y+slope_top_face*x,R)+1);
end
end
end
end  
end

% Generate parity-check matrix from line elements
PC_LDPC(Q*R*C,Q*Q*R*R)=int32(0);

current_line=1;
%check one of the circulant matrix

%slope_top_face= 1;
%y = 1 ;
%slope_QC= 1;
%x = 1;

for slope_top_face= 1:R
for slope_QC= 1:Q 
for y = 1:R 
for z = 1:Q  
for x = 1:C
   PC_LDPC(Z_project_lines(y, x, slope_top_face, slope_QC,z),current_line) =1;
   %
end
    current_line=current_line+1;
end
end
end
end
%generate quasi-cyclic matrix from parity-check matrix 
PC_QC_LDPC(R*C,Q*R*R)=int32(-1);
Circulant(Q,Q)=int32(-1);
%coordinate of left angle of considered circulant matrix

for y =1:R*C
for x =1:Q*R*R
    for current_y=1:Q
    for current_x=1:Q
    Circulant(current_y,current_x)=PC_LDPC((y-1)*Q+current_y,(x-1)*Q+current_x);
    end
    end
    
    A=find(Circulant(1,:),1);
    if isempty(A)
        PC_QC_LDPC(y,x)=-1;
    else
    PC_QC_LDPC(y,x)=A;
    end
end
end
spy(PC_LDPC);


end



if Type_of_LDPC==2 
%girth 8 codes generate 
if C==3 && Q>6*(R-1)
    %
    
    Z_project_lines_parallel_g6(R, C, R, Q)=uint32(0);

 for slope_top_face= 1:R
for y = 1:R 
slope_QC= (y+R)*(y+C)+(slope_top_face +R)*(slope_top_face+C);
for z = 1:Q  
for x = 1:C

   Z_project_lines_parallel_g6(y, x, slope_top_face, z)=Lattice(mod(z+slope_QC*x,Q)+1,x,mod(y+slope_top_face*x,R)+1);
end
end
end
end  

    
    
PC_LDPC_g8(Q*R*C,Q*R*R)=int8(0);

current_line=1;


for slope_top_face= 1:R
for y = 1:R 
for z = 1:Q  
for x = 1:C
   PC_LDPC_g8(Z_project_lines_parallel_g6(y, x, slope_top_face,z),current_line) =1;
   %
end
    current_line=current_line+1;
end
end
end
 
  
   
    
    
    PC_QC_LDPC_g8(R*C,R*R)=int16(-1);
Circulant_g8(Q,Q)=int16(-1);
%coordinate of left angle of considered circulant matrix

for y =1:R*C
for x =1:R*R
    for current_y=1:Q
    for current_x=1:Q
    Circulant_g8(current_y,current_x)=PC_LDPC_g8((y-1)*Q+current_y,(x-1)*Q+current_x);
    end
    end
    
    A=find(Circulant_g8(1,:),1);
    if isempty(A)
        PC_QC_LDPC_g8(y,x)=-1;
    else
    PC_QC_LDPC_g8(y,x)=A;
    end
end
end
    
    %
    spy(PC_LDPC_g8);
end
end



% type 3

% need to consider some combination of slopes 

if Type_of_LDPC==3 
%girth 8 codes generate 
if 1  %C>3 && Q>4*(R-1)
    %
    
    Z_project_lines_parallel_g6(R, C, R, Q)=uint32(0);

 for slope_top_face= 1:R
for y = 1:R 
slope_QC= (y+R)*(y+C)+(slope_top_face +R)*(slope_top_face+C);
for z = 1:Q  
for x = 1:C

   Z_project_lines_parallel_g6(y, x, slope_top_face, z)=Lattice(mod(z+slope_QC*x,Q)+1,x,mod(y+slope_top_face*x,R)+1);
end
end
end
end  

    
    
PC_LDPC_g8(Q*R*C,Q*R*R)=int8(0);

current_line=1;


for slope_top_face= 1:R
for y = 1:R 
for z = 1:Q  
for x = 1:C
   PC_LDPC_g8(Z_project_lines_parallel_g6(y, x, slope_top_face,z),current_line) =1;
   %
end
    current_line=current_line+1;
end
end
end
 
  
   
    
    
    PC_QC_LDPC_g8(R*C,R*R)=int16(-1);
Circulant_g8(Q,Q)=int16(-1);
%coordinate of left angle of considered circulant matrix

for y =1:R*C
for x =1:R*R
    for current_y=1:Q
    for current_x=1:Q
    Circulant_g8(current_y,current_x)=PC_LDPC_g8((y-1)*Q+current_y,(x-1)*Q+current_x);
    end
    end
    
    A=find(Circulant_g8(1,:),1);
    if isempty(A)
        PC_QC_LDPC_g8(y,x)=-1;
    else
    PC_QC_LDPC_g8(y,x)=A;
    end
end
end
    
    %
    spy(PC_LDPC_g8);
    
end

end



