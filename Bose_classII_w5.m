%Copyright(c) 2011, USAtyuk Vasiliy 
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

%Class-|| (weight 3)
% Application generate QC-LDPC parity-check matrix based on BOSE BIBD
% (which define Quasi-cyclic BOSE BIBD-LDPC (and can be generalized) 
% from GF(q) extender shall have size of field q-1
%  size of mother matrix depend of choise of rows which produce non-full
% matrix from W
clear all;

%
%if field great then 500, don't forget to change recursion limit in matlab
%to value above field charachteristic, example set(0,'RecursionLimit',700)
%p= 601; % 
%41,61,241,281,421,601,641,661,701,821
%GF(20t+1)
p=2081;
%p=131;
t=104; 
%t=30; %(t=21 for 421) %  c<=t, prime characteristic of field 
%a=7; % primitive  e     lement of 
%a=3; %primitive element
a=3;
k=0;
columnweight=5;
%rowweight=30; % must be less or equal t
rowweight=100;
exp(columnweight,rowweight)=zeros();
for i = 1:rowweight
    for j = 1:columnweight 
          exp(j,i)=mod(p+1-fldpow(2*(i-1)+4*t*(j-1),a,p),p);
    end
end



C(p,p)=sparse(zeros());
circ(p,p)=sparse(zeros());
for i = 1:rowweight
    
    for j = 1:columnweight
C=C+circshift(eye(p), exp(j,i));
    end
    
    if i==1
    circ=C;
    end
    if i>1
    circ=cat(2,circ,C);
    end
    C=zeros();
end
%To estimate lower bound of code distance 
%C(p,p)=sparse(zeros());
%H_=[zeros(421,421),H; H',zeros(8841,8841)];
%[V,D] = eig(H_);
