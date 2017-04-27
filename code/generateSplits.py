#Embedded file name: /srv/scratch/annashch/deeplearning/utils/generateSplits.py
def make_pluripotency_dict(pluripotency_file, pluripotency_buffer):
    data = open(pluripotency_file, 'r').read().split('\n')
    while '' in data:
        data.remove('')

    pluripotency_dict = dict()
    for line in data[1::]:
        tokens = line.split('\t')
        chrom = tokens[2]
        startts = int(tokens[4]) - pluripotency_buffer
        endts = int(tokens[5]) + pluripotency_buffer
        if chrom not in pluripotency_dict:
            pluripotency_dict[chrom] = dict()
        pluripotency_dict[chrom][startts] = endts

    return pluripotency_dict


def isPeakInPluripotencyRegion(pluripotency_dict, chrom, startpos, endpos):
    if chrom not in pluripotency_dict:
        return False
    for candidate_startval in pluripotency_dict[chrom]:
        if startpos >= candidate_startval:
            if endpos <= pluripotency_dict[chrom][candidate_startval]:
                return True

    return False


def write_splits(train, test, validation, outfile_train, outfile_test, outfile_validation):
    print(str(len(train)))
    print(str(len(test)))
    print(str(len(validation)))
    outfile_train = open(outfile_train, 'w')
    outfile_train.write('\n'.join(train))
    outfile_test = open(outfile_test, 'w')
    outfile_test.write('\n'.join(test))
    outfile_validation = open(outfile_validation, 'w')
    outfile_validation.write('\n'.join(validation))


def make_splits(peak_dict, test_chroms, validation_chroms, pluripotency_file, pluripotency_buffer, outfile_train, outfile_test, outfile_validation):
    train = []
    validation = []
    test = []
    pluripotency_dict = make_pluripotency_dict(pluripotency_file, pluripotency_buffer)
    print (str(len(peak_dict.keys())))
    for peakname in peak_dict:
        entry = peak_dict[peakname]
        chrom = entry[0]
        startpos = entry[1]
        endpos = entry[2]
        inpluripotency_region = isPeakInPluripotencyRegion(pluripotency_dict, chrom, startpos, endpos)
        if inpluripotency_region:
            test.append(peakname)
        elif chrom in test_chroms:
            test.append(peakname)
        elif chrom in validation_chroms:
            validation.append(peakname)
        else:
            train.append(peakname)

    write_splits(train, test, validation, outfile_train, outfile_test, outfile_validation)
