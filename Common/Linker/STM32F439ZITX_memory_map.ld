/* Memories definition */
MEMORY
{
  CCMRAM      (xrw)   : ORIGIN = 0x10000000,   LENGTH = 64K
  RAM         (xrw)   : ORIGIN = 0x20000000,   LENGTH = 192K
  BOOT_FLASH  (rx)    : ORIGIN = 0x08000000,   LENGTH = 128K
  APP1_FLASH  (rx)    : ORIGIN = 0x08020000,   LENGTH = 896K
  APP2_FLASH  (rx)    : ORIGIN = 0x08100000,   LENGTH = 896K
  SWAP        (rx)    : ORIGIN = 0x081E0000,   LENGTH = 128K
}

__boot_flash_start__ = ORIGIN(BOOT_FLASH);
__boot_flash_size__ = LENGTH(BOOT_FLASH);
__app1_flash_start__ = ORIGIN(APP1_FLASH);
__app1_flash_size__ = LENGTH(APP1_FLASH);
__app2_flash_start__ = ORIGIN(APP2_FLASH);
__app2_flash_size__ = LENGTH(APP2_FLASH);
__swap_start__ = ORIGIN(SWAP);
__swap_size__ = LENGTH(SWAP);