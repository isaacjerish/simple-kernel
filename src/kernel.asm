       bits 32
       section .text
       
       align 4
       dd 0x1BADB002 ;the magic number for multiboot spec header
       dd 0x00 ; the flags for multiboost spec header
       dd - (0x1BADB002 + 0x00) ;checksum 
       
       global start
       extern kmain
       
start:  
       cli
       mov esp, stack
       call kmain
       hlt
       
       section .bss
       resb 8000
stack:  