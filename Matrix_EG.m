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

clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Code generation based on Finit Geometry - by Fossorier, Shu Lin
% EG(m,2^n)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 2; 
m = 2;
q = 2^n;

fprintf('\n Points - %d\n Points per line - %d\n Lines - %d\n Line Bundles - %d\n',...
        q^m, q, q^(m-1)*(q^m-1)/(q-1), (q^m-1)/(q-1));

% Create field - 2^(m*n)
arr =  0:(q^m-1);
gf_array = gf(arr,m*n); % GF(2^(mn)) is implementation of
gf_array = [ gf_array(2:q^m) gf_array(1) ]; % 1, a, a^2,..., a^(q-2), 0 - field elements array

% Generate table with indeces for power representation of primitive element - set if the field elements
% a^0, a^1, a^2, ...,a^(q-2), 0
% a = gf_array(2);
ind_arr = zeros(1,q^m);
ppp = zeros(q^m, 2);
ppp(:,1) = 1:q^m ;
a = gf_array(2);
for iii = 1:(q^m-1)
    tmp = a^(iii-1);
    ind_arr(iii) = fix(tmp.x);
    ppp(iii, 2) = ind_arr(iii);                    % Correspondance between POWER and VECTOR implementation
end
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
ind_arr(q^m) = q^m;                             % Index for taken gf_array like VECTOR representation !!!!!
%  Lin, Ryan - page 74 as example
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
tmp = ppp(:,2:-1:1);
[sss, sss_ind] = sort(tmp(1:q^m-1,1));
tmp_ppp = ppp(sss_ind,:);
tmp_ppp(:,1) = tmp_ppp(:,1);
tmp_ppp(q^m,2) = q^m;
inv_ppp = tmp_ppp(:,2:-1:1);  
inv_ppp(1:q^m-1, 2) = inv_ppp(1:q^m-1, 2)-1;      % Correspondance between VECTOR and POWER implementation
inv_ind_arr = inv_ppp(:,2);


%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% 'gf_array' after its creation by GF(...) - is in 'ind_array' order.
% 'IND_ARR' - array of indeces that take from the field (gf_array)
% vector representation of the field elements by its power like
% gf_array(ind_arr(i+1)), where 'i' is power of field element
% ------------------------------------------------------------------------
% 'INV_IND_ARR' - array of indeces that take from the field (gf_array)
% power representation of the field elements by its vectore representation like
% gf_array(inv_ind_arr(i)), where i - is vector representation of the
% element i = gf.x
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

% Depends on particular polynomial
% Find all roots: check all 
ind_r = [];
for iii = 0:(q^m-2)
    a = gf_array(ind_arr(iii+1));
    tmp = (a^4 + a + 1);   % !!!! x^4 + x + 1 - for GF(2^(2*2)) !!!!
    %tmp = (a^12 + a^6 + a^4 + a + 1);   % !!!!  D^12+D^6+D^4+D+1 - for GF(2^(6*2)) !!!!
    if tmp == 0
        ind_r = [ind_r iii]; % roots in vector representation
    end
end
vec_roots = gf_array(ind_arr(ind_r+1));
ind_pow_roots = inv_ind_arr(vec_roots.x);

% Construct EG
fff = factor(q^m-1);
fmax = max(fff);

% Basic for EG(2,xxx)
beta = gf_array(ind_arr(fmax+1));
bas_2v = [];
for iii = 2:2^m
    bas_2v = [bas_2v beta^(iii-2)];
end
bas_2v = [gf_array(q^m) bas_2v];   % basis in vector format
                                   % gf_array(q^m) = 0;
% Convert to power representation
for iii = 1:2^m
    tmp = bas_2v(iii);
    if double(tmp.x) == 0;
        ind_bas_2p(iii) = q^m-1;  % last element in the filed == 0 
    else
        ind_bas_2p(iii) = inv_ind_arr(tmp.x); % power representation
    end
end

% Parallel bundles 
eg = [];
eg = gf(eg, m*n);
j = 1;          % power of alpha
alpha = gf_array(ind_arr(j+1));     % Take one of alfa^j
j = 2;
alpha2 = gf_array(ind_arr(j+1));     % Take one of alfa^j
beta = bas_2v(4);
% Make L_0
L_0 = beta + bas_2v*alpha;
L_0_1 = alpha + bas_2v*alpha2


                    % Coversion JUST TO LOOK !!!!!
                    bas_2v = L_0_1;
                    for iii = 1:2^m
                        tmp = bas_2v(iii);
                        if double(tmp.x) == 0;
                            ind_bas_2p(iii) = q^m-1;  % last element in the filed == 0 
                        else
                            ind_bas_2p(iii) = inv_ind_arr(tmp.x) % power representation
                        end
                    end

% Saving
str = 'EG=';
tmp = num2str(m);
str = strcat(str,tmp);
tmp = '_t=';
str = strcat(str,tmp);
tmp = num2str(t);
str = strcat(str,tmp);
tmp = '.mat';
str = strcat(str,tmp);
save(str, 'H_EG');

