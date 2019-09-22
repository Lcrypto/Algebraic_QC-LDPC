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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code generation based on Latin Square - by Shu Lin's  article
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%m = input('Galois field parameter = '); % default m=5
m = 5;
q = 2^m;
nu_ind = randi(q-1,1);
arr =  0:(q-1);
gf_array = gf(arr,m);
gf_array = [ gf_array(2:q) gf_array(1) ]; % 1, a, a^2,..., a^(q-2), 0 - field elements array

% m=5 => Primitive polynomial = D^5+D^2+1 (37 decimal)
% Find all roots: check all 
pol_roots = [];
for iii = 1:(q-1)
    a = gf_array(iii);
    tmp = (a^5 + a^2 + 1);
    if tmp == 0
        pol_roots = [pol_roots a]; % roots in vector representation
    end
end

polynomial = [1 0 1 0 0 1]; % D^5+D^2+1 
rts =gfroots(polynomial,m); % roots in power representation

% Generate table with indeces for power representation of primitive element
% a^0, a^1, a^2, ...,a^(q-2), 0
%a = gf_array(2);
ind_arr = zeros(1,q);
ind_arr(1) = 1;
%tmp = gf_array.x;
a = gf_array(2);
tmp = 1;
for iii = 2:(q-1)
    tmp = a*tmp;
    ind_arr(iii) = fix(tmp.x);
end
ind_arr(q) = q;

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% CHANGE INDECES FOR LATIN SQUEARE CALCULATIONS
                        % Generate table with indeces for power representation of primitive element - set if the field elements
                        % a^0, a^1, a^2, ...,a^(q-2), 0
                        % a = gf_array(2);
                        ind_arr = zeros(1,q^m);
                        ppp = zeros(q^m, 2);
                        ppp(:,1) = 1:q^m ;
                        ind_arr(1) = 1;
                        a = gf_array(2);
                        tmp = 1;
                        for iii = 2:(q^m-1)
                            tmp = a*tmp;
                            ind_arr(iii) = fix(tmp.x);
                            ppp(iii, 2) = ind_arr(iii);         % Correspondance between power and vector implementation
                        end
                        % !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        ind_arr(q^m) = q^m;                             % Index for taken gf_array like VECTOR representation !!!!!
                        %  Lin, Ryan - page 74 as example
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!




% Generate Latin Square of common form (depends on 'nu')
nu = gf_array(nu_ind);
l_s = zeros(q,q);
l_s_gf = gf(l_s, m);
for iii = 1:q
    for jjj = 1:q
        l_s_gf(iii, jjj) = gf_array(ind_arr(iii))*nu - gf_array(ind_arr(jjj));
    end
end
H_Latin = l_s_gf;

% Saving
str = 'Latin_Square_m=';
tmp = num2str(m);
str = strcat(str,tmp);
tmp = '_nu_ind=';
str = strcat(str,tmp);
tmp = num2str(nu_ind);
str = strcat(str,tmp);
tmp = '.mat';
str = strcat(str,tmp);
save(str, 'H_Latin');