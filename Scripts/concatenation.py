import os
import io
import sys
import argparse
import Bio.SeqIO as SeqIO
import gzip
import numpy as np
import pandas as pd

def get_no_hidden_folder_list(wd):
    folder_list = []
    for each_folder in os.listdir(wd):
        if not each_folder.startswith('.'):
            folder_list.append(each_folder)

    folder_list_sorte = sorted(folder_list)
    return folder_list_sorte

def main(path ,  output_file):
    file_list = get_no_hidden_folder_list(path)
    bin_num = len(file_list)	    
    for k in range(bin_num):
        seq_file = '%s/%s' % (path , file_list[k])
        if k==0:
            op1 = 'echo ' + '\">BIN_' + str(k) + '\" ' + '> ' + output_file
        else:
            op1 = 'echo ' + '\">BIN_' + str(k) + '\" ' + '>> ' + output_file

        os.system(op1)
        op2 = 'grep ' + '-v ' + '\'>\' ' + seq_file  + ' >> ' + output_file
        os.system(op2)    

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("-p",help="path")
    parser.add_argument("-o",help="output_file")
    args=parser.parse_args()
    main(args.p,args.o)



