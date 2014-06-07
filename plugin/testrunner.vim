let s:plugin_path = expand("<sfile>:p:h:h")
if !exists("g:test_runner")
  let g:test_runner = "os_x_terminal"
endif

if has("gui_running") && has("gui_macvim")
  let g:test_command = "silent !" . s:plugin_path . "/bin/" . g:test_runner . " '{test_runner} {test}'"
else
  let g:test_command = "!clear && echo {test_runner} {test} && {test_runner} {test}"
endif

function! RunCurrentTestFile()
  if InTestFile()
    let l:test = @%
    call SetLastTestCommand(l:test)
    call RunTests(l:test)
  else
    call RunLastTest()
  endif
endfunction

function! RunNearestTest()
  if InTestFile()
    " Only rspec accepts line based testing, fallback to full file for other
    " runners
    if match(expand("%"), '_spec\.rb$') != -1
      let l:test = @% . ":" . line(".")
    else
      let l:test = @%
    endif
    call SetLastTestCommand(l:test)
    call RunTests(l:test)
  else
    call RunLastTest()
  endif
endfunction

function! RunLastTest()
  if exists("s:last_test_command")
    call RunTests(s:last_test_command)
  endif
endfunction

function! InTestFile()
  return match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
endfunction

function! SetLastTestCommand(test)
  let s:last_test_command = a:test
endfunction

function! RunTests(test)
  if match(expand("%"), '\.feature$') != -1
    let l:test_runner = substitute(g:test_command, "{test_runner}", "spinach", "g")
  elseif match(expand("%"), '_spec\.rb$') != -1
    let l:test_runner = substitute(g:test_command, "{test_runner}", "rspec", "g")
  else
    let l:test_runner = substitute(g:test_command, "{test_runner}", "ruby -Itest", "g")
  endif
  execute substitute(l:test_runner, "{test}", a:test, "g")
endfunction
