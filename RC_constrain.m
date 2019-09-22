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


%131, 167, 179, 191, 227, 347, 613
%if field great then 500, don't forget to change recursion limit in matlab
%to value above field charachteristic, example set(0,'RecursionLimit',700)
p= 503; % GF(131) is GF(12*t-1), where t = 11
a=5; % primitive  element of 
k=0;
columnw=8;
W(columnw,p-1-columnw)=zeros(); % full matrix have  qxq size 
for i = 1:columnw
    for j = 1:p-columnw-1
  





          W(i,j)=fldpow(i-1,a,p);
          
            W(i,j)=mod(W(i,j)+fldpow(j+columnw-1,a,p),p);
           
  
    end
end
%calculate power of primitiv element in field 131

powfld(p-1)=zeros();
for i = 1:p-1
    powfld(i)=fldpow(i-1,a,p);
end


%return power of primitive element  from array W

exp(columnw,p-1-columnw)=zeros();
for i = 1:columnw
    for j = 1:p-columnw-1
       for k= 1:p-1
            if powfld(k)== W(i,j)
                exp(i,j)=k;
            end
       end
    end
end

