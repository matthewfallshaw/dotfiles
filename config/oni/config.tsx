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
  "oni.loadInitVim": true,

  "ui.colorscheme": "nord",

  //"oni.useDefaultConfig": true,
  //"oni.bookmarks": ["~/Documents"],
  "editor.fontSize": "12px",
  "editor.fontFamily": "FuraCodeNerdFontComplete-Retina",
  "editor.fontWeight": "normal",
  "editor.fontLigatures": true,
  "editor.renderer": "canvas",

  "environment.additionalVariables": {
    "LANG": "en_us.UTF-8",
  },

  // "debug.neovimPath": "/usr/local/bin/nvim",

  "editor.clipboard.enabled": true,
  "editor.clipboard.synchronizeYank": true,
  "editor.clipboard.synchronizeDelete": false,

  // UI customizations
  "ui.animations.enabled": true,
  "ui.fontSmoothing": "auto",

  "learning.enabled": false,
  "achievements.enabled": false,
}
