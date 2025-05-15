#define IDT_SIZE 256
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
    return;

}
