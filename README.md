# vim-testrunner

This is a lightweight RSpec runner for Vim and MacVim.

## Installation

Recommended installation with [vundle](https://github.com/gmarik/vundle):

```vim
Bundle 'jvanbaarsen/vim-testrunner'
```

If using zsh on OS X it may be necessary to move `/etc/zshenv` to `/etc/zshrc`.

## Configuration

### Key mappings

Add your preferred key mappings to your `.vimrc` file.

```vim
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
```

### Custom command

Overwrite the `g:test_command` variable to execute a custom command.

Example:

```vim
let g:test_command = "!rspec --drb {test}"
```

This `g:test_command` variable can be used to support any number of test
runners or pre-loaders. For example, to use
[Dispatch](https://github.com/tpope/vim-dispatch):

```vim
let g:test_command = "Dispatch rspec {test}"
```
Or, [Dispatch](https://github.com/tpope/vim-dispatch) and
[Zeus](https://github.com/burke/zeus) together:

```vim
let g:test_command = "compiler rspec | set makeprg=zeus | Make rspec {test}"
```

### Custom runners

Overwrite the `g:test_runner` variable to set a custom launch script. At the
moment there are two MacVim-specific runners, i.e. `os_x_terminal` and
`os_x_iterm`. The default is `os_x_terminal`, but you can set this to anything
you want, provided you include the appropriate script inside the plugin's
`bin/` directory.

#### iTerm instead of Terminal

If you use iTerm, you can set `g:test_runner` to use the included iterm
launching script. This will run the specs in the last session of the current
terminal.

```vim
let g:test_runner = "os_x_iterm"
```

Credits
-------

A super big thank you goes out to Thoughbot for creating the rspec.vim plugin, which i used as the base for this plugin.

