#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define BACKLIGHT_SUFFIX "/brightness"
#define MAX_BRIGHTNESS_SUFFIX "/max_brightness"


int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Usage: %s <backlight_path> <brightness>\n", argv[0]);
        return 1;
    }

    char *backlight_path = argv[1];
    char *brightness = argv[2];
    FILE *brightness_file = NULL;
    FILE *max_brightness_file = NULL;

    char *brightness_path = malloc(strlen(backlight_path) + strlen(BACKLIGHT_SUFFIX) + 1);
    strcpy(brightness_path, backlight_path);
    strcat(brightness_path, BACKLIGHT_SUFFIX);

    char *max_brightness_path = malloc(strlen(backlight_path) + strlen(MAX_BRIGHTNESS_SUFFIX) + 1);
    strcpy(max_brightness_path, backlight_path);
    strcat(max_brightness_path, MAX_BRIGHTNESS_SUFFIX);

    brightness_file = fopen(brightness_path, "w");
    if (brightness_file == NULL) {
        printf("Failed to open brightness file: %s\n", brightness_path);
        goto cleanup;
    }

    max_brightness_file = fopen(max_brightness_path, "r");
    if (max_brightness_file == NULL) {
        printf("Failed to open max brightness file: %s\n", max_brightness_path);
        goto cleanup;
    }

    char max_brightness[10];
    fgets(max_brightness, 10, max_brightness_file);

    int max_brightness_value = atoi(max_brightness);
    int brightness_value = atoi(brightness);

    if (brightness_value < 0 || brightness_value > max_brightness_value) {
        printf("Brightness out of range: %d\n", brightness_value);
        goto cleanup;
    }

    fprintf(brightness_file, "%d", brightness_value);

cleanup:
    if (brightness_file != NULL) {
        fclose(brightness_file);
    }
    if (max_brightness_file != NULL) {
        fclose(max_brightness_file);
    }

    free(brightness_path);
    free(max_brightness_path);

    return 0;
}
