#include <stdint.h>
#include "memory_map.h"

__attribute__((naked)) static void start_app(uint32_t pc, uint32_t sp) {
    __asm("           \n\
          msr msp, r1 /* load r1 into MSP */\n\
          bx r0       /* branch to the address at r0 */\n\
    ");
    (void)pc;
    (void)sp;
}

int main(void) {
  uint32_t *app_code = (uint32_t *)__app1_flash_start__;
  uint32_t app_sp = app_code[0];
  uint32_t app_start = app_code[1];
  start_app(app_start, app_sp);
  /* Not Reached */
  while (1) {};
  return 0;
}