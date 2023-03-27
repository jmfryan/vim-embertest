" Returns true if the given file belongs to your test runner
function! test#javascript#ember#test_file(file) abort
  return a:file =~# '.*-test.js'
endfunction

" Returns test runner's arguments which will run the current file and/or line
function! test#javascript#ember#build_position(type, position) abort
  if a:type ==# 'nearest'
    return [a:position['file'].':'.a:position['line']]
  elseif a:type ==# 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

" Returns processed args (if you need to do any processing)
function! test#javascript#ember#build_args(args)
  return filter(a:args, 'v:val != "--"')
endfunction

" Returns the executable of your test runner
function! test#javascript#ember#executable()
  return 'script/test-cli'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#javascript#patterns)
  return (len(name['namespace']) ? '^' : '') .
       \ test#base#escape_regex(join(name['namespace'] + name['test'])) .
       \ (len(name['test']) ? '$' : '')
endfunction
