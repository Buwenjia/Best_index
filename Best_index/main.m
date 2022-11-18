clc;
clear;
close all;

%Load pure original signal
load('f_my.mat')

%Load modal components after decomposition
load('imf_UP1_10.mat')

I = f_my;
IMF=imf_UP1_10;

%Call optimization operator
[max_S,min_R,Best_imfs_index]=Best_index(I,IMF)
 
