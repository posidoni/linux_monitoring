#!/bin/bash

awk -F ":" # - we are able to specify field separators

awk '                     ##Starting awk program from here.
prev!=file{               ##Checking condition if prev is NOT equal to file variable then do following.
  close(prev)             ##Closing output file, to avoid too many files opened in back-end by mentioning close(prev) command here.
}                         ##Closing condition prev!=file here.
/name:/{                  ##Checking condition if line has string name: in it then do following.
  file=$NF".yaml"         ##Creating variable named file whose value is $NF(last field of current line) .yaml
}                         ##Closing name: condition here.
file!="" && !/^--/{       ##Checking condition if variable file is NOT NULL AND line is NOT starting with dash then do following.
  print > (file)          ##Printing current line into output file whose name is there in file variable.
  prev=file               ##Setting prev variable whose value is variable file here.
}                         ##Closing BLOCK for file!="" && !/^--/ condition here.
'  /dev/null              ##Mentioning Input_file name here.
