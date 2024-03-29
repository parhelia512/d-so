module utilities;
import opcodes;
import std.algorithm;
import std.string;
import std.stdio;
string string_op(char inchar) {
	switch(inchar) {
		case '\n':
			return "NL";
		case '\t':
			return "TAB";
		case ' ':
			return "SPC";

		default:
			return "";
	}
}

string invertOperator(string op) {
	if(op.canFind(" != ")) {
		return op.replace("!=", "==");
	}
	if(op.canFind(" == ")) {
		return op.replace("==", "!=");
	}
	else if(op.canFind(" !$= ")) {
		return op.replace("!$=", "$=");
	}
	else if(op.canFind(" $= ")) {
		//curFile.writeln("ASS");
		return op.replace("$=", "!$=");
	}
	else if(op.canFind("!")) {
	//	curFile.writeln("let me");
		return op[1..op.length];
	}
	else if(!op.canFind("!")) {
		//curFile.writeln("stupid ass");
		return "!" ~ op;
	}
	//else if(op.canFind(" ")) {
	//	curFile.writeln("AAS");
	//	return "!(" ~ op ~ ")";
	//}
	//curFile.writeln("ASSS");
	return op;
}
string constructPrettyFunction(string fnName, string fnNamespace, string[] argv, CallTypes callType = CallTypes.FunctionCall) {
	string retVal = "";
	int i = 0;

	if(callType == CallTypes.ObjectCall) {
		if(argv[0].canFind(" ")) {
			retVal ~= "(" ~ argv[0] ~ ").";
		}
		else {
			retVal ~= argv[0] ~ ".";
		}
		//i = 1;
		if(argv.length != 1) {
			argv = argv[1..argv.length];
		}
		else {
			argv = [];
		}
	}
	if(fnNamespace != "") {
		retVal ~= fnNamespace ~ "::" ~ fnName;
	}
	else {
		retVal ~= fnName;
	}
	retVal ~= "(";
		if(argv.length == 1) {
			retVal ~= argv[0];
		}
		else {
			for(; i < argv.length; i++) {
				retVal ~= argv[i];
				if(i != argv.length - 1)
				{
					retVal ~= ", ";
				}
			}
		}

	retVal ~= ")";
	return retVal;
}

string popOffStack(ref string[] instack) {
	string ret;
	if(instack.length == 1) {
		ret = instack[0];
		instack = [];
	}
	else {
		ret = instack[instack.length - 1];
		instack = instack.remove(instack.length - 1);
	}
	return ret;
}

string getComparison(opcode oc) {
	switch(oc) {
		case opcode.OP_CMPEQ: {
			return "==";
		}
		case opcode.OP_CMPGE: {
			return ">=";
		}
		case opcode.OP_CMPNE: {
			return "!=";
		}
		case opcode.OP_CMPGR: {
			return ">";
		}
		case opcode.OP_CMPLT: {
			return "<";
		}
		case opcode.OP_CMPLE: {
			return "<=";
		}
		default: {
			return "";
		}
 	}
}




string addTabulation(string previous, int indentation_level) {
	string retVal = "";
	for(int l = 0; l < indentation_level; l++) {
		retVal ~= "\t";
	}
	retVal ~= previous;
	return retVal;
}
