function [max_S,min_R,Best_imfs_index]=Best_index(I,IMF)
%==================================================
 %inout  %The size of IMF matrix is [K,N],
 %        K is the number of IMF , N is the length of input signal. 
         % I is the original signal
 %output %max_S  is the SNR of the best combination
         %min_R  is the RMSE of the best combination
         %Best_imfs_index is the row numbers in matrix A corresponding to the best combination
%Compiled By BWJ. mail: bwj135892@163.com
%Last modified date:2022.9.21
%==================================================
%tic
%Generate IMF selection coefficient matrix
A=1:size(IMF,1);
SNR1=[];
RMSE1=[];
for i=1:size(A,2)
    In_dex=nchoosek(A,i); %%List the combinations of i elements taken from A. Where A is a vector containing n elements
    
    for j=1:size(In_dex,1)
        Useful_imf=IMF(In_dex(j,:),:);
        reconstruc_signal_Tem=sum(Useful_imf,1);
        SNR_Tem(j)=SNR(I,reconstruc_signal_Tem);
        RMSE_Tem(j)=RMSE(I,reconstruc_signal_Tem);
    end
    SNR1=[SNR1,SNR_Tem];
    RMSE1=[RMSE1,RMSE_Tem];
    SNR_Tem=[];
    RMSE_Tem=[];
end

[min_R,index]=min(RMSE1,[],2);
[max_S,index]=max(SNR1,[],2);

%Generate IMF combination number vector
for i=1:size(IMF,1)
    index_num(i)=nchoosek(size(IMF,1),i);
end

%Output the index of the best IMF combination
if size(IMF,1)==1
   disp('The signal is not decomposed or the number of IMF is less than or equal to 1')
   Best_imfs_index=0;
   return
else
    for i=1:size(IMF,1)-1
        if index > sum(index_num(1:i)) && index <= sum(index_num(1:i+1))
            Cha_zhi=index-sum(index_num(1:i));
            imf_j_index=nchoosek(A,i+1);
            Best_imfs_index=imf_j_index(Cha_zhi,:);
            break
        elseif index<=index_num(1) 
            Best_imfs_index=index;
            break
        else  
            continue
        end
    end
end
