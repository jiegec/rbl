//! RBL Library

#![feature(lang_items)]
#![feature(alloc)]
#![feature(global_asm)]
#![feature(panic_info_message)]
#![no_std]
#![deny(warnings)]

extern crate alloc;
extern crate lazy_static;
extern crate spin;
extern crate volatile;

#[macro_use]
extern crate bitflags;

use linked_list_allocator::LockedHeap;

#[macro_use]
mod serial;
mod boot;
mod consts;
mod device_tree;
mod lang_items;
mod memory;
mod trap;

#[global_allocator]
static HEAP_ALLOCATOR: LockedHeap = LockedHeap::empty();
