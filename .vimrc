set tabstop=4
set nonu
set ts=4
set expandtab
syntax on
set softtabstop=4
set shiftwidth=4
set autoindent
set hlsearch
execute pathogen#infect()
filetype plugin indent on
map <F7> :NERDTree<CR>
map <F8> :TlistToggle<CR>
let g:NERDTreeWinSize=20
let Tlist_Show_One_File=1    " 只展示一个文件的taglist
let Tlist_Exit_OnlyWindow=1  " 当taglist是最后以个窗口时自动退出
let Tlist_Use_Right_Window=1 " 在右边显示taglist窗口
let Tlist_Sort_Type="name"   " tag按名字排序"
filetype plugin indent on
set completeopt=longest,menu
let OmniCpp_NamespaceSearch = 2     " search namespaces in the current buffer   and in included files
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表
let OmniCpp_MayCompleteScope = 1    " 输入 :: 后自动补全
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]"]"
set tags+=~/.vim/tags/cpp_src/tags
"ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++"

map <F9>  :call GenerateCtags()<CR>  
             
function! GenerateCtags()  
    let dir = getcwd()  
    if filereadable("tags")  
        let tagsdeleted=delete("./"."tags")  
        if(tagsdeleted!=0)  
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None  
            return  
        endif  
    endif    
    if has("cscope")  
        silent! execute "cs kill -1"  
    endif    
    if filereadable("cscope.files")  
        let csfilesdeleted=delete("./"."cscope.files")  
        if(csfilesdeleted!=0)  
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None  
            return  
        endif  
    endif    
    if filereadable("cscope.out")  
        let csoutdeleted=delete("./"."cscope.out")  
        if(csoutdeleted!=0)  
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None  
            return  
        endif  
    endif    
    if(executable('ctags'))  
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."  
    endif    
    if(executable('cscope') && has("cscope") )  
        silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cc' -o -name '*.java' -o -name '*.cs' > cscope.files"  
        silent! execute "!cscope -Rbq"  
        execute "normal :"  
        if filereadable("cscope.out")  
            execute "cs add cscope.out"  
        endif                                                                                                                  
    endif    
endfunction  
