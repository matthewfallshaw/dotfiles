command! FunctionsToArrowFunctions %s/\v^( *)function *(\w+) *\(([^)]*)\)(:[^=]+)? *\{/\1const \2 = (\3)\4 => {/gc
command! ArrowFunctionsToFunctions %s/\v^( *)const *(\w+) *\= *\(([^)]*)\)(:[^=]+)? *\=\> *\{/\1function \2(\3)\4 {/gc

command! AnonFunctionsToArrowFunctions %s/\vfunction *\(([^)]*)\)(:[^=]+) *\{/(\1)\2 => {/gc
