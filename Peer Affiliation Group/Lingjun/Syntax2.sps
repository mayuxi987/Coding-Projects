* Encoding: windows-1252.
DATASET ACTIVATE DataSet1. 
SORT CASES BY id (A).

DATASET ACTIVATE DataSet2.
SORT CASES BY id (A).

MATCH FILES /FILE=*
  /FILE='DataSet1'
  /BY id.
EXECUTE.

recode  nominat  (sysmis=0)(1thr hi=1) into group.
execute. 
compute groupid=(trunc(id/100))*100+grpid1.
execute.


