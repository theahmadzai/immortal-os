#define VIDEO_MEMORY 0xb8000

void print(char *);

void _start(void)
{
    print("Executing kernel!!");

    while (1)
    {
    }
}

void print(char *message)
{
    char *p_video_buffer = (char *)VIDEO_MEMORY;
    char *p_next_char = message;

    while (*p_next_char)
    {
        *p_video_buffer = *p_next_char;
        p_next_char += 0x1;
        p_video_buffer += 0x2;
    }
}
