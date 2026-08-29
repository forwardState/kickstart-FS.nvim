# kickstart.nvim

## Michael's Neovim Config

This repo is a Kickstart-based Neovim config with custom plugins for LSP,
completion, AI helpers, database work, Compiler Explorer, file navigation, and
debugging.

The repo is intended to be portable across machines, but each machine still
needs local developer tools installed. Plugin source is managed by `lazy.nvim`;
language servers, formatters, and debug adapters are mostly managed by Mason.

### macOS Setup

Install the baseline tools with Homebrew:

```sh
brew install neovim git make ripgrep fd unzip node go elixir erlang llvm zig opam rustup-init
```

Install Apple's command line tools if they are not already present:

```sh
xcode-select --install
```

Optional but useful:

```sh
brew install postgresql@16 mysql-client sqlite
brew install --cask font-jetbrains-mono-nerd-font google-chrome
```

Notes:

- `node` is needed for TypeScript/JavaScript tooling, Copilot, and JS debugging.
- `go` is needed if Mason needs to build/install Delve for Go debugging.
- `elixir` and `erlang` are needed for Elixir LSP/debugging.
- `llvm` provides modern Clang/LLDB tooling. Mason installs `codelldb`
  separately for Neovim DAP.
- `zig` is needed for Zig projects; debug builds use `codelldb`.
- `opam` is needed for OCaml tools installed through Mason/opam.
- `rustup-init` is used to install the Rust toolchain, including `cargo`,
  `rustc`, and `rustfmt`.
- database CLIs are useful for `vim-dadbod`, depending on which databases you use.
- Chrome is only needed for browser debugging.

### Install This Config On Another Machine

Back up any existing config first:

```sh
mv ~/.config/nvim ~/.config/nvim.backup
```

Clone this repo:

```sh
git clone <your-repo-url> ~/.config/nvim
```

Start Neovim:

```sh
nvim
```

On first startup:

- `lazy.nvim` will install plugins.
- Mason will install configured language servers and debug adapters.
- If anything is missing, run `:checkhealth`, `:Lazy`, and `:Mason`.

Useful manual commands:

```vim
:Lazy sync
:Mason
:MasonToolsInstall
```

### CodeCompanion / Codex ACP

CodeCompanion is configured to use the Codex ACP adapter. Each machine must make
the `codex-acp` executable available in one of two ways.

Option 1: put `codex-acp` on `PATH`:

```sh
mkdir -p ~/.local/bin
cp /path/to/codex-acp ~/.local/bin/codex-acp
chmod +x ~/.local/bin/codex-acp
```

Make sure your shell exports `~/.local/bin`:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

Option 2: set `CODEX_ACP` to the absolute path:

```sh
export CODEX_ACP="$HOME/Dev/codex-acp"
```

Put the export in `~/.zshrc` or the machine's preferred shell/env setup.

Verify:

```sh
codex-acp --help
```

or:

```sh
"$CODEX_ACP" --help
```

Claude Code is a separate tool and is not used by this CodeCompanion config
unless a separate adapter/config is added later.

### Auth And Machine-Local Files

Do not commit machine-local secrets/logs:

- `.env`
- `.nvimlog`

Copilot requires auth on each machine:

```vim
:Copilot auth
```

CodeCompanion with Codex ACP currently uses `auth_method = 'chatgpt'`, so the
underlying Codex ACP setup must be authenticated on that machine.

### Plugin Commands

See `plugin-commands.md` for the command/keymap index across the configured
plugins, including:

- Telescope
- LSP
- GitSigns
- Neo-tree
- Barbar
- Compiler Explorer
- Copilot / Copilot Chat
- CodeCompanion
- Dadbod
- DAP
- Markdown rendering
- completion/snippets
- Treesitter
- Mini.nvim
- Comment.nvim
- Ghostty terminal bindings

Markdown files open as editable Markdown by default. Use `<leader>mr` in a
Markdown buffer to toggle an in-terminal rendered view for reading.

### Debugging Support

DAP is configured for:

- Go through Delve
- JavaScript/TypeScript/Svelte through `js-debug-adapter`
- C/C++/Rust/Zig through `codelldb`
- OCaml through `ocamlearlybird` when installed separately
- Elixir through `elixir-ls-debugger`

Mason should install the debug adapters automatically. If needed:

```vim
:MasonInstall delve js-debug-adapter codelldb elixir-ls ocaml-lsp ocamlformat rust-analyzer
```

For Node/TypeScript services:

- local launch: use `Node: Launch package script`
- local attach: start Node with `--inspect=127.0.0.1:9229`
- Docker attach: start Node with `--inspect=0.0.0.0:9229` and expose `9229:9229`

For browser/SvelteKit debugging:

- start the dev server
- use `Browser: Launch Chrome/SvelteKit`, or launch Chrome with:

```sh
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/chrome-nvim-dap
```

For C/C++/Rust/Zig:

- build with debug symbols, for example `clang -g -O0`, `clang++ -g -O0`, or
  `cargo build`, or `zig build -Doptimize=Debug`
- use `LLDB: Launch executable` or `LLDB: Attach process`

For Rust:

- install the Rust toolchain with `rustup-init`
- use `rust_analyzer` for LSP/completion and `rustfmt` for formatting
- use `codelldb` for DAP debugging
- build with `cargo build`; debug binaries are usually under `target/debug`

For OCaml:

- initialize an opam switch on the machine
- use `ocamllsp` for LSP/completion and `ocamlformat` for formatting
- use `ocamlearlybird` for DAP debugging when a compatible build is available
- build bytecode with debug symbols, usually through Dune `(modes byte exe)`
- debug the generated `.bc` file under `_build/default`

For detailed debugger scenario runbooks, see the DAP section in
`plugin-commands.md`.

### Lockfile

`lazy-lock.json` should be committed for reproducible plugin versions across
machines. Run `:Lazy sync` after pulling changes.

## Introduction

A starting point for Neovim that is:

* Small
* Single-file
* Completely Documented

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

Kickstart.nvim targets *only* the latest
['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest
['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:
- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

> **NOTE**
> See [Install Recipes](#Install-Recipes) for additional Windows and Linux specific notes
> and quick install snippets

### Install Kickstart

> **NOTE**
> [Backup](#FAQ) your previous configuration (if any exists)

Neovim's configurations are located under the following paths, depending on your OS:

| OS | PATH |
| :- | :--- |
| Linux, MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%localappdata%\nvim\` |
| Windows (powershell)| `$env:LOCALAPPDATA\nvim\` |

#### Recommended Step

[Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo
so that you have your own copy that you can modify, then install by cloning the
fork to your machine using one of the commands below, depending on your OS.

> **NOTE**
> Your fork's URL will be something like this:
> `https://github.com/<your_github_username>/kickstart.nvim.git`

You likely want to remove `lazy-lock.json` from your fork's `.gitignore` file
too - it's ignored in the kickstart repo to make maintenance easier, but it's
[recommended to track it in version control](https://lazy.folke.io/usage/lockfile).

#### Clone kickstart.nvim
> **NOTE**
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```sh
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/nvim-lua/kickstart.nvim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
the current plugin status. Hit `q` to close the window.

#### Read The Friendly Documentation

Read through the `init.lua` file in your configuration folder for more
information about extending and exploring Neovim. That also includes
examples of adding popularly requested plugins.

> [!NOTE]
> For more information about a particular plugin check its repository's documentation.


### Getting Started

[The Only Video You Need to Get Started with Neovim](https://youtu.be/m8C0Cq9Uv9o)

### FAQ

* What should I do if I already have a pre-existing Neovim configuration?
  * You should back it up and then delete all associated files.
  * This includes your existing init.lua and the Neovim files in `~/.local`
    which can be deleted with `rm -rf ~/.local/share/nvim/`
* Can I keep my existing configuration in parallel to kickstart?
  * Yes! You can use [NVIM_APPNAME](https://neovim.io/doc/user/starting.html#%24NVIM_APPNAME)`=nvim-NAME`
    to maintain multiple configurations. For example, you can install the kickstart
    configuration in `~/.config/nvim-kickstart` and create an alias:
    ```
    alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
    ```
    When you run Neovim using `nvim-kickstart` alias it will use the alternative
    config directory and the matching local directory
    `~/.local/share/nvim-kickstart`. You can apply this approach to any Neovim
    distribution that you would like to try out.
* What if I want to "uninstall" this configuration:
  * See [lazy.nvim uninstall](https://lazy.folke.io/usage#-uninstalling) information
* Why is the kickstart `init.lua` a single file? Wouldn't it make sense to split it into multiple files?
  * The main purpose of kickstart is to serve as a teaching tool and a reference
    configuration that someone can easily use to `git clone` as a basis for their own.
    As you progress in learning Neovim and Lua, you might consider splitting `init.lua`
    into smaller parts. A fork of kickstart that does this while maintaining the
    same functionality is available here:
    * [kickstart-modular.nvim](https://github.com/dam9000/kickstart-modular.nvim)
  * Discussions on this topic can be found here:
    * [Restructure the configuration](https://github.com/nvim-lua/kickstart.nvim/issues/218)
    * [Reorganize init.lua into a multi-file setup](https://github.com/nvim-lua/kickstart.nvim/pull/473)

### Install Recipes

Below you can find OS specific install instructions for Neovim and dependencies.

After installing all the dependencies continue with the [Install Kickstart](#Install-Kickstart) step.

#### Windows Installation

<details><summary>Windows with Microsoft C++ Build Tools and CMake</summary>
Installation may require installing build tools and updating the run command for `telescope-fzf-native`

See `telescope-fzf-native` documentation for [more details](https://github.com/nvim-telescope/telescope-fzf-native.nvim#installation)

This requires:

- Install CMake and the Microsoft C++ Build Tools on Windows

```lua
{'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
```
</details>
<details><summary>Windows with gcc/make using chocolatey</summary>
Alternatively, one can install gcc and make which don't require changing the config,
the easiest way is to use choco:

1. install [chocolatey](https://chocolatey.org/install)
either follow the instructions on the page or use winget,
run in cmd as **admin**:
```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit the previous cmd and
open a new one so that choco path is set, and run in cmd as **admin**:
```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
</details>
<details><summary>WSL (Windows Subsystem for Linux)</summary>

```
wsl --install
wsl
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>

#### Linux Install
<details><summary>Ubuntu Install Steps</summary>

```
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip neovim
```
</details>
<details><summary>Debian Install Steps</summary>

```
sudo apt update
sudo apt install make gcc ripgrep unzip git xclip curl

# Now we install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo mkdir -p /opt/nvim-linux-x86_64
sudo chmod a+rX /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

# make it available in /usr/local/bin, distro installs to /usr/bin
sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/
```
</details>
<details><summary>Fedora Install Steps</summary>

```
sudo dnf install -y gcc make git ripgrep fd-find unzip neovim
```
</details>

<details><summary>Arch Install Steps</summary>

```
sudo pacman -S --noconfirm --needed gcc make git ripgrep fd unzip neovim
```
</details>
