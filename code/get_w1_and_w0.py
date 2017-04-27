import sys 
import h5py 
import numpy as np 
data=h5py.File(sys.argv[1],'r') 
ymat_train=np.asarray(data['Y_train'])
ymat_test=np.asarray(data['Y_test'])
ymat_valid=np.asarray(data['Y_valid'])
ymat=np.concatenate((ymat_train,ymat_test),axis=0) 
ymat=np.concatenate((ymat,ymat_valid),axis=0)
nrow=ymat.shape[0] 
col_sums=np.sum(ymat,axis=0) 
w1=nrow/col_sums 
w0=nrow/(nrow-col_sums) 
print "nrow:"+str(nrow) 
print "w1:"+str(w1) 
print "w0:"+str(w0) 
outf=open(sys.argv[2],'w') 
outf.write('w1:'+'\t'.join([str(round(i,3)) for i in w1])+'\n') 
outf.write('w0:'+'\t'.join([str(round(i,3)) for i in w0])+'\n') 
