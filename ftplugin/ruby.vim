if !exists("g:rbar_command")
    let g:rbar_command = "rbar"
endif

function! InlineVariableUnderCursor()
    " Create a fake change to ensure undo jumps back to the current cursor,
    " see: https://goo.gl/mdBdnQ
    normal! ix
    normal! x

    let l:save = winsaveview()

    let l:curline = line(".")
    let l:curvcol = virtcol(".")
    let l:pos = join([l:curline, l:curvcol], ":")
    let l:args = join([
                \ "inline",
                \ "--file",
                \ expand("%:p"),
                \ "--start-pos",
                \ l:pos,
                \ "--end-pos",
                \ l:pos
                \ ], " ")

    execute "%!" . g:rbar_command . " " . l:args

    call winrestview(l:save)
endfunction

" TODO: extract common handler
function! RenameVariableUnderCursor()
    " Create a fake change to ensure undo jumps back to the current cursor,
    " see: https://goo.gl/mdBdnQ
    normal! ix
    normal! x

    let l:save = winsaveview()

    let l:curline = line(".")
    let l:curvcol = virtcol(".")
    let l:pos = join([l:curline, l:curvcol], ":")
    call inputsave()
    let l:new_name = input('Enter new name: ')
    call inputrestore()
    let l:args = join([
                \ "rename",
                \ "--new-name",
                \ l:new_name,
                \ "--file",
                \ expand("%:p"),
                \ "--start-pos",
                \ l:pos,
                \ "--end-pos",
                \ l:pos
                \ ], " ")

    execute "%!" . g:rbar_command . " " . l:args

    call winrestview(l:save)
endfunction
