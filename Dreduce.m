function Out = Dreduce(Inp)

Inp = double(Inp);
x = reshape(Inp,[],3);
[V,D] = eig(cov(x));
[Md,idx] = max(diag(D));
Si = reshape(x*V(:,idx),size(Inp,1),size(Inp,2));  
Out= ((Si - min(min(Si))).*255)./(max(max(Si))-min(min(Si)));   %%%%%Normalization[0 255]
   
end
