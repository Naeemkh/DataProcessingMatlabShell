%% Load data
% Load the input file
path1=pwd;
path2 = strrep(path1,'Functions_scripts','Output_files');
file1='/temp_grade_file.txt';
cfile1 = [path2 file1];
try
    student_grade = load(cfile1);
    student_grade = student_grade(:);
    status_temp = 0;
catch
    status_temp = 1;
end
if status_temp == 0
    % control for numbers bigger than 4.
    if any(student_grade >4) == 1
        status_temp = 2;
    end
    % control for negative numbers.
    if any(student_grade < 0) == 1
        status_temp = status_temp + 3;
    end
end
% Write the results into a file.
status_file_name = sprintf('%s%s',path2,'/temp_status_file.txt');
file_id = fopen(status_file_name,'w');
fprintf(file_id,'%d',status_temp);
fclose(file_id);

if status_temp ~= 0
    break;
end
%% Process data
size_data = size(student_grade,1);
sum_data = sum(student_grade);
av_data = sum_data ./ size_data;
grade_mat = [size_data av_data];
%% Save the results
%write the results in to the file.
path2 = strrep(path1,'/Functions_scripts','/Output_files');
file2 ='/temp_grade_mat.txt';
cfile2 = [path2 file2];
file_id_2 = fopen(cfile2,'w');
fprintf(file_id_2,'%d\t%2.3f',grade_mat(1,1),grade_mat(1,2));
fclose(file_id_2);