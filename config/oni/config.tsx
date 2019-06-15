import * as React from "react"
import * as Oni from "oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")
    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))
    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")
}
export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}
export const configuration = {
    "editor.fontLigatures" : true,
    "editor.fontSize"      : "12px",
    "editor.fontWeight"    : "normal",
    "editor.fontFamily"    : "FuraCodeNerdFontComplete-Retina",

    // UI customizations
    "ui.colorscheme"        : "nord",
    "ui.animations.enabled" : true,
    "ui.fontSmoothing"      : "auto",

    "autoUpdate.enabled": true,

    "environment.additionalPaths": [
        "/usr/bin",
        "/usr/local/bin"
    ],
    "environment.additionalVariables": {
        "LANG": "en_us.UTF-8"
    },




    // "browser.defaultUrl": "https://google.com",
    // "configuration.editor": "typescript",
    // "configuration.showReferenceBuffer": true,
    // "debug.fixedSize": null,
    // "debug.neovimPath": null,
    // "debug.persistOnNeovimExit": false,
    // "debug.detailedSessionLogging": false,
    // "debug.showTypingPrediction": false,
    // "debug.showNotificationOnError": false,
    // "debug.fakeLag.languageServer": null,
    // "debug.fakeLag.neovimInput": null,
    // "wildmenu.mode": true,
    // "commandline.mode": true,
    // "commandline.icons": true,

    // "experimental.preview.enabled": false,
    // "experimental.welcome.enabled": false,
    // "experimental.particles.enabled": false,
    // "experimental.sessions.enabled": false,
    // "experimental.sessions.directory": null,
    // "experimental.vcs.sidebar": false,
    // "experimental.vcs.blame.enabled": false,
    // "experimental.vcs.blame.mode": "auto",
    // "experimental.vcs.blame.timeout": 800,
    // "experimental.colorHighlight.enabled": false,
    // "experimental.colorHighlight.filetypes": [
    //     ".css",
    //     ".js",
    //     ".jsx",
    //     ".tsx",
    //     ".ts",
    //     ".re",
    //     ".sass",
    //     ".scss",
    //     ".less",
    //     ".pcss",
    //     ".sss",
    //     ".stylus",
    //     ".xml",
    //     ".svg"
    // ],
    // "experimental.indentLines.enabled": false,
    // "experimental.indentLines.color": null,
    // "experimental.indentLines.skipFirst": false,
    // "experimental.indentLines.bannedFiletypes": [],
    // "experimental.markdownPreview.enabled": false,
    // "experimental.markdownPreview.autoScroll": true,
    // "experimental.markdownPreview.syntaxHighlights": true,
    // "experimental.markdownPreview.syntaxTheme": "atom-one-dark",
    // "experimental.neovim.transport": "stdio",

    // "editor.maxLinesForLanguageServices": 2500,
    // "editor.textMateHighlighting.enabled": false,
    // "autoClosingPairs.enabled": false,
    // "autoClosingPairs.default": [
    //     {
    //         "open": "{",
    //         "close": "}"
    //     },
    //     {
    //         "open": "[",
    //         "close": "]"
    //     },
    //     {
    //         "open": "(",
    //         "close": ")"
    //     }
    // ],
    // "oni.audio.bellUrl": null,
    // "oni.useDefaultConfig": false,
    // "oni.enhancedSyntaxHighlighting": false,
    // "oni.loadInitVim": false,
    // "oni.hideMenu": false,
    // "oni.exclude": [
    //     "node_modules",
    //     ".git"
    // ],
    // "oni.bookmarks": [],
    // "editor.renderer": "canvas",
    // "editor.backgroundOpacity": 1,
    // "editor.backgroundImageUrl": null,
    // "editor.backgroundImageSize": "cover",
    // "editor.clipboard.enabled": true,
    // "editor.clipboard.synchronizeYank": true,
    // "editor.clipboard.synchronizeDelete": false,
    // "editor.definition.enabled": true,
    // "editor.quickInfo.enabled": true,
    // "editor.quickInfo.delay": 500,
    // "editor.completions.mode": "oni",
    // "editor.errors.slideOnFocus": true,
    // "editor.formatting.formatOnSwitchToNormalMode": false,
    // "editor.linePadding": 2,
    // "editor.quickOpen.filterStrategy": "vscode",
    // "editor.quickOpen.defaultOpenMode": 0,
    // "editor.quickOpen.alternativeOpenMode": 4,
    // "editor.quickOpen.showHidden": true,
    // "quickOpen.defaultOpenMode": 0,
    // "editor.split.mode": "native",
    // "editor.typingPrediction": true,
    // "editor.scrollBar.visible": true,
    // "editor.scrollBar.cursorTick.visible": true,
    // "editor.fullScreenOnStart": false,
    // "editor.maximizeScreenOnStart": false,
    // "editor.cursorLine": true,
    // "editor.cursorLineOpacity": 0.1,
    // "editor.cursorColumn": false,
    // "editor.cursorColumnOpacity": 0.1,
    // "editor.tokenColors": [],
    // "editor.imageLayerExtensions": [
    //     ".gif",
    //     ".jpg",
    //     ".jpeg",
    //     ".bmp",
    //     ".png"
    // ],
    // "explorer.persistDeletedFiles": true,
    // "explorer.maxUndoFileSizeInBytes": 500000,
    // "keyDisplayer.showInInsertMode": false,

    // // Language Servers
    // "language.html.languageServer.command": "/Applications/Oni.app/Contents/Resources/app/node_modules/vscode-html-languageserver-bin/htmlServerMain.js",
    // "language.html.languageServer.arguments": [
    //     "--stdio"
    // ],

    // "language.go.languageServer.command": "go-langserver",
    // "language.go.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/go/syntaxes/go.json",

    // "language.vue.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/vue/syntaxes/vue.json",

    // "language.python.languageServer.command": "pyls",

    // "language.cpp.languageServer.command": "clangd",

    // "language.c.languageServer.command": "clangd",

    // "language.css.languageServer.command": "/Applications/Oni.app/Contents/Resources/app/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
    // "language.css.languageServer.arguments": [
    //     "--stdio"
    // ],
    // "language.css.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/css/syntaxes/css.tmLanguage.json",
    // "language.css.tokenRegex": "[$_a-zA-Z0-9-]",

    // "language.elixir.textMateGrammar": {
    //     ".ex": "/Applications/Oni.app/Contents/Resources/app/extensions/elixir/syntaxes/elixir.tmLanguage.json",
    //     ".exs": "/Applications/Oni.app/Contents/Resources/app/extensions/elixir/syntaxes/elixir.tmLanguage.json",
    //     ".eex": "/Applications/Oni.app/Contents/Resources/app/extensions/elixir/syntaxes/eex.tmLanguage.json",
    //     ".html.eex": "/Applications/Oni.app/Contents/Resources/app/extensions/elixir/syntaxes/html(eex).tmLanguage.json"
    // },

    // "language.less.languageServer.command": "/Applications/Oni.app/Contents/Resources/app/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
    // "language.less.languageServer.arguments": [
    //     "--stdio"
    // ],
    // "language.less.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/less/syntaxes/less.tmLanguage.json",
    // "language.less.tokenRegex": "[$_a-zA-Z0-9-]",

    // "language.scss.languageServer.command": "/Applications/Oni.app/Contents/Resources/app/node_modules/vscode-css-languageserver-bin/cssServerMain.js",
    // "language.scss.languageServer.arguments": [
    //     "--stdio"
    // ],
    // "language.scss.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/scss/syntaxes/scss.json",
    // "language.scss.tokenRegex": "[$_a-zA-Z0-9-]",

    // "language.reason.languageServer.command": "/Applications/Oni.app/Contents/Resources/app/node_modules/ocaml-language-server/bin/server/index.js",
    // "language.reason.languageServer.arguments": [
    //     "--stdio"
    // ],
    // "language.reason.languageServer.rootFiles": [
    //     ".merlin",
    //     "bsconfig.json"
    // ],
    // "language.reason.languageServer.configuration": {
    //     "reason": {
    //         "codelens": {
    //             "enabled": true,
    //             "unicode": true
    //         },
    //         "bsb": {
    //             "enabled": true
    //         },
    //         "debounce": {
    //             "linter": 500
    //         },
    //         "diagnostics": {
    //             "tools": [
    //                 "bsb",
    //                 "merlin"
    //             ]
    //         },
    //         "path": {
    //             "bsb": "bsb",
    //             "ocamlfind": "ocamlfind",
    //             "ocamlmerlin": "ocamlmerlin",
    //             "opam": "opam",
    //             "rebuild": "rebuild",
    //             "refmt": "refmt",
    //             "refmterr": "refmterr",
    //             "rtop": "rtop"
    //         }
    //     }
    // },
    // "language.reason.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/reason/syntaxes/reason.json",

    // "language.ocaml.languageServer.command": "/Applications/Oni.app/Contents/Resources/app/node_modules/ocaml-language-server/bin/server/index.js",
    // "language.ocaml.languageServer.arguments": [
    //     "--stdio"
    // ],
    // "language.ocaml.languageServer.configuration": {
    //     "reason": {
    //         "codelens": {
    //             "enabled": true,
    //             "unicode": true
    //         },
    //         "bsb": {
    //             "enabled": true
    //         },
    //         "debounce": {
    //             "linter": 500
    //         },
    //         "diagnostics": {
    //             "tools": [
    //                 "bsb",
    //                 "merlin"
    //             ]
    //         },
    //         "path": {
    //             "bsb": "bsb",
    //             "ocamlfind": "ocamlfind",
    //             "ocamlmerlin": "ocamlmerlin",
    //             "opam": "opam",
    //             "rebuild": "rebuild",
    //             "refmt": "refmt",
    //             "refmterr": "refmterr",
    //             "rtop": "rtop"
    //         }
    //     }
    // },

    // "language.haskell.languageServer.command": "stack",
    // "language.haskell.languageServer.arguments": [
    //     "exec",
    //     "--",
    //     "hie",
    //     "--lsp"
    // ],
    // "language.haskell.languageServer.rootFiles": [
    //     ".git"
    // ],
    // "language.haskell.languageServer.configuration": {},

    // "language.typescript.completionTriggerCharacters": [
    //     ".",
    //     "/",
    //     "\\"
    // ],
    // "language.typescript.textMateGrammar": {
    //     ".ts": "/Applications/Oni.app/Contents/Resources/app/extensions/typescript/syntaxes/TypeScript.tmLanguage.json",
    //     ".tsx": "/Applications/Oni.app/Contents/Resources/app/extensions/typescript/syntaxes/TypeScriptReact.tmLanguage.json"
    // },

    // "language.lua.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/lua/syntaxes/lua.tmLanguage.json",

    // "language.clojure.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/clojure/syntaxes/clojure.tmLanguage.json",

    // "language.ruby.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/ruby/syntaxes/ruby.tmLanguage.json",

    // "language.swift.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/swift/syntaxes/swift.tmLanguage.json",

    // "language.rust.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/rust/syntaxes/rust.tmLanguage.json",

    // "language.php.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/php/syntaxes/php.tmLanguage.json",

    // "language.objc.textMateGrammar": {
    //     ".m": "/Applications/Oni.app/Contents/Resources/app/extensions/objective-c/syntaxes/objective-c.tmLanguage.json",
    //     ".h": "/Applications/Oni.app/Contents/Resources/app/extensions/objective-c/syntaxes/objective-c.tmLanguage.json"
    // },
    // "language.objcpp.textMateGrammar": {
    //     ".mm": "/Applications/Oni.app/Contents/Resources/app/extensions/objective-c++/syntaxes/objective-c++.tmLanguage.json"
    // },

    // "language.python.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/python/syntaxes/python.tmLanguage.json",
    // "language.sh.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",

    // "language.zsh.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/shell/syntaxes/shell.tmLanguage.json",

    // "language.markdown.textMateGrammar": {
    //     ".md": "/Applications/Oni.app/Contents/Resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    //     ".markdown": "/Applications/Oni.app/Contents/Resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    //     ".mkd": "/Applications/Oni.app/Contents/Resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json",
    //     ".mdown": "/Applications/Oni.app/Contents/Resources/app/extensions/markdown/syntaxes/markdown.tmLanguage.json"
    // },

    // "language.java.textMateGrammar": {
    //     ".java": "/Applications/Oni.app/Contents/Resources/app/extensions/java/syntaxes/Java.tmLanguage.json",
    //     ".jar": "/Applications/Oni.app/Contents/Resources/app/extensions/java/syntaxes/Java.tmLanguage.json"
    // },

    // "language.cs.textMateGrammar": "/Applications/Oni.app/Contents/Resources/app/extensions/csharp/syntaxes/csharp.tmLanguage.json",
    // "language.javascript.completionTriggerCharacters": [
    //     ".",
    //     "/",
    //     "\\"
    // ],

    // "language.javascript.textMateGrammar": {
    //     ".js": "/Applications/Oni.app/Contents/Resources/app/extensions/javascript/syntaxes/JavaScript.tmLanguage.json",
    //     ".jsx": "/Applications/Oni.app/Contents/Resources/app/extensions/javascript/syntaxes/JavaScriptReact.tmLanguage.json"
    // },

    // "learning.enabled": true,
    // "achievements.enabled": true,
    // "menu.caseSensitive": "smart",
    // "menu.rowHeight": 40,
    // "menu.maxItemsToShow": 8,
    // "notifications.enabled": true,
    // "recorder.copyScreenshotToClipboard": false,
    // // "recorder.outputPath": "/var/folders/vs/ynh2gq5n4cv110hb24w5616h0000gp/T",
    // "sidebar.enabled": true,
    // "sidebar.default.open": true,
    // "sidebar.width": "15em",
    // "sidebar.marks.enabled": true,
    // "sidebar.plugins.enabled": true,
    // "snippets.enabled": true,
    // // "snippets.userSnippetFolder": null,
    // "statusbar.enabled": true,
    // "statusbar.fontSize": "0.9em",
    // "statusbar.priority": {
    //     "oni.status.workingDirectory": 0,
    //     "oni.status.linenumber": 2,
    //     "oni.status.gitHubRepo": 0,
    //     "oni.status.mode": 1,
    //     "oni.status.filetype": 1,
    //     "oni.status.git": 3
    // },
    // "oni.plugins.prettier": {
    //     "settings": {
    //         "semi": false,
    //         "tabWidth": 2,
    //         "useTabs": false,
    //         "singleQuote": false,
    //         "trailingComma": "es5",
    //         "bracketSpacing": true,
    //         "jsxBracketSameLine": false,
    //         "arrowParens": "avoid",
    //         "printWidth": 80
    //     },
    //     "formatOnSave": true,
    //     "enabled": false
    // },
    // "tabs.mode": "tabs",
    // "tabs.height": "2.5em",
    // "tabs.highlight": true,
    // "tabs.maxWidth": "30em",
    // "tabs.showFileIcon": true,
    // "tabs.showIndex": true,
    // "tabs.wrap": false,
    // // "tabs.dirtyMarker.userColor": "",
    // // "terminal.shellCommand": null,
    // "ui.iconTheme": "theme-icons-seti",
    // "ui.fontFamily": "BlinkMacSystemFont, 'Lucida Grande', 'Segoe UI', Ubuntu, Cantarell, sans-serif",
    // "ui.fontSize": "13px",
    // "workspace.defaultWorkspace": "/Users/matt/code/dotfiles/config/oni",
    // "workspace.autoDetectWorkspace": "noworkspace",
    // "workspace.autoDetectRootFiles": [
    //     ".git",
    //     "node_modules",
    //     ".svn",
    //     "package.json",
    //     ".hg",
    //     ".bzr",
    //     "build.xml"
    // ],
}
