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
% Code generation based on Galois Field Subgroups - by Shu Lin's article
% "QC-LDPC: Algerbraic construction"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%m = input('Galois field parameter = '); % default m=5
m = 9;  % GF(2^m)
t = 4;  % fraction of polynomial basic < m (m/2 for m- even)

% Create field - 2^m
q = 2^m;
arr =  0:(q-1);
gf_array = gf(arr,m);
gf_array = [ gf_array(2:q) gf_array(1) ]; % 1, a, a^2,..., a^(q-2), 0 - field elements array

% Generate table with indeces for power representation of primitive element - set if the field elements
% a^0, a^1, a^2, ...,a^(q-2), 0
% a = gf_array(2);
ind_arr = zeros(1,q);
ind_arr(1) = 1;
a = gf_array(2);
tmp = 1;
for iii = 2:(q-1)
    tmp = a*tmp;
    ind_arr(iii) = fix(tmp.x);
end
ind_arr(q) = q;


%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% CHANGE INDEXES FOR SUBGROUP CALCULATION
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





% Polynomial basic
bas = gf_array(ind_arr(1:m)); % size of polynomial basic is 'm'
% Divide the basic into two groups based on 't'
bas_beta  = bas(1:t);
bas_delta = bas(t+1:m);

% Create two subgroups based on two basices
G1_i = zeros(1,2^t);
G2_i = zeros(1,2^(m-t));
G1 = gf(G1_i,m);
G2 = gf(G2_i,m);
% Coefs
%coef = 0:1;   % coef from GF(2)
c_1_i = zeros(2^t, t);
c_2_i = zeros(2^(m-t), (m-t));
tm = t;
for iii = 1:2^tm;
    tmp = dec2bin(iii-1,tm);
    for jjj = 1:tm
        if tmp(tm-jjj+1) == '1'
            c_1_i(iii,tm-jjj+1) = 1;
        else
            c_1_i(iii,tm-jjj+1) = 0;
        end
    end
end
C1 = gf(c_1_i,m);
tm = m-t;
for iii = 1:2^tm;
    tmp = dec2bin(iii-1,tm);
    for jjj = 1:tm
        if tmp(tm-jjj+1) == '1'
            c_2_i(iii,tm-jjj+1) = 1;
        else
            c_2_i(iii,tm-jjj+1) = 0;
        end
    end
end
C2 = gf(c_2_i,m);
% Create subgroups elements
G1 = C1*bas_beta';
G2 = C2*bas_delta';

% Create 'W' matrix consists from submatrices 'w'
% W size = 2^(m-t) x 2^(m-t)
% w size = 2^t x 2^t
WW = cell(2^(m-t),2^(m-t)); 
ww_i = zeros(2^t, 2^t);
ww = gf(ww_i,m); 
tmp = 0; tgf = gf(tmp,m);
for kkk = 1:2^(m-t)
    for lll = 1:2^(m-t)
        tgf = G2(lll) - G2(kkk);
        for iii = 1:2^t
            for jjj = 1:2^t
                ww(iii,jjj) = tgf +G1(iii)-G1(jjj);
            end
        end
        WW{kkk,lll} = double(ww.x);
    end
end
WW = cell2mat(WW);
H_FSG = gf(WW, m);     % Base matrix

% Saving
str = 'Field SubGroup_m=';
tmp = num2str(m);
str = strcat(str,tmp);
tmp = '_t=';
str = strcat(str,tmp);
tmp = num2str(t);
str = strcat(str,tmp);
tmp = '.mat';
str = strcat(str,tmp);
save(str, 'H_FSG');

