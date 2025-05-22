            bits 32
            section .text
            
            align 4
            dd 0x1BADB002 ;the magic number for multiboot spec header
            dd 0x00 ; the flags for multiboost spec header
            dd - (0x1BADB002 + 0x00) ;checksum 
            
            global start
            global read_port
            global write_port
            global load_idt
            extern kmain
            
start:  
            cli
            mov esp, stack
            call kmain
            hlt
read_port:  
            mov edx, [esp + 4]
            in al, dx
            ret
write_port:  
            mov edx, [esp +4]
            mov al, [esp + 8]
            out dx, al
            ret
load_idt:  
            mov edx, [esp+4]
            lidt [edx]
            sti
            ret 
            
            section .bss
            resb 8000
            
stack:  