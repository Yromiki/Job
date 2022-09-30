include \masm64\include64\masm64rt.inc
;Yn = 2,5x^2 – 3,2 (x изменяется от 4 с шагом 1).
.const
 title0 db"Number 7",0
fmt0 db "Yn = 2,5X^2-3.2; X0 = 4; STEP = 1.0", 10,
 "Y0 = %s", 10,
 "Y1 = %s", 10,
 "Y2 = %s", 10,
 "Y3 = %s", 10, 10,
 "Author: SEREBRYAKOV VIKTOR SERGEEVICH K-19-1", 0
const0 dq 2.5
const1 dq 3.2
step0 dq 1.0
loop_count0 dq 4
.data
    x0 dq 4.0
    res0 dq 4 dup(0.0) 
    text0 db 256 dup(0)
    sres0 db 32 dup(0)
    sres1 db 32 dup(0)
    sres2 db 32 dup(0)
    sres3 db 32 dup(0)
.code
entry_point proc
    lea rdi, res0 
    mov rcx, loop_count0 
    finit
m0:
    fld x0 
    fmul x0 
	fmul const0
	fsub const1
    fstp qword ptr [rdi] 
    add rdi, type res0 
 fld x0
    fld step0
    faddp st(1), st(0)
    fstp qword ptr [x0]
   loop m0 
    invoke fptoa, qword ptr[res0], addr sres0
    invoke fptoa, qword ptr[res0 + 8h], addr sres1
    invoke fptoa, qword ptr[res0 + 10h], addr sres2
    invoke fptoa, qword ptr[res0 + 18h], addr sres3
    invoke wsprintf, addr text0, addr fmt0, addr sres0, addr sres1, addr sres2, addr sres3
    invoke MessageBox, 0, addr text0, addr title0, MB_OK
    invoke ExitProcess, 0
entry_point endp
end