# CSC4351 Project 1
Dr. Baumgartener

Lexical Analysis Project

Authors: Annabelle Kanchirathingal & James Demaree

Overview:
    
For this project we implemented the features required for a working lexical analyzer for the CTiger language. We mainly utilized the Jlex documentation, Jlex sample code and yylex documentation(https://www.gnu.org/software/bison/manual/html_node/Lexical.html) 

The use of states:
   
   We made the use of 2 different states to handle comments and strings. 
   
   State: COMMENT
       
   When a "/*" is detectected it enters the comment state and updates comment_count, after that it ignores all characters after the "/*" until another "*/" is encountered.
    
   State: STRING
        
   When we get the escape character // we begin the string state, create a new string buffer, and append all following characters to yytext.

Error & end-of-file Handling:
    
    We implemented err statements for if the user tries to input a comment in a comment or input a non ascii character to propperly handle those situations, %endofval checks to       see if there's a comment or string already inputted. We also check to see if the count for strings or comments is negative, if so we have reached the end of the file.
