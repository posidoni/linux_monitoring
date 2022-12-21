# Linux Monitoring v1.0

Linux basic bash scripting and system research.

## 01. Warm-up

Write a bash script. The script is run with one parameter. It is a text parameter.  
The script outputs the value of the parameter.  
If the parameter is a number, the script must output an invalid input message.

## 02. System research

Write a bash script. The script should output the following information:

**HOSTNAME** = _network name_  
**TIMEZONE** = _time zone as: **America/New_York UTC -5** (time zone must be taken from the system and be correct for the current location)_  
**USER** = _current user who ran the script_  
**OS** = _type and version of operating system_  
**DATE** = _current time as: **12 May 2020 12:24:36**_  
**UPTIME** = _system uptime_  
**UPTIME_SEC** = _system uptime in seconds_  
**IP** = _ip address of the machine on any of the network interfaces  
**MASK** = _network mask of any of the network interfaces as: **xxx.xxx.xxx.xxx**_.  
**GATEWAY** = _default gateway ip_  
**RAM_TOTAL** = _main memory size in GB with an accuracy of three decimal places as: **3.125 GB**_  
**RAM_USED** = _used memory size in GB with an accuracy of three decimal places_  
**RAM_FREE** = _free memory size in GB, with an accuracy of three decimal places_  
**SPACE_ROOT** = _root partition size in MB, with an accuracy of two decimal places, as **254.25 MB**_  
**SPACE_ROOT_USED** = _size of used space of the root partition in MB, with an accuracy of two decimal places_  
**SPACE_ROOT_FREE** = _size of free space of the root partition in MB, with an accuracy of two decimal places_

After outputting the values, suggest writing the data to a file (ask the user to answer **Y/N**).  
Responses **Y** and **y** are considered positive, all others - negative.

If the user agrees, create a file in the current directory containing the information that had been outputted.
The file name must looks like: **DD_MM_YY_HH_MM_SS.status** (The time in the file name must indicate when the data was saved).

## 03. Visual output design for the system research script

Write a bash script. Use the script from **Part 2** and remove the part where the data is saved to a file.  The script is run with 4 parameters. The parameters are numeric. From 1 to 6, for example:  
`script03.sh 1 3 4 5`

Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)

**Parameter 1** is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)  
**Parameter 2** is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)  
**Parameter 3** is the background of the values (after the '=' sign)  
**Parameter 4** is the font colour of the values (after the '=' sign)

The font and background colours of one column must not match.  
If matching values are entered, there must be a message describing the problem and offering to call the script again.
After the message output, the program should exit correctly.

## 04. Configuring visual output design for the system research script

Write a bash script. Use the script from **Part 3**. The colour designations are similar. The script runs without parameters. The parameters are set in the configuration file before the script is running.

This is how the configuration file must look like:
```
column1_background=2
column1_font_color=4
column2_background=5
column2_font_color=1
```

If one or more parameters are not set in the configuration file, the colour must be substituted from the default colour scheme. (Choice is at the developer's discretion).


After the system information output from **Part 3**, you should output the colour scheme by indenting one empty line as follows:
```
Column 1 background = 2 (red)
Column 1 font color = 4 (blue)
Column 2 background = 5 (purple)
Column 2 font color = 1 (white)
```

When running the script with the default colour scheme, the output should look like this:
```
Column 1 background = default (black)
Column 1 font color = default (white)
Column 2 background = default (red)
Column 2 font color = default (blue)
```

## 05. File system research

Write a bash script. The script is run with a single parameter.  
The parameter is an absolute or relative path to a directory. The parameter must end with '/', for example:  
`script05.sh /var/log/`

The script must output the following information about the directory specified in the parameter:
- Total number of folders, including subfolders
- Top 5 folders with largest size in descending order (path and size)
- Total number of files
- Number of configuration files (with .conf extension), text files, executable files, log files (files with .log extension), archives, symbolic links
- Top 10 files with largest size in descending order (path, size and type)
- Top 10 executable files with largest size in descending order (path, size and hash)
- Execution time of the script

The script should output the following information:

```
Total number of folders (including all nested ones) = 6  
TOP 5 folders of maximum size arranged in descending order (path and size):  
1 - /var/log/one/, 100 GB  
2 - /var/log/two/, 100 MB  
etc up to 5
Total number of files = 30
Number of:  
Configuration files (with the .conf extension) = 1 
Text files = 10  
Executable files = 5
Log files (with the extension .log) = 2  
Archive files = 3  
Symbolic links = 4  
TOP 10 files of maximum size arranged in descending order (path, size and type):  
1 - /var/log/one/one.exe, 10 GB, exe  
2 - /var/log/two/two.log, 10 MB, log  
etc up to 10  
TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)  
1 - /var/log/one/one.exe, 10 GB, 3abb17b66815bc7946cefe727737d295  
2 - /var/log/two/two.exe, 9 MB, 53c8fdfcbb60cf8e1a1ee90601cc8fe2  
etc up to 10  
Script execution time (in seconds) = 1.5
```
