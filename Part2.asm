



org 100h

jmp start

result1 dw 8 dup('x')  
result2 dw 8 dup('x')
msg1 db "Enter the first number:   $"
spece dw "    $"
Line db 0Dh,0Ah, "$"
msg2 db "Enter the second number:  $" 
A db 0
N dw 38
Q0 db 0
lable db "N       A           Q       Q_1      M$"
num1 db ?
num2 db ?
coun dw 8
m1 db "   mult by $"
m2 db " is $"
v1 db ?
v2 db ?
res1 dw 8 dup('x')
var db ?
duha dw "--------------------------------------------- $"

start:

mov dx, offset msg1                    ; print msg1
mov ah, 9
int 21h


call scan_num                          ; scan num1
mov bx, cx

mov num1,bl   
mov v1,bl
call convert_to_bin                    ; convert num1 to binary and store answer in result1



mov dx, offset Line                    ; print new line
mov ah, 9
int 21h  
  

mov dx, offset msg2                    ; print msg2:
mov ah, 9
int 21h


                                       ; scan num2
call scan_num
mov num2,cl 
mov v2,cl
mov bx, cx                                      
call convert2bin                       ; convert num2 to binary and store answer in result2




       
       
mov dx, offset Line                    ; print new line
mov ah, 9
int 21h
mov dx, offset Line                    ; print new line
mov ah, 9
int 21h
mov dx, offset Lable                   ; print Lable 
mov ah, 9
int 21h
mov dx, offset Line                    ; print new line
mov ah, 9
int 21h

mov dl,'-'                              ; print N=8 
mov ah,02               
int 21h


                                       ; print space
mov ah,09
mov dx,offset spece
int 21h


mov bx,0                               
mov A,0                                ; initialize A=0
call convert_2_bin                     ; convert A to binary and store answer in res1
mov si, offset res1                    
mov ah, 0eh                            
mov cx, 8                              
call prin
 
 
mov ah,09
mov dx,offset spece                    ; print space
int 21h 


                                       ; print the binary of num1
mov si, offset result1                 
mov ah, 0eh                            
mov cx, 8                              
call prin



 
mov ah,09
mov dx,offset spece                    ; print space
int 21h


mov ah,02h                             ; print Q_1=0 initialy
mov dl,48
int 21h


mov ah,09                              ; print space
mov dx,offset spece
int 21h

 
                                       ; print the binary of num1
mov si, offset result2                 
mov ah, 0eh                          
mov cx, 8                               
call prin


mov ah,09
mov dx,offset line                     ; print new line
int 21h
 
                                       
;push v1                                ; put num1 in the stack  
mov coun,38h                             ; set counter to 8

mov al,v1
mov var,al
and var,00000001b                      ; check first step in mult 
cmp var,00000000b
je call shift

cmp var,00000001b
je c
c:
mov Q0,30h
call complement



L1: 

mov bl,v1                               ; check Q_1 if 0 or 1  
mov var,bl
cmp Q0,30h
je call even

cmp Q0,31h
je call odd

loop L1

   


exit:
mov ax,4cH
int 21h


ret 

;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
;/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

;====================================================================================================================================
;====================================================================================================================================
;====================================================================================================================================
;=================================================SHIFT RIGHE========================================================================
;====================================================================================================================================

even proc

and var,00000001b                        ; Q_1=0 , check the next step 
 
cmp var,00000000b
je call shift

  
cmp var,00000001b
je call complement
mov bl,v1
call convert_to_bin
mov bl,A
call convert_2_bin
cmp coun,30h
jle exit

even endp







odd proc                                     ; Q_1=1 , check the next step
;mov var,bx
and var,00000001b 
   
cmp var,00000001b
je call shift
 
  
cmp var,00000000b
je call sum   
mov bl,v1
call convert_to_bin 
mov bl,A
call convert_2_bin


cmp coun,30h
jle exit
odd endp









shift proc 
sar A,1                                     ; arithmatic shift
jc cc                                       ; ckeck if have a carry
  mov bl,A                                  ; store result in binary
  call convert_2_bin                        ; if we don't have a carry in sar A,1 make logic shift to v1(num1)  
 shr v1 ,1                                  ; check if we have a carry in shr v1,1 to store it in Q0
 jc set_Q
 mov Q0,30h 
 mov bl,v1                                  ;print shifting
 call convert_to_bin 
 call pr
 
 
mov ah,09
mov dx,offset duha
int 21h         
mov dx, offset Line
mov ah, 9
int 21h 
sub coun,1h 
cmp coun,30h
jle exit
jmp L1             
             
             
             
             
             
 set_Q:                                         ;set Q0=1
  mov Q0,31h  
  mov bl,v1
  call convert_to_bin
  call pr      
mov ah,09
mov dx,offset duha
int 21h         
mov dx, offset Line
mov ah, 9
int 21h 
sub coun,1h 
cmp coun,30h
jle exit
jmp L1

cc:
mov bl,A                                       ;if we have a carry in sar A,1 that's mean we need to shift it to v1 ( shr v1,1 ,,, then ,,, or v1,00000001b) 
  call convert_2_bin                           ; set Q0 if they have carry from shr v1,1
 shr v1 ,1 
 jc set_Q1
 or v1,10000000b
 mov Q0,30h 
 
 
 mov bl,v1
 call convert_to_bin 
 call pr
 
 
mov ah,09
mov dx,offset duha
int 21h         
mov dx, offset Line
mov ah, 9
int 21h 
sub coun,1h 
cmp coun,30h
jle exit             
jmp L1                        
             
 set_Q1:
 or v1,10000000b
  mov Q0,31h  
  mov bl,v1
  call convert_to_bin
  call pr      
mov ah,09
mov dx,offset duha
int 21h         
mov dx, offset Line
mov ah, 9
int 21h 
sub coun,1h 
cmp coun,30h
jle exit
jmp L1


   
shift endp  





;====================================================================================================================================
;====================================================================================================================================
;=====================================================COMPLEMENT=====================================================================
;====================================================================================================================================
complement proc
;mov Q0,30h                                         ;to calculate -M (complement of M)
mov al,num2 
not al
add al,1 
mov num2 ,al 
call sum1
complement endp  
;====================================================================================================================================
;====================================================================================================================================
;=====================================================SUM============================================================================
;==================================================================================================================================== 
sum1 proc  
 ;mov Q0,31h                                       ;to calculate A+M
 mov al,A
 mov ah,0
 add al,num2 
 mov A,al   
 mov bl,al
 call convert_2_bin  
 call pr
 call shift
sum1 endp 
;====================================================================================================================================
;====================================================================================================================================
;=====================================================SUM============================================================================
;==================================================================================================================================== 
sum proc  
 ;mov Q0,31h                                       ;to calculate A+M
 mov al,A
 mov ah,0
 add al,v2 
 mov A,al   
 mov bl,al
 call convert_2_bin  
 call pr
 call shift
sum endp  
;====================================================================================================================================
;====================================================================================================================================
;===============================================PRINT BINARY=========================================================================
;====================================================================================================================================
prin proc                                         ; to print binary numbers 
print_me:
	mov al, [si]
	int 10h                            ; print in teletype mode.
	inc si
loop print_me
ret
prin endp
;====================================================================================================================================
;====================================================================================================================================
;=============================================TO BINARY==============================================================================
;====================================================================================================================================
convert_to_bin    proc     near         ; function to convert num1 in binary and store it in result1
 pusha
 lea di, result1
 mov cx, 8
print: mov ah, 2                        ; print result in binary
       mov [di], '0'
       test bx, 1000_0000b              ; test first bit.
       jz zero
       mov [di], '1'
zero:  shl bx, 1
       inc di
loop print
 popa
 ret
convert_to_bin   endp
;====================================================================================================================================
;====================================================================================================================================
;==================================================PRINT ANSWERS=====================================================================
;==================================================================================================================================== 
pr proc                                              ; to print each step in mult

mov ah,02
mov dx,coun
int 21h


mov ah,09
mov dx,offset spece
int 21h
 

;call convert_2_bin            
mov si, offset res1  
mov ah, 0eh            
mov cx, 8             
call prin 
 
mov ah,09
mov dx,offset spece
int 21h




mov si, offset result1  
mov ah, 0eh            
mov cx, 8             
call prin
 
mov ah,09
mov dx,offset spece
int 21h


mov ah,02h              ;print Q0
mov dl,Q0
int 21h

mov ah,09
mov dx,offset spece
int 21h
 
mov bl,v2
call convert2bin 

mov si, offset result2  
mov ah, 0eh            
mov cx, 8             
call prin

mov dx, offset Line
mov ah, 9
int 21h  
ret
pr endp 
;====================================================================================================================================
;====================================================================================================================================
;=============================================TO BINARY==============================================================================
;====================================================================================================================================
convert2bin    proc     near
pusha

lea di, result2


mov cx, 8
print1: mov ah, 2   
       mov [di], '0'
       test bx, 1000_0000b 
       jz zero1
       mov [di], '1'
zero1:  shl bx, 1
       inc di
loop print1

popa
ret
convert2bin   endp
;====================================================================================================================================
;====================================================================================================================================
;=============================================TO BINARY==============================================================================
;====================================================================================================================================
convert_2_bin    proc     near
pusha

lea di, res1

mov cx, 8
print11: mov ah, 2   
       mov [di], '0'
       test bx, 1000_0000b  
       jz zero11
       mov [di], '1'
zero11:  shl bx, 1
       inc di
loop print11

popa
ret
convert_2_bin   endp


;====================================================================================================================================
;====================================================================================================================================
;====================================================================================================================================
;====================================================================================================================================
; this macro prints a char in al and advances the current cursor position:
putc    macro   char
        push    ax
        mov     al, char
        mov     ah, 0eh
        int     10h     
        pop     ax
endm

;====================================================================================================================================
;====================================================================================================================================
;=============================================SCAN NUMBERS===========================================================================
;====================================================================================================================================

scan_num        proc    near
        push    dx
        push    ax
        push    si
        
        mov     cx, 0

       
        mov     cs:MakeMin, 0

nDig:

        
        mov     ah, 00h
        int     16h
       
        mov     ah, 0eh
        int     10h

       
        cmp     al, '-'
        je      SetMin

        
        cmp     al, 13  
        jne     notCrr
        jmp     nInput
notCrr:


        cmp     al, 8                   
        jne     backChecked
        mov     dx, 0                   
        mov     ax, cx                  
        div     cs:Ten                 
        mov     cx, ax
        putc    ' '                     
        putc    8                       
        jmp     nDig
backChecked:


        
        cmp     al, '0'
        jae     Ok
        jmp     RemoveNDig
Ok:        
        cmp     al, '9'
        jbe     OkDig
RemoveNDig:       
        putc    8       
        putc    ' '     
        putc    8               
        jmp     nDig      
OkDig:


      
        push    ax
        mov     ax, cx
        mul     cs:Ten                  
        mov     cx, ax
        pop     ax

        
        sub     al, 30h

       
        mov     ah, 0
        mov     dx, cx      
        add     cx, ax

        jmp     nDig

SetMin:
        mov     cs:MakeMin, 1
        jmp     nDig


        
nInput:
       
        cmp     cs:MakeMin, 0
        je      nMin
        neg     cx
nMin:

        pop     si
        pop     ax
        pop     dx
        ret
MakeMin      db      ?       
Ten             dw      10      
scan_num        endp     


;////////////////////////////////////////////////////////////////////////////////////////
;////////////////////////////////////////////////////////////////////////////////////////
;----------------------------------------------------------------------------------------
;========================================================================================
;---------------------------------------------------------------------------------------
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\









