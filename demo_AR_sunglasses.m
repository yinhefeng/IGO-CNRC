clear
clc
close all

% load data
load('AR_55x40.mat')
load('sample_index.mat')

ClassNum = length(unique(Label)); % number of classes
experiments = size(Tr_ind,1); % repeat 3 times

acc = zeros(1,experiments);  % accuracy for IGO_CNRC
acc1 = zeros(1,experiments); % accuracy for IGO_CNRC (1st)
acc2 = zeros(1,experiments); % accuracy for IGO_CNRC (2nd)
acc3 = zeros(1,experiments); % accuracy for IGO_CNRC (3rd)

% parameter setting
lambda = 1e-3;
mu = 1e-1;

param = [];
param.mu = mu;
%--------------------------------------------------------------------------

for ii=1:experiments
    disp(ii)
    
    % obtain the training data and test data
    train_ind=logical(Tr_ind(ii,:));
    test_ind=logical(Tt_ind(ii,:));
    
    train_data=DATA(:,train_ind);
    train_label=Label(:,train_ind);
    
    test_data=DATA(:,test_ind);
    test_label=Label(:,test_ind);
    
    % total number of training and test data
    train_tol= length(train_label);
    test_tol = length(test_label);
    
    % extract the first order IGO feature
    tr_igo = igo(train_data,rows,cols);
    tt_igo = igo(test_data,rows,cols);
    
    % normalization
    tr_dat1 = normc(tr_igo);
    tt_dat1 = normc(tt_igo);
    
    % pre-computation
    tr_sym_mat = zeros(length(train_label));
    for ci = 1 : ClassNum
        ind_ci = find(train_label == ci);
        tr_descr_bar = zeros(size(tr_dat1));
        tr_descr_bar(:,ind_ci) = tr_dat1(:, ind_ci);
        tr_sym_mat = tr_sym_mat + lambda * (tr_descr_bar' * tr_descr_bar);
    end
    
    XTX = tr_dat1'*tr_dat1;
    temp_X1 = pinv(XTX+tr_sym_mat+mu/2*eye(train_tol));
    
    X1 = tr_dat1;
    Y1 = tt_dat1;
    %=============================================================
    % extract the second order IGO feature
    tr_igo2 = igo2(train_data,rows,cols);
    tt_igo2 = igo2(test_data,rows,cols);
    
    % normalization
    tr_dat2 = normc(tr_igo2);
    tt_dat2 = normc(tt_igo2);
    
    % pre-computation
    tr_sym_mat = zeros(length(train_label));
    for ci = 1 : ClassNum
        ind_ci = find(train_label == ci);
        tr_descr_bar = zeros(size(tr_dat2));
        tr_descr_bar(:,ind_ci) = tr_dat2(:, ind_ci);
        tr_sym_mat = tr_sym_mat + lambda * (tr_descr_bar' * tr_descr_bar);
    end
    
    XTX = tr_dat2'*tr_dat2;
    temp_X2 = pinv(XTX+tr_sym_mat+mu/2*eye(train_tol));
    
    X2 = tr_dat2;
    Y2 = tt_dat2;
    %==============================================================
    % extract the third order IGO feature
    tr_igo3 = igo3(train_data,rows,cols);
    tt_igo3 = igo3(test_data,rows,cols);
    
    % normalization
    tr_dat3 = normc(tr_igo3);
    tt_dat3 = normc(tt_igo3);
    
    % pre-computation
    tr_sym_mat = zeros(length(train_label));
    for ci = 1 : ClassNum
        ind_ci = find(train_label == ci);
        tr_descr_bar = zeros(size(tr_dat3));
        tr_descr_bar(:,ind_ci) = tr_dat3(:, ind_ci);
        tr_sym_mat = tr_sym_mat + lambda * (tr_descr_bar' * tr_descr_bar);
    end
    
    XTX = tr_dat3'*tr_dat3;
    temp_X3 = pinv(XTX+tr_sym_mat+mu/2*eye(train_tol));
    
    X3 = tr_dat3;
    Y3 = tt_dat3;
    %%%=========================================
    ID = zeros(1,test_tol); % predicted label for IGO_CNRC
    ID1 = zeros(1,test_tol); % predicted label for IGO_CNRC (1st)
    ID2 = zeros(1,test_tol); % predicted label for IGO_CNRC (2nd)
    ID3 = zeros(1,test_tol); % predicted label for IGO_CNRC (3rd)
    for i=1:test_tol
        y1 = Y1(:,i);
        [z,c1] = CNRC(X1, temp_X1, y1,param);
        residual1 = CNRC_res(X1,y1,c1,train_label);
        
        y2 = Y2(:,i);
        [z,c2] = CNRC(X2, temp_X2, y2,param);
        residual2 = CNRC_res(X2,y2,c2,train_label);
        
        y3 = Y3(:,i);
        [z,c3] = CNRC(X3, temp_X3, y3,param);
        residual3 = CNRC_res(X3,y3,c3,train_label);
        
        % fusion
        residual = residual1+residual2+residual3;
        
        [~,index1] = min(residual1);
        ID1(i) = index1;
        
        [~,index2] = min(residual2);
        ID2(i) = index2;
        
        [~,index3] = min(residual3);
        ID3(i) = index3;
        
        % classification
        [~,index] = min(residual);
        ID(i) = index;
    end
    
    %-------------------------------------------------------------------------
    cornum      =   sum(ID==test_label);
    acc1(ii)         =   sum(ID1==test_label)/length(test_label);
    acc2(ii)         =   sum(ID2==test_label)/length(test_label);
    acc3(ii)         =   sum(ID3==test_label)/length(test_label);
    acc(ii)         =   cornum/length(test_label); % recognition accuracy
end

acc_1st = mean(acc1);
acc_2nd = mean(acc2);
acc_3rd = mean(acc3);
acc_our = mean(acc);

% display the results
fprintf('Accuracy of IGO_CNRC (1st) is %.1f%%\n',acc_1st*100)
fprintf('Accuracy of IGO_CNRC (2nd) is %.1f%%\n',acc_2nd*100)
fprintf('Accuracy of IGO_CNRC (3rd) is %.1f%%\n',acc_3rd*100)
fprintf('Accuracy of IGO_CNRC is %.1f%%\n',acc_our*100)
