//######################## Import dependencies #######################
loadf["C:/Users/Rares/Documents/CodeProjects/kdb/TorQ/code/common/pubsub.q"]

\d .lg

CONFIG: (!) . (`cp`cd`ct`stop`trap`procname;
              ( .z.p;
                .z.d;
                .z.t;
                1b; 0b; `torq
                )
              );

// Set the logging table at the top level
// This is to allow it to be published
@[`.;`logmsg;:;([]time:`timestamp$(); sym:`symbol$(); proctype:`symbol$(); host:`symbol$(); loglevel:`symbol$(); id:`symbol$(); message:())];

// Logging functions live in here

// Format a log message
format:{[loglevel;proctype;proc;id;message] "|"sv string[(CONFIG[`cp];.z.h;proctype;proc;loglevel;id)],enlist(),message}

publish:{[loglevel;proctype;proc;id;message]
 if[0<0^pubmap[loglevel];
   .ps.publish[`logmsg;enlist`time`sym`proctype`host`loglevel`id`message!(CONFIG[`cp];proc;proctype;.z.h;loglevel;id;message)]]}

// Dictionary of log levels mapped to standard out/err
// Set to 0 if you don't want the log type to print
outmap:@[value;`outmap;`ERROR`ERR`INF`WARN!2 2 1 1]
// whether each message type should be published
pubmap:@[value;`pubmap;`ERROR`ERR`INF`WARN!1 1 0 1]

// Log a message
l:{[loglevel;proctype;proc;id;message;dict]
	if[0 < redir:`int$(0w 1 `onelog in key CONFIG)&0^outmap[loglevel];
		neg[redir] format[loglevel;proctype;proc;id;message]];
	ext[loglevel;proctype;proc;id;message;dict];
	publish[loglevel;proctype;proc;id;message];
	}

// Log an error.
// If trap mode is set to false, exit
err:{[loglevel;proctype;proc;id;message;dict]
        l[loglevel;proctype;proc;id;message;dict];
        if[CONFIG[`stop];'message];
        if[not CONFIG[`trap]; exit 3];
	}

// log out and log err
// The process name is temporary which we will reset later - once we know what type of process this is
o:l[`INF;CONFIG[`procname];`$"_" sv string (.z.f;.z.i;system"p");;;()!()]
e:err[`ERR;CONFIG[`procname];`$"_" sv string (.z.f;.z.i;system"p");;;()!()]
w:l[`WARN;CONFIG[`procname];`$"_" sv string (.z.f;.z.i;system"p");;;()!()]

// Hook to handle extended logging functionality
// Leave blank
ext:{[loglevel;proctype;proc;id;message;dict]}

\d .
