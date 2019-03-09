//! Boot init code

use super::device_tree;
use super::memory;
use super::trap;

#[no_mangle]
pub extern "C" fn abort() {
    panic!("abort");
}

#[no_mangle]
pub extern "C" fn boot_first_hart(_hartid: usize, dtb: usize) -> ! {
    trap::init();
    memory::clear_bss();
    memory::init_heap();
    device_tree::init(dtb);

    loop {}
}

global_asm!(include_str!("trap.asm"));
global_asm!(include_str!("boot.asm"));
