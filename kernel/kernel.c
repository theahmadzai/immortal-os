#include "type.h"

#define VIDEO_MEMORY 0xB8000

void print(const unsigned char *);

void _start(void)
{
    print("Executing kernel!!");

    while (1)
    {
    }
}

struct screen_letter
{
    u8 letter;
    u8 color;
};

void print(const u8 *message)
{
    volatile struct screen_letter *p_video_buffer = (volatile struct screen_letter *)VIDEO_MEMORY;
    const u8 *p_next_char = message;

    while (*p_next_char)
    {
        p_video_buffer->letter = *p_next_char;
        p_video_buffer->color = 0x0F;
        p_video_buffer += 0x1;
        p_next_char += 0x1;
    }
}
