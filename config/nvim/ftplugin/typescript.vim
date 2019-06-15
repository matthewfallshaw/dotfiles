command! FunctionsToArrowFunctions %s/\v^( *)function *(\w+) *\(([^)]*)\) *\{/\1const \2 = (\3) => {/gc
command! AnonFunctionsToArrowFunctions %s/\vfunction *\(([^)]*)\) *\{/(\1) => {/gc
