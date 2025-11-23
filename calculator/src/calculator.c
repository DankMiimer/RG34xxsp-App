#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>

#define SCREEN_WIDTH 720
#define SCREEN_HEIGHT 480
#define BUTTON_WIDTH 140
#define BUTTON_HEIGHT 70
#define DISPLAY_HEIGHT 80
#define MAX_DISPLAY 16

typedef struct {
    SDL_Rect rect;
    char label[3];
    SDL_Color color;
    SDL_Color text_color;
} Button;

typedef enum {
    OP_NONE,
    OP_ADD,
    OP_SUBTRACT,
    OP_MULTIPLY,
    OP_DIVIDE
} Operation;

// Calculator state
char display[MAX_DISPLAY + 1] = "0";
double stored_value = 0.0;
Operation current_operation = OP_NONE;
bool new_number = true;
bool error_state = false;

// Colors
SDL_Color COLOR_BG = {30, 30, 35, 255};
SDL_Color COLOR_DISPLAY = {20, 20, 25, 255};
SDL_Color COLOR_BUTTON = {60, 60, 70, 255};
SDL_Color COLOR_BUTTON_HOVER = {80, 80, 90, 255};
SDL_Color COLOR_BUTTON_OP = {100, 120, 180, 255};
SDL_Color COLOR_BUTTON_SPECIAL = {180, 80, 80, 255};
SDL_Color COLOR_TEXT = {255, 255, 255, 255};
SDL_Color COLOR_DISPLAY_TEXT = {100, 255, 150, 255};

// Button definitions (4 rows x 5 cols)
Button buttons[20];
int selected_button = 0;

void init_buttons() {
    const char* labels[20] = {
        "C", "(", ")", "/", "AC",
        "7", "8", "9", "*", "DEL",
        "4", "5", "6", "-", ".",
        "1", "2", "3", "+", "0",
    };

    int idx = 0;
    for (int row = 0; row < 4; row++) {
        for (int col = 0; col < 5; col++) {
            buttons[idx].rect.x = 10 + col * (BUTTON_WIDTH + 4);
            buttons[idx].rect.y = DISPLAY_HEIGHT + 10 + row * (BUTTON_HEIGHT + 4);
            buttons[idx].rect.w = BUTTON_WIDTH;
            buttons[idx].rect.h = BUTTON_HEIGHT;
            strncpy(buttons[idx].label, labels[idx], 2);
            buttons[idx].label[2] = '\0';

            // Set button colors based on type
            if (strcmp(labels[idx], "C") == 0 || strcmp(labels[idx], "AC") == 0 ||
                strcmp(labels[idx], "DEL") == 0) {
                buttons[idx].color = COLOR_BUTTON_SPECIAL;
            } else if (strcmp(labels[idx], "+") == 0 || strcmp(labels[idx], "-") == 0 ||
                       strcmp(labels[idx], "*") == 0 || strcmp(labels[idx], "/") == 0) {
                buttons[idx].color = COLOR_BUTTON_OP;
            } else {
                buttons[idx].color = COLOR_BUTTON;
            }
            buttons[idx].text_color = COLOR_TEXT;
            idx++;
        }
    }
}

void append_digit(char digit) {
    if (error_state) return;

    if (new_number) {
        display[0] = digit;
        display[1] = '\0';
        new_number = false;
    } else {
        size_t len = strlen(display);
        if (len < MAX_DISPLAY) {
            display[len] = digit;
            display[len + 1] = '\0';
        }
    }
}

void append_decimal() {
    if (error_state) return;

    // Check if decimal already exists
    if (strchr(display, '.') != NULL) return;

    if (new_number) {
        strcpy(display, "0.");
        new_number = false;
    } else {
        size_t len = strlen(display);
        if (len < MAX_DISPLAY - 1) {
            display[len] = '.';
            display[len + 1] = '\0';
        }
    }
}

void delete_last() {
    if (error_state) {
        error_state = false;
        strcpy(display, "0");
        return;
    }

    size_t len = strlen(display);
    if (len > 1) {
        display[len - 1] = '\0';
    } else {
        strcpy(display, "0");
        new_number = true;
    }
}

void clear_display() {
    strcpy(display, "0");
    new_number = true;
    error_state = false;
}

void clear_all() {
    strcpy(display, "0");
    stored_value = 0.0;
    current_operation = OP_NONE;
    new_number = true;
    error_state = false;
}

double get_display_value() {
    return atof(display);
}

void set_display_value(double value) {
    if (isnan(value) || isinf(value)) {
        strcpy(display, "Error");
        error_state = true;
        return;
    }

    // Format the number
    if (fabs(value) < 0.0001 && value != 0.0) {
        snprintf(display, MAX_DISPLAY, "%.6e", value);
    } else if (fabs(value) > 9999999999.0) {
        snprintf(display, MAX_DISPLAY, "%.6e", value);
    } else {
        snprintf(display, MAX_DISPLAY, "%.8g", value);
    }

    new_number = true;
}

void calculate() {
    if (error_state) return;

    double current_value = get_display_value();
    double result = stored_value;

    switch (current_operation) {
        case OP_ADD:
            result = stored_value + current_value;
            break;
        case OP_SUBTRACT:
            result = stored_value - current_value;
            break;
        case OP_MULTIPLY:
            result = stored_value * current_value;
            break;
        case OP_DIVIDE:
            if (current_value == 0.0) {
                strcpy(display, "Error");
                error_state = true;
                current_operation = OP_NONE;
                return;
            }
            result = stored_value / current_value;
            break;
        case OP_NONE:
            result = current_value;
            break;
    }

    set_display_value(result);
    stored_value = result;
    current_operation = OP_NONE;
}

void set_operation(Operation op) {
    if (error_state) return;

    if (current_operation != OP_NONE && !new_number) {
        calculate();
    } else {
        stored_value = get_display_value();
    }

    current_operation = op;
    new_number = true;
}

void handle_button_press(int button_idx) {
    const char* label = buttons[button_idx].label;

    if (strcmp(label, "AC") == 0) {
        clear_all();
    } else if (strcmp(label, "C") == 0) {
        clear_display();
    } else if (strcmp(label, "DEL") == 0) {
        delete_last();
    } else if (strcmp(label, ".") == 0) {
        append_decimal();
    } else if (strcmp(label, "+") == 0) {
        set_operation(OP_ADD);
    } else if (strcmp(label, "-") == 0) {
        set_operation(OP_SUBTRACT);
    } else if (strcmp(label, "*") == 0) {
        set_operation(OP_MULTIPLY);
    } else if (strcmp(label, "/") == 0) {
        set_operation(OP_DIVIDE);
    } else if (strcmp(label, "0") == 0) {
        if (strcmp(display, "0") != 0 || !new_number) {
            append_digit('0');
        }
    } else if (label[0] >= '1' && label[0] <= '9') {
        append_digit(label[0]);
    } else if (strcmp(label, "(") == 0 || strcmp(label, ")") == 0) {
        // Parentheses not implemented yet
    }
}

void render_button(SDL_Renderer* renderer, TTF_Font* font, Button* btn, bool is_selected) {
    // Draw button background
    SDL_Color color = is_selected ? COLOR_BUTTON_HOVER : btn->color;
    SDL_SetRenderDrawColor(renderer, color.r, color.g, color.b, color.a);
    SDL_RenderFillRect(renderer, &btn->rect);

    // Draw button border
    SDL_SetRenderDrawColor(renderer, 40, 40, 50, 255);
    SDL_RenderDrawRect(renderer, &btn->rect);

    // Draw button text
    SDL_Surface* text_surface = TTF_RenderText_Blended(font, btn->label, btn->text_color);
    if (text_surface) {
        SDL_Texture* text_texture = SDL_CreateTextureFromSurface(renderer, text_surface);
        if (text_texture) {
            SDL_Rect text_rect;
            text_rect.w = text_surface->w;
            text_rect.h = text_surface->h;
            text_rect.x = btn->rect.x + (btn->rect.w - text_rect.w) / 2;
            text_rect.y = btn->rect.y + (btn->rect.h - text_rect.h) / 2;
            SDL_RenderCopy(renderer, text_texture, NULL, &text_rect);
            SDL_DestroyTexture(text_texture);
        }
        SDL_FreeSurface(text_surface);
    }
}

void render_display(SDL_Renderer* renderer, TTF_Font* font) {
    // Draw display background
    SDL_Rect display_rect = {10, 10, SCREEN_WIDTH - 20, DISPLAY_HEIGHT - 10};
    SDL_SetRenderDrawColor(renderer, COLOR_DISPLAY.r, COLOR_DISPLAY.g,
                          COLOR_DISPLAY.b, COLOR_DISPLAY.a);
    SDL_RenderFillRect(renderer, &display_rect);

    // Draw display border
    SDL_SetRenderDrawColor(renderer, 40, 40, 50, 255);
    SDL_RenderDrawRect(renderer, &display_rect);

    // Draw display text (right-aligned)
    SDL_Surface* text_surface = TTF_RenderText_Blended(font, display, COLOR_DISPLAY_TEXT);
    if (text_surface) {
        SDL_Texture* text_texture = SDL_CreateTextureFromSurface(renderer, text_surface);
        if (text_texture) {
            SDL_Rect text_rect;
            text_rect.w = text_surface->w;
            text_rect.h = text_surface->h;
            text_rect.x = display_rect.x + display_rect.w - text_rect.w - 20;
            text_rect.y = display_rect.y + (display_rect.h - text_rect.h) / 2;
            SDL_RenderCopy(renderer, text_texture, NULL, &text_rect);
            SDL_DestroyTexture(text_texture);
        }
        SDL_FreeSurface(text_surface);
    }
}

int main(int argc, char* argv[]) {
    // Initialize SDL
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_GAMECONTROLLER) != 0) {
        fprintf(stderr, "SDL_Init Error: %s\n", SDL_GetError());
        return 1;
    }

    // Initialize SDL_ttf
    if (TTF_Init() != 0) {
        fprintf(stderr, "TTF_Init Error: %s\n", TTF_GetError());
        SDL_Quit();
        return 1;
    }

    // Create window
#ifdef HANDHELD
    SDL_Window* window = SDL_CreateWindow("Calculator",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
        SCREEN_WIDTH, SCREEN_HEIGHT,
        SDL_WINDOW_FULLSCREEN);
#else
    SDL_Window* window = SDL_CreateWindow("Calculator",
        SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED,
        SCREEN_WIDTH, SCREEN_HEIGHT,
        SDL_WINDOW_SHOWN);
#endif

    if (!window) {
        fprintf(stderr, "SDL_CreateWindow Error: %s\n", SDL_GetError());
        TTF_Quit();
        SDL_Quit();
        return 1;
    }

    // Create renderer
    SDL_Renderer* renderer = SDL_CreateRenderer(window, -1,
        SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (!renderer) {
        fprintf(stderr, "SDL_CreateRenderer Error: %s\n", SDL_GetError());
        SDL_DestroyWindow(window);
        TTF_Quit();
        SDL_Quit();
        return 1;
    }

    // Load font
    TTF_Font* font = TTF_OpenFont("/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf", 32);
    if (!font) {
        // Try alternative font locations
        font = TTF_OpenFont("/usr/share/fonts/TTF/DejaVuSans-Bold.ttf", 32);
        if (!font) {
            font = TTF_OpenFont("./font.ttf", 32);
            if (!font) {
                fprintf(stderr, "TTF_OpenFont Error: %s\n", TTF_GetError());
                SDL_DestroyRenderer(renderer);
                SDL_DestroyWindow(window);
                TTF_Quit();
                SDL_Quit();
                return 1;
            }
        }
    }

    // Initialize buttons
    init_buttons();

    // Main loop
    bool running = true;
    SDL_Event event;

    while (running) {
        // Handle events
        while (SDL_PollEvent(&event)) {
            if (event.type == SDL_QUIT) {
                running = false;
            } else if (event.type == SDL_KEYDOWN) {
                switch (event.key.keysym.sym) {
                    case SDLK_ESCAPE:
                    case SDLK_q:
                        running = false;
                        break;
                    case SDLK_LEFT:
                        selected_button = (selected_button - 1 + 20) % 20;
                        break;
                    case SDLK_RIGHT:
                        selected_button = (selected_button + 1) % 20;
                        break;
                    case SDLK_UP:
                        selected_button = (selected_button - 5 + 20) % 20;
                        break;
                    case SDLK_DOWN:
                        selected_button = (selected_button + 5) % 20;
                        break;
                    case SDLK_RETURN:
                    case SDLK_SPACE:
                    case SDLK_a: // A button on handheld
                        handle_button_press(selected_button);
                        break;
                    case SDLK_BACKSPACE:
                        delete_last();
                        break;
                    case SDLK_DELETE:
                        clear_all();
                        break;
                    // Number keys
                    case SDLK_0: case SDLK_KP_0: append_digit('0'); break;
                    case SDLK_1: case SDLK_KP_1: append_digit('1'); break;
                    case SDLK_2: case SDLK_KP_2: append_digit('2'); break;
                    case SDLK_3: case SDLK_KP_3: append_digit('3'); break;
                    case SDLK_4: case SDLK_KP_4: append_digit('4'); break;
                    case SDLK_5: case SDLK_KP_5: append_digit('5'); break;
                    case SDLK_6: case SDLK_KP_6: append_digit('6'); break;
                    case SDLK_7: case SDLK_KP_7: append_digit('7'); break;
                    case SDLK_8: case SDLK_KP_8: append_digit('8'); break;
                    case SDLK_9: case SDLK_KP_9: append_digit('9'); break;
                    case SDLK_PERIOD: case SDLK_KP_PERIOD: append_decimal(); break;
                    case SDLK_PLUS: case SDLK_KP_PLUS: set_operation(OP_ADD); break;
                    case SDLK_MINUS: case SDLK_KP_MINUS: set_operation(OP_SUBTRACT); break;
                    case SDLK_ASTERISK: case SDLK_KP_MULTIPLY: set_operation(OP_MULTIPLY); break;
                    case SDLK_SLASH: case SDLK_KP_DIVIDE: set_operation(OP_DIVIDE); break;
                    case SDLK_EQUALS: case SDLK_KP_EQUALS: calculate(); break;
                    case SDLK_c: clear_display(); break;
                }
            }
        }

        // Render
        SDL_SetRenderDrawColor(renderer, COLOR_BG.r, COLOR_BG.g, COLOR_BG.b, COLOR_BG.a);
        SDL_RenderClear(renderer);

        // Render display
        render_display(renderer, font);

        // Render buttons
        for (int i = 0; i < 20; i++) {
            render_button(renderer, font, &buttons[i], i == selected_button);
        }

        SDL_RenderPresent(renderer);
        SDL_Delay(16); // ~60 FPS
    }

    // Cleanup
    TTF_CloseFont(font);
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(window);
    TTF_Quit();
    SDL_Quit();

    return 0;
}
