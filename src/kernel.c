void kmain(void) {
    volatile char* video_memory = (volatile char*)0xb8000;
    video_memory[0] = 'T';
    video_memory[1] = 0x0F; 
}
