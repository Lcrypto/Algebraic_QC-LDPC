# Matlab and C++ tools for Algebraic QC-LDPC codes construction   
The GitHub repository contains MATLAB and C++ tools for implementing algebraic methods to construct Quasi-Cyclic and Cyclic Low-Density Parity-Check (LDPC) codes parity-check matrices using various techniques such as Projective Geometry, Affine Geometry, Euclidean Geometry, Finite Geometry, Latin Square, Balanced Incomplete Block Design (BIBD), Reed-Solomon (RS) code, Lattice Grid, and more.

The "egldpc-0.4" folder in the repository contains C++ source code for making Euclidean Geometry LDPC codes parity matrices and low-density generator matrix (LDGM) codes, developed by Fernando Pujaico Rivera. For efficient hard decoding of Euclidean Geometry LDPC codes and LDGM codes, you can use BFS, SHBF, PHBF, SSSBF, PSSBF, WBF, and MWBF decoders from https://github.com/Lcrypto/LDPC-Iterative-Bit-Flipping-family-decoders.

 
Most of construction based on articles 
* Kou Y, Lin S, Fossorier M. Low-density parity-check codes based on finite geometries: a rediscovery and new results. IEEE Transactions on Information Theory 2001; 47(7):2711–2736.
* L. Lan, Y. Y. Tai, S. Lin, B. Memari and B. Honary, "New constructions of quasi-cyclic LDPC codes based on special classes of BIBD's for the AWGN and binary erasure channels," in IEEE Transactions on Communications, vol. 56, no. 1, pp. 39-48, January 2008
* I. Djurdjevic, Jun Xu, K. Abdel-Ghaffar and Shu Lin, "A class of low-density parity-check codes constructed based on Reed-Solomon codes with two information symbols," in IEEE Communications Letters, vol. 7, no. 7, pp. 317-319, July 2003
