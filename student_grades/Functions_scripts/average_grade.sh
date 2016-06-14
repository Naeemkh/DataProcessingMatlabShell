#!/bin/sh
# This function call the MATLAB script to take the average of students grades.
# results will be at the output files folder
# go in to the first variable after the ./xx.sh command.

# In this case is ../Input files.


cd $1

for i in $(ls *.txt)
do

current_path=`pwd`
script_path=`echo $current_path| sed -e 's/Input_files/Functions_scripts/g'`
cat $i > ../Output_files/temp_grade_file.txt
matlab -nodisplay -nosplash -r "try,run $script_path/matlab_st_grade,catch,end,quit"
status_mode=`cat ../Output_files/temp_status_file.txt |awk '{print $1}'`

case $status_mode in
0) status_report=`echo Processed successfully.`;;
1) status_report=`echo Unable to load.`;;
2) status_report=`echo There is at least one grade greater than 4.`;;
3) status_report=`echo There is at least one negative grade.`;;
5) status_report=`echo There are out of range grades.`;;
esac

if (( $status_mode > 0 )); then
echo 'File ' $i $status_report >> ../Log_files/grade_run_status.txt
else
echo 'File ' $i $status_report >> ../Log_files/grade_run_status.txt
number_of_grades=`cat ../Output_files/temp_grade_mat.txt | awk '{print $1}'`
average=`cat ../Output_files/temp_grade_mat.txt | awk '{print $2}'`
echo $i 'Number of grades:' $number_of_grades 'Average score:' $average >> ../Output_files/Final_grade.txt
fi

done
rm ../Output_files/temp*

# -----------------------------------------------------
# ------- run summary file ----------------------------

date_t=`date`
user="$USER"
echo $user 'ran the program on' $date_t >> ../Log_files/run_summary.txt
