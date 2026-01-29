# Day 06 – Linux File Read & Write Practice

## Files Created
- notes.txt

## Commands Used

- ```touch notes.txt```  
  Created an empty text file.

- ```echo "This is Day-6 of traning linux fundamentals." > notes.txt```  
  Wrote the first line using redirection.

- ```echo "Task-6 is to create a note.txt file and print it in the notes.txt and the next process is to overwite this line in the second." >> notes.txt```
  Appended the second line.

- ```echo "Thank you, see you in Day-7." | tee -a notes.txt``` 
  Displayed and appended text at the same time.

- ```cat notes.txt```  
  Displayed the full file content.

- ```head -n 2 notes.txt```  
  Displayed the first two lines.

- ```tail -n 2 notes.txt```  
  Displayed the last two lines.

## Key Learning
Redirection and file reading commands are essential for handling logs and configuration files in DevOps.

