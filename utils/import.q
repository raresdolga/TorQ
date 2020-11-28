// utilities to load individual files / paths, and also a complete directory
// this should then be enough to bootstrap
loadedf:enlist enlist""
loadf0:{[reload;x]
  if[not[reload]&x in loadedf;:()];
  //TODO: DO we need to check for circular dependency?
  // error if not found
  @[system;"l ",x; {'"failed to load ",x," : ",y}[x]];
  // if we got this far, file is loaded
  loadedf,:enlist x;
 }
loadf:loadf0[0b]   /load a file if it hasn't been loaded
reloadf:loadf0[1b] /load a file even if's been loaded


loaddir:{
	// Check the directory exists
	$[()~files:key hsym `$x; ' "specified directory ",x," doesn't exist";
	// Try to read in a load order file
		[     show "INYTA";
        	$[`order.txt in files:key hsym `$x;
                 	order:(`$read0 `$x,"/order.txt") inter files;
                	order:`symbol$()];
        	files:files where any files like/: ("*.q";"*.k");
        	// rearrange the ordering
        	files:order,files except order;
        	loadf each (x,"/"),/:string files
		]
    ];
  };
