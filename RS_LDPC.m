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

% Application generate QC-LDPC parity-check matrix based on RS-codewords
% 
clear all;



p=503; %
a=5; % primitive  element
k=0;
%etta=fldpow(k,a,p);
W(p-1,p-1)=zeros(); % full matrix have  qxq size
A(p-1)=zeros();
for i = 1:p-1
   if i ==1
      A(i)=0;
   else
   A(i)=mod(fldpow(i-1,a,p)-1,p);
   end
end
 W=circulant(A,1);
 
 powfld(p-1)=zeros();
for i = 1:p-1
    powfld(i)=fldpow(i-1,a,p);
end


%return power of primitive element  from array W

e(p-1)=zeros();
 e(1)=-1;
for i = 2:p-1
                
            for k= 1:p-1
            if powfld(k)== W(1,i)
                e(i)=k;
            end
            
            end
end
exp=circulant(e,1);
 
 
    