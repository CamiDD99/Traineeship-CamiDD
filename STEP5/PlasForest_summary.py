#!/usr/bin/python3
################################################################################
import csv
import re 
import os

with open("PlasForest_Summary.csv", mode="w") as result_file:
    result_writer = csv.writer(result_file, delimiter=",")
    result_writer.writerow(["Species","ID","Prediction"])

    location = "/home/guest/Traineeship/Tools/PlasForestFolder/Output_PlasForest"
    os.chdir(location)
    files = os.listdir(location)
    for file in files:
        geno_name = file.replace("_Result.csv","")
        #print(geno_name)
        file_open = open(file, "r")
        next(file_open)
        for line in file_open.readlines():
            id_pred = line.split(",")
            geno_id = id_pred[0]
            geno_pred = id_pred[1]
            #print(geno_id)
            #print(geno_pred)
            result_writer.writerow([geno_name,geno_id,geno_pred])
        file_open.close()

result_file.close()