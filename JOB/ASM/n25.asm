include \masm64\include64\masm64rt.inc
;Yn=25x^3-2,1  Вычислить 3 значения  функции Y = 3,3 * log2(x^2 +1) (x изменяется с шагом 0,3)
.const
 title0 db"Number 25",0
fmt0 db "Y = 3,3 * log2(x^2 +1); X0 = 1; STEP = 0.3", 10,
 "Y0 = %s", 10,
 "Y1 = %s", 10,
 "Y2 = %s", 10, 10,
 "Author: SEREBRYAKOV VIKTOR SERGEEVICH K-19-1",0
const1 dq 3.3
step0 dq 0.3
loop_count0 dq 3
.data
 x0 dq 1.0
 res1 dq 4 dup(0.0) 
 text0 db 256 dup(0)
 sres0 db 32 dup(0)
 sres1 db 32 dup(0)
 sres2 db 32 dup(0)
.code
entry_point proc
    lea rdi, res1
    mov rcx, loop_count0 
    finit
m0:
fld const1
fld x0 
fmul x0 ;x^2
fyl2xp1 ;3,3 * log2(x^2 +1)
fstp qword ptr [rdi] 
add rdi, type res1 
fld x0
fld step0
faddp st(1), st(0)
fstp qword ptr [x0]
loop m0 
 invoke fptoa, qword ptr[res1], addr sres0
 invoke fptoa, qword ptr[res1 + 8h], addr sres1
 invoke fptoa, qword ptr[res1 + 10h], addr sres2
 invoke wsprintf, addr text0, addr fmt0, addr sres0, addr sres1, addr sres2
 invoke MessageBox, 0, addr text0, addr title0, MB_OK
 invoke ExitProcess, 0
entry_point endp
end