* Encoding: windows-1252.
*SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/1.sav'
  /keep  =id classgrp to grp4o
/COMPRESSED.

*compute classid=trunc(id/100).
*EXECUTE.


*first part 
*download the big sav
*subset it

select if classid=10503.
EXECUTE.

*check if subset is sucessful

frequencies classid.

*for each class, subset it as four dataset
no need to change the 


*you need to change the path according to your own computer

SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/1.sav'
  /keep  =id grpa to grpo
/COMPRESSED.

SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/2.sav'
  /keep  =id grp1a to grp1o
/COMPRESSED.

SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/3.sav'
  /keep  =id grp2a to grp2o
/COMPRESSED.
SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/4.sav'
  /keep  =id grp3a to grp3o
/COMPRESSED.
SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/5.sav'
  /keep  =id grp4a to grp4o
/COMPRESSED.

SAVE OUTFILE='/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/classid.sav'
  /keep  =id
/COMPRESSED.
*close all the dataset, don't save change


*second part
*open datasets without manually clicking

GET 
  FILE='C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/1.sav'. 
DATASET NAME DataSet1 WINDOW=FRONT. 
GET 
  FILE='C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/2.sav'. 
DATASET NAME DataSet2 WINDOW=FRONT. 
GET 
  FILE='C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/3.sav'. 
DATASET NAME DataSet3 WINDOW=FRONT. 
GET 
  FILE='C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/4.sav'. 
DATASET NAME DataSet4 WINDOW=FRONT. 
DATASET ACTIVATE DataSet3. 
GET 
  FILE='C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/5.sav'. 
DATASET NAME DataSet5 WINDOW=FRONT.

*rename 4 dataset so that all the variables has the same name

DATASET ACTIVATE DataSet1.
compute merge=1.
execute.
DATASET ACTIVATE DataSet2.
compute merge=2.
execute.
RENAME VARIABLES (grp1a  grp1b  grp1c  grp1d  grp1e  grp1f  grp1g  grp1h  grp1i  grp1j  grp1k  grp1l  grp1m  grp1n  grp1o  = grpa grpb grpc grpd grpe grpf grpg grph grpi grpj grpk grpl grpm grpn grpo).

DATASET ACTIVATE DataSet3.
compute merge=3.
execute.
RENAME VARIABLES (grp2a   grp2b   grp2c   grp2d   grp2e   grp2f   grp2g   grp2h   grp2i   grp2j   grp2k   grp2l   grp2m   grp2n   grp2o  = grpa grpb grpc grpd grpe grpf grpg grph grpi grpj grpk grpl grpm grpn grpo).

DATASET ACTIVATE DataSet4.
compute merge=4.
execute.
RENAME VARIABLES (grp3a  grp3b  grp3c  grp3d  grp3e  grp3f  grp3g  grp3h  grp3i  grp3j  grp3k  grp3l  grp3m  grp3n  grp3o  = grpa grpb grpc grpd grpe grpf grpg grph grpi grpj grpk grpl grpm grpn grpo).

DATASET ACTIVATE DataSet5.
compute merge=5.
execute.
RENAME VARIABLES (grp4a   grp4b   grp4c   grp4d   grp4e   grp4f   grp4g   grp4h   grp4i   grp4j   grp4k   grp4l   grp4m   grp4n   grp4o  = grpa grpb grpc grpd grpe grpf grpg grph grpi grpj grpk grpl grpm grpn grpo).


DATASET ACTIVATE DataSet1.
ADD FILES /FILE=*
  /FILE='DataSet2'.
EXECUTE.
DATASET ACTIVATE DataSet1.
ADD FILES /FILE=*
  /FILE='DataSet3'.
EXECUTE.
DATASET ACTIVATE DataSet1.
ADD FILES /FILE=*
  /FILE='DataSet4'.
EXECUTE.
DATASET ACTIVATE DataSet1.
ADD FILES /FILE=*
  /FILE='DataSet5'.
EXECUTE.

temporary.
SELECT IF NOT MISSING(grpa).
execute.


*save this dataset into xlsx

SAVE TRANSLATE OUTFILE='C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/class10503.xlsx' 
  /TYPE=XLS 
  /VERSION=12 
  /MAP 
  /REPLACE 
  /FIELDNAMES 
  /CELLS=VALUES. 

SAVE OUTFILE="C:/Users/pkuch/Documents/工作/16organize peer affiliation/W1-10503/class10503.sav".
