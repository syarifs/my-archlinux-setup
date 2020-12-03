func! Run()
exec "!javac % -d /tmp/vim/java/"
exec ":cd /tmp/vim/java"
exec "!time java %:t:r"
endfunc

map <F5> :call Run()<CR>
source ~/.config/nvim/highlighter/java.vim
