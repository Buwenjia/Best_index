function err_mse=RMSE(f,n)
err = f - n;
err_mse = sqrt( sum(err .^ 2) / length(err) ); 
