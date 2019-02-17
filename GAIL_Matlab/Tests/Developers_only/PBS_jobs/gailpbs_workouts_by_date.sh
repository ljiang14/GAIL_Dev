#!/bin/sh
# calls workouts with a particular version of matlab depending on the date today

N=5
dt=$(date +\%d)
dt_modN=$(($dt%N))

if [ $dt_modN == 0 ]
then
  matlabVer_1="R2014a"
  matlabVer_2="R2014b"
elif [ $dt_modN == 1 ]
then
  matlabVer_1="R2015a"
  matlabVer_2="R2015b"
elif [ $dt_modN == 2 ]
then
  matlabVer_1="R2016a"
  matlabVer_2="R2016b"
elif [ $dt_modN == 3 ]
then
  matlabVer_1="R2017a"
  matlabVer_2="R2017b"
else
  matlabVer_1="R2018a"
  matlabVer_2="R2018b"
fi

echo "date" $dt_modN "matlab version" $matlabVer

# call the workouts
sh /home/gail/GAIL_tests/PBS_jobs/gailpbs_workouts_report.sh $matlabVer_1

if [ -z "$matlabVer_2" ]
then
  echo "\$matlabVer_2 is empty"
else
  sh /home/gail/GAIL_tests/PBS_jobs/gailpbs_workouts_report.sh $matlabVer_2
fi
