# Neovim Plugin Commands

`<leader>` is space.

## Plugin Manager / Tooling

- `:Lazy` - lazy.nvim plugin UI
- `:Lazy update` - update plugins
- `:Mason` - Mason package UI
- `:ConformInfo` - formatter status/info
- `<leader>f` - format current buffer

## Telescope

- `:Telescope help_tags`
- `<leader>sh` - search help
- `<leader>sk` - search keymaps
- `<leader>sf` - search files
- `<leader>ss` - select Telescope picker
- `<leader>sw` - grep word under cursor
- `<leader>sg` - live grep
- `<leader>sd` - search diagnostics
- `<leader>sr` - resume last picker
- `<leader>s.` - recent files
- `<leader><leader>` - buffers
- `<leader>/` - fuzzy search current buffer
- `<leader>s/` - grep open files
- `<leader>sn` - search Neovim config files

## LSP

- `gd` - go to definition
- `gr` - references
- `gI` - implementation
- `gD` - declaration
- `<leader>D` - type definition
- `<leader>ds` - document symbols
- `<leader>ws` - workspace symbols
- `<leader>rn` - rename
- `<leader>ca` - code action
- `<leader>th` - toggle inlay hints, when supported
- `:LspInfo`, `:LspStart`, `:LspStop`, `:LspRestart`, `:LspLog`

## Diagnostics

- `<leader>q` - open diagnostic quickfix list

## GitSigns

- `]c` - next git change
- `[c` - previous git change
- `<leader>hs` - stage hunk
- `<leader>hr` - reset hunk
- `<leader>hS` - stage buffer
- `<leader>hu` - undo stage hunk
- `<leader>hR` - reset buffer
- `<leader>hp` - preview hunk
- `<leader>hb` - blame line
- `<leader>hd` - diff against index
- `<leader>hD` - diff against last commit
- `<leader>tb` - toggle current line blame
- `<leader>tD` - preview deleted hunk inline
- `:Gitsigns`

## Neo-tree

- `\` - reveal current file in Neo-tree
- `:Neotree`
- Inside Neo-tree: `\` closes the Neo-tree window

## Barbar Buffers

- `<S-Tab>` - previous buffer
- `<Tab>` - next buffer
- `<C-<>` - move buffer left
- `<C->>` - move buffer right
- `<D-1>` through `<D-9>` - go to buffer 1-9
- `<D-0>` - go to last buffer
- `<C-p>` - pin buffer
- `<C-c>` - close buffer
- `<C-b>` - pick buffer
- `<C-S-b>` - pick buffer to delete
- `<leader>bb` - order by buffer number
- `<leader>bn` - order by name
- `<leader>bd` - order by directory
- `<leader>bl` - order by language
- `<leader>bw` - order by window number

## Compiler Explorer

- `<leader>ce` - compile buffer
- Visual `<leader>ce` - compile selection
- `<leader>cE` - compile into new asm window
- `<leader>cl` - toggle live compile
- `<leader>cf` - format buffer through Compiler Explorer
- `<leader>cb` - add library
- `<leader>co` - open in Compiler Explorer website
- `<leader>cL` - load example
- `<leader>cD` - clear CE cache
- In asm buffers: `K` - show instruction tooltip
- Extra available commands: `:CECompile`, `:CECompile!`, `:CECompileLive`, `:CECompileRun`, `:CEOpen`, `:CEEditConfig`, `:CEFormat`, `:CEAddLibrary`, `:CEOpenWebsite`, `:CELoadExample`, `:CEDeleteCache`

## Copilot / Copilot Chat

- `:Copilot`
- `<leader>cc` - open Copilot Chat
- `:CopilotChat`
- `:CopilotChatToggle`
- `:CopilotChatOpen`
- `:CopilotChatClose`
- `:CopilotChatStop`
- `:CopilotChatReset`
- `:CopilotChatSave`
- `:CopilotChatLoad`
- `:CopilotChatPrompts`
- `:CopilotChatModels`
- `:CopilotChatDocs`
- `:CopilotChatExplain`
- `:CopilotChatReview`
- `:CopilotChatFix`
- `:CopilotChatOptimize`
- `:CopilotChatTests`
- `:CopilotChatCommit`

## CodeCompanion

- `:CodeCompanion`
- `:CodeCompanionChat`
- `:CodeCompanionActions`
- `:CodeCompanionCmd`

## Markdown Rendering

- `<leader>mr` - toggle rendered Markdown view for the current buffer
- `<leader>mp` - toggle pretty/rendered Markdown view for the current buffer
- `:RenderMarkdown buf_toggle` - toggle rendered Markdown for the current buffer
- `:RenderMarkdown toggle` - toggle rendered Markdown globally
- `:RenderMarkdown preview` - plugin side-preview command; not mapped because it is less useful in this setup

## Dadbod

- `:DB` - run a database query or open a database URL
- `:DBUI` - open Dadbod UI
- `:DBUIToggle` - toggle Dadbod UI
- `:DBUIAddConnection` - add a saved DBUI connection
- `:DBUIFindBuffer` - reveal current query buffer in DBUI
- SQL buffers use `vim-dadbod-completion` as the first completion source.

## DAP

- `<leader>dc` - start/continue debugging
- `<leader>di` - step into
- `<leader>do` - step over
- `<leader>dO` - step out
- `<leader>du` - toggle DAP UI
- `<leader>b` - toggle breakpoint
- `<leader>B` - set conditional breakpoint
- Inline DAP virtual text is enabled with basic redaction for values that look like secrets/API data.
- Installed adapters: `delve`, `js-debug-adapter`, `codelldb`, `elixir-ls-debugger`
- Go: configured through `nvim-dap-go`
- JavaScript/TypeScript/Svelte:
  - `Node: Launch current file`
  - `Node: Launch package script`
  - `Node: Attach process`
  - `Node: Attach inspect port 9229`
  - `Browser: Launch Chrome/SvelteKit`
  - `Browser: Attach Chrome port 9222`
- C/C++/Zig:
  - `LLDB: Launch executable`
  - `LLDB: Attach process`
- OCaml:
  - `OCaml: Launch bytecode prompt`
  - `OCaml: Launch current module bytecode`
- Elixir:
  - `Elixir: Mix task prompt`
  - `Elixir: Mix test`
  - `Elixir: Mix test current file`
  - `Elixir: Phoenix server`

### DAP Setup Notes

#### Scenario Runbook

General flow for any debugger:

1. Open the relevant source file.
2. Put the cursor on a line that should pause.
3. Press `<leader>b` to set a breakpoint.
4. Press `<leader>dc` to start/continue.
5. Pick the DAP config that matches the scenario.
6. Use `<leader>du` to show/hide debugger panes.

#### Local Node / TypeScript Services

Use this when you want Neovim to start a local backend, CLI, worker, API server, or dev server.

Use `Node: Launch package script` for app/dev-server commands. It prompts for:

- package manager, default `npm`
- package manager args, default `run dev`

Examples:

- `npm` + `run dev`
- `pnpm` + `dev`
- `yarn` + `dev`
- `bun` + `run dev`

Steps:

1. Open a relevant `.js`, `.ts`, `.jsx`, `.tsx`, or `.svelte` file.
2. Set a breakpoint with `<leader>b`.
3. Press `<leader>dc`.
4. Choose `Node: Launch package script`.
5. Enter the package manager and script args.

Use `Node: Attach process` when the service is already running on your machine. It opens a process picker.

Steps:

1. Start the service normally in another terminal.
2. Open a relevant source file in Neovim.
3. Set a breakpoint with `<leader>b`.
4. Press `<leader>dc`.
5. Choose `Node: Attach process`.
6. Pick the running Node process.

For explicit inspect-port debugging, start the service with an inspect port:

```sh
node --inspect=127.0.0.1:9229 ./server.js
```

For TypeScript runners, the same idea applies:

```sh
node --inspect=127.0.0.1:9229 --loader ts-node/esm ./src/server.ts
```

or:

```sh
tsx --inspect=127.0.0.1:9229 ./src/server.ts
```

Then use `Node: Attach inspect port 9229`.

Steps:

1. Start the service with `--inspect=127.0.0.1:9229`.
2. Open a relevant source file in Neovim.
3. Set a breakpoint with `<leader>b`.
4. Press `<leader>dc`.
5. Choose `Node: Attach inspect port 9229`.
6. Accept `127.0.0.1` and `9229`.

#### Dockerized Node / TypeScript Services

Use this when Node is running inside Docker and Neovim is running on your host machine.

Run Node inside the container with an inspect listener on all interfaces:

```sh
node --inspect=0.0.0.0:9229 ./server.js
```

Expose the port from Docker:

```yaml
ports:
  - "9229:9229"
```

Use `Node: Attach inspect port 9229` and answer prompts like:

- debug host: `127.0.0.1`
- debug port: `9229`
- remote root: the app path inside the container, commonly `/app`

The `remoteRoot` must match where your source files live in the container. The local root is configured as your workspace folder.

Steps:

1. Start the container with Node listening on `0.0.0.0:9229`.
2. Ensure Docker exposes `9229:9229`.
3. Open the matching local source file in Neovim.
4. Set a breakpoint with `<leader>b`.
5. Press `<leader>dc`.
6. Choose `Node: Attach inspect port 9229`.
7. Use host `127.0.0.1`, port `9229`, and the container source root, often `/app`.

If breakpoints do not bind, the likely issue is `remoteRoot`. Check the path inside the container with:

```sh
docker exec -it <container> pwd
```

#### SvelteKit / Browser Debugging

Use this for SvelteKit and other Vite-style apps where some code runs on the server and some runs in Chrome.

For SvelteKit server-side code, use the Node configs:

- `Node: Launch package script`
- `Node: Attach inspect port 9229`

Server-side steps:

1. Open server-side code such as hooks, endpoints, load functions, or backend utilities.
2. Set a breakpoint with `<leader>b`.
3. Press `<leader>dc`.
4. Choose `Node: Launch package script` if Neovim should start the dev server.
5. Choose `Node: Attach inspect port 9229` if the dev server is already running with inspect enabled.

For browser/client code, use:

- `Browser: Launch Chrome/SvelteKit`
- `Browser: Attach Chrome port 9222`

Default browser URL is:

```text
http://localhost:5173
```

For browser attach, launch Chrome with remote debugging first:

```sh
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/chrome-nvim-dap
```

Then use `Browser: Attach Chrome port 9222`.

Browser launch steps:

1. Start the SvelteKit dev server, for example `npm run dev`.
2. Open a client-side `.svelte`, `.ts`, or `.js` file.
3. Set a breakpoint with `<leader>b`.
4. Press `<leader>dc`.
5. Choose `Browser: Launch Chrome/SvelteKit`.
6. Accept or edit the URL, usually `http://localhost:5173`.

Browser attach steps:

1. Start Chrome with `--remote-debugging-port=9222`.
2. Start the SvelteKit dev server.
3. Open a client-side file in Neovim.
4. Set a breakpoint with `<leader>b`.
5. Press `<leader>dc`.
6. Choose `Browser: Attach Chrome port 9222`.
7. Accept host `127.0.0.1` and port `9222`.

If client breakpoints do not bind, check that source maps are being generated and that the URL matches the running app.

#### C / C++ / Zig

These use `codelldb`. Build binaries with debug symbols.

C:

```sh
clang -g -O0 main.c -o main
```

C++:

```sh
clang++ -g -O0 main.cpp -o main
```

Zig:

```sh
zig build -Doptimize=Debug
```

or for a single file:

```sh
zig build-exe -O Debug main.zig
```

Then use `LLDB: Launch executable` and select the compiled binary.

Launch steps:

1. Build the binary with debug symbols.
2. Open the relevant `.c`, `.cpp`, `.h`, `.hpp`, or `.zig` file.
3. Set a breakpoint with `<leader>b`.
4. Press `<leader>dc`.
5. Choose `LLDB: Launch executable`.
6. Select the compiled binary.
7. Enter program args if needed, or press Enter for none.

Use `LLDB: Attach process` when the native program is already running. If attach fails, macOS permissions or process ownership may be the issue.

Attach steps:

1. Build the binary with debug symbols.
2. Start the binary in another terminal.
3. Open the relevant source file in Neovim.
4. Set a breakpoint with `<leader>b`.
5. Press `<leader>dc`.
6. Choose `LLDB: Attach process`.
7. Pick the running process.

Use launch when you want the debugger to start the program. Use attach when the program is already running or must be started by another tool.

#### OCaml

OCaml editor support:

- syntax highlighting: Treesitter `ocaml`
- completion/go-to-definition/etc: `ocamllsp`
- formatting: `ocamlformat`
- debugging: `ocamlearlybird` when installed separately

Use `OCaml: Launch bytecode prompt` when:

- you have built a `.bc` bytecode executable
- you know where the `.bc` file is under `_build/default`
- you want the most reliable OCaml debug path

Steps:

1. Build bytecode with debug symbols.
2. Open a relevant `.ml` or `.mli` file.
3. Set a breakpoint with `<leader>b`.
4. Press `<leader>dc`.
5. Choose `OCaml: Launch bytecode prompt`.
6. Select the built `.bc` file.

Use `OCaml: Launch current module bytecode` when:

- the current file maps directly to a built `.bc` file at the same relative path
- you want a faster shortcut than selecting the bytecode file manually

Steps:

1. Build bytecode with debug symbols.
2. Open the relevant `.ml` file.
3. Set a breakpoint with `<leader>b`.
4. Press `<leader>dc`.
5. Choose `OCaml: Launch current module bytecode`.

OCaml DAP requirements:

- install/init an opam switch on the machine
- install project dependencies
- Dune should use `(lang dune 3.7)` or newer for earlybird workflows
- add `(map_workspace_root false)` to `dune-project` when using Dune 3.7+
- build a bytecode executable, not only a native executable
- bytecode stanzas generally need `(modes byte exe)`

Example Dune executable stanza:

```scheme
(executable
 (name main)
 (modes byte exe)
 (libraries your_libraries))
```

Build:

```sh
dune build
```

Then debug the resulting `.bc` file, commonly somewhere under:

```text
_build/default/
```

OCaml debugging is less universal than the JS/C/Zig setup. `ocamlearlybird` works with bytecode/debug-info workflows; native-code debugging is not covered by this DAP config.

#### Elixir

Elixir debugging uses the ElixirLS debug adapter:

```text
elixir-ls-debugger
```

Use `Elixir: Mix task prompt` for the most flexible workflow. It prompts for a Mix task and optional args.

Examples:

- task `test`, args empty
- task `test`, args `test/my_feature_test.exs`
- task `run`, args `priv/scripts/example.exs`
- task `phx.server`, args empty

Use `Elixir: Mix test` for the whole test suite with `--trace`.

Use `Elixir: Mix test current file` from a test file to debug that file.

Use `Elixir: Phoenix server` only in Phoenix projects. The generic Mix task prompt can also run Phoenix by entering `phx.server`.

Use `Elixir: Mix task prompt` when:

- you are unsure which config to use
- you want to run a custom Mix task
- you want to run Phoenix through the generic path
- you want to pass custom test args

Steps:

1. Open an Elixir source or test file.
2. Set a breakpoint with `<leader>b`.
3. Press `<leader>dc`.
4. Choose `Elixir: Mix task prompt`.
5. Enter a Mix task, such as `test`, `run`, or `phx.server`.
6. Enter optional args, or press Enter for none.

Use `Elixir: Mix test` when:

- you want to debug the whole test suite
- you want to debug test setup or failures that only happen in the full suite

Steps:

1. Open an Elixir project with `mix.exs`.
2. Set a breakpoint in code hit by the tests.
3. Press `<leader>dc`.
4. Choose `Elixir: Mix test`.

Use `Elixir: Mix test current file` when:

- your cursor is in a test file
- you only want to debug that one test file
- you want the usual day-to-day Elixir test-debugging flow

Steps:

1. Open a file like `test/my_app/something_test.exs`.
2. Set a breakpoint with `<leader>b`.
3. Press `<leader>dc`.
4. Choose `Elixir: Mix test current file`.

Use `Elixir: Phoenix server` when:

- you are in a Phoenix app
- you want to debug request handling, controllers, LiveViews, channels, or app runtime behavior

Steps:

1. Open Phoenix code that is hit by a request or browser interaction.
2. Set a breakpoint with `<leader>b`.
3. Press `<leader>dc`.
4. Choose `Elixir: Phoenix server`.
5. Trigger the request or browser action that reaches the breakpoint.

Do not use `Elixir: Phoenix server` in a non-Phoenix project; use `Elixir: Mix task prompt` instead.

Project requirements:

- run from a project with `mix.exs`
- dependencies should already be fetched/compiled
- breakpoints work best in project modules/tests loaded by the Mix task

## Completion / Snippets

- Insert mode `<C-n>` - next completion item
- Insert mode `<C-p>` - previous completion item
- Insert mode `<C-b>` - scroll docs up
- Insert mode `<C-f>` - scroll docs down
- Insert mode `<C-y>` - accept completion
- Insert mode `<C-Space>` - trigger completion
- Insert/select mode `<C-l>` - jump forward in snippet
- Insert/select mode `<C-h>` - jump backward in snippet
- `:CmpStatus`
- `:LuaSnipListAvailable`
- `:LuaSnipUnlinkCurrent`

## Treesitter

- `:TSUpdate`
- `:TSInstall`
- `:TSInstallInfo`
- `:TSModuleInfo`
- `:TSEnable`
- `:TSDisable`
- `:TSToggle`
- `:TSBufEnable`
- `:TSBufDisable`
- `:TSBufToggle`
- `:TSEditQuery`

## Indent Guides

- `:IBLToggle`
- `:IBLEnable`
- `:IBLDisable`
- `:IBLToggleScope`
- `:IBLEnableScope`
- `:IBLDisableScope`

## Mini.nvim

- `mini.ai` textobjects are enabled, e.g. `va)`, `ci'`, `yinq`
- `mini.surround` defaults are enabled, e.g. `saiw)`, `sd'`, `sr)'`

## Comment.nvim

- `gcc` - toggle line comment
- `gc` in visual mode - toggle selected comment
- `gbc` - block comment

## Basic Non-plugin Mappings

- `<Esc>` - clear search highlight
- Terminal `<Esc><Esc>` - exit terminal mode
- `<C-h/j/k/l>` - move between windows

## Ghostty Terminal

These are active Ghostty 1.3.1 bindings from `ghostty +show-config`.
`super` is the macOS Command key.

### Config

- `super+,` - open Ghostty config
- `super+shift+,` - reload Ghostty config

### Clipboard / Selection

- `copy` - copy to clipboard
- `paste` - paste from clipboard
- `super+c` - copy to clipboard
- `super+v` - paste from clipboard
- `super+shift+v` - paste from selection
- `super+a` - select all
- `shift+arrow_left/right/up/down` - adjust selection
- `shift+page_up/page_down` - adjust selection by page
- `shift+home/end` - adjust selection to start/end

### Font / Screen

- `super+=` or `super++` - increase font size
- `super+-` - decrease font size
- `super+0` - reset font size
- `super+k` - clear screen
- `super+ctrl+shift+j` - copy screen contents to file
- `super+shift+j` - paste screen contents to file
- `super+alt+shift+j` - open screen contents as file

### Windows / Tabs

- `super+n` - new window
- `super+w` - close current surface
- `super+shift+w` - close window
- `super+alt+w` - close current tab
- `super+alt+shift+w` - close all windows
- `super+t` - new tab
- `ctrl+tab` - next tab
- `ctrl+shift+tab` - previous tab
- `super+shift+]` - next tab
- `super+shift+[` - previous tab
- `super+1` through `super+8` - go to tab 1-8
- `super+9` - go to last tab
- `super+enter` or `super+ctrl+f` - toggle fullscreen
- `super+q` - quit Ghostty

### Splits

- `super+d` - new split to the right
- `super+shift+d` - new split down
- `super+shift+enter` - toggle split zoom
- `super+[` - focus previous split by creation order
- `super+]` - focus next split by creation order
- `super+arrow_left` - focus previous split by creation order
- `super+arrow_right` - focus next split by creation order
- `super+alt+arrow_left/right/up/down` - focus split in that direction
- `super+ctrl+arrow_left/right/up/down` - resize split in that direction
- `super+ctrl+=` - equalize splits

Ghostty does not currently expose a "toggle last focused split" action in this
config. `goto_split:previous` and `goto_split:next` cycle through splits by
creation order, so they feel like toggling only when there are two splits.

### Scroll / Prompts / Search

- `super+home` - scroll to top
- `super+end` - scroll to bottom
- `super+page_up` - scroll page up
- `super+page_down` - scroll page down
- `super+j` - scroll to selection
- `super+arrow_up` or `super+shift+arrow_up` - jump to previous prompt
- `super+arrow_down` or `super+shift+arrow_down` - jump to next prompt
- `super+f` - start search
- `super+e` - search selected text
- `super+shift+f` or `escape` - end search
- `super+g` - next search result
- `super+shift+g` - previous search result

### Editing / Misc

- `super+shift+p` - toggle command palette
- `super+shift+t` or `super+z` - undo
- `super+shift+z` - redo
- `super+alt+i` - toggle inspector
- `super+backspace` - send `Ctrl-U`
- `alt+arrow_left` - send `Esc-b`
- `alt+arrow_right` - send `Esc-f`

## Disabled Modules

`lua/kickstart/plugins/lint.lua` exists, but it is commented out in `init.lua`, so its mappings/autocommands are not active right now.
