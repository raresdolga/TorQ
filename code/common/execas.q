loadf["C:/Users/Rares/Documents/CodeProjects/kdb/TorQ/code/handlers/permissions.q"];
\d .pm

execas:{[f;u]
 $[`.pm.requ ~ key `.pm.requ;.pm.requ[u;f]; value f]}
