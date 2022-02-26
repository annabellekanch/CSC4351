package Parse;
import ErrorMsg.ErrorMsg;

%% 

%implements Lexer
%function nextToken
%type java_cup.runtime.Symbol
%char
%state COMMENT
%state STRING
%state IGNORE
%state ESCCHAR

%{

private int comments = 0;
private int strings = 0;
private int comment_count = 0;
private StringBuffer buffer;

private void newline() {
  errorMsg.newline(yychar);
}

private void err(int pos, String s) {
  errorMsg.error(pos,s);
}

private void err(String s) {
  err(yychar,s);
}

private java_cup.runtime.Symbol tok(int kind) {
    return tok(kind, null);
}

private java_cup.runtime.Symbol tok(int kind, Object value) {
    return new java_cup.runtime.Symbol(kind, yychar, yychar+yylength(), value);
}

private ErrorMsg errorMsg;

Yylex(java.io.InputStream s, ErrorMsg e) {
  this(s);
  errorMsg=e;
}

%}

%eofval{
	{
    if(comments != 0)
    {
      err("COMMENT ERROR");
    }
    if(strings != 0)
    {
      err("STRING ERROR");
    }
    return tok(sym.EOF, null);
  }
%eofval}       


%%
<YYINITIAL> " "	{}
<YYINITIAL> \n	{newline();}
<YYINITIAL> ","	{return tok(sym.COMMA, null);}

<YYINITIAL> "while" {return tok(sym.WHILE, null);}
<YYINITIAL> "for" {return tok(sym.FOR, null);}
<YYINITIAL> "to" {return tok(sym.TO, null);}
<YYINITIAL> "break" {return tok(sym.BREAK, null);}
<YYINITIAL> "let" {return tok(sym.LET, null);}
<YYINITIAL> "in" {return tok(sym.IN, null);}
<YYINITIAL> "end" {return tok(sym.END, null);}
<YYINITIAL> "function" {return tok(sym.FUNCTION, null);}
<YYINITIAL> "var" {return tok(sym.VAR, null);}
<YYINITIAL> "type" {return tok(sym.TYPE, null);}
<YYINITIAL> "array" {return tok(sym.ARRAY, null);}
<YYINITIAL> "if" {return tok(sym.IF, null);}
<YYINITIAL> "then" {return tok(sym.THEN, null);}
<YYINITIAL> "else" {return tok(sym.ELSE, null);}
<YYINITIAL> "do" {return tok(sym.DO, null);}
<YYINITIAL> "of" {return tok(sym.OF, null);}
<YYINITIAL> "nil" {return tok(sym.NIL, null);}

<YYINITIAL> "," {return tok(sym.COMMA, null);}
<YYINITIAL> ":" {return tok(sym.COLON, null);}
<YYINITIAL> ";" {return tok(sym.SEMICOLON, null);}
<YYINITIAL> "." {return tok(sym.DOT, null);}

<YYINITIAL> "(" {return tok(sym.LPAREN, null);}
<YYINITIAL> ")" {return tok(sym.RPAREN, null);}
<YYINITIAL> "[" {return tok(sym.LBRACK, null);}
<YYINITIAL> "]" {return tok(sym.RBRACK, null);}
<YYINITIAL> "{" {return tok(sym.LBRACE, null);}
<YYINITIAL> "}" {return tok(sym.RBRACE, null);}

<YYINITIAL> "+" {return tok(sym.PLUS, null);}
<YYINITIAL> "-" {return tok(sym.MINUS, null);}
<YYINITIAL> "*" {return tok(sym.TIMES, null);}
<YYINITIAL> "/" {return tok(sym.DIVIDE, null);}

<YYINITIAL> "=" {return tok(sym.EQ, null);}
<YYINITIAL> "<>" {return tok(sym.NEQ, null);}
<YYINITIAL> "<" {return tok(sym.LT, null);}
<YYINITIAL> "<=" {return tok(sym.LE, null);}
<YYINITIAL> ">" {return tok(sym.GT, null);}
<YYINITIAL> ">=" {return tok(sym.GE, null);}

<YYINITIAL> "&" {return tok(sym.AND, null);}
<YYINITIAL> "|" {return tok(sym.OR, null);}
<YYINITIAL> ":=" {return tok(sym.ASSIGN, null);}

<YYINITIAL> [0-9]+ {return tok(sym.INT, new Integer(yytext()));}
<YYINITIAL> [a-zA-Z][a-zA-Z0-9]* {return tok(sym.ID, yytext());}

<YYINITIAL> \" 
{
  yybegin(STRING);
  buffer = new StringBuffer();
  strings = yychar;
}

<STRING> [^\\\"] {buffer.append(yytext());}





<YYINITIAL> "/*" {comment_count++; yybegin(COMMENT);}
<COMMENT> "/*" {comment_count++;}
<COMMENT> [\n\r]+ {}
<COMMENT> "*/" {if (--comment_count == 0) {yybegin(YYINITIAL); }}
<COMMENT> . {}

<ESCCHAR> [" "|\t|\f]+ {}
<ESCCHAR> \\ {yybegin(STRING);}

<YYINITIAL, COMMENT> . {err("Illegal character: " + yytext());}

