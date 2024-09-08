#Requires AutoHotkey v2.0

GetAlias(key) => MeowConf.Of('./cfg/alias.txt').Get(key)

/* 
# example
~_t :echo hello $_$
*/