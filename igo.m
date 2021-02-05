function y=igo(x,rows,cols)
[s1,s2]=size(x);
y=zeros(s1,s2);

for i=1:s2
    t1=reshape(x(:,i),rows,cols);
    fh=[-1 0 1;-2 0 2;-1 0 1]; fv=[-1 -2 -1;0 0 0;1 2 1]; % Sobel Filter can be change to others
    Gh=filter2(fh,t1); Gv=filter2(fv,t1);
    t2=tanh(Gv./Gh);
    y(:,i)=reshape(t2,[s1,1]);
    y(find(isnan(y)==1))=0;
end
end