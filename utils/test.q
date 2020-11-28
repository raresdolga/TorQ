
a:1;
b:2;
show a;
show b;
\l utils/import.q
loadf["utils/logging.q"];
loadf["utils/test2.q"]
show "THE file was loaded successfully";
main:{
  .lg.w[`globalFunction; "a test message from a test file"];
 };
