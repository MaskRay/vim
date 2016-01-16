" Test for expanding file names

func Test_with_directories()
  call mkdir('Xdir1')
  call mkdir('Xdir2')
  call mkdir('Xdir3')
  cd Xdir3
  call mkdir('Xdir4')
  cd ..

  split Xdir1/file
  call setline(1, ['a', 'b'])
  w
  w Xdir3/Xdir4/file
  close

  next Xdir?/*/file
  call assert_equal('Xdir3/Xdir4/file', expand('%'))
  next! Xdir?/*/nofile
  call assert_equal('Xdir?/*/nofile', expand('%'))

  call delete('Xdir1', 'rf')
  call delete('Xdir2', 'rf')
  call delete('Xdir3', 'rf')
endfunc

func Test_with_tilde()
  let dir = getcwd()
  call mkdir('Xdir ~ dir')
  call assert_true(isdirectory('Xdir ~ dir'))
  cd Xdir\ ~\ dir
  call assert_true(getcwd() =~ 'Xdir \~ dir')
  exe 'cd ' . fnameescape(dir)
  call delete('Xdir ~ dir', 'd')
  call assert_false(isdirectory('Xdir ~ dir'))
endfunc