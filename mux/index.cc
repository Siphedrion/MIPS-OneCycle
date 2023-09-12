#include <iostream>
#include <cstdlib>

using std::cout;
using std::endl;

int main(int argc, char* argv[]){
  unsigned sel_num = std::atoi(argv[1]);
  unsigned a, b, sel, f;
  for (unsigned i = 0; i < sel_num;  i++)
    for (unsigned j = 0; j < (1 << i); j++){
      a = (1<<(i+1)) + 2*j - 1;
      b = (1<<(i+1)) + 2*j;
      sel = sel_num - i - 1;
      f = (1<<i) + j - 1;
      cout << "mux: "      << f   << '\n'
           << "port a: "   << a   << ' '
           << "port b: "   << b   << ' '
           << "port sel: " << sel << ' '
           << "port f: "   << f   << endl;
    }
  return 0;
}