
import line:Line;

import std.stdio;

void main(){
	auto myline = Line(0,12,6);

	writefln("Current: %s", myline);
	writefln("Front: %s", myline[0]);
	writefln("Front: %s", myline[1]);

}