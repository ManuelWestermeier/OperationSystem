extern "C" void kernel_main() {
    char* video_memory = (char*)0xb8000;
    const char* str = "Hello, World!";
    int i = 0;

    while (str[i] != '\0') {
        video_memory[i * 2] = str[i];
        video_memory[i * 2 + 1] = 0x07; // White text on black background
        i++;
    }

    while (1); // Halt the CPU
}