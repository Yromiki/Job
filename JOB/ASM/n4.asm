include \masm64\include64\masm64rt.inc
; Yn = 5,1x^2 + 5,3 (х изменяется от 4,7 с шагом 3)
.const
 title0 db"Number 4",0
fmt0 db "5,1x^2 + 5,3; X0 = 4,7; STEP = 3", 10,
 "Y0 = %s", 10,
 "Y1 = %s", 10,
 "Y2 = %s", 10,
 "Y3 = %s", 10, 10,
 "Author: SEREBRYAKOV VIKTOR SERGEEVICH K-19-1" ,0
const0 dq 5.1
const1 dq 5.3
step0 dq 3.0
loop_count0 dq 4
.data
    x0 dq 4.7
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
	fadd const1
	frndint
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