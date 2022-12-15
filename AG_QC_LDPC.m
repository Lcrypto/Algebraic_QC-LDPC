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

%Based on Article Kou Y, Lin S, Fossorier M. Low-density parity-check codes based
%on finite geometries: a rediscovery and new results. IEEE Transactions
%on Information Theory 2001; 47(7):2711–2736.


 clear all;

qcParity_FileName= "AG_QC_LDPC.txt";
q=47; % GF(q) prime field and size of circulant
CN=4; % number of rows (check nodes) in QC protograph
VN=44; % number of columns (variable nodes) in QC protograph
check_rate=1; % check how many variable nodes independent and calculate final rate of QC-LDPC

if ~isprime(q) 
    error('Change q to prime and rerun');
end



gf_v = 0:q - 1;

exp = zeros(q);

for k = 1:q-1
    exp(k + 1, :) = mod(gf_v .* k, q);
end



file = fopen(qcParity_FileName, 'w');
fprintf(file, '%d %d %d \n',VN, CN,q);
for i = 1:CN
    for j = 1:VN
fprintf(file, '%d ', exp(i,j));
    end
    fprintf(file, '\n');
end
fclose(file);




[H_full, n, m, z] = qc2sparse(qcParity_FileName);
H_full=full(H_full);


if check_rate
full_parity_mat = gfrank(H_full);
if full_parity_mat~=size(H_full, 2)
    R = ((size(H_full, 2) - full_parity_mat)/size(H_full, 2));
    fprintf("Parity-check matrix contain linear dependend variables, only %d from %d independent. \n Rate of code equal %f from original %f .",size(H_full, 2)-full_parity_mat,size(H_full, 2), R,1-CN/VN)
end
end





