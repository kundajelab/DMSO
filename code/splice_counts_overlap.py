from os import listdir
from os.path import isfile, join

#fill in absent peaks with 0 count reads 
def main(): 
    mypath="/srv/scratch/annashch/stemcells/het/anna_data/" 
    candidates= [f for f in listdir(mypath) if isfile(join(mypath, f))]
    all_peaks=open(mypath+'all.merged','r').read().split('\n') 
    while '' in all_peaks: 
        all_peaks.remove('') 
    count_dict=dict() 
    for c in candidates: 
        if c.endswith('ANNOTATED'): 
            count_dict[c]=dict() 
            cur_data=open(mypath+c,'r').read().split('\n') 
            while '' in cur_data: 
                cur_data.remove('') 
            num_blanks=0 
            for line in cur_data: 
                tokens=line.split('\t') 
                entry=tokens[0]+'\t'+tokens[1]+'\t'+tokens[2] 
                count=tokens[-2]
                if count!=".": 
                    num_blanks=len(count.split(' '))
                else: 
                    count=[0]*num_blanks
                    count=' '.join([str(i) for i in count])
                print str(count) 
                count_dict[c][entry]=count 
    outf_meta=open('counts_merged.metadata','w') 
    reps=count_dict.keys() 
    outf_meta.write('\n'.join(reps))
    outf=open('counts_merged.txt','w') 
    for entry in all_peaks: 
        for r in reps: 
            outf.write(count_dict[r][entry]+' ')
        outf.write('\n') 

if __name__=="__main__": 
    main() 
