#Requires AutoHotkey v2.0

#Include g:\AHK\git-ahk-lib\util\config\CustomFS.ahk

GetAlias(key) => CustomFS.Of('./cfg/alias.txt').Get(key)

/* 
# example
~_t :echo hello $_$
*/