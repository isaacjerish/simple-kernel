#define IDT_SIZE 256
extern void keyboard_handler(void);
extern unsigned char read_port(unsigned short port);
extern void write_port(unsigned short port, unsigned char data);
extern void load_idt(unsigned long int* idt_desc_ptr);
struct IDT_entry{
	unsigned short int offset_lowerbits;
	unsigned short int selector;
	unsigned char zero;
	unsigned char type_attr;
	unsigned short int offset_higherbits;
};
struct IDT_entry IDT[IDT_SIZE];
void kmain(void) {
    char* vid_memory  = (char*) 0xB8000;
    char* string = "Hello World from Isaac's Kernel!";
    unsigned short int i, j, k;
    i = 0;
    j = 0;
    k = 80 * 25 *2;
    while (i < k) {
        vid_memory[i]= ' ';
        vid_memory[++i] = 0x0C;
        i++;
    }
    i = 0;
    while (string[j]) {
        vid_memory[i] = string[j];
        vid_memory[++i] = 0x0C;
        j++;
        i++;
    }
    idt_init();
    return;

}
void idt_init(void) {
    unsigned long int addy = (unsigned long int)&keyboard_handler;
    IDT[0x21].selector = 0x08;
    IDT[0x21].zero = 0x00;
    IDT[0x21].type_attr = 0x8e;
    IDT[0x21].offset_lowerbits = addy & 0x0000FFFF;
    IDT[0x21].offset_higherbits = (addy >> 16) & 0x0000FFFF;
    write_port(0x20, 0x11); 
    write_port(0xA0, 0x11); 
    write_port(0x21, 0x20); 
    write_port(0xA1, 0x28); 
    write_port(0x21, 0x00);
    write_port(0xA1, 0x00);
    write_port(0x21, 0x01); 
    write_port(0xA1, 0x01); 
    write_port(0x21, 0xFF); 
    write_port(0xA1, 0xFF);
    unsigned long int base_addy = (unsigned long int)IDT;
    unsigned long int idt_ptr[2];
    idt_ptr[1] = base_addy >> 16;
    idt_ptr[0] = ((sizeof(struct IDT_entry) * IDT_SIZE)-1)  + ( (base_addy & 0xffff) << 16 );
    load_idt(idt_ptr);
}
