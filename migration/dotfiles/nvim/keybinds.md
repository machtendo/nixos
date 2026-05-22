# Neovim Keybindings Cheat Sheet (Full, Categorized)

## General & Navigation

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Leader Key                 | `<Space>`                 | Global            | Sets SPACE as leader key for custom shortcuts     |
| Local Leader Key           | `<Space>`                 | Global            | Sets SPACE as local leader key                   |
| Move Down (wrap-aware)     | `j`                       | Normal            | Moves down, aware of wrapped lines               |
| Move Up (wrap-aware)       | `k`                       | Normal            | Moves up, aware of wrapped lines                 |
| Next Buffer                | `<leader>bn`              | Normal            | Switches to next buffer                          |
| Previous Buffer            | `<leader>bp`              | Normal            | Switches to previous buffer                      |
| Move to Left Window        | `<Ctrl-h>`                | Normal            | Moves to left window                             |
| Move to Bottom Window      | `<Ctrl-j>`                | Normal            | Moves to bottom window                           |
| Move to Top Window         | `<Ctrl-k>`                | Normal            | Moves to top window                              |
| Move to Right Window       | `<Ctrl-l>`                | Normal            | Moves to right window                            |
| Split Window Vertically    | `<leader>sv`              | Normal            | Splits window vertically                         |
| Split Window Horizontally  | `<leader>sh`              | Normal            | Splits window horizontally                       |
| Increase Window Height     | `<Ctrl-Up>`               | Normal            | Increases window height                          |
| Decrease Window Height     | `<Ctrl-Down>`             | Normal            | Decreases window height                          |
| Decrease Window Width      | `<Ctrl-Left>`             | Normal            | Decreases window width                           |
| Increase Window Width      | `<Ctrl-Right>`            | Normal            | Increases window width                           |

---

## Search & Highlight

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Clear Search Highlights    | `<leader>c`               | Normal            | Clears search highlights                         |
| Next Search Result         | `n`                       | Normal            | Moves to next search result, centers view        |
| Previous Search Result     | `N`                       | Normal            | Moves to previous search result, centers view    |
| Half Page Down (centered)  | `<Ctrl-d>`                | Normal            | Scrolls half page down, centers view             |
| Half Page Up (centered)    | `<Ctrl-u>`                | Normal            | Scrolls half page up, centers view               |

---

## Editing & Text Manipulation

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Paste Without Yanking      | `<leader>p`               | Visual            | Pastes over selection without yanking            |
| Delete Without Yanking     | `<leader>x`               | Normal/Visual     | Deletes without yanking                          |
| Move Line Down             | `<A-j>`                   | Normal            | Moves current line down                          |
| Move Line Up               | `<A-k>`                   | Normal            | Moves current line up                            |
| Move Selection Down        | `<A-j>`                   | Visual            | Moves selected lines down                        |
| Move Selection Up          | `<A-k>`                   | Visual            | Moves selected lines up                          |
| Indent Left & Reselect     | `<`                       | Visual            | Indents left and reselects                       |
| Indent Right & Reselect    | `>`                       | Visual            | Indents right and reselects                      |
| Join Lines (keep cursor)   | `J`                       | Normal            | Joins lines, keeps cursor position               |

---

## File & Path

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Copy Full File Path        | `<leader>pa`              | Normal            | Copies full file path to clipboard               |
| Toggle File Explorer (NvimTree) | `<leader>e`         | Normal            | Toggles file explorer                            |

---

## Diagnostics & LSP

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Toggle Diagnostics         | `<leader>td`              | Normal            | Toggles diagnostics display                      |
| Show Line Diagnostics      | `<leader>D`               | Normal            | Shows diagnostics for current line               |
| Show Cursor Diagnostics    | `<leader>d`               | Normal            | Shows diagnostics for cursor                     |
| Next Diagnostic            | `<leader>nd`              | Normal            | Jumps to next diagnostic                         |
| Previous Diagnostic        | `<leader>pd`              | Normal            | Jumps to previous diagnostic                     |
| Open Diagnostic List       | `<leader>q`               | Normal            | Opens diagnostic list                            |
| Show Line Diagnostics Float| `<leader>dl`              | Normal            | Shows diagnostics for current line (float)       |
| Go to Definition           | `<leader>gd`              | Normal            | Go to definition (FZF)                           |
| Go to Definition (LSP)     | `<leader>gD`              | Normal            | Go to definition (LSP)                           |
| Go to Definition (Split)   | `<leader>gS`              | Normal            | Go to definition in split window                 |
| Code Action                | `<leader>ca`              | Normal            | Triggers code action                             |
| Rename Symbol              | `<leader>rn`              | Normal            | Renames symbol                                   |
| Hover Documentation        | `K`                       | Normal            | Shows hover documentation                        |
| LSP Definitions            | `<leader>fd`              | Normal            | FZF LSP definitions                              |
| LSP References             | `<leader>fr`              | Normal            | FZF LSP references                               |
| LSP Typedefs               | `<leader>ft`              | Normal            | FZF LSP typedefs                                 |
| LSP Document Symbols       | `<leader>fs`              | Normal            | FZF LSP document symbols                         |
| LSP Workspace Symbols      | `<leader>fw`              | Normal            | FZF LSP workspace symbols                        |
| LSP Implementations        | `<leader>fi`              | Normal            | FZF LSP implementations                          |
| Organize Imports & Format  | `<leader>oi`              | Normal            | Organizes imports and formats buffer             |

---

## Git Integration (gitsigns)

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Next Git Hunk              | `]h`                      | Normal            | Moves to next git hunk                           |
| Previous Git Hunk          | `[h`                      | Normal            | Moves to previous git hunk                       |
| Stage Hunk                 | `<leader>hs`              | Normal            | Stages current git hunk                          |
| Reset Hunk                 | `<leader>hr`              | Normal            | Resets current git hunk                          |
| Preview Hunk               | `<leader>hp`              | Normal            | Previews current git hunk                        |
| Blame Line                 | `<leader>hb`              | Normal            | Shows git blame for current line                 |
| Toggle Inline Blame        | `<leader>hB`              | Normal            | Toggles inline git blame                         |
| Diff This                  | `<leader>hd`              | Normal            | Shows diff for current file                      |

---

## Fuzzy Finder (fzf-lua)

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| FZF Files                  | `<leader>ff`              | Normal            | Opens FZF file search                            |
| FZF Live Grep              | `<leader>fg`              | Normal            | Opens FZF live grep                              |
| FZF Buffers                | `<leader>fb`              | Normal            | Opens FZF buffer search                          |
| FZF Help Tags              | `<leader>fh`              | Normal            | Opens FZF help tags                              |
| FZF Diagnostics Document   | `<leader>fx`              | Normal            | Opens FZF diagnostics for document               |
| FZF Diagnostics Workspace  | `<leader>fX`              | Normal            | Opens FZF diagnostics for workspace              |

---

## Terminal

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Toggle Floating Terminal   | `<leader>t`               | Normal            | Toggles floating terminal                        |
| Close Floating Terminal    | `<Esc>`                   | Terminal          | Closes floating terminal                         |

---

## Completion (blink.cmp)

| Name                       | Keybinding                | Mode(s)           | Description                                      |
|----------------------------|---------------------------|-------------------|--------------------------------------------------|
| Show/Hide Completion Menu  | `<Ctrl-Space>`            | Insert            | Show/hide completion menu                        |
| Accept Completion/Fallback | `<CR>`                    | Insert            | Accept completion or fallback                    |
| Select Next Completion     | `<Ctrl-j>`                | Insert            | Select next completion or fallback               |
| Select Previous Completion | `<Ctrl-k>`                | Insert            | Select previous completion or fallback           |
| Snippet Forward/Fallback   | `<Tab>`                   | Insert            | Move forward in snippet or fallback              |
| Snippet Backward/Fallback  | `<Shift-Tab>`             | Insert            | Move backward in snippet or fallback             |

