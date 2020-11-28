CONFIG: (!) . (`cp`cd`ct`stop;
              (
                .z.P;
                .z.D;
                .z.T;
                1b
                )
              );

\d .ps

u:all `pub`sub`init in key `.u
reloadf["utils/logging.q"]
publish:$[u;.u.pub; {[tab;data] show "intra"}]
subscribe:$[u;.u.sub;{[tab;syms]}]
init:$[u;.u.init;{[]}]
initialise:{.ps.init[];}
