void kernel_main() {
    const char *message = "Hello from sleep OS";
    unsigned short *video_memory = (unsigned short *)0xB8000;

    // Виведемо повідомлення на екран
    for (int i = 0; message[i] != '\0'; i++) {
        video_memory[i] = (unsigned short)message[i] | 0x0F00;  // Чорний текст на білому фоні
    }

    // "Спокій"
    while (1) {
        // нескінченний цикл, поки комп'ютер не вимкнеться
    }
}
