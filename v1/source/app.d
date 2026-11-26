

import matica.shape;
import std.stdio;


void main(){

    auto p = new Rectangle(5.0, 3.0);
    writeln(p.name);
    writeln(p.type);

    auto q = new Triangle(3.0, 4.0, 5.0);
    writeln(q.name);
    writeln(q.type);

    auto r = new Sphere(2.0);
    writeln(r.name);
    writeln(r.type);
}


