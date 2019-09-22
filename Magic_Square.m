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

% Application generate QC-LDPC parity-check matrix based on Latin Square
% (which define Quasi-cyclic BOSE BIBD-LDPC (and can be generalized) 
% from GF(q)extender shall have size of field q-1
%  size of mother matrix depend of choise of rows which produce non-full
% submatrix from W
clear all;
%factorize=factor(p-1);
%num_fact=size(factorize,2);

%for i = 1:num_fact
    
%    if mod(factorize(i)^((p-1)/q),p)~=1 && isprime(q)p-1; 
        
%    end
%end


p=1021; % GF(181) is GF(12*t+1), where t = 12
a=10; % primitive  element
k=0;
etta=fldpow(k,a,p);
W(p,p)=zeros(); % full matrix have  qxq size 
for i = 1:p
    for j = 1:p
      if i~=p && j~=p
          
            W(i,j)=fldpow(i-1,a,p);
            W(i,j)=W(i,j)*etta;
            W(i,j)=mod(W(i,j)-fldpow(j-1,a,p),p);
      else
            if i==p

            W(i,j)=mod(-fldpow(j-1,a,p),p);
            end
            if j==p
                W(i,j)=fldpow(i-1,a,p);
            W(i,j)=W(i,j)*etta;
            end
      end
      
      %W(i,j)=mod(a^(i-1),p);
       %W(i,j)=W(i,j)*etta;
       %W(i,j)=W(i,j)-mod(a^(j-1),p);
 
    end
end
 W(p,1)=mod(-1,p);
 W(p,p)=0;
 W(1,p)=etta;
 
 
 powfld(p-1)=zeros();
for i = 1:p-1
    powfld(i)=fldpow(i-1,a,p);
end


%return power of primitive element  from array W

exp(p,p)=zeros();
for i = 1:p
    for j = 1:p
       for k= 1:p-1
            if powfld(k)== W(i,j)
                exp(i,j)=k;
            end
            if i==j
                exp(i,j)=-1;
            end
       end
    end
end

 
 
    