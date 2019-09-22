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

%Class-I type 2 (weight 5)
% Application generate QC-LDPC parity-check matrix based on BOSE BIBD
% (which define Quasi-cyclic BOSE BIBD-LDPC (and can be generalized) 
% from GF(q) extender shall have size of field q-1
%  size of mother matrix depend of choise of rows which produce non-full
% matrix from W
clear all;
%factorize=factor(p-1);
%num_fact=size(factorize,2);

%for i = 1:num_fact
    
%    if mod(factorize(i)^((p-1)/q),p)~=1 && isprime(q)p-1; 
        
%    end
%end


%41,61,241,281,421,601,641,661,701,821
%if field great then 500, don't forget to change recursion limit in matlab
%to value above field charachteristic, example set(0,'RecursionLimit',700)
p= 509; % 
t=30; %(t=21 for 421) %  c<=t, prime characteristic of field 
a=2; % primitive  element of 
k=0;
columnweight=5;
rowweight=30; % must be less or equal t



exp(columnweight,rowweight)=zeros();
for i = 1:rowweight
    for j = 1:columnweight 
          exp(j,i)=mod(p+1-fldpow(2*(i-1)+4*t*(j-1),a,p),p);
    end
end



