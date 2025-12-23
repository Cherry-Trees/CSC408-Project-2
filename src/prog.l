%{
#include "MyScanner.hpp"
#include "Parser.hpp"
#define YY_DECL int MyScanner::lex(Parser::semantic_type *yylval)


using namespace yy;
  #include <iostream>
using namespace std;

%}

%option c++
%option noyywrap
%option outfile="MyScanner.cpp"

DIGIT   [0-9]
NZDIGIT [1-9]
WSPACE  [\ \t\n]
ALPHA   [a-zA-Z]

%%

%{
   // Keywords.
%}
"void"                       {return Parser::token::VOID_T;}
"int"                        {return Parser::token::INT_T;}
"float"                      {return Parser::token::FLOAT_T;}
"begin"                      {return Parser::token::BEGIN_T;}
"end"                        {return Parser::token::END_T;}
"if"                         {return Parser::token::IF_T;}
"then"                       {return Parser::token::THEN_T;}
"else"                       {return Parser::token::ELSE_T;}
"while"                      {return Parser::token::WHILE_T;}

%{
  // Rules from the given automata. 
%}
{ALPHA}({ALPHA}|{DIGIT})*    {yylval->id = YYText(); return Parser::token::ID_T;}
{NZDIGIT}{DIGIT}*            {return Parser::token::NUM_INT_T;}
"0"                          {return Parser::token::NUM_INT_T;}
{NZDIGIT}{DIGIT}*"."{DIGIT}+ {return Parser::token::NUM_REAL_T;}
"0""."{DIGIT}+               {return Parser::token::NUM_REAL_T;}
"+"                          {return Parser::token::ADDOP_T;}
"-"                          {return Parser::token::ADDOP_T;}
"*"                          {return Parser::token::MULOP_T;}
"/"                          {return Parser::token::MULOP_T;}
">"                          {return Parser::token::RELOP_T;}
">="                         {return Parser::token::RELOP_T;}
"=="                         {return Parser::token::RELOP_T;}
"<"                          {return Parser::token::RELOP_T;}
"<="                         {return Parser::token::RELOP_T;}
"<-"                         {return Parser::token::ASSIGNOP_T;}
"&&"                         {return Parser::token::AND_T;}
"||"                         {return Parser::token::OR_T;}
";"                          {return Parser::token::SEMICOLON_T;}
","                          {return Parser::token::COMMA_T;}
")"                          {return Parser::token::RPAREN_T;}
"("                          {return Parser::token::LPAREN_T;}
"]"                          {return Parser::token::RBRACK_T;}
"["                          {return Parser::token::LBRACK_T;}
"~"                          {return Parser::token::NOT_T;}

%{
  // Comments, whitespace, invalid ID.
%}
"#".*                        {}
{WSPACE}+                    {}
{DIGIT}{ALPHA}*{DIGIT}*      {return Parser::token::ERROR_T;}
.                            {return Parser::token::ERROR_T;}

%{
  // End of file.
%}



%%



