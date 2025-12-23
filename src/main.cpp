#include <iostream>
#include <fstream>

#include <FlexLexer.h>

#include "MyScanner.hpp"
#include "Parser.hpp"

using namespace yy;
using namespace std;

int yyFlexLexer::yylex() {
    // this call should never happen, but flex/bison requires its implementation
    throw std::runtime_error("Bad call to yyFlexLexer::yylex()");
}

int main(int argc, char *argv[]) {
  if (argc == 2) {
    ifstream in;
    in.open(argv[1]);
    MyScanner scanner( in, cerr );
    Parser parser( &scanner );
    parser.parse();
    in.close();
  }
  else if (argc == 1) {  
    MyScanner scanner( cin, cerr );
    Parser parser( &scanner );
    parser.parse();
  }
}
