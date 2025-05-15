void kmain(void) {
    char* vid_memory  = (char*) 0xB8000;
    char* string = "Hello World from Isaac's Kernel!";
    unsigned short i, j, k;
    i = 0;
    j = 0;
    k = 80 * 25 *2;
    while (i < k) {
        vid_memory[i]= ' ';
        vid_memory[++i] = 0x0C;
        i++;
    }

}
