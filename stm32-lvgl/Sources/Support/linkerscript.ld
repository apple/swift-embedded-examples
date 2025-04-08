MEMORY
{
   flash (rx)      : ORIGIN = 0x08000000, LENGTH = 1024K  /* end: 0x08100000 */
   sram_stack (rw) : ORIGIN = 0x20000000, LENGTH = 32K    /* end: 0x20008000 */
   sram_data (rw)  : ORIGIN = 0x20008000, LENGTH = 160K   /* end: 0x20030000 */
   sram_heap (rw)  : ORIGIN = 0x20030000, LENGTH = 128K   /* end: 0x20050000 */
}

SECTIONS
{
  .text     : { *(.vectors*) ; *(.text*) } > flash
  .rodata   : { *(.rodata*) ; *(.got*) } > flash
   
  __flash_data_start = (. + 3) & ~ 3; /* 4-byte aligned end of text is where data is going to be placed (by elf2hex) */ 

  .bss      : { *(.bss*) } > sram_data
  .tbss      : { *(.tbss*) } > sram_data
  .data     : { *(.data*) } > sram_data
   
  __flash_data_len   = . - ORIGIN(sram_data);
  
  /* TODO: Add a safeguard to detect when adding data to flash would overflow the flash memory */
  
  /DISCARD/ : { *(.swift_modhash*) }
  
  /* ARM metadata sections */
  /DISCARD/ : { *(.ARM.attributes*) *(.ARM.exidx) }
  
  /* ELF metadata sections */
  .symtab   : { *(.symtab) }
  .strtab   : { *(.strtab) }
  .shstrtab : { *(.shstrtab) }
  .debug    : { *(.debug*) }
  .comment  : { *(.comment) }
}

__stack_start      = ORIGIN(sram_stack);
__stack_end        = ORIGIN(sram_stack) + LENGTH(sram_stack);

__data_start      = ORIGIN(sram_data);
__data_end        = ORIGIN(sram_data) + LENGTH(sram_data);

__heap_start      = ORIGIN(sram_heap);
__heap_end        = ORIGIN(sram_heap) + LENGTH(sram_heap);
