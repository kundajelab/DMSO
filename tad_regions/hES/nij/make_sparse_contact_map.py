import sys
import numpy as np
data=np.loadtxt(sys.argv[1])
coords=np.transpose(np.nonzero(data))
bin1,bin2=np.nonzero(data)
vals=data[bin1,bin2]
print(str(coords.shape))
print(str(vals.shape))
sparse_map=np.column_stack((coords,vals))
np.savetxt(sys.argv[1]+".sparse_map",sparse_map,fmt='%i\t%i\t%f')
