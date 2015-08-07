
#ifdef NEED_UNDERSCORE
# define TRANSFORM_SYMBOLS
# define EXPORT_SYMBOL(sym) _ ## sym
#endif

#ifndef TRANSFORM_SYMBOLS

# define GLOBAL(sym) \
  .global sym; \
  sym ##:

# define GLOBAL_FUNC(sym) \
  GLOBAL (sym)

#else

# define GLOBAL(sym) \
  .global EXPORT_SYMBOL (sym); \
  EXPORT_SYMBOL (sym) ##: \
  sym ##:

# define GLOBAL_FUNC(sym) \
  .global sym; \
  GLOBAL (sym)

#endif

.text

.global EXPORT_SYMBOL(disk_err);
.global EXPORT_SYMBOL(data_159728);
.global EXPORT_SYMBOL(data_15972c);
.global EXPORT_SYMBOL(data_15978c);
.global EXPORT_SYMBOL(data_159790);
.global EXPORT_SYMBOL(data_16207c);
.global EXPORT_SYMBOL(sound_dig_ini_filename);
.global EXPORT_SYMBOL(sound_mdi_ini_filename);
.global EXPORT_SYMBOL(sound_driver_directory);

/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_vmm_lock)
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%edx
		mov    0x8(%esp),%eax
		add    %edx,%eax
		push   %eax
		push   %edx
		call   VMM_lock_range
		add    $0x8,%esp
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_vmm_unlock)
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%edx
		mov    0x8(%esp),%eax
		add    %edx,%eax
		push   %eax
		push   %edx
		call   VMM_unlock_range
		add    $0x8,%esp
		ret


/*----------------------------------------------------------------*/
FILE_size:
/*----------------------------------------------------------------*/
		push   %ebx
		push   $0x200
		mov    0xc(%esp),%ebx
		xor    %edx,%edx
		push   %ebx
		mov    %edx,EXPORT_SYMBOL(disk_err)
		call   ac_dos_open
		add    $0x8,%esp
		mov    %eax,%edx
		cmp    $0xffffffff,%eax
		jne    jump_10fafe
		movl   $0x3,EXPORT_SYMBOL(disk_err)
		pop    %ebx
		ret
	jump_10fafe:
		call   _filelength
		mov    %eax,%ebx
		cmp    $0xffffffff,%eax
		jne    jump_10fb14
		movl   $0x5,EXPORT_SYMBOL(disk_err)
	jump_10fb14:
		mov    %edx,%eax
		call   ac_close
		mov    %ebx,%eax
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
FILE_read:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x18(%esp),%esi
		mov    0x14(%esp),%ebx
		xor    %edx,%edx
		push   %ebx
		mov    %edx,EXPORT_SYMBOL(disk_err)
		call   FILE_size
		add    $0x4,%esp
		mov    %eax,%edi
		cmp    $0xffffffff,%eax
		jne    jump_10fb56
		mov    $0x3,%edx
		xor    %eax,%eax
		mov    %edx,EXPORT_SYMBOL(disk_err)
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_10fb56:
		test   %esi,%esi
		jne    jump_10fb64
		call   *EXPORT_SYMBOL(data_15978c)
		mov    %eax,%ecx
		jmp    jump_10fb66
	jump_10fb64:
		mov    %esi,%ecx
	jump_10fb66:
		test   %ecx,%ecx
		jne    jump_10fb7b
		movl   $0x2,EXPORT_SYMBOL(disk_err)
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_10fb7b:
		push   $0x200
		mov    0x18(%esp),%esi
		push   %esi
		call   ac_dos_open
		mov    %eax,%esi
		add    $0x8,%esp
		cmp    $0xffffffff,%eax
		jne    jump_10fbae
		mov    %ecx,%eax
		mov    $0x3,%ebp
		call   *EXPORT_SYMBOL(data_159790)
		mov    %ebp,EXPORT_SYMBOL(disk_err)
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_10fbae:
		mov    %edi,%ebx
		mov    %ecx,%edx
		call   ac_read
		cmp    %edi,%eax
		je     jump_10fbd5
		mov    %ecx,%eax
		mov    $0x5,%edi
		call   *EXPORT_SYMBOL(data_159790)
		mov    %edi,EXPORT_SYMBOL(disk_err)
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_10fbd5:
		mov    %esi,%eax
		call   ac_close
		mov    %ecx,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILDEBUG_start_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_159328
		jne    jump_101775
		push   $AILDEBUG_end_
		push   $AILDEBUG_start_
		call   VMM_lock_range
		add    $0x8,%esp
		push   $0x4
		push   $AIL_debug
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $AIL_sys_debug
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $ail_debug_file
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1e8fac
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1e8fbc
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1e8fb8
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1e8fc0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1e8fb0
		mov    $0x1,%ebx
		call   AIL_vmm_lock
		add    $0x8,%esp
		mov    %ebx,data_159328
	jump_101775:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_101780:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    data_1e8fac,%edx
		cmp    $0x63,%edx
		jne    jump_1017a7
		mov    data_1e8fbc,%ebx
		cmp    $0x3b,%ebx
		jne    jump_1017a7
		cmp    data_1e8fb8,%ebx
		jne    jump_1017a7
		cmp    data_1e8fc0,%edx
		je     jump_1017ec
	jump_1017a7:
		incl   data_1e8fc0
		cmpl   $0x64,data_1e8fc0
		jne    jump_1017ec
		xor    %eax,%eax
		mov    %eax,data_1e8fc0
		incl   data_1e8fb8
		mov    data_1e8fb8,%ebx
		cmp    $0x3c,%ebx
		jne    jump_1017ec
		mov    %eax,data_1e8fb8
		incl   data_1e8fbc
		cmp    data_1e8fbc,%ebx
		jne    jump_1017ec
		mov    %eax,data_1e8fbc
		incl   data_1e8fac
	jump_1017ec:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
TIME_write_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		call   AIL_API_lock
		mov    data_1e8fac,%ebp
		mov    data_1e8fbc,%edi
		mov    data_1e8fb8,%esi
		mov    data_1e8fc0,%ebx
		call   AIL_API_unlock
		cmpl   $0x1,AIL_indent
		jne    jump_10183b
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		push   $data_1600f4
		mov    ail_debug_file,%ebx
		push   %ebx
		call   ac_fprintf
		add    $0x18,%esp
		jmp    jump_10185a
	jump_10183b:
		xor    %edx,%edx
		lea    0x0(%eax),%eax
	jump_101840:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_101840
	jump_10185a:
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_101886
	jump_101867:
		push   $data_160114
		mov    ail_debug_file,%edi
		push   %edi
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%ebp
		add    $0x8,%esp
		cmp    %ebp,%edx
		jb     jump_101867
	jump_101886:
		mov    $0x1,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_startup)	/* 1018a0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x4,%esp
		call   AILDEBUG_start_
		xor    %edx,%edx
		mov    $data_160118,%eax /* "AIL_DEBUG" */
		mov    %edx,AIL_debug
		mov    %edx,AIL_sys_debug
		call   ac_getenv
		mov    %eax,%ebx
		test   %eax,%eax
		jne    jump_1018d4
		call   AIL_API_startup
		jmp    jump_101a38
	jump_1018d4:
		mov    $data_160124,%eax /* "AIL_SYS_DEBUG" */
		call   ac_getenv
		test   %eax,%eax
		je     jump_1018ec
		movl   $0x1,AIL_sys_debug
	jump_1018ec:
		mov    $data_160134,%edx
		mov    %ebx,%eax
		call   ac_dos_fopen
		mov    %eax,ail_debug_file
		test   %eax,%eax
		jne    jump_10190e
		call   AIL_API_startup
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_10190e:
		call   ac_fileno
		call   ac_isatty
		test   %eax,%eax
		je     jump_101926
		mov    ail_debug_file,%eax
		xor    %edx,%edx
		call   ac_setbuf
	jump_101926:
		mov    %esp,%eax
		call   ac_time
		mov    %esp,%eax
		mov    $data_1e8fc4,%edi
		call   ac_localtime
		call   ac_asctime
		mov    %eax,%esi
		push   %edi
	jump_101941:
		mov    (%esi),%al
		mov    %al,(%edi)
		cmp    $0x0,%al
		je     jump_101959
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    %al,0x1(%edi)
		add    $0x2,%edi
		cmp    $0x0,%al
		jne    jump_101941
	jump_101959:
		pop    %edi
		push   $data_160138
		mov    ail_debug_file,%esi
		xor    %ah,%ah
		push   %esi
		mov    %ah,data_1e8fdc
		call   ac_fprintf
		add    $0x8,%esp
		push   $data_16018c
		push   $data_160194
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
		push   $data_1e8fc4
		push   $data_1601dc
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
		push   $data_1601ec
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x8,%esp
		call   AIL_API_startup
		xor    %edx,%edx
		mov    %edx,data_1e8fac
		xor    %ebx,%ebx
		mov    %edx,data_1e8fbc
		mov    %edx,data_1e8fb8
		push   $func_101780
		mov    %edx,data_1e8fc0
		call   ac_timer_register_callback
		add    $0x4,%esp
		push   $0x64
		push   %eax
		mov    %eax,data_1e8fb0
		call   AIL_API_set_timer_frequency
		add    $0x8,%esp
		mov    data_1e8fb0,%edi
		push   %edi
		mov    $0x1,%ebp
		call   AIL_API_start_timer
		add    $0x4,%esp
		mov    %ebp,AIL_debug
		mov    %ebp,AIL_indent
		call   TIME_write_
		push   $data_160240
		mov    %ebx,AIL_indent
		mov    ail_debug_file,%ebx
		push   %ebx
		call   ac_fprintf
		add    $0x8,%esp
	jump_101a38:
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_shutdown)	/* 101a40 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_101a80
		cmp    $0x1,%edx
		je     jump_101a67
		cmpl   $0x0,AIL_sys_debug
		je     jump_101a80
	jump_101a67:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101a80
		call   TIME_write_
		test   %eax,%eax
		je     jump_101a80
		mov    $0x1,%eax
		jmp    jump_101a82
	jump_101a80:
		xor    %eax,%eax
	jump_101a82:
		test   %eax,%eax
		je     jump_101a9a
		push   $data_160250
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0x8,%esp
	jump_101a9a:
		call   AIL_API_shutdown
		cmpl   $0x0,AIL_debug
		je     jump_101acd
		cmpl   $0x1,AIL_indent
		je     jump_101aba
		cmpl   $0x0,AIL_sys_debug
		je     jump_101acd
	jump_101aba:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101acd
		mov    ail_debug_file,%eax
		call   ac_fclose
	jump_101acd:
		decl   AIL_indent
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_set_preference)	/* 101ae0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_101b26
		cmp    $0x1,%edx
		je     jump_101b0d
		cmpl   $0x0,AIL_sys_debug
		je     jump_101b26
	jump_101b0d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101b26
		call   TIME_write_
		test   %eax,%eax
		je     jump_101b26
		mov    $0x1,%edx
		jmp    jump_101b28
	jump_101b26:
		xor    %edx,%edx
	jump_101b28:
		test   %edx,%edx
		je     jump_101b45
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_160260
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_101b45:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   AIL_API_set_preference
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_101beb
		cmpl   $0x1,AIL_indent
		je     jump_101b79
		cmpl   $0x0,AIL_sys_debug
		je     jump_101beb
	jump_101b79:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101beb
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_101b90:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_101b90
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_101bd6
	jump_101bb7:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_101bb7
	jump_101bd6:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_101beb:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_lock)	/* 101c00 */
/*----------------------------------------------------------------*/
		jmp    AIL_API_lock


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_unlock)	/* 101c10 */
/*----------------------------------------------------------------*/
		jmp    AIL_API_unlock


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_get_real_vect)	/* 101c20 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_101c65
		cmp    $0x1,%edx
		je     jump_101c4c
		cmpl   $0x0,AIL_sys_debug
		je     jump_101c65
	jump_101c4c:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101c65
		call   TIME_write_
		test   %eax,%eax
		je     jump_101c65
		mov    $0x1,%eax
		jmp    jump_101c67
	jump_101c65:
		xor    %eax,%eax
	jump_101c67:
		test   %eax,%eax
		je     jump_101c80
		push   %ebx
		push   $data_16028c
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_101c80:
		push   %ebx
		call   AIL_API_get_real_vect
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_101d1a
		cmpl   $0x1,AIL_indent
		je     jump_101cae
		cmpl   $0x0,AIL_sys_debug
		je     jump_101d1a
	jump_101cae:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101d1a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_101cc0:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_101cc0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_101d05
	jump_101ce7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_101ce7
	jump_101d05:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_101d1a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_set_real_vect)	/* 101d30 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_101d71
		cmp    $0x1,%edx
		je     jump_101d58
		cmpl   $0x0,AIL_sys_debug
		je     jump_101d71
	jump_101d58:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101d71
		call   TIME_write_
		test   %eax,%eax
		je     jump_101d71
		mov    $0x1,%eax
		jmp    jump_101d73
	jump_101d71:
		xor    %eax,%eax
	jump_101d73:
		test   %eax,%eax
		je     jump_101d94
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_1602b8
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_101d94:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_real_vect
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_restore_USE16_ISR)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_101ea1
		cmp    $0x1,%edx
		je     jump_101e88
		cmpl   $0x0,AIL_sys_debug
		je     jump_101ea1
	jump_101e88:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101ea1
		call   TIME_write_
		test   %eax,%eax
		je     jump_101ea1
		mov    $0x1,%eax
		jmp    jump_101ea3
	jump_101ea1:
		xor    %eax,%eax
	jump_101ea3:
		test   %eax,%eax
		je     jump_101ec0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_1602f8
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_101ec0:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_restore_USE16_ISR
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_disable_interrupts)
/*----------------------------------------------------------------*/
		jmp    jump_11147c


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_restore_interrupts)
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%edx
		push   %edx
		call   AIL_API_restore_interrupts
		add    $0x4,%esp
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_call_driver)	/* 101f00 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x20(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_101f46
		cmp    $0x1,%edx
		je     jump_101f2d
		cmpl   $0x0,AIL_sys_debug
		je     jump_101f46
	jump_101f2d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_101f46
		call   TIME_write_
		test   %eax,%eax
		je     jump_101f46
		mov    $0x1,%eax
		jmp    jump_101f48
	jump_101f46:
		xor    %eax,%eax
	jump_101f48:
		test   %eax,%eax
		je     jump_101f70
		push   %ebx
		mov    0x20(%esp),%ebp
		push   %ebp
		mov    0x20(%esp),%eax
		push   %eax
		mov    0x20(%esp),%edx
		push   %edx
		push   $data_160314
		mov    ail_debug_file,%ecx
		push   %ecx
		call   ac_fprintf
		add    $0x18,%esp
	jump_101f70:
		push   %ebx
		mov    0x20(%esp),%esi
		push   %esi
		mov    0x20(%esp),%edi
		push   %edi
		mov    0x20(%esp),%ebp
		push   %ebp
		call   ac_sound_call_driver
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x10,%esp
		test   %eax,%eax
		je     jump_10201a
		cmpl   $0x1,AIL_indent
		je     jump_101fad
		cmpl   $0x0,AIL_sys_debug
		je     jump_10201a
	jump_101fad:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10201a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		mov    %edx,%edx
	jump_101fc0:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_101fc0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102005
	jump_101fe7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_101fe7
	jump_102005:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_10201a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_delay)	/* 102030 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_102071
		cmp    $0x1,%edx
		je     jump_102058
		cmpl   $0x0,AIL_sys_debug
		je     jump_102071
	jump_102058:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102071
		call   TIME_write_
		test   %eax,%eax
		je     jump_102071
		mov    $0x1,%eax
		jmp    jump_102073
	jump_102071:
		xor    %eax,%eax
	jump_102073:
		test   %eax,%eax
		je     jump_102090
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_16033c
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_102090:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_1115c1
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_background)
/*----------------------------------------------------------------*/
		jmp    AIL_API_background


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_read_INI)	/* 1020c0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    0x18(%esp),%esi
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_10210a
		cmp    $0x1,%edx
		je     jump_1020f1
		cmpl   $0x0,AIL_sys_debug
		je     jump_10210a
	jump_1020f1:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10210a
		call   TIME_write_
		test   %eax,%eax
		je     jump_10210a
		mov    $0x1,%eax
		jmp    jump_10210c
	jump_10210a:
		xor    %eax,%eax
	jump_10210c:
		test   %eax,%eax
		je     jump_102125
		push   %esi
		push   %ebx
		push   $data_16034c
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_102125:
		push   %esi
		push   %ebx
		call   AIL_API_read_INI
		add    $0x8,%esp
		mov    %eax,%esi
		test   %eax,%eax
		je     jump_1023ee
		cmpl   $0x0,AIL_debug
		je     jump_10247a
		cmpl   $0x1,AIL_indent
		je     jump_10215c
		cmpl   $0x0,AIL_sys_debug
		je     jump_10247a
	jump_10215c:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10247a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		mov    %ecx,%ecx
	jump_102170:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102170
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_1021b5
	jump_102197:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102197
	jump_1021b5:
		lea    0x80(%ebx),%eax
		push   %eax
		push   $data_160368
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		mov    %eax,%eax
	jump_1021e0:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_1021e0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102225
	jump_102207:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102207
	jump_102225:
		push   %ebx
		push   $data_160378
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
		xor    %edx,%edx
		lea    0x0(%eax),%eax
	jump_102240:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102240
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102285
	jump_102267:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102267
	jump_102285:
		movswl 0x100(%ebx),%eax
		push   %eax
		push   $data_160388
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		nop
	jump_1022b0:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_1022b0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_1022f5
	jump_1022d7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_1022d7
	jump_1022f5:
		movswl 0x102(%ebx),%eax
		push   %eax
		push   $data_160398
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		nop
	jump_102320:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102320
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102365
	jump_102347:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102347
	jump_102365:
		movswl 0x104(%ebx),%eax
		push   %eax
		push   $data_1603a8
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		nop
	jump_102390:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102390
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_1023d5
	jump_1023b7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_1023b7
	jump_1023d5:
		movswl 0x106(%ebx),%eax
		push   %eax
		push   $data_1603b8
		mov    ail_debug_file,%edx
		push   %edx
		jmp    jump_102472
	jump_1023ee:
		cmpl   $0x0,AIL_debug
		je     jump_10247a
		cmpl   $0x1,AIL_indent
		je     jump_102411
		cmpl   $0x0,AIL_sys_debug
		je     jump_10247a
	jump_102411:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10247a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
	jump_102420:
		push   $data_160110
		mov    ail_debug_file,%ebx
		push   %ebx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102420
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102466
	jump_102447:
		push   $data_160114
		mov    ail_debug_file,%edi
		push   %edi
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%ebp
		add    $0x8,%esp
		cmp    %ebp,%edx
		jb     jump_102447
	jump_102466:
		push   %esi
		push   $data_1603c8
		mov    ail_debug_file,%eax
		push   %eax
	jump_102472:
		call   ac_fprintf
		add    $0xc,%esp
	jump_10247a:
		mov    AIL_indent,%ebx
		dec    %ebx
		mov    %esi,%eax
		mov    %ebx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_register_timer)	/* 102490 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1024d5
		cmp    $0x1,%edx
		je     jump_1024bc
		cmpl   $0x0,AIL_sys_debug
		je     jump_1024d5
	jump_1024bc:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1024d5
		call   TIME_write_
		test   %eax,%eax
		je     jump_1024d5
		mov    $0x1,%eax
		jmp    jump_1024d7
	jump_1024d5:
		xor    %eax,%eax
	jump_1024d7:
		test   %eax,%eax
		je     jump_1024f0
		push   %ebx
		push   $data_1603d8
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1024f0:
		push   %ebx
		call   ac_timer_register_callback
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_10258a
		cmpl   $0x1,AIL_indent
		je     jump_10251e
		cmpl   $0x0,AIL_sys_debug
		je     jump_10258a
	jump_10251e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10258a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_102530:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102530
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102575
	jump_102557:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102557
	jump_102575:
		push   %ebx
		push   $data_1603c8
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_10258a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_timer_user)	/* 1025a0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1025e6
		cmp    $0x1,%edx
		je     jump_1025cd
		cmpl   $0x0,AIL_sys_debug
		je     jump_1025e6
	jump_1025cd:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1025e6
		call   TIME_write_
		test   %eax,%eax
		je     jump_1025e6
		mov    $0x1,%edx
		jmp    jump_1025e8
	jump_1025e6:
		xor    %edx,%edx
	jump_1025e8:
		test   %edx,%edx
		je     jump_102605
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_1603f4
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_102605:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   ac_timer_set_user_data
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_1026ab
		cmpl   $0x1,AIL_indent
		je     jump_102639
		cmpl   $0x0,AIL_sys_debug
		je     jump_1026ab
	jump_102639:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1026ab
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_102650:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102650
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102696
	jump_102677:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_102677
	jump_102696:
		push   %ebx
		push   $data_1603c8
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_1026ab:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_timer_period)	/* 1026c0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_102701
		cmp    $0x1,%edx
		je     jump_1026e8
		cmpl   $0x0,AIL_sys_debug
		je     jump_102701
	jump_1026e8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102701
		call   TIME_write_
		test   %eax,%eax
		je     jump_102701
		mov    $0x1,%eax
		jmp    jump_102703
	jump_102701:
		xor    %eax,%eax
	jump_102703:
		test   %eax,%eax
		je     jump_102724
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160410
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_102724:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_timer_period
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_timer_frequency)	/* 102750 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_102791
		cmp    $0x1,%edx
		je     jump_102778
		cmpl   $0x0,AIL_sys_debug
		je     jump_102791
	jump_102778:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102791
		call   TIME_write_
		test   %eax,%eax
		je     jump_102791
		mov    $0x1,%eax
		jmp    jump_102793
	jump_102791:
		xor    %eax,%eax
	jump_102793:
		test   %eax,%eax
		je     jump_1027b4
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160430
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_1027b4:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_timer_frequency
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_interrupt_divisor)	/* 102870 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1028b1
		cmp    $0x1,%edx
		je     jump_102898
		cmpl   $0x0,AIL_sys_debug
		je     jump_1028b1
	jump_102898:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1028b1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1028b1
		mov    $0x1,%eax
		jmp    jump_1028b3
	jump_1028b1:
		xor    %eax,%eax
	jump_1028b3:
		test   %eax,%eax
		je     jump_1028cb
		push   $data_160470
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0x8,%esp
	jump_1028cb:
		call   AIL_API_interrupt_divisor
		mov    AIL_debug,%ebp
		mov    %eax,%ebx
		test   %ebp,%ebp
		je     jump_10296a
		cmpl   $0x1,AIL_indent
		je     jump_1028f6
		cmpl   $0x0,AIL_sys_debug
		je     jump_10296a
	jump_1028f6:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10296a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		lea    0x0(%eax),%eax
	jump_102910:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102910
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102956
	jump_102937:
		push   $data_160114
		mov    ail_debug_file,%edi
		push   %edi
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%ebp
		add    $0x8,%esp
		cmp    %ebp,%edx
		jb     jump_102937
	jump_102956:
		push   %ebx
		push   $data_1603c8
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0xc,%esp
	jump_10296a:
		mov    AIL_indent,%edx
		dec    %edx
		mov    %ebx,%eax
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_start_timer)	/* 102980 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1029c1
		cmp    $0x1,%edx
		je     jump_1029a8
		cmpl   $0x0,AIL_sys_debug
		je     jump_1029c1
	jump_1029a8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1029c1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1029c1
		mov    $0x1,%eax
		jmp    jump_1029c3
	jump_1029c1:
		xor    %eax,%eax
	jump_1029c3:
		test   %eax,%eax
		je     jump_1029e0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_16048c
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1029e0:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_start_timer
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_release_timer_handle)	/* 102b60 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_102ba1
		cmp    $0x1,%edx
		je     jump_102b88
		cmpl   $0x0,AIL_sys_debug
		je     jump_102ba1
	jump_102b88:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102ba1
		call   TIME_write_
		test   %eax,%eax
		je     jump_102ba1
		mov    $0x1,%eax
		jmp    jump_102ba3
	jump_102ba1:
		xor    %eax,%eax
	jump_102ba3:
		test   %eax,%eax
		je     jump_102bc0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_1604e8
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_102bc0:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_release_timer_handle
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_release_all_timers)	/* 102be0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_102c20
		cmp    $0x1,%edx
		je     jump_102c07
		cmpl   $0x0,AIL_sys_debug
		je     jump_102c20
	jump_102c07:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102c20
		call   TIME_write_
		test   %eax,%eax
		je     jump_102c20
		mov    $0x1,%eax
		jmp    jump_102c22
	jump_102c20:
		xor    %eax,%eax
	jump_102c22:
		test   %eax,%eax
		je     jump_102c3a
		push   $data_160508
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0x8,%esp
	jump_102c3a:
		call   AIL_API_release_all_timers
		decl   AIL_indent
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_get_IO_environment)	/* 102c50 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_102c95
		cmp    $0x1,%edx
		je     jump_102c7c
		cmpl   $0x0,AIL_sys_debug
		je     jump_102c95
	jump_102c7c:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102c95
		call   TIME_write_
		test   %eax,%eax
		je     jump_102c95
		mov    $0x1,%eax
		jmp    jump_102c97
	jump_102c95:
		xor    %eax,%eax
	jump_102c97:
		test   %eax,%eax
		je     jump_102cb0
		push   %ebx
		push   $data_160524
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_102cb0:
		push   %ebx
		call   AIL_API_get_IO_environment
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_102d4a
		cmpl   $0x1,AIL_indent
		je     jump_102cde
		cmpl   $0x0,AIL_sys_debug
		je     jump_102d4a
	jump_102cde:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102d4a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_102cf0:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102cf0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102d35
	jump_102d17:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102d17
	jump_102d35:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_102d4a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_install_driver)	/* 102d60 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_102da6
		cmp    $0x1,%edx
		je     jump_102d8d
		cmpl   $0x0,AIL_sys_debug
		je     jump_102da6
	jump_102d8d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102da6
		call   TIME_write_
		test   %eax,%eax
		je     jump_102da6
		mov    $0x1,%edx
		jmp    jump_102da8
	jump_102da6:
		xor    %edx,%edx
	jump_102da8:
		test   %edx,%edx
		je     jump_102dc5
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_160544
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_102dc5:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   AIL_API_install_driver
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_102e6b
		cmpl   $0x1,AIL_indent
		je     jump_102df9
		cmpl   $0x0,AIL_sys_debug
		je     jump_102e6b
	jump_102df9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102e6b
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_102e10:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102e10
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102e56
	jump_102e37:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_102e37
	jump_102e56:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_102e6b:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_uninstall_driver)	/* 102e80 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_102ec1
		cmp    $0x1,%edx
		je     jump_102ea8
		cmpl   $0x0,AIL_sys_debug
		je     jump_102ec1
	jump_102ea8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102ec1
		call   TIME_write_
		test   %eax,%eax
		je     jump_102ec1
		mov    $0x1,%eax
		jmp    jump_102ec3
	jump_102ec1:
		xor    %eax,%eax
	jump_102ec3:
		test   %eax,%eax
		je     jump_102ee0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160564
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_102ee0:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_uninstall_driver
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_install_DIG_INI)	/* 102f00 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_102f45
		cmp    $0x1,%edx
		je     jump_102f2c
		cmpl   $0x0,AIL_sys_debug
		je     jump_102f45
	jump_102f2c:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102f45
		call   TIME_write_
		test   %eax,%eax
		je     jump_102f45
		mov    $0x1,%eax
		jmp    jump_102f47
	jump_102f45:
		xor    %eax,%eax
	jump_102f47:
		test   %eax,%eax
		je     jump_102f60
		push   %ebx
		push   $data_160580
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_102f60:
		push   %ebx
		call   ac_sound_install_dig_ini
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_102ffa
		cmpl   $0x1,AIL_indent
		je     jump_102f8e
		cmpl   $0x0,AIL_sys_debug
		je     jump_102ffa
	jump_102f8e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_102ffa
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_102fa0:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_102fa0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_102fe5
	jump_102fc7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_102fc7
	jump_102fe5:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_102ffa:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_install_DIG_driver_file)	/* 103010 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_103056
		cmp    $0x1,%edx
		je     jump_10303d
		cmpl   $0x0,AIL_sys_debug
		je     jump_103056
	jump_10303d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103056
		call   TIME_write_
		test   %eax,%eax
		je     jump_103056
		mov    $0x1,%edx
		jmp    jump_103058
	jump_103056:
		xor    %edx,%edx
	jump_103058:
		test   %edx,%edx
		je     jump_103075
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_16059c
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_103075:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   ac_sound_install_dig_driver_file
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_10311b
		cmpl   $0x1,AIL_indent
		je     jump_1030a9
		cmpl   $0x0,AIL_sys_debug
		je     jump_10311b
	jump_1030a9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10311b
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_1030c0:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_1030c0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_103106
	jump_1030e7:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_1030e7
	jump_103106:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_10311b:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_uninstall_DIG_driver)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103171
		cmp    $0x1,%edx
		je     jump_103158
		cmpl   $0x0,AIL_sys_debug
		je     jump_103171
	jump_103158:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103171
		call   TIME_write_
		test   %eax,%eax
		je     jump_103171
		mov    $0x1,%eax
		jmp    jump_103173
	jump_103171:
		xor    %eax,%eax
	jump_103173:
		test   %eax,%eax
		je     jump_103190
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_1605c4
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_103190:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_uninstall_DIG_driver
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_allocate_sample_handle)	/* 1031b0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1031f5
		cmp    $0x1,%edx
		je     jump_1031dc
		cmpl   $0x0,AIL_sys_debug
		je     jump_1031f5
	jump_1031dc:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1031f5
		call   TIME_write_
		test   %eax,%eax
		je     jump_1031f5
		mov    $0x1,%eax
		jmp    jump_1031f7
	jump_1031f5:
		xor    %eax,%eax
	jump_1031f7:
		test   %eax,%eax
		je     jump_103210
		push   %ebx
		push   $data_1605e4
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_103210:
		push   %ebx
		call   AIL_API_allocate_sample_handle
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_1032aa
		cmpl   $0x1,AIL_indent
		je     jump_10323e
		cmpl   $0x0,AIL_sys_debug
		je     jump_1032aa
	jump_10323e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1032aa
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_103250:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_103250
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_103295
	jump_103277:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_103277
	jump_103295:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_1032aa:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_release_sample_handle)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103421
		cmp    $0x1,%edx
		je     jump_103408
		cmpl   $0x0,AIL_sys_debug
		je     jump_103421
	jump_103408:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103421
		call   TIME_write_
		test   %eax,%eax
		je     jump_103421
		mov    $0x1,%eax
		jmp    jump_103423
	jump_103421:
		xor    %eax,%eax
	jump_103423:
		test   %eax,%eax
		je     jump_103440
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160630
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_103440:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_release_sample_handle
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_init_sample)	/* 103460 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1034a1
		cmp    $0x1,%edx
		je     jump_103488
		cmpl   $0x0,AIL_sys_debug
		je     jump_1034a1
	jump_103488:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1034a1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1034a1
		mov    $0x1,%eax
		jmp    jump_1034a3
	jump_1034a1:
		xor    %eax,%eax
	jump_1034a3:
		test   %eax,%eax
		je     jump_1034c0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160654
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1034c0:
		mov    0x10(%esp),%eax
		push   %eax
		call   ailimpl_init_sample
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sample_file)	/* 1034e0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_103526
		cmp    $0x1,%edx
		je     jump_10350d
		cmpl   $0x0,AIL_sys_debug
		je     jump_103526
	jump_10350d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103526
		call   TIME_write_
		test   %eax,%eax
		je     jump_103526
		mov    $0x1,%eax
		jmp    jump_103528
	jump_103526:
		xor    %eax,%eax
	jump_103528:
		test   %eax,%eax
		je     jump_10354b
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   %ebx
		push   $data_16066c
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_10354b:
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		push   %ebx
		call   AIL_API_allocate_file_sample
		mov    AIL_debug,%edi
		mov    %eax,%ebx
		add    $0xc,%esp
		test   %edi,%edi
		je     jump_1035ea
		cmpl   $0x1,AIL_indent
		je     jump_103584
		cmpl   $0x0,AIL_sys_debug
		je     jump_1035ea
	jump_103584:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1035ea
		xor    %edx,%edx
		nop
	jump_103590:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_103590
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_1035d6
	jump_1035b7:
		push   $data_160114
		mov    ail_debug_file,%edi
		push   %edi
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%ebp
		add    $0x8,%esp
		cmp    %ebp,%edx
		jb     jump_1035b7
	jump_1035d6:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0xc,%esp
	jump_1035ea:
		mov    AIL_indent,%edx
		dec    %edx
		mov    %ebx,%eax
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sample_address)	/* 103600 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103642
		cmp    $0x1,%edx
		je     jump_103629
		cmpl   $0x0,AIL_sys_debug
		je     jump_103642
	jump_103629:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103642
		call   TIME_write_
		test   %eax,%eax
		je     jump_103642
		mov    $0x1,%eax
		jmp    jump_103644
	jump_103642:
		xor    %eax,%eax
	jump_103644:
		test   %eax,%eax
		je     jump_10366b
		mov    0x1c(%esp),%edi
		push   %edi
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_160690
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_10366b:
		mov    0x1c(%esp),%ebx
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		call   AIL_API_set_sample_address
		mov    AIL_indent,%edi
		dec    %edi
		add    $0xc,%esp
		mov    %edi,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sample_type)	/* 1036a0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1036e2
		cmp    $0x1,%edx
		je     jump_1036c9
		cmpl   $0x0,AIL_sys_debug
		je     jump_1036e2
	jump_1036c9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1036e2
		call   TIME_write_
		test   %eax,%eax
		je     jump_1036e2
		mov    $0x1,%eax
		jmp    jump_1036e4
	jump_1036e2:
		xor    %eax,%eax
	jump_1036e4:
		test   %eax,%eax
		je     jump_10370b
		mov    0x1c(%esp),%edi
		push   %edi
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_1606b8
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_10370b:
		mov    0x1c(%esp),%ebx
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		call   AIL_API_set_sample_type
		mov    AIL_indent,%edi
		dec    %edi
		add    $0xc,%esp
		mov    %edi,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_start_sample)	/* 103740 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103781
		cmp    $0x1,%edx
		je     jump_103768
		cmpl   $0x0,AIL_sys_debug
		je     jump_103781
	jump_103768:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103781
		call   TIME_write_
		test   %eax,%eax
		je     jump_103781
		mov    $0x1,%eax
		jmp    jump_103783
	jump_103781:
		xor    %eax,%eax
	jump_103783:
		test   %eax,%eax
		je     jump_1037a0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_1606dc
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1037a0:
		mov    0x10(%esp),%eax
		push   %eax
		call   ailimpl_start_sample
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_end_sample)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103901
		cmp    $0x1,%edx
		je     jump_1038e8
		cmpl   $0x0,AIL_sys_debug
		je     jump_103901
	jump_1038e8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103901
		call   TIME_write_
		test   %eax,%eax
		je     jump_103901
		mov    $0x1,%eax
		jmp    jump_103903
	jump_103901:
		xor    %eax,%eax
	jump_103903:
		test   %eax,%eax
		je     jump_103920
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160728
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_103920:
		mov    0x10(%esp),%eax
		push   %eax
		call   AIL_API_end_sample
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sample_playback_rate)	/* 103940 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103981
		cmp    $0x1,%edx
		je     jump_103968
		cmpl   $0x0,AIL_sys_debug
		je     jump_103981
	jump_103968:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103981
		call   TIME_write_
		test   %eax,%eax
		je     jump_103981
		mov    $0x1,%eax
		jmp    jump_103983
	jump_103981:
		xor    %eax,%eax
	jump_103983:
		test   %eax,%eax
		je     jump_1039a4
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160740
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_1039a4:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_sample_playback_rate
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sample_volume)	/* 1039d0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103a11
		cmp    $0x1,%edx
		je     jump_1039f8
		cmpl   $0x0,AIL_sys_debug
		je     jump_103a11
	jump_1039f8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103a11
		call   TIME_write_
		test   %eax,%eax
		je     jump_103a11
		mov    $0x1,%eax
		jmp    jump_103a13
	jump_103a11:
		xor    %eax,%eax
	jump_103a13:
		test   %eax,%eax
		je     jump_103a34
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160768
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_103a34:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_sample_volume
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sample_pan)	/* 103a60 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103aa1
		cmp    $0x1,%edx
		je     jump_103a88
		cmpl   $0x0,AIL_sys_debug
		je     jump_103aa1
	jump_103a88:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103aa1
		call   TIME_write_
		test   %eax,%eax
		je     jump_103aa1
		mov    $0x1,%eax
		jmp    jump_103aa3
	jump_103aa1:
		xor    %eax,%eax
	jump_103aa3:
		test   %eax,%eax
		je     jump_103ac4
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160788
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_103ac4:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_sample_pan
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_set_sample_loop_count)	/* 103af0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_103b31
		cmp    $0x1,%edx
		je     jump_103b18
		cmpl   $0x0,AIL_sys_debug
		je     jump_103b31
	jump_103b18:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103b31
		call   TIME_write_
		test   %eax,%eax
		je     jump_103b31
		mov    $0x1,%eax
		jmp    jump_103b33
	jump_103b31:
		xor    %eax,%eax
	jump_103b33:
		test   %eax,%eax
		je     jump_103b54
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_1607a8
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_103b54:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   ailimpl_set_sample_loop_count
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_sample_status)	/* 103b80 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_103bc5
		cmp    $0x1,%edx
		je     jump_103bac
		cmpl   $0x0,AIL_sys_debug
		je     jump_103bc5
	jump_103bac:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103bc5
		call   TIME_write_
		test   %eax,%eax
		je     jump_103bc5
		mov    $0x1,%eax
		jmp    jump_103bc7
	jump_103bc5:
		xor    %eax,%eax
	jump_103bc7:
		test   %eax,%eax
		je     jump_103be0
		push   %ebx
		push   $data_1607cc
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_103be0:
		push   %ebx
		call   AIL_API_sample_status
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_103c7a
		cmpl   $0x1,AIL_indent
		je     jump_103c0e
		cmpl   $0x0,AIL_sys_debug
		je     jump_103c7a
	jump_103c0e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_103c7a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_103c20:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_103c20
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_103c65
	jump_103c47:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_103c47
	jump_103c65:
		push   %ebx
		push   $data_1603c8
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_103c7a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_set_digital_master_volume)	/* 1040d0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_104111
		cmp    $0x1,%edx
		je     jump_1040f8
		cmpl   $0x0,AIL_sys_debug
		je     jump_104111
	jump_1040f8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104111
		call   TIME_write_
		test   %eax,%eax
		je     jump_104111
		mov    $0x1,%eax
		jmp    jump_104113
	jump_104111:
		xor    %eax,%eax
	jump_104113:
		test   %eax,%eax
		je     jump_104134
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_16085c
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_104134:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_digital_master_volume
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_minimum_sample_buffer_size)	/* 104390 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1043d6
		cmp    $0x1,%edx
		je     jump_1043bd
		cmpl   $0x0,AIL_sys_debug
		je     jump_1043d6
	jump_1043bd:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1043d6
		call   TIME_write_
		test   %eax,%eax
		je     jump_1043d6
		mov    $0x1,%eax
		jmp    jump_1043d8
	jump_1043d6:
		xor    %eax,%eax
	jump_1043d8:
		test   %eax,%eax
		je     jump_1043fb
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   %ebx
		push   $data_1608d4
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_1043fb:
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		push   %ebx
		call   ailimpl_minimum_sample_buffer_size
		mov    AIL_debug,%edi
		mov    %eax,%ebx
		add    $0xc,%esp
		test   %edi,%edi
		je     jump_10449a
		cmpl   $0x1,AIL_indent
		je     jump_104434
		cmpl   $0x0,AIL_sys_debug
		je     jump_10449a
	jump_104434:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10449a
		xor    %edx,%edx
		nop
	jump_104440:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_104440
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_104486
	jump_104467:
		push   $data_160114
		mov    ail_debug_file,%edi
		push   %edi
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%ebp
		add    $0x8,%esp
		cmp    %ebp,%edx
		jb     jump_104467
	jump_104486:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0xc,%esp
	jump_10449a:
		mov    AIL_indent,%edx
		dec    %edx
		mov    %ebx,%eax
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_sample_buffer_ready)	/* 1044b0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1044f5
		cmp    $0x1,%edx
		je     jump_1044dc
		cmpl   $0x0,AIL_sys_debug
		je     jump_1044f5
	jump_1044dc:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1044f5
		call   TIME_write_
		test   %eax,%eax
		je     jump_1044f5
		mov    $0x1,%eax
		jmp    jump_1044f7
	jump_1044f5:
		xor    %eax,%eax
	jump_1044f7:
		test   %eax,%eax
		je     jump_104510
		push   %ebx
		push   $data_160900
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_104510:
		push   %ebx
		call   ailimpl_sample_buffer_ready
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_1045aa
		cmpl   $0x1,AIL_indent
		je     jump_10453e
		cmpl   $0x0,AIL_sys_debug
		je     jump_1045aa
	jump_10453e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1045aa
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_104550:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_104550
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_104595
	jump_104577:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_104577
	jump_104595:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_1045aa:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_load_sample_buffer)	/* 1045c0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_104602
		cmp    $0x1,%edx
		je     jump_1045e9
		cmpl   $0x0,AIL_sys_debug
		je     jump_104602
	jump_1045e9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104602
		call   TIME_write_
		test   %eax,%eax
		je     jump_104602
		mov    $0x1,%eax
		jmp    jump_104604
	jump_104602:
		xor    %eax,%eax
	jump_104604:
		test   %eax,%eax
		je     jump_104630
		mov    0x20(%esp),%edi
		push   %edi
		mov    0x20(%esp),%ebp
		push   %ebp
		mov    0x20(%esp),%eax
		push   %eax
		mov    0x20(%esp),%edx
		push   %edx
		push   $data_160920
		mov    ail_debug_file,%ebx
		push   %ebx
		call   ac_fprintf
		add    $0x18,%esp
	jump_104630:
		mov    0x20(%esp),%ecx
		push   %ecx
		mov    0x20(%esp),%esi
		push   %esi
		mov    0x20(%esp),%edi
		push   %edi
		mov    0x20(%esp),%ebp
		push   %ebp
		call   AIL_API_load_sample_buffer
		mov    AIL_indent,%eax
		dec    %eax
		add    $0x10,%esp
		mov    %eax,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_func_104a40)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_104a86
		cmp    $0x1,%edx
		je     jump_104a6d
		cmpl   $0x0,AIL_sys_debug
		je     jump_104a86
	jump_104a6d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104a86
		call   TIME_write_
		test   %eax,%eax
		je     jump_104a86
		mov    $0x1,%edx
		jmp    jump_104a88
	jump_104a86:
		xor    %edx,%edx
	jump_104a88:
		test   %edx,%edx
		je     jump_104aa5
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_1609dc
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_104aa5:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   AIL_API_register_EOS_callback
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_104b4b
		cmpl   $0x1,AIL_indent
		je     jump_104ad9
		cmpl   $0x0,AIL_sys_debug
		je     jump_104b4b
	jump_104ad9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104b4b
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_104af0:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_104af0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_104b36
	jump_104b17:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_104b17
	jump_104b36:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_104b4b:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_set_sample_user_data)	/* 104c80 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_104cc2
		cmp    $0x1,%edx
		je     jump_104ca9
		cmpl   $0x0,AIL_sys_debug
		je     jump_104cc2
	jump_104ca9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104cc2
		call   TIME_write_
		test   %eax,%eax
		je     jump_104cc2
		mov    $0x1,%eax
		jmp    jump_104cc4
	jump_104cc2:
		xor    %eax,%eax
	jump_104cc4:
		test   %eax,%eax
		je     jump_104ceb
		mov    0x1c(%esp),%edi
		push   %edi
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_160a2c
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_104ceb:
		mov    0x1c(%esp),%ebx
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		call   AIL_API_set_sample_user_data
		mov    AIL_indent,%edi
		dec    %edi
		add    $0xc,%esp
		mov    %edi,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_func_104d20)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_104d66
		cmp    $0x1,%edx
		je     jump_104d4d
		cmpl   $0x0,AIL_sys_debug
		je     jump_104d66
	jump_104d4d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104d66
		call   TIME_write_
		test   %eax,%eax
		je     jump_104d66
		mov    $0x1,%edx
		jmp    jump_104d68
	jump_104d66:
		xor    %edx,%edx
	jump_104d68:
		test   %edx,%edx
		je     jump_104d85
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_160a54
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_104d85:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   AIL_API_sample_user_data
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_104e2b
		cmpl   $0x1,AIL_indent
		je     jump_104db9
		cmpl   $0x0,AIL_sys_debug
		je     jump_104e2b
	jump_104db9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104e2b
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_104dd0:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_104dd0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_104e16
	jump_104df7:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_104df7
	jump_104e16:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_104e2b:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_install_mdi_ini)	/* 104f50 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_104f95
		cmp    $0x1,%edx
		je     jump_104f7c
		cmpl   $0x0,AIL_sys_debug
		je     jump_104f95
	jump_104f7c:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_104f95
		call   TIME_write_
		test   %eax,%eax
		je     jump_104f95
		mov    $0x1,%eax
		jmp    jump_104f97
	jump_104f95:
		xor    %eax,%eax
	jump_104f97:
		test   %eax,%eax
		je     jump_104fb0
		push   %ebx
		push   $data_160a94
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_104fb0:
		push   %ebx
		call   ailimpl_install_mdi_ini
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_10504a
		cmpl   $0x1,AIL_indent
		je     jump_104fde
		cmpl   $0x0,AIL_sys_debug
		je     jump_10504a
	jump_104fde:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10504a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_104ff0:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_104ff0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_105035
	jump_105017:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_105017
	jump_105035:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_10504a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_install_mdi_driver_file)	/* 105060 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1050a6
		cmp    $0x1,%edx
		je     jump_10508d
		cmpl   $0x0,AIL_sys_debug
		je     jump_1050a6
	jump_10508d:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1050a6
		call   TIME_write_
		test   %eax,%eax
		je     jump_1050a6
		mov    $0x1,%edx
		jmp    jump_1050a8
	jump_1050a6:
		xor    %edx,%edx
	jump_1050a8:
		test   %edx,%edx
		je     jump_1050c5
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_160ab0
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_1050c5:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   func_1164f0
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_10516b
		cmpl   $0x1,AIL_indent
		je     jump_1050f9
		cmpl   $0x0,AIL_sys_debug
		je     jump_10516b
	jump_1050f9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10516b
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_105110:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_105110
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_105156
	jump_105137:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_105137
	jump_105156:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_10516b:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_uninstall_mdi_driver)	/* 105180 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1051c1
		cmp    $0x1,%edx
		je     jump_1051a8
		cmpl   $0x0,AIL_sys_debug
		je     jump_1051c1
	jump_1051a8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1051c1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1051c1
		mov    $0x1,%eax
		jmp    jump_1051c3
	jump_1051c1:
		xor    %eax,%eax
	jump_1051c3:
		test   %eax,%eax
		je     jump_1051e0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160ad8
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1051e0:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_116660
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_allocate_sequence_handle)	/* 105200 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_105245
		cmp    $0x1,%edx
		je     jump_10522c
		cmpl   $0x0,AIL_sys_debug
		je     jump_105245
	jump_10522c:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_105245
		call   TIME_write_
		test   %eax,%eax
		je     jump_105245
		mov    $0x1,%eax
		jmp    jump_105247
	jump_105245:
		xor    %eax,%eax
	jump_105247:
		test   %eax,%eax
		je     jump_105260
		push   %ebx
		push   $data_160af8
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_105260:
		push   %ebx
		call   func_1167a0
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_1052fa
		cmpl   $0x1,AIL_indent
		je     jump_10528e
		cmpl   $0x0,AIL_sys_debug
		je     jump_1052fa
	jump_10528e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1052fa
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_1052a0:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_1052a0
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_1052e5
	jump_1052c7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_1052c7
	jump_1052e5:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_1052fa:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_init_sequence)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1053d6
		cmp    $0x1,%edx
		je     jump_1053bd
		cmpl   $0x0,AIL_sys_debug
		je     jump_1053d6
	jump_1053bd:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1053d6
		call   TIME_write_
		test   %eax,%eax
		je     jump_1053d6
		mov    $0x1,%eax
		jmp    jump_1053d8
	jump_1053d6:
		xor    %eax,%eax
	jump_1053d8:
		test   %eax,%eax
		je     jump_1053fb
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   %ebx
		push   $data_160b40
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_1053fb:
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		push   %ebx
		call   func_116840
		mov    AIL_debug,%edi
		mov    %eax,%ebx
		add    $0xc,%esp
		test   %edi,%edi
		je     jump_10549a
		cmpl   $0x1,AIL_indent
		je     jump_105434
		cmpl   $0x0,AIL_sys_debug
		je     jump_10549a
	jump_105434:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10549a
		xor    %edx,%edx
		nop
	jump_105440:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_105440
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_105486
	jump_105467:
		push   $data_160114
		mov    ail_debug_file,%edi
		push   %edi
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%ebp
		add    $0x8,%esp
		cmp    %ebp,%edx
		jb     jump_105467
	jump_105486:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0xc,%esp
	jump_10549a:
		mov    AIL_indent,%edx
		dec    %edx
		mov    %ebx,%eax
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_start_sequence)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1054f1
		cmp    $0x1,%edx
		je     jump_1054d8
		cmpl   $0x0,AIL_sys_debug
		je     jump_1054f1
	jump_1054d8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1054f1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1054f1
		mov    $0x1,%eax
		jmp    jump_1054f3
	jump_1054f1:
		xor    %eax,%eax
	jump_1054f3:
		test   %eax,%eax
		je     jump_105510
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160b64
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_105510:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_116b70
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_stop_sequence)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_105571
		cmp    $0x1,%edx
		je     jump_105558
		cmpl   $0x0,AIL_sys_debug
		je     jump_105571
	jump_105558:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_105571
		call   TIME_write_
		test   %eax,%eax
		je     jump_105571
		mov    $0x1,%eax
		jmp    jump_105573
	jump_105571:
		xor    %eax,%eax
	jump_105573:
		test   %eax,%eax
		je     jump_105590
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160b80
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_105590:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_116ba0
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_resume_sequence)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1055f1
		cmp    $0x1,%edx
		je     jump_1055d8
		cmpl   $0x0,AIL_sys_debug
		je     jump_1055f1
	jump_1055d8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1055f1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1055f1
		mov    $0x1,%eax
		jmp    jump_1055f3
	jump_1055f1:
		xor    %eax,%eax
	jump_1055f3:
		test   %eax,%eax
		je     jump_105610
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160b9c
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_105610:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_116c60
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_end_sequence)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_105671
		cmp    $0x1,%edx
		je     jump_105658
		cmpl   $0x0,AIL_sys_debug
		je     jump_105671
	jump_105658:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_105671
		call   TIME_write_
		test   %eax,%eax
		je     jump_105671
		mov    $0x1,%eax
		jmp    jump_105673
	jump_105671:
		xor    %eax,%eax
	jump_105673:
		test   %eax,%eax
		je     jump_105690
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160bb8
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_105690:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_116cd0
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sequence_tempo)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1056f2
		cmp    $0x1,%edx
		je     jump_1056d9
		cmpl   $0x0,AIL_sys_debug
		je     jump_1056f2
	jump_1056d9:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1056f2
		call   TIME_write_
		test   %eax,%eax
		je     jump_1056f2
		mov    $0x1,%eax
		jmp    jump_1056f4
	jump_1056f2:
		xor    %eax,%eax
	jump_1056f4:
		test   %eax,%eax
		je     jump_10571b
		mov    0x1c(%esp),%edi
		push   %edi
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_160bd0
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_10571b:
		mov    0x1c(%esp),%ebx
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		call   func_116d20
		mov    AIL_indent,%edi
		dec    %edi
		add    $0xc,%esp
		mov    %edi,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_sequence_volume)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_105792
		cmp    $0x1,%edx
		je     jump_105779
		cmpl   $0x0,AIL_sys_debug
		je     jump_105792
	jump_105779:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_105792
		call   TIME_write_
		test   %eax,%eax
		je     jump_105792
		mov    $0x1,%eax
		jmp    jump_105794
	jump_105792:
		xor    %eax,%eax
	jump_105794:
		test   %eax,%eax
		je     jump_1057bb
		mov    0x1c(%esp),%edi
		push   %edi
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_160bf4
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_1057bb:
		mov    0x1c(%esp),%ebx
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		call   func_116d90
		mov    AIL_indent,%edi
		dec    %edi
		add    $0xc,%esp
		mov    %edi,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_func_105880) /* AIL_set_XMIDI_master_volume candidate 2 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1058c5
		cmp    $0x1,%edx
		je     jump_1058ac
		cmpl   $0x0,AIL_sys_debug
		je     jump_1058c5
	jump_1058ac:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1058c5
		call   TIME_write_
		test   %eax,%eax
		je     jump_1058c5
		mov    $0x1,%eax
		jmp    jump_1058c7
	jump_1058c5:
		xor    %eax,%eax
	jump_1058c7:
		test   %eax,%eax
		je     jump_1058e0
		push   %ebx
		push   $data_160c44
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1058e0:
		push   %ebx
		call   func_116e20
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_10597a
		cmpl   $0x1,AIL_indent
		je     jump_10590e
		cmpl   $0x0,AIL_sys_debug
		je     jump_10597a
	jump_10590e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10597a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_105920:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_105920
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_105965
	jump_105947:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_105947
	jump_105965:
		push   %ebx
		push   $data_1603c8
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_10597a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (ail_func_105cc0) /* AIL_set_XMIDI_master_volume candidate 1 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_105d01
		cmp    $0x1,%edx
		je     jump_105ce8
		cmpl   $0x0,AIL_sys_debug
		je     jump_105d01
	jump_105ce8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_105d01
		call   TIME_write_
		test   %eax,%eax
		je     jump_105d01
		mov    $0x1,%eax
		jmp    jump_105d03
	jump_105d01:
		xor    %eax,%eax
	jump_105d03:
		test   %eax,%eax
		je     jump_105d24
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160cb8
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_105d24:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   AIL_API_set_XMIDI_master_volume
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_MDI_driver_type)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_105fc5
		cmp    $0x1,%edx
		je     jump_105fac
		cmpl   $0x0,AIL_sys_debug
		je     jump_105fc5
	jump_105fac:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_105fc5
		call   TIME_write_
		test   %eax,%eax
		je     jump_105fc5
		mov    $0x1,%eax
		jmp    jump_105fc7
	jump_105fc5:
		xor    %eax,%eax
	jump_105fc7:
		test   %eax,%eax
		je     jump_105fe0
		push   %ebx
		push   $data_160d2c
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_105fe0:
		push   %ebx
		call   func_116670
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_10607a
		cmpl   $0x1,AIL_indent
		je     jump_10600e
		cmpl   $0x0,AIL_sys_debug
		je     jump_10607a
	jump_10600e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10607a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_106020:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_106020
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_106065
	jump_106047:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_106047
	jump_106065:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_10607a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_set_GTL_filename_prefix)	/* 106090 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1060d1
		cmp    $0x1,%edx
		je     jump_1060b8
		cmpl   $0x0,AIL_sys_debug
		je     jump_1060d1
	jump_1060b8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1060d1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1060d1
		mov    $0x1,%eax
		jmp    jump_1060d3
	jump_1060d1:
		xor    %eax,%eax
	jump_1060d3:
		test   %eax,%eax
		je     jump_1060f0
		mov    0x10(%esp),%edi
		push   %edi
		push   $data_160d48
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_1060f0:
		mov    0x10(%esp),%eax
		push   %eax
		call   func_116720
		mov    AIL_indent,%edx
		dec    %edx
		add    $0x4,%esp
		mov    %edx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_sequence_position)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x18(%esp),%ebx
		mov    0x1c(%esp),%esi
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_10682a
		cmp    $0x1,%edx
		je     jump_106811
		cmpl   $0x0,AIL_sys_debug
		je     jump_10682a
	jump_106811:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10682a
		call   TIME_write_
		test   %eax,%eax
		je     jump_10682a
		mov    $0x1,%eax
		jmp    jump_10682c
	jump_10682a:
		xor    %eax,%eax
	jump_10682c:
		test   %eax,%eax
		je     jump_10684b
		push   %esi
		push   %ebx
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_160e54
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_10684b:
		push   %esi
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		call   func_117100
		mov    AIL_debug,%edi
		add    $0xc,%esp
		test   %edi,%edi
		je     jump_1068f1
		cmpl   $0x1,AIL_indent
		je     jump_10687e
		cmpl   $0x0,AIL_sys_debug
		je     jump_1068f1
	jump_10687e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1068f1
		xor    %edx,%edx
		lea    0x0(%eax),%eax
	jump_106890:
		push   $data_160110
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_106890
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_1068d5
	jump_1068b7:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_1068b7
	jump_1068d5:
		mov    (%ebx),%eax
		inc    %eax
		push   %eax
		mov    (%esi),%eax
		inc    %eax
		push   %eax
		push   $data_160e7c
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x10,%esp
	jump_1068f1:
		decl   AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_branch_index)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_106941
		cmp    $0x1,%edx
		je     jump_106928
		cmpl   $0x0,AIL_sys_debug
		je     jump_106941
	jump_106928:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_106941
		call   TIME_write_
		test   %eax,%eax
		je     jump_106941
		mov    $0x1,%eax
		jmp    jump_106943
	jump_106941:
		xor    %eax,%eax
	jump_106943:
		test   %eax,%eax
		je     jump_106964
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_160e8c
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_106964:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   func_117170
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_register_trigger_callback)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_106af6
		cmp    $0x1,%edx
		je     jump_106add
		cmpl   $0x0,AIL_sys_debug
		je     jump_106af6
	jump_106add:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_106af6
		call   TIME_write_
		test   %eax,%eax
		je     jump_106af6
		mov    $0x1,%edx
		jmp    jump_106af8
	jump_106af6:
		xor    %edx,%edx
	jump_106af8:
		test   %edx,%edx
		je     jump_106b15
		mov    0x18(%esp),%ebp
		push   %ebp
		push   %ebx
		push   $data_160ed4
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_106b15:
		mov    0x18(%esp),%edx
		push   %edx
		push   %ebx
		call   func_117220
		mov    AIL_debug,%ecx
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %ecx,%ecx
		je     jump_106bbb
		cmpl   $0x1,AIL_indent
		je     jump_106b49
		cmpl   $0x0,AIL_sys_debug
		je     jump_106bbb
	jump_106b49:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_106bbb
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_106b60:
		push   $data_160110
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_106b60
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_106ba6
	jump_106b87:
		push   $data_160114
		mov    ail_debug_file,%ecx
		push   %ecx
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%esi
		add    $0x8,%esp
		cmp    %esi,%edx
		jb     jump_106b87
	jump_106ba6:
		push   %ebx
		push   $data_1602a8_result_hex
		mov    ail_debug_file,%edi
		push   %edi
		call   ac_fprintf
		add    $0xc,%esp
	jump_106bbb:
		mov    AIL_indent,%ebp
		dec    %ebp
		mov    %ebx,%eax
		mov    %ebp,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_lock_channel)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ecx
		mov    %edx,AIL_indent
		test   %ecx,%ecx
		je     jump_1072e5
		cmp    $0x1,%edx
		je     jump_1072cc
		cmpl   $0x0,AIL_sys_debug
		je     jump_1072e5
	jump_1072cc:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1072e5
		call   TIME_write_
		test   %eax,%eax
		je     jump_1072e5
		mov    $0x1,%eax
		jmp    jump_1072e7
	jump_1072e5:
		xor    %eax,%eax
	jump_1072e7:
		test   %eax,%eax
		je     jump_107300
		push   %ebx
		push   $data_161018
		mov    ail_debug_file,%ebp
		push   %ebp
		call   ac_fprintf
		add    $0xc,%esp
	jump_107300:
		push   %ebx
		call   func_117310
		mov    %eax,%ebx
		mov    AIL_debug,%eax
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_10739a
		cmpl   $0x1,AIL_indent
		je     jump_10732e
		cmpl   $0x0,AIL_sys_debug
		je     jump_10739a
	jump_10732e:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_10739a
		xor    %edx,%edx
		lea    0x0(%eax),%eax
		nop
	jump_107340:
		push   $data_160110
		mov    ail_debug_file,%esi
		push   %esi
		inc    %edx
		call   ac_fprintf
		add    $0x8,%esp
		cmp    $0xe,%edx
		jb     jump_107340
		mov    $0x1,%edx
		cmp    AIL_indent,%edx
		jae    jump_107385
	jump_107367:
		push   $data_160114
		mov    ail_debug_file,%ebp
		push   %ebp
		inc    %edx
		call   ac_fprintf
		mov    AIL_indent,%eax
		add    $0x8,%esp
		cmp    %eax,%edx
		jb     jump_107367
	jump_107385:
		push   %ebx
		push   $data_16027c_result_decimal
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0xc,%esp
	jump_10739a:
		mov    AIL_indent,%ecx
		dec    %ecx
		mov    %ebx,%eax
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_release_channel)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_1073f1
		cmp    $0x1,%edx
		je     jump_1073d8
		cmpl   $0x0,AIL_sys_debug
		je     jump_1073f1
	jump_1073d8:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_1073f1
		call   TIME_write_
		test   %eax,%eax
		je     jump_1073f1
		mov    $0x1,%eax
		jmp    jump_1073f3
	jump_1073f1:
		xor    %eax,%eax
	jump_1073f3:
		test   %eax,%eax
		je     jump_107414
		mov    0x14(%esp),%edi
		push   %edi
		mov    0x14(%esp),%ebp
		push   %ebp
		push   $data_161030
		mov    ail_debug_file,%eax
		push   %eax
		call   ac_fprintf
		add    $0x10,%esp
	jump_107414:
		mov    0x14(%esp),%edx
		push   %edx
		mov    0x14(%esp),%ebx
		push   %ebx
		call   func_1174a0
		mov    AIL_indent,%ecx
		dec    %ecx
		add    $0x8,%esp
		mov    %ecx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_map_sequence_channel)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_107482
		cmp    $0x1,%edx
		je     jump_107469
		cmpl   $0x0,AIL_sys_debug
		je     jump_107482
	jump_107469:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_107482
		call   TIME_write_
		test   %eax,%eax
		je     jump_107482
		mov    $0x1,%eax
		jmp    jump_107484
	jump_107482:
		xor    %eax,%eax
	jump_107484:
		test   %eax,%eax
		je     jump_1074ab
		mov    0x1c(%esp),%edi
		push   %edi
		mov    0x1c(%esp),%ebp
		push   %ebp
		mov    0x1c(%esp),%eax
		push   %eax
		push   $data_161050
		mov    ail_debug_file,%edx
		push   %edx
		call   ac_fprintf
		add    $0x14,%esp
	jump_1074ab:
		mov    0x1c(%esp),%ebx
		push   %ebx
		mov    0x1c(%esp),%ecx
		push   %ecx
		mov    0x1c(%esp),%esi
		push   %esi
		call   func_1175c0
		mov    AIL_indent,%edi
		dec    %edi
		add    $0xc,%esp
		mov    %edi,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (AIL_send_channel_voice_message)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    AIL_indent,%edx
		inc    %edx
		mov    AIL_debug,%ebx
		mov    %edx,AIL_indent
		test   %ebx,%ebx
		je     jump_107642
		cmp    $0x1,%edx
		je     jump_107629
		cmpl   $0x0,AIL_sys_debug
		je     jump_107642
	jump_107629:
		call   AIL_API_background
		test   %eax,%eax
		jne    jump_107642
		call   TIME_write_
		test   %eax,%eax
		je     jump_107642
		mov    $0x1,%eax
		jmp    jump_107644
	jump_107642:
		xor    %eax,%eax
	jump_107644:
		test   %eax,%eax
		je     jump_107675
		mov    0x24(%esp),%edi
		push   %edi
		mov    0x24(%esp),%ebp
		push   %ebp
		mov    0x24(%esp),%eax
		push   %eax
		mov    0x24(%esp),%edx
		push   %edx
		mov    0x24(%esp),%ebx
		push   %ebx
		push   $data_16109c
		mov    ail_debug_file,%ecx
		push   %ecx
		call   ac_fprintf
		add    $0x1c,%esp
	jump_107675:
		mov    0x24(%esp),%esi
		push   %esi
		mov    0x24(%esp),%edi
		push   %edi
		mov    0x24(%esp),%ebp
		push   %ebp
		mov    0x24(%esp),%eax
		push   %eax
		mov    0x24(%esp),%edx
		push   %edx
		call   func_117620
		mov    AIL_indent,%ebx
		dec    %ebx
		add    $0x14,%esp
		mov    %ebx,AIL_indent
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILDEBUG_end_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_159328
		je     jump_107916
		push   $AILDEBUG_end_
		push   $AILDEBUG_start_
		xor    %ebx,%ebx
		call   VMM_unlock_range
		add    $0x8,%esp
		mov    %ebx,data_159328
	jump_107916:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_lock:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		incl   timer_lock
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_unlock:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		decl   timer_lock
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
ail_API_timer:	/* 110e62 */
/*----------------------------------------------------------------*/
		cmpl   $0x0,%cs:timer_reentrance_lock
		ja     jump_110f81
		pusha
		push   %ds
		push   %es
		push   %fs
		push   %gs
		mov    %esp,%ebp
		cld
		data16 		mov    %cs:data_15a032,%ds
		data16 		mov    %cs:data_15a032,%es
		incl   timer_reentrance_lock
		mov    %ss,data_15aa40
		mov    %esp,data_15aa44
		mov    %ds,%ax
		mov    %ax,%ss
		mov    $data_15aa40,%esp
		mov    timer_period,%edx
		mov    $0x0,%edi
	jump_110eb2:
		cmpl   $0x2,timer_callback_states(%edi)
		jne    jump_110edd
		mov    timer_callback_elapsed_times(%edi),%eax
		add    %edx,%eax
		cmp    timer_callback_periods(%edi),%eax
		jb     jump_110ed7
		sub    timer_callback_periods(%edi),%eax
		incl   timer_callback_call_counts(%edi)
	jump_110ed7:
		mov    %eax,timer_callback_elapsed_times(%edi)
	jump_110edd:
		add    $0x4,%edi
		cmp    $0x40,%edi
		jb     jump_110eb2
		mov    $0x20,%al
		out    %al,$0x20
		sti
		cmpl   $0x0,timer_lock
		jg     jump_110f22
		mov    $0x0,%edi
	jump_110ef8:
		cmpl   $0x0,timer_callback_call_counts(%edi)
		je     jump_110f1a
		decl   timer_callback_call_counts(%edi)
		mov    %esp,%esi
		mov    timer_callback_arguments(%edi),%eax
		push   %eax
		call   *timer_callbacks(%edi)
		mov    %esi,%esp
		jmp    jump_110ef8
	jump_110f1a:
		add    $0x4,%edi
		cmp    $0x3c,%edi
		jb     jump_110ef8
	jump_110f22:
		cmpl   $0x0,data_159fd4
		je     jump_110f65
		decl   data_159fd4
		mov    data_15aa40,%ss
		mov    data_15aa44,%esp
		decl   timer_reentrance_lock
		mov    timer_old_handler,%ecx
		movzwl timer_old_handler_segment,%eax
		mov    %ebp,%esp
		xchg   %ecx,0x28(%ebp)
		xchg   %eax,0x2c(%ebp)
		pop    %gs
		pop    %fs
		pop    %es
		pop    %ds
		pop    %edi
		pop    %esi
		pop    %ebp
		pop    %ebx
		pop    %ebx
		pop    %edx
		lret
	jump_110f65:
		mov    data_15aa40,%ss
		mov    data_15aa44,%esp
		decl   timer_reentrance_lock
		mov    %ebp,%esp
		pop    %gs
		pop    %fs
		pop    %es
		pop    %ds
		popa
		iret
	jump_110f81:
		push   %eax
		mov    $0x20,%al
		out    %al,$0x20
		pop    %eax
		iret


/*----------------------------------------------------------------*/
set_PIT_divisor:	/* 110f88 */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		pushf
		cli
		mov    $0x36,%al
		out    %al,$0x43
		mov    0x8(%ebp),%eax
		mov    %eax,timer_divisor
		jmp    jump_110f9e
	jump_110f9e:
		out    %al,$0x40
		mov    %ah,%al
		jmp    jump_110fa4
	jump_110fa4:
		out    %al,$0x40
		push   %ebp
		mov    %esp,%ebp
		testb  $0x2,0x5(%ebp)
		cli
		je     jump_110fb1
		sti
	jump_110fb1:
		pop    %ebp
		popf
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/* void set_PIT_period (uint32_t usec) */
/*----------------------------------------------------------------*/
set_PIT_period:	/* 110fb8 */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		mov    $0x0,%eax
		cmpl   $0xd68d,0x8(%ebp)
		jae    jump_110fdd
		mov    0x8(%ebp),%eax
		mov    $0x20bc,%ebx
		mov    $0x2710,%ecx
		mul    %ecx
		div    %ebx
	jump_110fdd:
		push   %eax
		call   ac_timer_set_divisor
		add    $0x4,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*
 * void ailimpl_program_timers (void)
 *
 * Sets the period to be the shortest of all callbacks, or else the maximum
 * period.
 */
/*----------------------------------------------------------------*/
ailimpl_program_timers:	/* 110feb */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %es
		call   AIL_lock
		push   %ds
		pop    %es
		cld
		mov    $0xffffffff,%ecx
		mov    $0x0,%edi
	jump_111001:
		cmpl   $0x0,timer_callback_states(%edi)
		je     jump_111016
		mov    timer_callback_periods(%edi),%eax
		cmp    %ecx,%eax
		jae    jump_111016
		mov    %eax,%ecx
	jump_111016:
		add    $0x4,%edi
		cmp    $0x40,%edi
		jb     jump_111001
		cmp    timer_period,%ecx
		je     jump_111046
		mov    %ecx,timer_period
		push   %ecx
		call   set_PIT_period
		add    $0x4,%esp
		mov    $0x0,%eax
		mov    $timer_callback_elapsed_times,%edi
		mov    $0x10,%ecx
		rep stos %eax,%es:(%edi)
	jump_111046:
		call   AIL_unlock
		pop    %es
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_111050:
		push   %ebx
		push   %esi
		push   %edi
		push   %es
		pushf
		/* cli */
		push   %ds
		pop    %es
		cld
		data16 		mov    %ds,data_15a032
		data16 		mov    data_15a032,%es
		call   AILA_VMM_lock
		movl   $0x0,timer_reentrance_lock
		movl   $0x0,timer_lock
		movl   $0xffffffff,timer_period
		movl   $0xffffffff,data_15a034
		mov    $0x0,%eax
		mov    $timer_callback_states,%edi
		mov    $0x10,%ecx
		rep stos %eax,%es:(%edi)
		mov    $timer_callback_elapsed_times,%edi
		mov    $0x10,%ecx
		rep stos %eax,%es:(%edi)
		mov    $timer_callback_periods,%edi
		mov    $0x10,%ecx
		rep stos %eax,%es:(%edi)
		mov    $timer_callback_call_counts,%edi
		mov    $0x10,%ecx
		rep stos %eax,%es:(%edi)
		mov    $0x8,%eax
		push   %eax
		mov    %eax,%ebx
		mov    $0x200,%eax
		/* int    $0x31 */
		shl    $0x10,%ecx
		mov    %dx,%cx
		pop    %eax
		push   %ecx
		mov    $0x35,%ah
		push   %es
		/* int    $0x21 */
		mov    %es,%dx
		pop    %es
		pop    %ecx
		mov    %ebx,timer_old_handler
		mov    %dx,timer_old_handler_segment
		mov    %ecx,data_15a01e
		mov    $0x8,%eax
		mov    $ail_API_timer,%edx
		mov    %cs,%bx
		mov    $0x25,%ah
		push   %ds
		mov    %bx,%ds
		/* int    $0x21 */
		pop    %ds
		movl   $0x2,data_159f14
		push   $0xd68d
		push   $0x3c
		call   AIL_set_timer_period
		add    $0x8,%esp
		push   %ebp
		mov    %esp,%ebp
		testb  $0x2,0x5(%ebp)
		/* cli */
		je     jump_111137
		/* sti */
	jump_111137:
		pop    %ebp
		popf
		pop    %es
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILA_shutdown:	/* 1111e3 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		pushf
		/* cli */
		push   $0x0
		call   ac_timer_set_divisor
		add    $0x4,%esp
#if 0
		mov    $0x8,%eax
		mov    timer_old_handler,%edx
		movzwl timer_old_handler_segment,%ebx
		mov    $0x25,%ah
		push   %ds
		mov    %bx,%ds
		int    $0x21
		pop    %ds
		push   %ebp
		mov    %esp,%ebp
		testb  $0x2,0x5(%ebp)
		cli
		je     jump_111173
		sti
	jump_111173:
		pop    %ebp
#endif
		popf
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_get_real_vect:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		mov    0x8(%ebp),%eax
		push   %eax
		mov    %eax,%ebx
		mov    $0x200,%eax
		int    $0x31
		shl    $0x10,%ecx
		mov    %dx,%cx
		pop    %eax
		push   %ecx
		mov    $0x35,%ah
		push   %es
		int    $0x21
		mov    %es,%dx
		pop    %es
		pop    %ecx
		mov    %ecx,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_set_real_vect:	/* 1111a5 */
/*----------------------------------------------------------------*/
		ret /* XXX: sound */

		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		mov    0x8(%ebp),%eax
		mov    0xc(%ebp),%ebx
		mov    %ebx,%ecx
		shr    $0x10,%ecx
		mov    %ebx,%edx
		and    $0xffff,%edx
		mov    %eax,%ebx
		mov    $0x201,%eax
		int    $0x31
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
ail_thunk_proc:
/*----------------------------------------------------------------*/
		push   %ds
		push   %es
		push   %eax
		push   %ebx
		push   %ecx
		mov    $0x9999,%ax
		mov    %ax,%ds
		mov    %ax,%es
		mov    %ss,%bx
		mov    %esp,%ecx
		mov    $0x9999,%ax
		mov    %ax,%ss
		mov    $0x99999999,%esp
		pushfw
		pop    %ax
		mov    %ax,-0x2(%esp)
		mov    %cs,-0x4(%esp)
		movw   $0x9999,-0x6(%esp)
		sub    $0x6,%esp
		movw   $0x9999,-0x2(%esp)
		movw   $0x9999,-0x4(%esp)
		sub    $0x4,%esp
		lretw
		mov    %bx,%ss
		mov    %ecx,%esp
		pop    %ecx
		pop    %ebx
		pop    %eax
		pop    %es
		pop    %ds
		iret


/*----------------------------------------------------------------*/
AIL_API_restore_USE16_ISR:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		push   %es
		mov    0x8(%ebp),%ebx
		cmp    $0xffffffff,%ebx
		je     jump_111476
		cmp    data_15a034,%ebx
		jne    jump_111476
		cmp    $0x8,%ebx
		jb     jump_111456
		add    $0x60,%ebx
	jump_111456:
		add    $0x8,%ebx
		mov    $0x205,%eax
		mov    data_15a038,%ecx
		mov    data_15a03c,%edx
		int    $0x31
		movl   $0xffffffff,data_15a034
	jump_111476:
		pop    %es
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret
	jump_11147c:
		pushf
		pop    %eax
		cli
		ret


/*----------------------------------------------------------------*/
AIL_API_restore_interrupts:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		pushl  0x8(%ebp)
		push   %ebp
		mov    %esp,%ebp
		testb  $0x2,0x5(%ebp)
		cli
		je     jump_111491
		sti
	jump_111491:
		pop    %ebp
		popf
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_call_driver:	/* 1114e7 */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		add    $0xffffffc4,%esp
		push   %ebx
		push   %esi
		push   %edi
		push   %ds
		push   %es
		call   AIL_lock
		cld
		mov    $0x32,%ecx
		push   %ds
		pop    %es
		lea    -0x3a(%ebp),%edi
		mov    $0x0,%eax
		push   %ecx
		and    $0x3,%ecx
		rep stos %al,%es:(%edi)
		pop    %ecx
		shr    $0x2,%ecx
		rep stos %eax,%es:(%edi)
		movw   $0x0,-0x16(%ebp)
		movw   $0x0,-0x18(%ebp)
		pushfw
		pop    %ax
		mov    %ax,-0x1a(%ebp)
		mov    0xc(%ebp),%eax
		mov    %ax,-0x1e(%ebp)
		mov    0x10(%ebp),%ebx
		cmp    $0x0,%ebx
		je     jump_111556
		mov    0x4(%ebx),%cx
		mov    0x6(%ebx),%dx
		mov    0x8(%ebx),%si
		mov    0xa(%ebx),%di
		mov    %cx,-0x22(%ebp)
		mov    %dx,-0x26(%ebp)
		mov    %si,-0x36(%ebp)
		mov    %di,-0x3a(%ebp)
	jump_111556:
		mov    0x8(%ebp),%ebx
		mov    0x8(%ebx),%ebx
		movswl 0x32(%ebx),%ebx
		mov    %bx,-0x2a(%ebp)
		mov    $0x300,%eax
		mov    $0x66,%ebx
		mov    $0x0,%ecx
		lea    -0x3a(%ebp),%edi
		int    $0x31
		mov    0x14(%ebp),%ebx
		cmp    $0x0,%ebx
		je     jump_1115af
		mov    -0x1e(%ebp),%ax
		mov    -0x22(%ebp),%cx
		mov    -0x26(%ebp),%dx
		mov    -0x36(%ebp),%si
		mov    -0x3a(%ebp),%di
		mov    %ax,(%ebx)
		mov    %cx,0x4(%ebx)
		mov    %dx,0x6(%ebx)
		mov    %si,0x8(%ebx)
		mov    %di,0xa(%ebx)
		mov    -0x2a(%ebp),%ax
		mov    %ax,0x2(%ebx)
	jump_1115af:
		movswl -0x1e(%ebp),%eax
		push   %eax
		call   AIL_unlock
		pop    %eax
		pop    %es
		pop    %ds
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
func_1115c1:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %esi
		mov    $0x63,%bx
		push   %ds
		and    $0xffff,%ebx
		mov    $0x40,%eax
		mov    %ax,%ds
		mov    (%ebx),%eax
		pop    %ds
		mov    %eax,%edx
		add    $0x6,%edx
		mov    0x8(%ebp),%ecx
		jecxz  jump_1115f9
	jump_1115e7:
		in     (%dx),%al
		test   $0x8,%eax
		je     jump_1115e7
	jump_1115ef:
		in     (%dx),%al
		test   $0x8,%eax
		jne    jump_1115ef
		loop   jump_1115e7
	jump_1115f9:
		pop    %esi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_background:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %esi
		mov    timer_reentrance_lock,%eax
		pop    %esi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_register_timer:	/* 11160a */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    $0x0,%eax
	jump_11161a:
		cmpl   $0x0,timer_callback_states(%eax)
		je     jump_111632
		add    $0x4,%eax
		cmp    $0x3c,%eax
		jb     jump_11161a
		mov    $0xffffffff,%eax
		jmp    jump_111645
	jump_111632:
		movl   $0x1,timer_callback_states(%eax)
		mov    0x8(%ebp),%esi
		mov    %esi,timer_callbacks(%eax)
	jump_111645:
		push   %eax
		call   AIL_unlock
		pop    %eax
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_set_timer_user:	/* 111651 */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    0x8(%ebp),%ebx
		cmp    $0xffffffff,%ebx
		je     jump_11166d
		mov    0xc(%ebp),%eax
		xchg   %eax,timer_callback_arguments(%ebx)
	jump_11166d:
		push   %eax
		call   AIL_unlock
		pop    %eax
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_release_timer_handle:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    0x8(%ebp),%eax
		cmp    $0xffffffff,%eax
		je     jump_111696
		movl   $0x0,timer_callback_states(%eax)
	jump_111696:
		call   AIL_unlock
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_release_all_timers:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    $0x38,%esi
	jump_1116ad:
		push   %esi
		call   AIL_release_timer_handle
		add    $0x4,%esp
		sub    $0x4,%esi
		jge    jump_1116ad
		call   AIL_unlock
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_start_timer:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    0x8(%ebp),%ebx
		cmp    $0xffffffff,%ebx
		je     jump_1116ea
		cmpl   $0x1,timer_callback_states(%ebx)
		jne    jump_1116ea
		movl   $0x2,timer_callback_states(%ebx)
	jump_1116ea:
		call   AIL_unlock
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/* void AIL_API_set_timer_period (uint32_t index, uint32_t period_usec) */
/*----------------------------------------------------------------*/
AIL_API_set_timer_period:	/* 11176c */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    0x8(%ebp),%ebx
		mov    0xc(%ebp),%eax
		mov    %eax,timer_callback_periods(%ebx)
		movl   $0x0,timer_callback_elapsed_times(%ebx)
		call   ailimpl_program_timers
		call   AIL_unlock
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_set_timer_frequency:	/* 11179c */
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		call   AIL_lock
		mov    $0x0,%edx
		mov    $0xf4240,%eax
		mov    0xc(%ebp),%ebx
		div    %ebx
		push   %eax
		pushl  0x8(%ebp)
		call   AIL_set_timer_period
		add    $0x8,%esp
		call   AIL_unlock
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AIL_API_interrupt_divisor:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    timer_divisor,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILA_VMM_lock:
/*----------------------------------------------------------------*/
		push   $data_15aa48
		push   $timer_callbacks
		call   VMM_lock_range
		add    $0x8,%esp
		push   $AILA_VMM_lock
		push   $AIL_API_lock
		call   VMM_lock_range
		add    $0x8,%esp
		ret


/*----------------------------------------------------------------*/
AIL_start_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15aa4c
		jne    jump_1118c6
		push   $AIL_end_
		push   $AIL_start_
		call   VMM_lock_range
		add    $0x8,%esp
		push   $0x40
		push   $data_1ed6b0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4c
		push   $data_1ed80c
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x100
		push   $data_1ed6f0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x18
		push   $data_1ed7f0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_15aa48
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed808
		mov    $0x1,%ebx
		call   AIL_vmm_lock
		add    $0x8,%esp
		mov    %ebx,data_15aa4c
	jump_1118c6:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_driver_server:
/*----------------------------------------------------------------*/
		push   %esi
		push   %edi
		cmpl   $0x0,data_15aa48
		jne    jump_11191c
		movl   $0x1,data_15aa48
		call   AIL_disable_interrupts
		push   $0x0
		push   $0x0
		push   $0x302
		mov    0x18(%esp),%ecx
		push   %ecx
		mov    %eax,data_1ed808
		call   AIL_call_driver
		add    $0x10,%esp
		mov    data_1ed808,%esi
		push   %esi
		xor    %edi,%edi
		call   AIL_restore_interrupts
		add    $0x4,%esp
		mov    %edi,data_15aa48
	jump_11191c:
		pop    %edi
		pop    %esi
		ret


/*----------------------------------------------------------------*/
ASC_val:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0xc,%esp
		mov    0x24(%esp),%esi
		mov    $0x1,%ebx
		xor    %edx,%edx
		mov    0x20(%esp),%ebp
		mov    %edx,(%esp)
		mov    %ebx,0x4(%esp)
		mov    %edx,0x8(%esp)
		jmp    jump_1119a0
	jump_111943:
		mov    0x0(%ebp),%ah
		cmp    $0x2d,%ah
		jne    jump_111951
		negl   0x4(%esp)
		jmp    jump_111996
	jump_111951:
		mov    %ah,%al
		inc    %al
		and    $0xff,%eax
		testb  $0x2,EXPORT_SYMBOL(data_16207c)(%eax)
		jne    jump_111996
		xor    %edx,%edx
		test   %esi,%esi
		jle    jump_111992
		mov    %ebp,%ecx
	jump_11196b:
		xor    %eax,%eax
		xor    %ebx,%ebx
		mov    (%ecx),%al
		mov    data_161820(%edx),%bl
		call   ac_toupper
		cmp    %ebx,%eax
		jne    jump_11198d
		mov    (%esp),%eax
		imul   %esi,%eax
		add    %edx,%eax
		mov    %eax,(%esp)
		jmp    jump_111992
	jump_11198d:
		inc    %edx
		cmp    %esi,%edx
		jl     jump_11196b
	jump_111992:
		cmp    %esi,%edx
		je     jump_1119b4
	jump_111996:
		mov    0x8(%esp),%ecx
		inc    %ecx
		inc    %ebp
		mov    %ecx,0x8(%esp)
	jump_1119a0:
		mov    0x20(%esp),%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		cmp    0x8(%esp),%ecx
		ja     jump_111943
	jump_1119b4:
		mov    0x28(%esp),%edx
		test   %edx,%edx
		je     jump_1119c8
		mov    0x20(%esp),%eax
		mov    0x8(%esp),%ebx
		add    %ebx,%eax
		mov    %eax,(%edx)
	jump_1119c8:
		mov    (%esp),%eax
		imul   0x4(%esp),%eax
		add    $0xc,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_read_INI:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x16c,%esp
		mov    0x184(%esp),%ecx
		mov    $0x118,%ebx
		mov    %esp,%eax
		xor    %edx,%edx
		call   ac_memset
		mov    $0x18,%ebx
		mov    $0xffffffff,%edx
		lea    0x100(%esp),%eax
		call   ac_memset
		mov    $data_161834,%edx
		mov    %ecx,%eax
		call   ac_dos_fopen
		mov    %eax,0x168(%esp)
		test   %eax,%eax
		jne    jump_111a33
		xor    %ecx,%ecx
		jmp    jump_111d0a
	jump_111a33:
		mov    0x168(%esp),%ebx
		mov    $0x50,%edx
		lea    0x118(%esp),%eax
		call   ac_fgets
		test   %eax,%eax
		je     jump_111ca3
		mov    0x168(%esp),%eax
		testb  $0x10,0xc(%eax)
		jne    jump_111ca3
		lea    0x118(%esp),%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		dec    %ecx
		test   %ecx,%ecx
		jl     jump_111aa0
	jump_111a7a:
		mov    0x118(%esp,%ecx,1),%dl
		inc    %dl
		and    $0xff,%edx
		testb  $0x2,EXPORT_SYMBOL(data_16207c)(%edx)
		je     jump_111aa0
		dec    %ecx
		xor    %dh,%dh
		mov    %dh,0x119(%esp,%ecx,1)
		test   %ecx,%ecx
		jge    jump_111a7a
	jump_111aa0:
		xor    %edx,%edx
		jmp    jump_111abd
	jump_111aa4:
		mov    0x118(%esp,%edx,1),%cl
		inc    %cl
		and    $0xff,%ecx
		testb  $0x2,EXPORT_SYMBOL(data_16207c)(%ecx)
		je     jump_111ad2
		inc    %edx
	jump_111abd:
		lea    0x118(%esp),%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		cmp    %ecx,%edx
		jb     jump_111aa4
	jump_111ad2:
		lea    0x118(%esp),%esi
		add    %edx,%esi
		jmp    jump_111af6
	jump_111add:
		mov    0x118(%esp,%edx,1),%cl
		inc    %cl
		and    $0xff,%ecx
		testb  $0x2,EXPORT_SYMBOL(data_16207c)(%ecx)
		jne    jump_111b0b
		inc    %edx
	jump_111af6:
		lea    0x118(%esp),%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		cmp    %ecx,%edx
		jb     jump_111add
	jump_111b0b:
		lea    0x118(%esp),%ebx
		add    %edx,%ebx
		jmp    jump_111b2f
	jump_111b16:
		mov    0x118(%esp,%edx,1),%cl
		inc    %cl
		and    $0xff,%ecx
		testb  $0x2,EXPORT_SYMBOL(data_16207c)(%ecx)
		je     jump_111b44
		inc    %edx
	jump_111b2f:
		lea    0x118(%esp),%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		cmp    %ecx,%edx
		jb     jump_111b16
	jump_111b44:
		lea    0x118(%esp),%edi
		lea    0x118(%esp),%ebp
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		add    %edx,%ebp
		cmp    %ecx,%edx
		jae    jump_111a33
		movb   $0x0,(%ebx)
		cmpb   $0x3b,(%esi)
		je     jump_111a33
		mov    $0x7,%ebx
		mov    $data_161838,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111baf
		lea    0x80(%esp),%edi
		mov    %ebp,%esi
		push   %edi
	jump_111b91:
		mov    (%esi),%al
		mov    %al,(%edi)
		cmp    $0x0,%al
		je     jump_111ba9
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    %al,0x1(%edi)
		add    $0x2,%edi
		cmp    $0x0,%al
		jne    jump_111b91
	jump_111ba9:
		pop    %edi
		jmp    jump_111a33
	jump_111baf:
		mov    $0x7,%ebx
		mov    $data_161840,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111be7
		mov    %esp,%edi
		mov    %ebp,%esi
		push   %edi
	jump_111bc9:
		mov    (%esi),%al
		mov    %al,(%edi)
		cmp    $0x0,%al
		je     jump_111be1
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    %al,0x1(%edi)
		add    $0x2,%edi
		cmp    $0x0,%al
		jne    jump_111bc9
	jump_111be1:
		pop    %edi
		jmp    jump_111a33
	jump_111be7:
		mov    $0x8,%ebx
		mov    $data_161848,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111c15
		push   %eax
		push   $0x10
		push   %ebp
		call   ASC_val
		add    $0xc,%esp
		mov    %ax,0x100(%esp)
		jmp    jump_111a33
	jump_111c15:
		mov    $0x4,%ebx
		mov    $data_161850,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111c43
		push   %eax
		push   $0xa
		push   %ebp
		call   ASC_val
		add    $0xc,%esp
		mov    %ax,0x102(%esp)
		jmp    jump_111a33
	jump_111c43:
		mov    $0xa,%ebx
		mov    $data_161854,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111c71
		push   %eax
		push   $0xa
		push   %ebp
		call   ASC_val
		add    $0xc,%esp
		mov    %ax,0x104(%esp)
		jmp    jump_111a33
	jump_111c71:
		mov    $0xb,%ebx
		mov    $data_161860,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111a33
		push   %eax
		push   $0xa
		push   %ebp
		call   ASC_val
		add    $0xc,%esp
		mov    %ax,0x106(%esp)
		jmp    jump_111a33
	jump_111ca3:
		mov    0x168(%esp),%eax
		lea    0x80(%esp),%edi
		call   ac_fclose
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		test   %ecx,%ecx
		je     jump_111cd4
		mov    %esp,%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		test   %ecx,%ecx
		jne    jump_111cf5
	jump_111cd4:
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_16186c,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		xor    %ecx,%ecx
		mov    %ecx,%eax
		add    $0x16c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_111cf5:
		mov    $0x46,%ecx
		mov    0x180(%esp),%edi
		mov    %esp,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		mov    $0x1,%ecx
	jump_111d0a:
		mov    %ecx,%eax
		add    $0x16c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_set_preference:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		mov    0xc(%esp),%ebx
		mov    data_1ed80c(,%eax,4),%edx
		mov    %ebx,data_1ed80c(,%eax,4)
		mov    %edx,%eax
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_install_driver:	/* 111d40 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x4,%esp
		mov    0x18(%esp),%esi
		mov    0x1c(%esp),%ebx
		push   $0x2c
		call   MEM_alloc_lock
		mov    %eax,0x4(%esp)
		mov    %eax,%ebp
		add    $0x4,%esp
		test   %eax,%eax
		jne    jump_111d7c
		mov    $0xa,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161884,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		jmp    jump_111fc9
	jump_111d7c:
		add    $0x4,%eax
		push   %eax
		mov    %ebp,%ecx
		push   %ecx
		mov    %ebx,0x8(%eax)
		lea    0x8(%ecx),%eax
		push   %eax
		lea    0xf(%ebx),%eax
		shr    $0x4,%eax
		push   %eax
		call   func_10f290
		add    $0x10,%esp
		test   %eax,%eax
		jne    jump_111dc6
		mov    $0x6,%ecx
		push   $0x2c
		mov    $data_1ed6f0,%edi
		mov    %ebp,%edx
		mov    $data_1618b0,%esi
		push   %edx
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_111dc6:
		mov    %ebp,%eax
		mov    %esi,%edx
		mov    0x8(%eax),%eax
		call   ac_memmove
		mov    %ebp,%eax
		mov    %ebp,%ebx
		mov    0x8(%eax),%eax
		mov    $data_1618cc,%edx
		mov    %eax,0x10(%ebx)
		mov    $0x7,%ebx
		call   ac_strnicmp
		test   %eax,%eax
		jne    jump_111dfa
		mov    %ebp,%eax
		movl   $0x0,0x14(%eax)
		jmp    jump_111e5b
	jump_111dfa:
		mov    %ebp,%eax
		mov    $0x7,%ebx
		mov    $data_1618d4,%edx
		mov    0x10(%eax),%eax
		call   ac_strnicmp
		test   %eax,%eax
		je     jump_111e52
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_1618dc,%esi
		mov    %ebp,%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		mov    0x4(%eax),%esi
		push   %esi
		mov    (%eax),%edi
		push   %edi
		mov    0x8(%eax),%ebp
		push   %ebp
		call   MEM_free_DOS
		add    $0xc,%esp
		push   $0x2c
		mov    0x4(%esp),%eax
		push   %eax
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_111e52:
		mov    %ebp,%eax
		movl   $0x1,0x14(%eax)
	jump_111e5b:
		xor    %ecx,%ecx
		xor    %esi,%esi
	jump_111e5f:
		cmpl   $0x0,data_1ed6b0(%esi)
		jne    jump_111e77
		mov    %ebp,data_1ed6b0(%esi)
		mov    0x10(%ebp),%eax
		mov    %cx,0x32(%eax)
		jmp    jump_111e80
	jump_111e77:
		inc    %ecx
		add    $0x4,%esi
		cmp    $0x10,%ecx
		jb     jump_111e5f
	jump_111e80:
		cmp    $0x10,%ecx
		jne    jump_111ec2
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_1618f4,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		mov    0x4(%ebp),%eax
		push   %eax
		mov    0x0(%ebp),%edx
		push   %edx
		mov    0x8(%ebp),%ebx
		push   %ebx
		call   MEM_free_DOS
		add    $0xc,%esp
		push   $0x2c
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_111ec2:
		mov    0x10(%ebp),%eax
		movw   $0x0,0x30(%eax)
		movl   $0x0,0x18(%ebp)
		push   $0x66
		movl   $0xffffffff,0x1c(%ebp)
		call   ail_get_real_vect
		mov    0x10(%ebp),%ebx
		mov    %eax,0x36(%ebx)
		mov    0x10(%ebp),%eax
		add    $0x4,%esp
		mov    0x34(%eax),%ax
		and    $0xffff,%eax
		add    0x0(%ebp),%eax
		push   %eax
		push   $0x66
		call   ail_set_real_vect
		add    $0x8,%esp
		push   $0x0
		push   $0x0
		push   $0x300
		movl   $0x0,0x24(%ebp)
		push   %ebp
		movl   $0x0,0x28(%ebp)
		call   AIL_call_driver
		mov    0x10(%ebp),%eax
		mov    0x2e(%eax),%dx
		add    $0x10,%esp
		test   %dx,%dx
		jg     jump_111f3b
		movl   $0xffffffff,0x20(%ebp)
		jmp    jump_111fc7
	jump_111f3b:
		push   $AIL_driver_server
		call   AIL_register_timer
		add    $0x4,%esp
		mov    %eax,0x20(%ebp)
		cmp    $0xffffffff,%eax
		jne    jump_111f9d
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_16190c,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    0x10(%ebp),%eax
		mov    0x36(%eax),%ebx
		push   %ebx
		push   $0x66
		call   ail_set_real_vect
		add    $0x8,%esp
		mov    0x4(%ebp),%ecx
		push   %ecx
		mov    0x0(%ebp),%esi
		push   %esi
		mov    0x8(%ebp),%edi
		push   %edi
		call   MEM_free_DOS
		add    $0xc,%esp
		push   $0x2c
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_111f9d:
		push   %ebp
		push   %eax
		call   AIL_set_timer_user
		mov    0x10(%ebp),%eax
		add    $0x8,%esp
		movswl 0x2e(%eax),%eax
		push   %eax
		mov    0x20(%ebp),%eax
		push   %eax
		call   AIL_set_timer_frequency
		add    $0x8,%esp
		mov    0x20(%ebp),%edx
		push   %edx
		call   AIL_start_timer
		add    $0x4,%esp
	jump_111fc7:
		mov    %ebp,%eax
	jump_111fc9:
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_uninstall_driver:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		cmpl   $0x0,0x24(%ebx)
		je     jump_111ff8
		mov    0x28(%ebx),%ecx
		push   %ecx
		call   *0x24(%ebx)
		add    $0x4,%esp
	jump_111ff8:
		mov    0x20(%ebx),%esi
		cmp    $0xffffffff,%esi
		je     jump_112009
		push   %esi
		call   AIL_release_timer_handle
		add    $0x4,%esp
	jump_112009:
		cmpl   $0x0,0x18(%ebx)
		je     jump_112032
		mov    0x1c(%ebx),%eax
		cmp    $0xffffffff,%eax
		je     jump_112020
		push   %eax
		call   AIL_restore_USE16_ISR
		add    $0x4,%esp
	jump_112020:
		push   $0x0
		push   $0x0
		push   $0x306
		push   %ebx
		call   AIL_call_driver
		add    $0x10,%esp
	jump_112032:
		mov    0x10(%ebx),%eax
		mov    0x36(%eax),%ecx
		push   %ecx
		push   $0x66
		call   ail_set_real_vect
		add    $0x8,%esp
		mov    0x4(%ebx),%esi
		push   %esi
		mov    (%ebx),%edi
		push   %edi
		mov    0x8(%ebx),%ebp
		push   %ebp
		call   MEM_free_DOS
		add    $0xc,%esp
		push   $0x2c
		push   %ebx
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		nop
	jump_112070:
		cmp    data_1ed6b0(%eax),%ebx
		jne    jump_112080
		xor    %ecx,%ecx
		mov    %ecx,data_1ed6b0(%eax)
	jump_112080:
		add    $0x4,%eax
		cmp    $0x40,%eax
		jne    jump_112070
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_get_IO_environment:	/* 112090 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%esi
		mov    0x10(%esi),%eax
		mov    0x12(%eax),%ecx
		shr    $0x10,%ecx
		mov    0x12(%eax),%eax
		shl    $0x4,%ecx
		and    $0xffff,%eax
		add    %ecx,%eax
		je     jump_112100
		call   ac_getenv
		test   %eax,%eax
		je     jump_112100
		mov    0x10(%esi),%ecx
		mov    $0x80,%ebx
		add    $0x3a,%ecx
		mov    %eax,%edx
		mov    %ecx,%eax
		call   ac_strncpy
		push   $0x0
		push   $0x0
		push   $0x303
		push   %esi
		call   AIL_call_driver
		add    $0x10,%esp
		cmp    $0xffffffff,%eax
		jne    jump_1120e9
		xor    %eax,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1120e9:
		mov    0x10(%esi),%esi
		mov    $0x6,%ecx
		mov    $data_1ed858,%edi
		lea    0x16(%esi),%esi
		mov    $data_1ed858,%eax
		rep movsl %ds:(%esi),%es:(%edi)
	jump_112100:
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_startup:	/* 112110 */
/*----------------------------------------------------------------*/
		call   AIL_start_
		push   $0xc8
		push   $0x0
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x1
		push   $0x1
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x8000
		push   $0x2
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x64
		push   $0x3
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x10
		push   $0x4
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x64
		push   $0x5
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x28f
		push   $0x6
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x0
		push   $0x7
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x0
		push   $0x8
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x1
		push   $0x9
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x0
		push   $0xa
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x78
		push   $0xb
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x8
		push   $0xc
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x7f
		push   $0xd
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x1
		push   $0xe
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x0
		push   $0xf
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x2
		push   $0x10
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x1
		push   $0x11
		call   ail_set_preference
		add    $0x8,%esp
		push   $0x1
		push   $0x12
		call   ail_set_preference
		add    $0x8,%esp
		xor    %eax,%eax
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_112210:
		add    $0x4,%eax
		xor    %edx,%edx
		mov    %edx,data_1ed6ac(%eax)
		cmp    $0x40,%eax
		jne    jump_112210
		xor    %ah,%ah
		mov    %ah,data_1ed6f0
		jmp    jump_111050


/*----------------------------------------------------------------*/
AIL_API_shutdown:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    $0x3c,%ebx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_112240:
		mov    data_1ed6b0(%ebx),%eax
		test   %eax,%eax
		je     jump_112260
		push   %eax
		call   AIL_uninstall_driver
		add    $0x4,%esp
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		nop
	jump_112260:
		sub    $0x4,%ebx
		cmp    $0xfffffffc,%ebx
		jne    jump_112240
		call   AIL_release_all_timers
		call   AILA_shutdown
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_end_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15aa4c
		je     jump_112303
		push   $AIL_end_
		push   $AIL_start_
		call   VMM_unlock_range
		add    $0x8,%esp
		push   $0x40
		push   $data_1ed6b0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4c
		push   $data_1ed80c
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x100
		push   $data_1ed6f0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x18
		push   $data_1ed7f0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_15aa48
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed808
		xor    %ebx,%ebx
		call   AIL_vmm_unlock
		add    $0x8,%esp
		mov    %ebx,data_15aa4c
	jump_112303:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
___localtime_:	/* 0x112307 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %esi
		push   %edi
		mov    %eax,%edi
		mov    %edx,%esi
		call   ac_tzset
		mov    $0x63df,%eax
		mov    EXPORT_SYMBOL(data_159728),%ebx
		mov    (%edi),%edi
		mov    %edx,%ecx
		mov    %edi,%edx
		call   ____brktime_
		mov    %esi,%eax
		call   ____isindst_
		test   %eax,%eax
		je     jump_112351
		mov    $0x63df,%eax
		mov    EXPORT_SYMBOL(data_159728),%ebx
		mov    EXPORT_SYMBOL(data_15972c),%edx
		mov    %esi,%ecx
		sub    %edx,%ebx
		mov    %edi,%edx
		call   ____brktime_
	jump_112351:
		mov    %esi,%eax
		pop    %edi
		pop    %esi
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
_localtime:	/* 0x112358 */
/*----------------------------------------------------------------*/
		push   %edx
		mov    $data_1ed870,%edx
		call   ___localtime_
		pop    %edx
		ret


/*----------------------------------------------------------------*/
__convDec_:	/* 0x112365 */
/*----------------------------------------------------------------*/
		push   %ecx
		push   %esi
		push   %edi
		sub    $0x8,%esp
		mov    %edx,%edi
		mov    $0xa,%ecx
		mov    %esp,%esi
		cltd
		idiv   %ecx
		mov    %eax,(%esi)
		mov    %edx,0x4(%esi)
		mov    (%esp),%dl
		lea    (%ebx,%edi,1),%eax
		add    $0x30,%dl
		mov    %dl,(%eax)
		mov    0x4(%esp),%bl
		add    $0x30,%bl
		mov    %bl,0x1(%eax)
		add    $0x8,%esp
		pop    %edi
		pop    %esi
		pop    %ecx
		ret


/*----------------------------------------------------------------*/
___asctime_:	/* 0x112398 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %esi
		push   %edi
		sub    $0x8,%esp
		mov    %eax,%ecx
		mov    %edx,%edi
		mov    0x18(%eax),%eax
		mov    data_162204(%eax),%dl
		mov    %dl,(%edi)
		mov    data_16220b(%eax),%dl
		mov    %dl,0x1(%edi)
		mov    data_162212(%eax),%al
		movb   $0x20,0x3(%edi)
		mov    %al,0x2(%edi)
		mov    0x10(%ecx),%eax
		mov    data_1621e0(%eax),%dl
		mov    %dl,0x4(%edi)
		mov    data_1621ec(%eax),%dl
		mov    %dl,0x5(%edi)
		mov    data_1621f8(%eax),%al
		movb   $0x20,0x7(%edi)
		mov    %edi,%ebx
		mov    %al,0x6(%edi)
		mov    $0x8,%edx
		mov    0xc(%ecx),%eax
		call   __convDec_
		xor    %eax,%eax
		mov    0x8(%edi),%al
		cmp    $0x30,%eax
		jne    jump_112403
		movb   $0x20,0x8(%edi)
	jump_112403:
		mov    $0xb,%edx
		movb   $0x20,0xa(%edi)
		mov    %edi,%ebx
		mov    0x8(%ecx),%eax
		call   __convDec_
		mov    $0xe,%edx
		movb   $0x3a,0xd(%edi)
		mov    %edi,%ebx
		mov    0x4(%ecx),%eax
		call   __convDec_
		mov    $0x11,%edx
		movb   $0x3a,0x10(%edi)
		mov    %edi,%ebx
		mov    (%ecx),%eax
		call   __convDec_
		movb   $0x20,0x13(%edi)
		mov    %esp,%esi
		mov    0x14(%ecx),%eax
		mov    $0x64,%ecx
		mov    %edi,%ebx
		cltd
		idiv   %ecx
		mov    %eax,(%esi)
		mov    %edx,0x4(%esi)
		mov    (%esp),%eax
		mov    $0x14,%edx
		add    $0x13,%eax
		call   __convDec_
		mov    $0x16,%edx
		mov    0x4(%esp),%eax
		mov    %edi,%ebx
		call   __convDec_
		movb   $0xa,0x18(%edi)
		mov    %edi,%eax
		movb   $0x0,0x19(%edi)
		add    $0x8,%esp
		pop    %edi
		pop    %esi
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
_asctime:	/* 0x1124a3 */
/*----------------------------------------------------------------*/
		push   %edx
		mov    $data_1ed894,%edx
		call   ___asctime_
		pop    %edx
		ret


/*----------------------------------------------------------------*/
AILSS_start_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15aad4
		jne    jump_11256c
		push   $AILSS_end_
		push   $AILSS_start_
		call   VMM_lock_range
		add    $0x8,%esp
		push   $0x80
		push   $data_15aa50
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_15aad0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8c4
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0xc
		push   $data_1ed8b4
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8cc
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8d0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8c0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8c8
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8b0
		call   AIL_vmm_lock
		add    $0x8,%esp
		mov    $0x1,%ebx
		call   AILSSA_VMM_lock
		mov    %ebx,data_15aad4
	jump_11256c:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
SS_start_DIG_driver_playback:
/*----------------------------------------------------------------*/
		push   %ebx
		sub    $0xc,%esp
		mov    0x14(%esp),%ebx
		mov    0x54(%ebx),%edx
		test   %edx,%edx
		jne    jump_1125ae
		mov    0x18(%ebx),%ax
		mov    %ax,0x6(%esp)
		mov    0x14(%ebx),%ax
		push   %edx
		mov    %ax,0x8(%esp)
		lea    0x4(%esp),%eax
		push   %eax
		push   $0x401
		mov    (%ebx),%ecx
		push   %ecx
		call   AIL_call_driver
		add    $0x10,%esp
		movl   $0x1,0x54(%ebx) /* ->playing = true */
	jump_1125ae:
		add    $0xc,%esp
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
SS_stop_DIG_driver_playback:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ebx
		cmpl   $0x0,0x54(%ebx)
		je     jump_1125e6
		push   $0x0
		push   $0x0
		push   $0x402
		mov    (%ebx),%ecx
		push   %ecx
		call   AIL_call_driver
		add    $0x10,%esp
		movl   $0x0,0x54(%ebx) /* ->playing = false */
	jump_1125e6:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
SS_build_amplitude_tables:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x1c,%esp
		mov    0x30(%esp),%ecx
		mov    0x40(%ecx),%edx
		cmp    $0x7f,%edx
		jle    jump_11260c
		movl   $0x7f,0x40(%ecx)
		jmp    jump_112617
	jump_11260c:
		test   %edx,%edx
		jge    jump_112617
		movl   $0x0,0x40(%ecx)
	jump_112617:
		mov    0x44(%ecx),%esi
		cmp    $0x7f,%esi
		jle    jump_112628
		movl   $0x7f,0x44(%ecx)
		jmp    jump_112633
	jump_112628:
		test   %esi,%esi
		jge    jump_112633
		movl   $0x0,0x44(%ecx)
	jump_112633:
		mov    0x40(%ecx),%eax
		mov    %eax,0x18(%esp)
		mov    (%ecx),%eax
		mov    0x18(%esp),%edx
		imul   0x68(%eax),%edx
		mov    $0x7f,%ebx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		mov    0x44(%ecx),%edi
		mov    %eax,0x18(%esp)
		test   %eax,%eax
		jge    jump_112661
		xor    %edx,%edx
		mov    %edx,0x18(%esp)
	jump_112661:
		cmpl   $0x7f,0x18(%esp)
		jle    jump_112670
		movl   $0x7f,0x18(%esp)
	jump_112670:
		mov    0x34(%ecx),%ebp
		cmp    $0x1,%ebp
		je     jump_11267d
		cmp    $0x3,%ebp
		jne    jump_1126c6
	jump_11267d:
		mov    $0x7f,%eax
		sub    %edi,%eax
		xor    %edx,%edx
		mov    data_15aa50(%eax),%dl
		imul   0x18(%esp),%edx
		mov    $0x7f,%ebx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		xor    %edx,%edx
		mov    %eax,0x48(%ecx)
		mov    0x18(%esp),%ebx
		mov    data_15aa50(%edi),%dl
		imul   %ebx,%edx
		mov    $0x7f,%ebx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		mov    %eax,0x448(%ecx)
		jmp    jump_1128fb
	jump_1126c6:
		mov    0x18(%esp),%edx
		test   %edx,%edx
		je     jump_1126d5
		lea    0x1(%edx),%ebx
		mov    %ebx,0x18(%esp)
	jump_1126d5:
		mov    (%ecx),%eax
		mov    0x18(%eax),%esi
		cmp    $0x2,%esi
		je     jump_112702
		cmp    $0x3,%esi
		je     jump_112702
		test   %esi,%esi
		je     jump_1126f1
		cmp    $0x1,%esi
		jne    jump_11284c
	jump_1126f1:
		mov    0x34(%ecx),%esi
		cmp    $0x2,%esi
		je     jump_112702
		cmp    $0x3,%esi
		jne    jump_11284c
	jump_112702:
		mov    $0x7f,%ebx
		lea    0x48(%ecx),%eax
		sub    %edi,%ebx
		lea    0x448(%ecx),%edx
		mov    data_15aa50(%ebx),%bl
		movzbl data_15aa50(%edi),%esi
		mov    0x18(%esp),%edi
		shl    $0x8,%edi
		and    $0xff,%ebx
		mov    %edi,0x8(%esp)
		testb  $0x1,0x38(%ecx)
		je     jump_1127e8
		mov    0x8(%esp),%ecx
		mov    0x18(%esp),%ebp
		xor    %edi,%edi
		mov    %ecx,0xc(%esp)
		imul   $0x0,%ebp,%ecx
		lea    0x0(%eax),%eax
		mov    %ecx,%ecx
	jump_112750:
		mov    %ecx,%ebp
		sar    $0x7,%ebp
		mov    %ebp,(%esp)
		imul   %ebx,%ebp
		sar    $0x7,%ebp
		mov    %ebp,(%eax)
		mov    (%esp),%ebp
		imul   %esi,%ebp
		add    $0x4,%edx
		sar    $0x7,%ebp
		add    $0x4,%eax
		mov    %ebp,-0x4(%edx)
		mov    0xc(%esp),%ebp
		add    $0x100,%edi
		add    %ebp,%ecx
		cmp    $0x8000,%edi
		jl     jump_112750
		mov    0x18(%esp),%ecx
		shl    $0x8,%ecx
		mov    %ecx,0x14(%esp)
		mov    0x18(%esp),%ecx
		mov    %ecx,0x4(%esp)
		mov    0x4(%esp),%ebp
		shl    $0x11,%ecx
		sub    %ebp,%ecx
		mov    $0xffff8000,%edi
		shl    $0xf,%ecx
		lea    0x0(%eax),%eax
	jump_1127b0:
		mov    %ecx,%ebp
		sar    $0x7,%ebp
		mov    %ebp,(%esp)
		imul   %ebx,%ebp
		sar    $0x7,%ebp
		mov    %ebp,(%eax)
		mov    (%esp),%ebp
		imul   %esi,%ebp
		add    $0x4,%edx
		sar    $0x7,%ebp
		add    $0x4,%eax
		mov    %ebp,-0x4(%edx)
		mov    0x14(%esp),%ebp
		add    $0x100,%edi
		add    %ebp,%ecx
		test   %edi,%edi
		jge    jump_1128fb
		jmp    jump_1127b0
	jump_1127e8:
		mov    0x8(%esp),%ecx
		mov    %ecx,0x10(%esp)
		mov    0x18(%esp),%ecx
		mov    %ecx,0x4(%esp)
		mov    0x4(%esp),%ebp
		shl    $0x11,%ecx
		sub    %ebp,%ecx
		mov    $0xffff8000,%edi
		shl    $0xf,%ecx
		lea    0x0(%eax),%eax
		nop
	jump_112810:
		mov    %ecx,%ebp
		sar    $0x7,%ebp
		mov    %ebp,(%esp)
		imul   %ebx,%ebp
		sar    $0x7,%ebp
		mov    %ebp,(%eax)
		mov    (%esp),%ebp
		imul   %esi,%ebp
		add    $0x4,%edx
		sar    $0x7,%ebp
		add    $0x4,%eax
		mov    %ebp,-0x4(%edx)
		mov    0x10(%esp),%ebp
		add    $0x100,%edi
		add    %ebp,%ecx
		cmp    $0x8000,%edi
		jge    jump_1128fb
		jmp    jump_112810
	jump_11284c:
		mov    0x18(%esp),%edx
		lea    0x48(%ecx),%eax
		mov    0x38(%ecx),%bl
		shl    $0x8,%edx
		test   $0x1,%bl
		je     jump_1128c9
		mov    0x18(%esp),%ebx
		mov    %edx,%edi
		xor    %ecx,%ecx
		imul   $0x0,%ebx,%edx
		lea    0x0(%eax),%eax
	jump_112870:
		mov    %edx,%ebx
		add    $0x4,%eax
		add    $0x100,%ecx
		sar    $0x7,%ebx
		add    %edi,%edx
		mov    %ebx,-0x4(%eax)
		cmp    $0x8000,%ecx
		jl     jump_112870
		mov    0x18(%esp),%ecx
		mov    %ecx,%edx
		mov    $0xffff8000,%ebx
		shl    $0x11,%edx
		mov    0x18(%esp),%esi
		sub    %ecx,%edx
		shl    $0x8,%esi
		shl    $0xf,%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		mov    %ebx,%ebx
	jump_1128b0:
		mov    %edx,%ecx
		add    $0x4,%eax
		add    $0x100,%ebx
		sar    $0x7,%ecx
		add    %esi,%edx
		mov    %ecx,-0x4(%eax)
		test   %ebx,%ebx
		jge    jump_1128fb
		jmp    jump_1128b0
	jump_1128c9:
		mov    0x18(%esp),%ebx
		mov    %edx,%edi
		mov    %ebx,%edx
		shl    $0x11,%edx
		sub    %ebx,%edx
		mov    $0xffff8000,%ecx
		shl    $0xf,%edx
		mov    %eax,%eax
	jump_1128e0:
		mov    %edx,%ebx
		add    $0x4,%eax
		add    $0x100,%ecx
		sar    $0x7,%ebx
		add    %edi,%edx
		mov    %ebx,-0x4(%eax)
		cmp    $0x8000,%ecx
		jl     jump_1128e0
	jump_1128fb:
		add    $0x1c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (SS_serve)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    data_1ed8c0,%ebx
		cmpl   $0x0,data_15aad0
		jne    jump_112afb
		mov    $0x1,%ecx
		mov    0x14(%esp),%eax
		mov    data_1ed834,%esi
		mov    %ecx,data_15aad0
		mov    %eax,data_1ed8c4
		test   %esi,%esi
		je     jump_11294f
		call   AIL_disable_interrupts
		mov    %eax,data_1ed8cc
	jump_11294f:
		mov    data_1ed8c4,%eax
		mov    0x54(%eax),%edi
		mov    data_1ed8c0,%ebx
		test   %edi,%edi
		jne    jump_11298c
		cmpl   $0x0,data_1ed834
		je     jump_112979
		mov    data_1ed8cc,%ecx
		push   %ecx
		call   AIL_restore_interrupts
		add    $0x4,%esp
	jump_112979:
		xor    %esi,%esi
		mov    data_1ed8c0,%ebx
		mov    %esi,data_15aad0
		jmp    jump_112afb
	jump_11298c:
		mov    0x34(%eax),%edx
		movswl (%edx),%edx
		mov    %edx,data_1ed8c8
		cmp    $0xffffffff,%edx
		je     jump_1129a2
		cmp    0x38(%eax),%edx
		jne    jump_1129d9
	jump_1129a2:
		mov    data_1ed834,%edi
		mov    %ebx,data_1ed8c0
		test   %edi,%edi
		je     jump_1129c1
		mov    data_1ed8cc,%ebp
		push   %ebp
		call   AIL_restore_interrupts
		add    $0x4,%esp
	jump_1129c1:
		xor    %eax,%eax
		mov    data_1ed8c0,%ebx
		mov    %eax,data_15aad0
		mov    %ebx,data_1ed8c0
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1129d9:
		push   %eax
		mov    %edx,0x38(%eax)
		call   AILSSA_flush_buffer
		xor    %esi,%esi
		mov    data_1ed8c4,%eax
		add    $0x4,%esp
		mov    %esi,data_1ed8d0
		mov    0x60(%eax),%ebx
		mov    0x5c(%eax),%eax
		mov    %ebx,data_1ed8c0
		mov    %eax,data_1ed8b0
		test   %ebx,%ebx
		je     jump_112a44
	jump_112a07:
		mov    data_1ed8b0,%eax
		cmpl   $0x4,0x4(%eax)
		jne    jump_112a21
		push   %eax
		incl   data_1ed8d0
		call   AILSSA_merge
		add    $0x4,%esp
	jump_112a21:
		mov    data_1ed8c0,%ebx
		mov    data_1ed8b0,%edi
		dec    %ebx
		add    $0x894,%edi
		mov    %ebx,data_1ed8c0
		mov    %edi,data_1ed8b0
		test   %ebx,%ebx
		jne    jump_112a07
	jump_112a44:
		mov    data_1ed8c4,%eax
		mov    data_1ed8d0,%edx
		mov    %edx,0x64(%eax)
		mov    data_1ed8c8,%edx
		xor    $0x1,%dl
		push   %edx
		push   %eax
		call   AILSSA_DMA_copy
		mov    data_1ed8c4,%eax
		mov    0x1c(%eax),%dl
		add    $0x8,%esp
		test   $0x10,%dl
		je     jump_112aa3
		push   $0x0
		xor    %edx,%edx
		push   $data_1ed8b4
		mov    %dx,data_1ed8b8
		push   $0x405
		mov    data_1ed8c8,%dx
		mov    (%eax),%ebp
		xor    $0x1,%dl
		push   %ebp
		mov    %dx,data_1ed8ba
		call   AIL_call_driver
		add    $0x10,%esp
	jump_112aa3:
		mov    data_1ed8c4,%eax
		mov    0x64(%eax),%edx
		mov    data_1ed8c0,%ebx
		test   %edx,%edx
		je     jump_112abe
		movl   $0x0,0x58(%eax)
		jmp    jump_112ad5
	jump_112abe:
		mov    0x58(%eax),%edx
		lea    0x1(%edx),%ecx
		mov    %ecx,0x58(%eax)
		cmp    $0x2,%edx
		jne    jump_112ad5
		push   %eax
		call   SS_stop_DIG_driver_playback
		add    $0x4,%esp
	jump_112ad5:
		cmpl   $0x0,data_1ed834
		je     jump_112aed
		mov    data_1ed8cc,%esi
		push   %esi
		call   AIL_restore_interrupts
		add    $0x4,%esp
	jump_112aed:
		xor    %edi,%edi
		mov    data_1ed8c0,%ebx
		mov    %edi,data_15aad0
	jump_112afb:
		mov    %ebx,data_1ed8c0
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret

vtable_112b08:
		.long   func_112bc6
		.long   func_112be8
		.long   func_112c0a
		.long   func_112c2c

vtable_112b18:
		.long   func_112d98
		.long   func_112db8
		.long   func_112da8
		.long   func_112dc1


/*----------------------------------------------------------------*/
SS_configure_buffers:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x1c,%esp
		mov    0x30(%esp),%esi
		mov    0x54(%esi),%eax
		mov    %eax,0x10(%esp)
		test   %eax,%eax
		je     jump_112ba6
		mov    0x60(%esi),%ecx
		xor    %ebx,%ebx
		test   %ecx,%ecx
		jle    jump_112b7e
		xor    %eax,%eax
	jump_112b51:
		mov    0x5c(%esi),%ecx
		mov    0x4(%ecx,%eax,1),%ebp
		mov    %ebp,0x890(%ecx,%eax,1)
		mov    0x5c(%esi),%ecx
		add    %eax,%ecx
		cmpl   $0x4,0x4(%ecx)
		jne    jump_112b71
		movl   $0x8,0x4(%ecx)
	jump_112b71:
		inc    %ebx
		mov    0x60(%esi),%edx
		add    $0x894,%eax
		cmp    %edx,%ebx
		jl     jump_112b51
	jump_112b7e:
		push   %esi
		call   SS_stop_DIG_driver_playback
		add    $0x4,%esp
		push   %esi
		call   AILSSA_flush_buffer
		add    $0x4,%esp
		push   $0x0
		push   %esi
		call   AILSSA_DMA_copy
		add    $0x8,%esp
		push   $0x1
		push   %esi
		call   AILSSA_DMA_copy
		add    $0x8,%esp
	jump_112ba6:
		mov    data_1ed828,%eax
		mov    data_1ed82c,%ebx
		add    %eax,%eax
		or     %ebx,%eax
		cmp    $0x3,%eax
		ja     jump_112c4c
		jmp    *%cs:vtable_112b08(,%eax,4)


/*----------------------------------------------------------------*/
func_112bc6:
/*----------------------------------------------------------------*/
		mov    $0x1,%edx
		mov    $0x2,%ebx
		xor    %eax,%eax
		mov    $0x3,%ecx
		mov    %eax,(%esp)
		mov    %edx,0x4(%esp)
		mov    %ebx,0x8(%esp)
		mov    %ecx,0xc(%esp)
		jmp    jump_112c4c


/*----------------------------------------------------------------*/
func_112be8:
/*----------------------------------------------------------------*/
		mov    $0x1,%edx
		mov    $0x3,%ecx
		mov    $0x2,%ebp
		xor    %ebx,%ebx
		mov    %edx,(%esp)
		mov    %ebx,0x4(%esp)
		mov    %ecx,0x8(%esp)
		mov    %ebp,0xc(%esp)
		jmp    jump_112c4c


/*----------------------------------------------------------------*/
func_112c0a:
/*----------------------------------------------------------------*/
		mov    $0x2,%ebx
		mov    $0x3,%ecx
		mov    $0x1,%eax
		xor    %ebp,%ebp
		mov    %ebx,(%esp)
		mov    %ecx,0x4(%esp)
		mov    %ebp,0x8(%esp)
		mov    %eax,0xc(%esp)
		jmp    jump_112c4c


/*----------------------------------------------------------------*/
func_112c2c:
/*----------------------------------------------------------------*/
		mov    $0x3,%ecx
		mov    $0x2,%ebp
		mov    $0x1,%eax
		xor    %edx,%edx
		mov    %ecx,(%esp)
		mov    %ebp,0x4(%esp)
		mov    %eax,0x8(%esp)
		mov    %edx,0xc(%esp)
	jump_112c4c:
		mov    0x4(%esi),%ecx
		xor    %eax,%eax
	jump_112c51:
		mov    (%esp,%eax,1),%ebx
		cmpb   $0x0,(%ecx,%ebx,1)
		je     jump_112c5f
		mov    %ebx,0x18(%esi)
		jmp    jump_112c67
	jump_112c5f:
		add    $0x4,%eax
		cmp    $0x10,%eax
		jl     jump_112c51
	jump_112c67:
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		mov    0x4(%esi),%ebx
		sub    %edx,%eax
		mov    0x1a(%ebx,%eax,2),%eax
		mov    %eax,0x1c(%esi)
		mov    data_1ed810,%eax
		cmp    $0x1,%eax
		jb     jump_112c90
		jbe    jump_112cb2
		cmp    $0x2,%eax
		je     jump_112cd0
		jmp    jump_112cee
	jump_112c90:
		test   %eax,%eax
		jne    jump_112cee
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		mov    0x4(%esi),%ebx
		sub    %edx,%eax
		mov    0x10(%ebx,%eax,2),%ax
		and    $0xffff,%eax
		jmp    jump_112d85
	jump_112cb2:
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		mov    0x4(%esi),%ebx
		sub    %edx,%eax
		mov    0x12(%ebx,%eax,2),%ax
		and    $0xffff,%eax
		jmp    jump_112d85
	jump_112cd0:
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		mov    0x4(%esi),%ebx
		sub    %edx,%eax
		mov    0x14(%ebx,%eax,2),%ax
		and    $0xffff,%eax
		jmp    jump_112d85
	jump_112cee:
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		sub    %edx,%eax
		mov    0x4(%esi),%ebx
		add    %eax,%eax
		lea    (%ebx,%eax,1),%edx
		xor    %eax,%eax
		mov    0x10(%edx),%ax
		mov    %eax,(%esp)
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		sub    %edx,%eax
		mov    0x4(%esi),%ebx
		add    %eax,%eax
		add    %eax,%ebx
		xor    %eax,%eax
		mov    0x12(%ebx),%ax
		mov    %eax,0x4(%esp)
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		sub    %edx,%eax
		mov    0x4(%esi),%ebx
		add    %eax,%eax
		lea    (%ebx,%eax,1),%edx
		xor    %eax,%eax
		mov    data_1ed810,%ebp
		mov    0x14(%edx),%ax
		xor    %ecx,%ecx
		mov    %eax,0x8(%esp)
		mov    $0x7fffffff,%eax
		xor    %ebx,%ebx
		mov    %eax,0x18(%esp)
	jump_112d59:
		mov    %ebp,%eax
		sub    (%esp,%ebx,1),%eax
		cltd
		xor    %edx,%eax
		sub    %edx,%eax
		cmp    0x18(%esp),%eax
		jg     jump_112d79
		mov    %ebp,%eax
		sub    (%esp,%ebx,1),%eax
		cltd
		xor    %edx,%eax
		sub    %edx,%eax
		mov    %eax,0x18(%esp)
		mov    %ecx,%edi
	jump_112d79:
		inc    %ecx
		add    $0x4,%ebx
		cmp    $0x3,%ecx
		jl     jump_112d59
		mov    (%esp,%edi,4),%eax
	jump_112d85:
		mov    %eax,0x14(%esi)
		mov    0x18(%esi),%eax
		cmp    $0x3,%eax
		ja     jump_112dcf
		jmp    *%cs:vtable_112b18(,%eax,4)


/*----------------------------------------------------------------*/
func_112d98:
/*----------------------------------------------------------------*/
		movl   $0x1,0x3c(%esi)
		movl   $0x1,0x40(%esi)
		jmp    jump_112dcf


/*----------------------------------------------------------------*/
func_112da8:
/*----------------------------------------------------------------*/
		movl   $0x2,0x3c(%esi)
		movl   $0x1,0x40(%esi)
		jmp    jump_112dcf


/*----------------------------------------------------------------*/
func_112db8:
/*----------------------------------------------------------------*/
		movl   $0x1,0x3c(%esi)
		jmp    jump_112dc8


/*----------------------------------------------------------------*/
func_112dc1:
/*----------------------------------------------------------------*/
		movl   $0x2,0x3c(%esi)
	jump_112dc8:
		movl   $0x2,0x40(%esi)
	jump_112dcf:
		mov    data_1ed818,%ebp
		mov    0x14(%esi),%edx
		imul   %ebp,%edx
		mov    $0x3e8,%ebx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		mov    0x40(%esi),%edx
		imul   %eax,%edx
		mov    0x3c(%esi),%eax
		imul   %eax,%edx
		mov    %edx,0x10(%esi)
		mov    0x18(%esi),%edx
		lea    0x0(,%edx,8),%eax
		sub    %edx,%eax
		mov    0x4(%esi),%ebp
		add    %eax,%eax
		add    %eax,%ebp
		xor    %eax,%eax
		mov    0x16(%ebp),%ax
		mov    %eax,0x14(%esp)
		mov    data_1ed854,%eax
		movzwl 0x18(%ebp),%ebp
		test   %eax,%eax
		je     jump_112e52
		cmp    $0x800,%ebp
		jle    jump_112e2d
		mov    $0x800,%ebp
	jump_112e2d:
		cmpl   $0x800,0x14(%esp)
		jle    jump_112e52
		mov    $0xa,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161924,%esi
		xor    %eax,%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		jmp    jump_112f5c
	jump_112e52:
		mov    $0x7fffffff,%ebx
		mov    $0x8,%ecx
		jmp    jump_112e7c
	jump_112e5e:
		mov    %ecx,%eax
		sub    0x10(%esi),%eax
		cltd
		xor    %edx,%eax
		sub    %edx,%eax
		cmp    %ebx,%eax
		jg     jump_112e7a
		mov    %ecx,%eax
		sub    0x10(%esi),%eax
		mov    %ecx,%edi
		cltd
		xor    %edx,%eax
		sub    %edx,%eax
		mov    %eax,%ebx
	jump_112e7a:
		add    %ecx,%ecx
	jump_112e7c:
		mov    data_1ed814,%eax
		mov    %eax,%edx
		sar    $0x1f,%edx
		sub    %edx,%eax
		sar    %eax
		cmp    %eax,%ecx
		jle    jump_112e5e
		mov    0x14(%esp),%ebx
		mov    %edi,0x10(%esi)
		cmp    %ebx,%edi
		jge    jump_112e9c
		mov    %ebx,0x10(%esi)
	jump_112e9c:
		cmp    0x10(%esi),%ebp
		jge    jump_112ea4
		mov    %ebp,0x10(%esi)
	jump_112ea4:
		mov    data_1ed854,%edi
		mov    0x20(%esi),%eax
		test   %edi,%edi
		je     jump_112ec1
		shr    $0xc,%eax
		add    $0xfff,%eax
		and    $0xff000,%eax
		shl    $0xc,%eax
	jump_112ec1:
		mov    0x8(%esi),%edx
		mov    %eax,(%edx)
		mov    0x10(%esi),%ebp
		mov    0x8(%esi),%edx
		add    %ebp,%eax
		mov    %eax,0x4(%edx)
		mov    0x8(%esi),%eax
		mov    (%eax),%edx
		shr    $0x10,%edx
		mov    (%eax),%eax
		shl    $0x4,%edx
		and    $0xffff,%eax
		add    %eax,%edx
		mov    0x8(%esi),%eax
		mov    %edx,0x2c(%esi)
		mov    0x4(%eax),%edx
		shr    $0x10,%edx
		mov    0x4(%eax),%eax
		shl    $0x4,%edx
		and    $0xffff,%eax
		add    %eax,%edx
		mov    0x10(%esp),%eax
		mov    %edx,0x30(%esi)
		test   %eax,%eax
		je     jump_112f57
		mov    0x60(%esi),%edx
		xor    %ecx,%ecx
		test   %edx,%edx
		jle    jump_112f2f
		xor    %eax,%eax
	jump_112f14:
		mov    0x5c(%esi),%ebx
		mov    0x890(%ebx,%eax,1),%edi
		mov    %edi,0x4(%ebx,%eax,1)
		inc    %ecx
		mov    0x60(%esi),%edi
		add    $0x894,%eax
		cmp    %edi,%ecx
		jl     jump_112f14
	jump_112f2f:
		push   %esi
		call   AILSSA_flush_buffer
		add    $0x4,%esp
		push   $0x0
		push   %esi
		call   AILSSA_DMA_copy
		add    $0x8,%esp
		push   $0x1
		push   %esi
		call   AILSSA_DMA_copy
		add    $0x8,%esp
		push   %esi
		call   SS_start_DIG_driver_playback
		add    $0x4,%esp
	jump_112f57:
		mov    $0x1,%eax
	jump_112f5c:
		add    $0x1c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
SS_attempt_DIG_detection:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x24,%esp
		mov    0x38(%esp),%ebp
		mov    0x3c(%esp),%esi
		mov    $0x6,%ecx
		mov    %esp,%edi
		rep movsl %ds:(%esi),%es:(%edi)
		mov    0x0(%ebp),%eax
		mov    0x10(%eax),%eax
		cmpw   $0x0,0x10(%eax)
		jbe    jump_11300a
		mov    0xc(%eax),%ebx
		shr    $0x10,%ebx
		mov    0xc(%eax),%eax
		shl    $0x4,%ebx
		and    $0xffff,%eax
		add    %eax,%ebx
		movswl (%esp),%eax
		test   %eax,%eax
		jge    jump_112fbb
		mov    (%ebx),%ax
		mov    %ax,(%esp)
	jump_112fbb:
		movswl 0x2(%esp),%eax
		test   %eax,%eax
		jge    jump_112fcd
		mov    0x2(%ebx),%ax
		mov    %ax,0x2(%esp)
	jump_112fcd:
		movswl 0x4(%esp),%eax
		test   %eax,%eax
		jge    jump_112fdf
		mov    0x4(%ebx),%ax
		mov    %ax,0x4(%esp)
	jump_112fdf:
		movswl 0x6(%esp),%eax
		test   %eax,%eax
		jge    jump_112ff1
		mov    0x6(%ebx),%ax
		mov    %ax,0x6(%esp)
	jump_112ff1:
		xor    %eax,%eax
	jump_112ff3:
		cmpl   $0x0,0x8(%esp,%eax,1)
		jge    jump_113002
		mov    0x8(%ebx,%eax,1),%edx
		mov    %edx,0x8(%esp,%eax,1)
	jump_113002:
		add    $0x4,%eax
		cmp    $0x10,%eax
		jne    jump_112ff3
	jump_11300a:
		mov    0x0(%ebp),%esi
		mov    0x10(%esi),%esi
		mov    $0x6,%ecx
		lea    0x16(%esi),%edi
		mov    %esp,%esi
		mov    data_1ed830,%ebx
		rep movsl %ds:(%esi),%es:(%edi)
		test   %ebx,%ebx
		jne    jump_113041
		push   %ebx
		lea    0x1c(%esp),%eax
		mov    $0x1,%ecx
		push   %eax
		mov    %cx,0x26(%esp)
		push   $0x304
		mov    0x0(%ebp),%esi
		push   %esi
		jmp    jump_11305b
	jump_113041:
		push   $0x0
		lea    0x1c(%esp),%eax
		mov    $0x3,%ebx
		push   %eax
		mov    %bx,0x26(%esp)
		push   $0x304
		mov    0x0(%ebp),%ecx
		push   %ecx
	jump_11305b:
		call   AIL_call_driver
		add    $0x10,%esp
		add    $0x24,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
SS_destroy_DIG_driver:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		cmpl   $0x0,0x54(%ebx)
		je     jump_1130b0
		push   %ebx
		call   SS_stop_DIG_driver_playback
		add    $0x4,%esp
		push   %ebx
		call   AILSSA_flush_buffer
		add    $0x4,%esp
		push   $0x0
		push   %ebx
		call   AILSSA_DMA_copy
		add    $0x8,%esp
		push   $0x1
		push   %ebx
		call   AILSSA_DMA_copy
		add    $0x8,%esp
		push   $0xa
		call   AIL_delay
		add    $0x4,%esp
	jump_1130b0:
		mov    0xc(%ebx),%ecx
		push   %ecx
		call   AIL_release_timer_handle
		add    $0x4,%esp
		mov    0x24(%ebx),%esi
		push   %esi
		mov    0x20(%ebx),%edi
		push   %edi
		mov    0x28(%ebx),%ebp
		push   %ebp
		call   MEM_free_DOS
		imul   $0x894,0x60(%ebx),%eax
		add    $0xc,%esp
		push   %eax
		mov    0x5c(%ebx),%ecx
		push   %ecx
		call   MEM_free_lock
		add    $0x8,%esp
		mov    0x4c(%ebx),%esi
		push   %esi
		mov    0x50(%ebx),%edi
		push   %edi
		call   MEM_free_lock
		add    $0x8,%esp
		push   $0x8c
		push   %ebx
		call   MEM_free_lock
		add    $0x8,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (SS_construct_DIG_driver)	/* 113110 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x3c,%esp
		call   AILSS_start_
		push   $0x8c
		call   MEM_alloc_lock	/* allocate SoundPCMDriver */
		mov    %eax,%ebp
		add    $0x4,%esp
		test   %eax,%eax
		jne    jump_113147
		mov    $0x9,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161950,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		jmp    jump_113703
	jump_113147:
		mov    0x50(%esp),%edx
		mov    %edx,(%eax)
		mov    0x14(%edx),%ebx
		mov    %edx,%eax
		test   %ebx,%ebx
		je     jump_113183
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161978,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		push   $0x8c
		mov    %ebp,%ecx
		push   %ecx
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_113183:
		lea    0x18(%esp),%edx
		push   %edx
		push   %ebx
		push   $0x301
		push   %eax
		call   AIL_call_driver
		add    $0x10,%esp
		xor    %eax,%eax
		xor    %edx,%edx
		mov    0x1e(%esp),%ax
		mov    0x18(%esp),%dx
		shl    $0x4,%eax
		add    %edx,%eax
		mov    %ebp,%edx
		mov    %eax,0x4(%edx)
		xor    %eax,%eax
		mov    0x1c(%esp),%ax
		mov    %eax,%edx
		xor    %eax,%eax
		shl    $0x4,%edx
		mov    0x1a(%esp),%ax
		add    %eax,%edx
		mov    %ebp,%eax
		mov    %edx,0x8(%eax)
		lea    0x8(%edx),%eax
		mov    %ebp,%edx
		movl   $0xffffffff,0x38(%edx)
		movl   $0x7f,0x68(%edx)
		mov    %eax,0x34(%edx)
		mov    %ebx,0x54(%edx)
		xor    %ecx,%ecx
		mov    %ebx,0x58(%edx)
		mov    0x54(%esp),%esi
		mov    %ebx,0x64(%edx)
		mov    $0x18,%ebx
		mov    $0xffffffff,%edx
		mov    $data_1ed7f0,%eax
		mov    %ecx,0x34(%esp)
		call   ac_memset
		test   %esi,%esi
		je     jump_113240
		mov    $0x6,%ecx
		mov    $data_1ed7f0,%edi
		rep movsl %ds:(%esi),%es:(%edi)
		mov    0x54(%esp),%edi
		push   %edi
		mov    %ebp,%eax
		push   %eax
		call   SS_attempt_DIG_detection
		add    $0x8,%esp
		test   %eax,%eax
		je     jump_113240
		mov    $0x1,%edx
		mov    $0x6,%ecx
		mov    %esp,%edi
		mov    0x54(%esp),%esi
		mov    %edx,0x34(%esp)
		rep movsl %ds:(%esi),%es:(%edi)
	jump_113240:
		cmpl   $0x0,0x34(%esp)
		jne    jump_113289
		mov    0x0(%ebp),%ecx
		push   %ecx
		call   ac_sound_get_io_environment
		mov    %eax,%ebx
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_113289
		mov    $0x6,%ecx
		push   %eax
		mov    $data_1ed7f0,%edi
		mov    %eax,%esi
		push   %ebp
		rep movsl %ds:(%esi),%es:(%edi)
		call   SS_attempt_DIG_detection
		add    $0x8,%esp
		test   %eax,%eax
		je     jump_113289
		mov    $0x1,%esi
		mov    $0x6,%ecx
		mov    %esp,%edi
		mov    %esi,0x34(%esp)
		mov    %ebx,%esi
		rep movsl %ds:(%esi),%es:(%edi)
	jump_113289:
		mov    0x34(%esp),%edi
		test   %edi,%edi
		jne    jump_113323
		cmpl   $0x1,data_1ed850
		jne    jump_113323
		mov    %edi,0x38(%esp)
		mov    %edi,0x30(%esp)
		jmp    jump_11330f
	jump_1132ac:
		mov    0xc(%eax),%ebx
		shr    $0x10,%ebx
		mov    0xc(%eax),%eax
		shl    $0x4,%ebx
		and    $0xffff,%eax
		mov    0x30(%esp),%edi
		add    %eax,%ebx
		add    %edi,%ebx
		test   %esi,%esi
		jne    jump_1132d7
		mov    $0x6,%ecx
		mov    $data_1ed7f0,%edi
		mov    %ebx,%esi
		rep movsl %ds:(%esi),%es:(%edi)
	jump_1132d7:
		push   %ebx
		push   %ebp
		call   SS_attempt_DIG_detection
		add    $0x8,%esp
		test   %eax,%eax
		je     jump_1132fb
		mov    $0x1,%ecx
		mov    %esp,%edi
		mov    %ebx,%esi
		mov    %ecx,0x34(%esp)
		mov    $0x6,%ecx
		rep movsl %ds:(%esi),%es:(%edi)
		jmp    jump_113323
	jump_1132fb:
		mov    0x30(%esp),%edx
		mov    0x38(%esp),%ebx
		add    $0x18,%edx
		inc    %ebx
		mov    %edx,0x30(%esp)
		mov    %ebx,0x38(%esp)
	jump_11330f:
		mov    0x0(%ebp),%eax
		mov    0x10(%eax),%eax
		xor    %ebx,%ebx
		mov    0x38(%esp),%esi
		mov    0x10(%eax),%bx /* number of IO configurations */
		cmp    %esi,%ebx
		jg     jump_1132ac
	jump_113323:
		cmpl   $0x0,0x34(%esp)
		jne    jump_113355
		mov    $0x8,%ecx
		push   $0x8c
		mov    $data_1ed6f0,%edi
		mov    $data_161990,%esi
		push   %ebp
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_113355:
		mov    $0x6,%ecx
		mov    %esp,%esi
		mov    $data_1ed7f0,%edi
		rep movsl %ds:(%esi),%es:(%edi)
		cmpl   $0x0,data_1ed854
		je     jump_113373
		mov    $0x2000,%esi
		jmp    jump_113379
	jump_113373:
		mov    data_1ed814,%esi
	jump_113379:
		lea    0xf(%esi),%edx
		mov    %edx,%eax
		sar    $0x1f,%edx
		shl    $0x4,%edx
		sbb    %edx,%eax
		sar    $0x4,%eax
		movl   $0x0,0x28(%ebp)
		mov    %eax,%edi
	jump_113392:
		lea    0x24(%esp),%eax
		push   %eax
		lea    0x2c(%esp),%eax
		push   %eax
		lea    0x34(%esp),%eax
		push   %eax
		push   %edi
		call   func_10f290
		add    $0x10,%esp
		test   %eax,%eax
		jne    jump_1133d7
		mov    $0x8,%ecx
		push   $0x8c
		mov    $data_1ed6f0,%edi
		mov    $data_1619b4,%esi
		push   %ebp
		rep movsl %ds:(%esi),%es:(%edi)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1133d7:
		mov    0x28(%ebp),%eax
		test   %eax,%eax
		je     jump_1133ef
		mov    0x24(%ebp),%edx
		push   %edx
		mov    0x20(%ebp),%ebx
		push   %ebx
		push   %eax
		call   MEM_free_DOS
		add    $0xc,%esp
	jump_1133ef:
		mov    0x2c(%esp),%eax
		mov    %eax,0x28(%ebp)
		mov    0x28(%esp),%eax
		mov    %eax,0x20(%ebp)
		mov    0x24(%esp),%eax
		mov    %eax,0x24(%ebp)
		mov    0x28(%esp),%eax
		shr    $0xc,%eax
		mov    %eax,%ebx
		add    %esi,%eax
		dec    %eax
		and    $0xf0000,%ebx
		and    $0xf0000,%eax
		cmp    %eax,%ebx
		jne    jump_113392
		push   %ebp
		call   SS_configure_buffers
		add    $0x4,%esp
		test   %eax,%eax
		jne    jump_11345c
		mov    0x24(%ebp),%esi
		push   %esi
		mov    0x20(%ebp),%edi
		push   %edi
		mov    0x28(%ebp),%eax
		push   %eax
		call   MEM_free_DOS
		add    $0xc,%esp
		push   $0x8c
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_11345c:
		push   $0x0
		push   $0x0
		push   $0x305
		mov    0x0(%ebp),%esi
		push   %esi
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		movl   $0x1,0x18(%eax)
		mov    0x3c(%ebp),%ebx
		imul   0x40(%ebp),%ebx
		mov    0x10(%ebp),%edx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		mov    0x10(%ebp),%edx
		mov    0x40(%ebp),%ebx
		mov    %eax,0x48(%ebp)
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		add    $0x10,%esp
		mov    %eax,0x44(%ebp)
		lea    0x0(,%eax,4),%eax
		push   %eax
		mov    %eax,0x4c(%ebp)
		call   MEM_alloc_lock
		add    $0x4,%esp
		mov    %eax,0x50(%ebp)
		test   %eax,%eax
		jne    jump_11352b
		mov    $0x8,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_1619d4,%esi
		mov    0x50(%esp),%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		mov    0x1c(%eax),%esi
		cmp    $0xffffffff,%esi
		je     jump_1134e0
		push   %esi
		call   AIL_restore_USE16_ISR
		add    $0x4,%esp
	jump_1134e0:
		push   $0x0
		push   $0x0
		push   $0x306
		mov    0x0(%ebp),%eax
		push   %eax
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		movl   $0x0,0x18(%eax)
		add    $0x10,%esp
		mov    0x24(%ebp),%edx
		push   %edx
		mov    0x20(%ebp),%ebx
		push   %ebx
		mov    0x28(%ebp),%ecx
		push   %ecx
		call   MEM_free_DOS
		add    $0xc,%esp
		push   $0x8c
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_11352b:
		mov    data_1ed81c,%eax
		mov    %eax,0x60(%ebp)
		imul   $0x894,%eax,%eax
		push   %eax
		call   MEM_alloc_lock
		add    $0x4,%esp
		mov    %eax,0x5c(%ebp)
		test   %eax,%eax
		jne    jump_1135d0
		mov    $0x9,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_1619f8,%esi
		mov    0x50(%esp),%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    0x1c(%eax),%ebx
		cmp    $0xffffffff,%ebx
		je     jump_113575
		push   %ebx
		call   AIL_restore_USE16_ISR
		add    $0x4,%esp
	jump_113575:
		push   $0x0
		push   $0x0
		push   $0x306
		mov    0x0(%ebp),%esi
		push   %esi
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		movl   $0x0,0x18(%eax)
		add    $0x10,%esp
		mov    0x24(%ebp),%edi
		push   %edi
		mov    0x20(%ebp),%eax
		push   %eax
		mov    0x28(%ebp),%edx
		push   %edx
		call   MEM_free_DOS
		add    $0xc,%esp
		mov    0x4c(%ebp),%ebx
		push   %ebx
		mov    0x50(%ebp),%ecx
		push   %ecx
		call   MEM_free_lock
		add    $0x8,%esp
		push   $0x8c
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1135d0:
		mov    0x60(%ebp),%edx
		xor    %ecx,%ecx
		test   %edx,%edx
		jle    jump_1135f9
		xor    %eax,%eax
	jump_1135db:
		mov    0x5c(%ebp),%ebx
		movl   $0x1,0x4(%ebx,%eax,1)
		mov    0x5c(%ebp),%ebx
		mov    %ebp,(%ebx,%eax,1)
		inc    %ecx
		mov    0x60(%ebp),%edx
		add    $0x894,%eax
		cmp    %edx,%ecx
		jl     jump_1135db
	jump_1135f9:
		push   $SS_serve
		call   AIL_register_timer
		add    $0x4,%esp
		mov    %eax,0xc(%ebp)
		cmp    $0xffffffff,%eax
		jne    jump_1136a9
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161a20,%esi
		mov    0x50(%esp),%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    0x1c(%eax),%edx
		cmp    $0xffffffff,%edx
		je     jump_11363a
		push   %edx
		call   AIL_restore_USE16_ISR
		add    $0x4,%esp
	jump_11363a:
		push   $0x0
		push   $0x0
		push   $0x306
		mov    0x0(%ebp),%ecx
		push   %ecx
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		movl   $0x0,0x18(%eax)
		add    $0x10,%esp
		mov    0x24(%ebp),%esi
		push   %esi
		mov    0x20(%ebp),%edi
		push   %edi
		mov    0x28(%ebp),%eax
		push   %eax
		call   MEM_free_DOS
		imul   $0x894,0x60(%ebp),%eax
		add    $0xc,%esp
		push   %eax
		mov    0x5c(%ebp),%ebx
		push   %ebx
		call   MEM_free_lock
		add    $0x8,%esp
		mov    0x4c(%ebp),%ecx
		push   %ecx
		mov    0x50(%ebp),%esi
		push   %esi
		call   MEM_free_lock
		add    $0x8,%esp
		push   $0x8c
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1136a9:
		push   %ebp
		push   %eax
		call   AIL_set_timer_user
		add    $0x8,%esp
		mov    data_1ed80c,%esi
		push   %esi
		mov    0xc(%ebp),%edi
		push   %edi
		call   AIL_set_timer_frequency
		add    $0x8,%esp
		mov    0xc(%ebp),%eax
		push   %eax
		call   AIL_start_timer
		mov    0x0(%ebp),%eax
		movl   $SS_destroy_DIG_driver,0x24(%eax)
		add    $0x4,%esp
		mov    0x0(%ebp),%eax
		mov    %ebp,0x28(%eax)
#if 0
		push   %ebp
		call   AILSSA_flush_buffer
		add    $0x4,%esp
		push   $0x0
		push   %ebp
		call   AILSSA_DMA_copy
		add    $0x8,%esp
		push   $0x1
		push   %ebp
		call   AILSSA_DMA_copy
		add    $0x8,%esp
#endif
		mov    %ebp,%eax
	jump_113703:
		add    $0x3c,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_install_DIG_driver_file:	/* 113710 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		sub    $0x90,%esp
		mov    0xa0(%esp),%edx
		push   %edx
		push   $EXPORT_SYMBOL(sound_driver_directory)
		push   $data_161a38
		lea    0xc(%esp),%eax
		push   %eax
		call   ac_sprintf
		add    $0x10,%esp
		push   $0x0
		lea    0x4(%esp),%eax
		push   %eax
		call   FILE_read
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %eax,%eax
		jne    jump_113763
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161a40,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		jmp    jump_1137b4
	jump_113763:
		mov    %esp,%eax
		push   %eax
		call   FILE_size
		add    $0x4,%esp
		push   %eax
		push   %ebx
		call   AIL_install_driver
		add    $0x8,%esp
		mov    %eax,%esi
		mov    %ebx,%eax
		call   *EXPORT_SYMBOL(data_159790)
		test   %esi,%esi
		jne    jump_113792
		xor    %eax,%eax
		add    $0x90,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_113792:
		mov    0xa4(%esp),%ebx
		push   %ebx
		push   %esi
		call   SS_construct_DIG_driver
		add    $0x8,%esp
		mov    %eax,%ebx
		test   %eax,%eax
		jne    jump_1137b2
		push   %esi
		call   AIL_uninstall_driver
		add    $0x4,%esp
	jump_1137b2:
		mov    %ebx,%eax
	jump_1137b4:
		add    $0x90,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_install_DIG_INI:	/* 113800 */
/*----------------------------------------------------------------*/
		push   %esi
		push   %edi
		sub    $0x118,%esp
		push   $EXPORT_SYMBOL(sound_dig_ini_filename)
		lea    0x4(%esp),%eax
		push   %eax
		call   AIL_read_INI
		add    $0x8,%esp
		test   %eax,%eax
		jne    jump_113837
		mov    $0x7,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161a58,%esi
		mov    $0x1,%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		jmp    jump_11386c
	jump_113837:
		lea    0x100(%esp),%eax
		push   %eax
		lea    0x84(%esp),%eax
		push   %eax
		call   AIL_install_DIG_driver_file
		add    $0x8,%esp
		mov    0x124(%esp),%edx
		mov    %eax,(%edx)
		test   %eax,%eax
		jne    jump_11386a
		mov    $0x2,%eax
		add    $0x118,%esp
		pop    %edi
		pop    %esi
		ret
	jump_11386a:
		xor    %eax,%eax
	jump_11386c:
		add    $0x118,%esp
		pop    %edi
		pop    %esi
		ret


/*----------------------------------------------------------------*/
AIL_API_uninstall_DIG_driver:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		mov    (%eax),%edx
		push   %edx
		call   AIL_uninstall_driver
		add    $0x4,%esp
		ret


/*----------------------------------------------------------------*/
AIL_API_allocate_sample_handle:	/* 1138c0 */
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%ebx
		call   AIL_lock
		mov    0x60(%ebx),%edx
		xor    %eax,%eax
		test   %edx,%edx
		jle    jump_1138ec
		mov    0x5c(%ebx),%edx
	jump_1138d8:
		cmpl   $0x1,0x4(%edx)
		je     jump_1138ec
		inc    %eax
		mov    0x60(%ebx),%ecx
		add    $0x894,%edx
		cmp    %ecx,%eax
		jl     jump_1138d8
	jump_1138ec:
		cmp    0x60(%ebx),%eax
		jne    jump_113910
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161a78,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		call   AIL_unlock
		xor    %eax,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_113910:
		imul   $0x894,%eax,%eax
		mov    0x5c(%ebx),%ebx
		add    %eax,%ebx
		push   %ebx
		call   AIL_init_sample
		add    $0x4,%esp
		call   AIL_unlock
		mov    %ebx,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret

/*----------------------------------------------------------------*/
AIL_API_release_sample_handle:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		test   %eax,%eax
		je     jump_11393f
		movl   $0x1,0x4(%eax)
	jump_11393f:
		ret


/*----------------------------------------------------------------*/
ailimpl_init_sample:	/* 113940 */
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		test   %eax,%eax
		je     jump_113a04
		movl   $0x2,0x4(%eax)
		movl   $0x0,0x8(%eax)
		movl   $0x0,0x10(%eax)
		movl   $0x0,0x18(%eax)
		movl   $0x0,0x20(%eax)
		movl   $0x0,0xc(%eax)
		movl   $0x0,0x14(%eax)
		movl   $0x0,0x1c(%eax)
		movl   $0x1,0x24(%eax)
		movl   $0x0,0x28(%eax)
		movl   $0xfffffffe,0x2c(%eax)
		movl   $0x1,0x30(%eax)
		movl   $0x0,0x34(%eax)
		mov    data_1ed820,%edx
		movl   $0x0,0x38(%eax)
		mov    %edx,0x40(%eax)
		mov    (%eax),%edx
		movl   $0x2b11,0x3c(%eax)
		mov    0x18(%edx),%ebx
		test   %ebx,%ebx
		je     jump_1139cd
		cmp    $0x1,%ebx
		jne    jump_1139d6
	jump_1139cd:
		movl   $0x0,0x44(%eax)
		jmp    jump_1139dd
	jump_1139d6:
		movl   $0x40,0x44(%eax)
	jump_1139dd:
		movl   $0x0,0x848(%eax)
		movl   $0x0,0x84c(%eax)
		push   %eax
		movl   $0x0,0x850(%eax)
		call   SS_build_amplitude_tables
		add    $0x4,%esp
	jump_113a04:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_sample_status:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		test   %eax,%eax
		jne    jump_113a19
		ret
	jump_113a19:
		mov    0x4(%eax),%eax
		ret


/*----------------------------------------------------------------*/
AIL_API_set_sample_address:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		test   %eax,%eax
		je     jump_113a44
		movl   $0x0,0xc(%eax)
		mov    0x8(%esp),%edx
		movl   $0x0,0x14(%eax)
		mov    %edx,0x8(%eax)
		mov    0xc(%esp),%edx
		mov    %edx,0x10(%eax)
	jump_113a44:
		ret


/*----------------------------------------------------------------*/
AIL_API_set_sample_type:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		mov    0xc(%esp),%edx
		test   %eax,%eax
		je     jump_113a7e
		cmp    0x34(%eax),%edx
		jne    jump_113a6b
		mov    0x10(%esp),%ebx
		cmp    0x38(%eax),%ebx
		je     jump_113a7e
	jump_113a6b:
		mov    %edx,0x34(%eax)
		mov    0x10(%esp),%edx
		push   %eax
		mov    %edx,0x38(%eax)
		call   SS_build_amplitude_tables
		add    $0x4,%esp
	jump_113a7e:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_sample_playback_rate:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		test   %eax,%eax
		je     jump_113a9f
		mov    0x8(%esp),%edx
		mov    %edx,0x3c(%eax)
	jump_113a9f:
		ret


/*----------------------------------------------------------------*/
AIL_API_set_sample_volume:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		mov    0x8(%esp),%edx
		test   %eax,%eax
		je     jump_113acd
		cmp    0x40(%eax),%edx
		je     jump_113acd
		push   %eax
		mov    %edx,0x40(%eax)
		call   SS_build_amplitude_tables
		add    $0x4,%esp
	jump_113acd:
		ret


/*----------------------------------------------------------------*/
AIL_API_set_sample_pan:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		mov    0x8(%esp),%edx
		test   %eax,%eax
		je     jump_113afd
		cmp    0x44(%eax),%edx
		je     jump_113afd
		push   %eax
		mov    %edx,0x44(%eax)
		call   SS_build_amplitude_tables
		add    $0x4,%esp
	jump_113afd:
		ret


/*----------------------------------------------------------------*/
ailimpl_set_sample_loop_count:	/* 113b60 */
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		test   %eax,%eax
		je     jump_113b6f
		mov    0x8(%esp),%edx
		mov    %edx,0x30(%eax)
	jump_113b6f:
		ret


/*----------------------------------------------------------------*/
ailimpl_start_sample:	/* 113b70 */
/*----------------------------------------------------------------*/
		push   %esi
		mov    0x8(%esp),%eax
		test   %eax,%eax
		je     jump_113bb0
		cmpl   $0x1,0x4(%eax)
		je     jump_113bb0
		mov    0x28(%eax),%edx	/* XXX: current_buffer */
		lea    0x0(,%edx,4),%edx
		add    %eax,%edx
		cmpl   $0x0,0x10(%edx)  /* len[buf] */
		je     jump_113bb0
		cmpl   $0x0,0x8(%edx)   /* start[buf] */
		je     jump_113bb0
		movl   $0x0,0x18(%edx)	/* pos[buf] */
		mov    (%eax),%esi	/* driver */
		push   %esi
		movl   $0x4,0x4(%eax)	/* status */
		call   SS_start_DIG_driver_playback
		add    $0x4,%esp
	jump_113bb0:
		pop    %esi
		ret


/*----------------------------------------------------------------*/
AIL_API_end_sample:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		mov    0xc(%esp),%ebx
		test   %ebx,%ebx
		je     jump_113c55
		mov    0x4(%ebx),%edx
		cmp    $0x1,%edx
		je     jump_113c55
		cmp    $0x2,%edx
		je     jump_113c55
		mov    0x84c(%ebx),%esi
		movl   $0x2,0x4(%ebx)
		test   %esi,%esi
		je     jump_113c42
		push   %ebx
		call   *0x84c(%ebx)
		add    $0x4,%esp
	jump_113c42:
		cmpl   $0x0,0x850(%ebx)
		je     jump_113c55
		push   %ebx
		call   *0x850(%ebx)
		add    $0x4,%esp
	jump_113c55:
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_register_EOS_callback:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		test   %eax,%eax
		je     jump_113cbb
		mov    0xc(%esp),%ebx
		mov    0x850(%eax),%edx
		mov    %ebx,0x850(%eax)
		mov    %edx,%eax
	jump_113cbb:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_set_sample_user_data:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%edx
		test   %edx,%edx
		je     jump_113cdf
		mov    0x8(%esp),%eax
		lea    0x0(,%eax,4),%eax
		add    %edx,%eax
		mov    0xc(%esp),%edx
		mov    %edx,0x854(%eax)
	jump_113cdf:
		ret


/*----------------------------------------------------------------*/
AIL_API_sample_user_data:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%edx
		test   %edx,%edx
		jne    jump_113ceb
		xor    %eax,%eax
		ret
	jump_113ceb:
		mov    0x8(%esp),%eax
		mov    0x854(%edx,%eax,4),%eax
		ret


/*----------------------------------------------------------------*/
AIL_API_set_digital_master_volume:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%edi
		mov    0x14(%esp),%eax
		mov    0x60(%edi),%edx
		xor    %ebx,%ebx
		mov    %eax,0x68(%edi)
		test   %edx,%edx
		jle    jump_113d3b
		xor    %esi,%esi
	jump_113d19:
		mov    0x5c(%edi),%eax
		add    %esi,%eax
		cmpl   $0x1,0x4(%eax)
		je     jump_113d2d
		push   %eax
		call   SS_build_amplitude_tables
		add    $0x4,%esp
	jump_113d2d:
		inc    %ebx
		mov    0x60(%edi),%ecx
		add    $0x894,%esi
		cmp    %ecx,%ebx
		jl     jump_113d19
	jump_113d3b:
		pop    %edi
		pop    %esi
		pop    %ebx
		ret

vtable_113d48:
		.long   func_113d7d
		.long   func_113d84
		.long   func_113d84
		.long   func_113d8b


/*----------------------------------------------------------------*/
ailimpl_minimum_sample_buffer_size:	/* 113d60 */
/*----------------------------------------------------------------*/
		mov    $2048,%eax /* XXX: sound */
		ret

		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ecx
		mov    0x18(%esp),%esi
		mov    0x1c(%esp),%eax
		cmp    $0x3,%eax
		ja     jump_113d90
		jmp    *%cs:vtable_113d48(,%eax,4)


/*----------------------------------------------------------------*/
func_113d7d:
/*----------------------------------------------------------------*/
		mov    $0x1,%edx
		jmp    jump_113d90


/*----------------------------------------------------------------*/
func_113d84:
/*----------------------------------------------------------------*/
		mov    $0x2,%edx
		jmp    jump_113d90


/*----------------------------------------------------------------*/
func_113d8b:
/*----------------------------------------------------------------*/
		mov    $0x4,%edx
	jump_113d90:
		mov    0x3c(%ecx),%ebx
		imul   0x40(%ecx),%ebx
		mov    0x10(%ecx),%ebp
		imul   %ebp,%edx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		imul   %esi,%eax
		mov    %eax,%edx
		mov    0x14(%ecx),%ebx
		sar    $0x1f,%edx
		idiv   %ebx
		mov    data_1ed824,%edx
		imul   %eax,%edx
		mov    %eax,%ebx
		mov    %edx,%eax
		sar    $0x1f,%edx
		shl    $0xf,%edx
		sbb    %edx,%eax
		sar    $0xf,%eax
		mov    0x14(%ecx),%edi
		add    %eax,%ebx
		cmp    %edi,%esi
		je     jump_113deb
		lea    0x0(,%esi,2),%eax
		cmp    %edi,%eax
		je     jump_113deb
		lea    0x0(,%esi,4),%esi
		cmp    %edi,%esi
		je     jump_113deb
		add    $0x4,%ebx
	jump_113deb:
		add    $0xff,%ebx
		xor    %bl,%bl
		mov    %ebx,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_load_sample_buffer:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%edx
		mov    0x14(%esp),%ecx
		test   %edx,%edx
		je     jump_113e52
		test   %ecx,%ecx
		sete   %al
		mov    %eax,%ebx
		mov    0xc(%esp),%eax
		and    $0xff,%ebx
		movl   $0x0,0x18(%edx,%eax,4)
		mov    %ebx,0x20(%edx,%eax,4)
		mov    %ecx,0x10(%edx,%eax,4)
		mov    0x10(%esp),%ebx
		mov    %ebx,0x8(%edx,%eax,4)
		test   %ecx,%ecx
		je     jump_113e52
		cmpl   $0x4,0x4(%edx)
		je     jump_113e52
		mov    (%edx),%ecx
		push   %ecx
		movl   $0x4,0x4(%edx)
		call   SS_start_DIG_driver_playback
		add    $0x4,%esp
	jump_113e52:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
ailimpl_sample_buffer_ready:	/* 113e60 */
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		test   %eax,%eax
		jne    jump_113e70
		mov    $0xffffffff,%eax
		pop    %ebx
		ret
	jump_113e70:
		mov    0x2c(%eax),%edx /* XXX: last_buffer */
		cmp    $0xfffffffe,%edx
		jb     jump_113ea0
		jbe    jump_113e81
		cmp    $0xffffffff,%edx
		je     jump_113e93
		jmp    jump_113ea0
	jump_113e81:
		movl   $0x0,0x24(%eax)
		movl   $0xffffffff,0x2c(%eax)
		xor    %eax,%eax
		pop    %ebx
		ret
	jump_113e93:
		mov    0x28(%eax),%edx
		mov    %edx,0x2c(%eax)
		mov    $0x1,%eax
		pop    %ebx
		ret
	jump_113ea0:
		mov    0x2c(%eax),%edx
		mov    0x28(%eax),%ebx
		cmp    %ebx,%edx
		jne    jump_113eb1
		mov    $0xffffffff,%eax
		pop    %ebx
		ret
	jump_113eb1:
		mov    %ebx,0x2c(%eax)
		mov    %ebx,%eax
		xor    $0x1,%al
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILSS_end_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15aad4
		je     jump_113f74
		push   $AILSS_end_
		push   $AILSS_start_
		call   VMM_unlock_range
		add    $0x8,%esp
		push   $0x80
		push   $data_15aa50
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_15aad0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8c4
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0xc
		push   $data_1ed8b4
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8cc
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8d0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8c0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8c8
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8b0
		xor    %ebx,%ebx
		call   AIL_vmm_unlock
		add    $0x8,%esp
		mov    %ebx,data_15aad4
	jump_113f74:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILSFILE_start_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15aad8
		jne    jump_113fa9
		push   $AILSFILE_end_
		push   $AILSFILE_start_
		mov    $0x1,%ebx
		call   VMM_lock_range
		add    $0x8,%esp
		mov    %ebx,data_15aad8
	jump_113fa9:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_VOC_block_len:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		mov    (%eax),%eax
		shr    $0x8,%eax
		ret


/*----------------------------------------------------------------*/
AIL_VOC_terminate:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ebx
		cmpl   $0x0,0x874(%ebx)
		je     jump_113fd8
		push   %ebx
		call   *0x874(%ebx)
		add    $0x4,%esp
	jump_113fd8:
		cmpl   $0x0,0x88c(%ebx)
		jle    jump_113fea
		push   %ebx
		call   AIL_release_sample_handle
		add    $0x4,%esp
	jump_113fea:
		movl   $0xffffffff,0x88c(%ebx)
		pop    %ebx
		ret

vtable_113ff8:
		.long   func_11404b
		.long   func_114059
		.long   func_114271
		.long   func_114271
		.long   func_1140c2
		.long   func_114271
		.long   func_1140f7
		.long   func_11410e
		.long   func_114138
		.long   func_1141d6


/*----------------------------------------------------------------*/
AIL_process_VOC_block:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    0x18(%esp),%ebp
		xor    %edi,%edi
	jump_11402e:
		mov    0x878(%ebx),%esi
		mov    (%esi),%al
		cmp    $0x9,%al
		ja     func_114271
		and    $0xff,%eax
		jmp    *%cs:vtable_113ff8(,%eax,4)


/*----------------------------------------------------------------*/
func_11404b:
/*----------------------------------------------------------------*/
		push   %ebx
		call   AIL_VOC_terminate
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114059:
/*----------------------------------------------------------------*/
		cmpl   $0x0,0x888(%ebx)
		je     func_114271
		push   %esi
		call   AIL_VOC_block_len
		add    $0x4,%esp
		sub    $0x2,%eax
		push   %eax
		lea    0x6(%esi),%eax
		push   %eax
		push   %ebx
		call   AIL_set_sample_address
		xor    %eax,%eax
		mov    $0x100,%edi
		mov    0x4(%esi),%al
		xor    %edx,%edx
		sub    %eax,%edi
		mov    $0xf4240,%eax
		div    %edi
		add    $0xc,%esp
		push   %eax
		push   %ebx
		call   AIL_set_sample_playback_rate
		add    $0x8,%esp
		push   $0x0
		push   $0x0
		push   %ebx
		call   AIL_set_sample_type
		add    $0xc,%esp
		test   %ebp,%ebp
		je     jump_11426c
		push   %ebx
		call   AIL_start_sample
		add    $0x4,%esp
		jmp    jump_11426c


/*----------------------------------------------------------------*/
func_1140c2:
/*----------------------------------------------------------------*/
		mov    0x884(%ebx),%ecx
		cmp    $0xffffffff,%ecx
		je     func_114271
		movswl 0x4(%esi),%eax
		cmp    %ecx,%eax
		jne    jump_1140e8
		movl   $0x1,0x888(%ebx)
		jmp    func_114271
	jump_1140e8:
		movl   $0x0,0x888(%ebx)
		jmp    func_114271


/*----------------------------------------------------------------*/
func_1140f7:
/*----------------------------------------------------------------*/
		xor    %eax,%eax
		mov    %esi,0x87c(%ebx)
		mov    0x4(%esi),%ax
		mov    %eax,0x880(%ebx)
		jmp    func_114271


/*----------------------------------------------------------------*/
func_11410e:
/*----------------------------------------------------------------*/
		mov    0x880(%ebx),%edx
		cmp    $0xffff,%edx
		je     jump_11412d
		mov    %edx,%eax
		dec    %edx
		mov    %edx,0x880(%ebx)
		test   %eax,%eax
		je     func_114271
	jump_11412d:
		mov    0x87c(%ebx),%esi
		jmp    func_114271


/*----------------------------------------------------------------*/
func_114138:
/*----------------------------------------------------------------*/
		cmpl   $0x0,0x888(%ebx)
		je     func_114271
		cmpb   $0x0,0x7(%esi)
		je     jump_11416b
		push   $0x0
		push   $0x2
		push   %ebx
		call   AIL_set_sample_type
		xor    %eax,%eax
		mov    $0x10000,%edi
		mov    0x4(%esi),%ax
		xor    %edx,%edx
		sub    %eax,%edi
		mov    $0x7a12000,%eax
		jmp    jump_114189
	jump_11416b:
		push   $0x0
		push   $0x0
		push   %ebx
		call   AIL_set_sample_type
		xor    %eax,%eax
		mov    $0x10000,%edi
		mov    0x4(%esi),%ax
		xor    %edx,%edx
		sub    %eax,%edi
		mov    $0xf424000,%eax
	jump_114189:
		div    %edi
		add    $0xc,%esp
		push   %eax
		push   %ebx
		call   AIL_set_sample_playback_rate
		add    $0x8,%esp
		push   %esi
		call   AIL_VOC_block_len
		add    %eax,%esi
		add    $0x4,%esp
		add    $0x4,%esi
		push   %esi
		call   AIL_VOC_block_len
		add    $0x4,%esp
		sub    $0x2,%eax
		push   %eax
		lea    0x6(%esi),%eax
		push   %eax
		push   %ebx
		call   AIL_set_sample_address
		add    $0xc,%esp
		test   %ebp,%ebp
		je     jump_11426c
		push   %ebx
		call   AIL_start_sample
		add    $0x4,%esp
		jmp    jump_11426c


/*----------------------------------------------------------------*/
func_1141d6:
/*----------------------------------------------------------------*/
		cmpl   $0x0,0x888(%ebx)
		je     func_114271
		push   %esi
		call   AIL_VOC_block_len
		add    $0x4,%esp
		sub    $0xc,%eax
		push   %eax
		lea    0x10(%esi),%eax
		push   %eax
		push   %ebx
		call   AIL_set_sample_address
		add    $0xc,%esp
		mov    0x4(%esi),%ecx
		push   %ecx
		push   %ebx
		call   AIL_set_sample_playback_rate
		mov    0x9(%esi),%ah
		add    $0x8,%esp
		cmp    $0x1,%ah
		jne    jump_11421f
		cmpw   $0x0,0xa(%esi)
		jne    jump_11421f
		push   $0x0
		push   $0x0
		jmp    jump_114256
	jump_11421f:
		cmpb   $0x2,0x9(%esi)
		jne    jump_114232
		cmpw   $0x0,0xa(%esi)
		jne    jump_114232
		push   $0x0
		push   $0x2
		jmp    jump_114256
	jump_114232:
		cmpb   $0x1,0x9(%esi)
		jne    jump_114245
		cmpw   $0x4,0xa(%esi)
		jne    jump_114245
		push   $0x1
		push   $0x1
		jmp    jump_114256
	jump_114245:
		cmpb   $0x2,0x9(%esi)
		jne    jump_11425f
		cmpw   $0x4,0xa(%esi)
		jne    jump_11425f
		push   $0x1
		push   $0x3
	jump_114256:
		push   %ebx
		call   AIL_set_sample_type
		add    $0xc,%esp
	jump_11425f:
		test   %ebp,%ebp
		je     jump_11426c
		push   %ebx
		call   AIL_start_sample
		add    $0x4,%esp
	jump_11426c:
		mov    $0x1,%edi


/*----------------------------------------------------------------*/
func_114271:
/*----------------------------------------------------------------*/
		push   %esi
		call   AIL_VOC_block_len
		add    %esi,%eax
		add    $0x4,%eax
		add    $0x4,%esp
		mov    %eax,0x878(%ebx)
		test   %edi,%edi
		je     jump_11402e
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_VOC_EOS:
/*----------------------------------------------------------------*/
		push   $0x1
		mov    0x8(%esp),%edx
		push   %edx
		call   AIL_process_VOC_block
		add    $0x8,%esp
		ret


/*----------------------------------------------------------------*/
AIL_process_WAV_image:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x14(%esp),%edi
		mov    0x10(%esp),%esi
		mov    $data_161a90,%ecx
		add    $0xc,%esi
	jump_1142c3:
		mov    $0x4,%ebx
		mov    %ecx,%edx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		je     jump_1142e7
		mov    0x4(%esi),%eax
		add    %esi,%eax
		mov    0x4(%esi),%esi
		add    $0x8,%eax
		and    $0x1,%esi
		add    %eax,%esi
		jmp    jump_1142c3
	jump_1142e7:
		cmpw   $0x1,0xa(%esi)
		jne    jump_1142f9
		cmpw   $0x8,0x16(%esi)
		jne    jump_1142f9
		push   %eax
		push   %eax
		jmp    jump_114333
	jump_1142f9:
		cmpw   $0x2,0xa(%esi)
		jne    jump_11430d
		cmpw   $0x8,0x16(%esi)
		jne    jump_11430d
		push   $0x0
		push   $0x2
		jmp    jump_114333
	jump_11430d:
		cmpw   $0x1,0xa(%esi)
		jne    jump_114321
		cmpw   $0x10,0x16(%esi)
		jne    jump_114321
		push   $0x1
		push   $0x1
		jmp    jump_114333
	jump_114321:
		cmpw   $0x2,0xa(%esi)
		jne    jump_11433c
		cmpw   $0x10,0x16(%esi)
		jne    jump_11433c
		push   $0x1
		push   $0x3
	jump_114333:
		push   %edi
		call   AIL_set_sample_type
		add    $0xc,%esp
	jump_11433c:
		mov    0xc(%esi),%edx
		push   %edx
		push   %edi
		call   AIL_set_sample_playback_rate
		add    $0x8,%esp
		mov    0x10(%esp),%esi
		add    $0xc,%esi
		mov    $0x4,%ecx
	jump_114355:
		mov    $data_161a98,%edx
		mov    %ecx,%ebx
		mov    %esi,%eax
		call   ac_strnicmp
		test   %eax,%eax
		je     jump_114379
		mov    0x4(%esi),%eax
		mov    0x4(%esi),%edx
		add    %esi,%eax
		and    $0x1,%edx
		lea    0x8(%eax),%esi
		add    %edx,%esi
		jmp    jump_114355
	jump_114379:
		mov    0x4(%esi),%ebx
		push   %ebx
		add    $0x8,%esi
		push   %esi
		push   %edi
		call   AIL_set_sample_address
		add    $0xc,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_WAV_EOS:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ebx
		cmpl   $0x0,0x874(%ebx)
		je     jump_1143a8
		push   %ebx
		call   *0x874(%ebx)
		add    $0x4,%esp
	jump_1143a8:
		cmpl   $0x0,0x88c(%ebx)
		jle    jump_1143ba
		push   %ebx
		call   AIL_release_sample_handle
		add    $0x4,%esp
	jump_1143ba:
		movl   $0xffffffff,0x88c(%ebx)
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AIL_API_allocate_file_sample:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%esi
		mov    0x14(%esp),%ecx
		mov    $0x8,%ebx
		mov    $data_161aa0,%edx
		mov    %ecx,%eax
		call   ac_strnicmp
		test   %eax,%eax
		je     jump_114554
		mov    $0x4,%ebx
		mov    $data_161aac,%edx
		lea    0x8(%ecx),%eax
		call   ac_strnicmp
		test   %eax,%eax
		je     jump_11454f
		mov    $0x9,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161afc,%esi
		xor    %eax,%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_11454f:
		mov    $0x1,%eax
	jump_114554:
		test   %eax,%eax
		jbe    jump_11455f
		cmp    $0x1,%eax
		je     jump_11459c
		jmp    jump_1145b0
	jump_11455f:
		xor    %eax,%eax
		mov    0x14(%ecx),%ax
		add    %eax,%ecx
		mov    0x18(%esp),%eax
		mov    %ecx,0x878(%esi)
		mov    %eax,0x884(%esi)
		cmp    $0xffffffff,%eax
		sete   %al
		push   $0x0
		and    $0xff,%eax
		movl   $0x0,0x88c(%esi)
		push   %esi
		mov    %eax,0x888(%esi)
		call   AIL_process_VOC_block
		jmp    jump_1145ad
	jump_11459c:
		push   %esi
		push   %ecx
		movl   $0x0,0x88c(%esi)
		call   AIL_process_WAV_image
	jump_1145ad:
		add    $0x8,%esp
	jump_1145b0:
		cmpl   $0xffffffff,0x88c(%esi)
		jne    jump_1145d3
		mov    $0x7,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161b24,%esi
		xor    %eax,%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1145d3:
		mov    $0x1,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILSFILE_end_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15aad8
		je     jump_114626
		push   $AILSFILE_end_
		push   $AILSFILE_start_
		xor    %ebx,%ebx
		call   VMM_unlock_range
		add    $0x8,%esp
		mov    %ebx,data_15aad8
	jump_114626:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILXMIDI_start_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15ab60
		jne    jump_114741
		push   $AILXMIDI_end_
		push   $AILXMIDI_start_
		call   VMM_lock_range
		add    $0x8,%esp
		push   $0x80
		push   $data_15aadc
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_15ab5c
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8f8
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8fc
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed900
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed904
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed910
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed908
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed90c
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8f4
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8e8
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8f0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8ec
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8e0
		call   AIL_vmm_lock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8e4
		mov    $0x1,%ebx
		call   AIL_vmm_lock
		add    $0x8,%esp
		mov    %ebx,data_15ab60
	jump_114741:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114750:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		and    $0xf0,%eax
		cmp    $0xb0,%eax
		jb     jump_11477f
		jbe    jump_114799
		cmp    $0xd0,%eax
		jb     jump_114775
		jbe    jump_11479f
		cmp    $0xe0,%eax
		je     jump_114799
		xor    %eax,%eax
		ret
	jump_114775:
		cmp    $0xc0,%eax
		je     jump_11479f
		xor    %eax,%eax
		ret
	jump_11477f:
		cmp    $0x90,%eax
		jb     jump_114792
		jbe    jump_114799
		cmp    $0xa0,%eax
		je     jump_114799
		xor    %eax,%eax
		ret
	jump_114792:
		cmp    $0x80,%eax
		jne    jump_1147a5
	jump_114799:
		mov    $0x3,%eax
		ret
	jump_11479f:
		mov    $0x2,%eax
		ret
	jump_1147a5:
		xor    %eax,%eax
		ret


/*----------------------------------------------------------------*/
func_1147b0:
/*----------------------------------------------------------------*/
		push   %ebx
		sub    $0xc,%esp
		mov    0x14(%esp),%ebx
		cmpl   $0x0,0x1a8(%ebx)
		jle    jump_1147f8
		mov    0x1a8(%ebx),%ax
		push   $0x0
		mov    %ax,0x8(%esp)
		lea    0x4(%esp),%eax
		push   %eax
		push   $0x502
		mov    (%ebx),%ecx
		push   %ecx
		call   AIL_call_driver
		movl   $0x0,0x1a8(%ebx)
		add    $0x10,%esp
		movl   $0x0,0x1ac(%ebx)
	jump_1147f8:
		add    $0xc,%esp
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114800:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%ebx
		mov    0x14(%esp),%edx
		push   %edx
		call   func_114750
		mov    0x1ac(%ebx),%ecx
		mov    %eax,%esi
		add    %ecx,%eax
		add    $0x4,%esp
		cmp    $0x200,%eax
		jbe    jump_11482e
		push   %ebx
		call   func_1147b0
		add    $0x4,%esp
	jump_11482e:
		mov    0x1ac(%ebx),%eax
		mov    0x8(%ebx),%edx
		lea    0x1(%eax),%edi
		mov    0x14(%esp),%cl
		mov    %edi,0x1ac(%ebx)
		mov    %cl,0x100(%edx,%eax,1)
		mov    0x1ac(%ebx),%eax
		mov    0x8(%ebx),%ecx
		lea    0x1(%eax),%edi
		mov    0x18(%esp),%dl
		mov    %edi,0x1ac(%ebx)
		mov    %dl,0x100(%ecx,%eax,1)
		cmp    $0x3,%esi
		jne    jump_11488a
		mov    0x1ac(%ebx),%eax
		mov    0x8(%ebx),%edx
		lea    0x1(%eax),%esi
		mov    0x1c(%esp),%cl
		mov    %esi,0x1ac(%ebx)
		mov    %cl,0x100(%edx,%eax,1)
	jump_11488a:
		incl   0x1a8(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1148a0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		mov    0xc(%esp),%esi
		mov    0x14(%esp),%ebx
		push   %esi
		call   func_1147b0
		add    $0x4,%esp
		cmp    $0x200,%ebx
		jbe    jump_1148c0
		mov    $0x200,%ebx
	jump_1148c0:
		mov    0x8(%esi),%eax
		mov    0x10(%esp),%edx
		add    $0x100,%eax
		call   ac_memmove
		mov    0x1a8(%esi),%edx
		inc    %edx
		push   %esi
		mov    %edx,0x1a8(%esi)
		call   func_1147b0
		add    $0x4,%esp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1148f0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%edi
		mov    $0x4,%eax
		xor    %ecx,%ecx
	jump_1148fe:
		mov    (%edi),%edx
		xor    %ebx,%ebx
		mov    (%edx),%bl
		shl    $0x7,%ecx
		mov    %ebx,%esi
		inc    %edx
		and    $0x7f,%esi
		mov    %edx,(%edi)
		or     %esi,%ecx
		test   $0x80,%bl
		je     jump_114919
		dec    %eax
		jne    jump_1148fe
	jump_114919:
		mov    %ecx,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114920:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		mov    %eax,%ebx
		mov    %eax,%edx
		and    $0xff,%ebx
		and    $0xff00,%edx
		shl    $0x18,%ebx
		shl    $0x8,%edx
		add    %ebx,%edx
		mov    %eax,%ebx
		and    $0xff0000,%ebx
		and    $0xff000000,%eax
		shr    $0x8,%ebx
		shr    $0x18,%eax
		add    %ebx,%edx
		add    %edx,%eax
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114960:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%esi
		mov    0x18(%esp),%edi
		xor    %ecx,%ecx
		mov    $0x4,%ebp
	jump_114973:
		mov    $data_161b44,%edx
		add    %ecx,%esi
		mov    %ebp,%ebx
		mov    %esi,%eax
		call   ac_strncmp
		test   %eax,%eax
		je     jump_11499d
		mov    $data_161b4c,%edx
		mov    %ebp,%ebx
		mov    %esi,%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_114a21
	jump_11499d:
		mov    0x4(%esi),%edx
		push   %edx
		mov    %ebp,%ebx
		call   func_114920
		add    $0x4,%esp
		lea    0x8(%eax),%ecx
		mov    $data_161b54,%edx
		lea    0x8(%esi),%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_114973
		mov    $0x4,%ebx
		mov    $data_161b44,%edx
		mov    %esi,%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_1149df
		test   %edi,%edi
		jne    jump_114a23
		mov    %esi,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1149df:
		lea    (%esi,%ecx,1),%ebp
		add    $0xc,%esi
		cmp    %ebp,%esi
		jae    jump_114a21
	jump_1149e9:
		mov    $0x4,%ebx
		mov    $data_161b54,%edx
		lea    0x8(%esi),%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_114a0c
		dec    %edi
		cmp    $0xffffffff,%edi
		jne    jump_114a0c
		mov    %esi,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114a0c:
		mov    0x4(%esi),%ebx
		push   %ebx
		call   func_114920
		add    $0x8,%eax
		add    %eax,%esi
		add    $0x4,%esp
		cmp    %ebp,%esi
		jb     jump_1149e9
	jump_114a21:
		xor    %eax,%eax
	jump_114a23:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114bf0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%esi
		mov    0x14(%esp),%ecx
		mov    0x18(%esp),%eax
		mov    0x1c(%esp),%edx
		mov    %ecx,%edi
		and    $0xf,%ecx
		lea    0x0(,%ecx,4),%ebx
		and    $0xf0,%edi
		add    %esi,%ebx
		cmp    $0xc0,%edi
		jb     jump_114c2d
		jbe    jump_114c39
		cmp    $0xe0,%edi
		je     jump_114c44
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114c2d:
		cmp    $0xb0,%edi
		je     jump_114c5a
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114c39:
		and    $0xff,%eax
		mov    %eax,(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114c44:
		and    $0xff,%eax
		mov    %eax,0x40(%ebx)
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x80(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114c5a:
		cmp    $0x5d,%eax
		jb     jump_114cab
		jbe    jump_114db7
		cmp    $0x70,%eax
		jb     jump_114c95
		jbe    jump_114d26
		cmp    $0x73,%eax
		jb     jump_114c88
		jbe    jump_114d42
		cmp    $0x77,%eax
		je     jump_114d50
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114c88:
		cmp    $0x72,%eax
		je     jump_114d34
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114c95:
		cmp    $0x6e,%eax
		jb     jump_114c9e
		jbe    jump_114cfc
		jmp    jump_114d0a
	jump_114c9e:
		cmp    $0x6b,%eax
		je     jump_114d18
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114cab:
		cmp    $0xa,%eax
		jb     jump_114cdb
		jbe    jump_114d7c
		cmp    $0x40,%eax
		jb     jump_114cce
		jbe    jump_114d9a
		cmp    $0x5b,%eax
		je     jump_114da9
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114cce:
		cmp    $0xb,%eax
		je     jump_114d8b
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114cdb:
		cmp    $0x6,%eax
		jb     jump_114cf3
		jbe    jump_114dc5
		cmp    $0x7,%eax
		je     jump_114d6d
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114cf3:
		cmp    $0x1,%eax
		je     jump_114d5e
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114cfc:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0xc0(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d0a:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x100(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d18:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x140(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d26:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x180(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d34:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x1c0(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d42:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x200(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d50:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x240(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d5e:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x280(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d6d:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x2c0(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d7c:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x300(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d8b:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x340(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114d9a:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x380(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114da9:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x3c0(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114db7:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x400(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_114dc5:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x440(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_114de0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x10,%esp
		mov    0x24(%esp),%ebx
		mov    0x28(%esp),%eax
		mov    0x2c(%esp),%edi
		mov    0x30(%esp),%esi
		mov    %eax,%edx
		mov    (%ebx),%ebp
		and    $0xf,%eax
		and    $0xf0,%edx
		mov    %eax,0xc(%esp)
		mov    0x94(%ebx,%eax,4),%eax
		mov    %edx,0x8(%esp)
		mov    %eax,0x4(%esp)
		cmp    $0xb0,%edx
		je     jump_114e2f
		cmp    $0xc0,%edx
		je     jump_114e2f
		cmp    $0xe0,%edx
		jne    jump_114e4b
	jump_114e2f:
		push   %esi
		mov    0xc(%esp),%eax
		mov    0x10(%esp),%edx
		push   %edi
		or     %edx,%eax
		push   %eax
		lea    0xd4(%ebx),%eax
		push   %eax
		call   func_114bf0
		add    $0x10,%esp
	jump_114e4b:
		cmpl   $0xb0,0x8(%esp)
		jne    jump_114f8a
		cmpl   $0x0,0x34(%esp)
		je     jump_114e84
		mov    0xc(%esp),%eax
		lea    0x0(,%eax,4),%eax
		add    %ebx,%eax
		mov    0x2d4(%eax),%edx
		cmp    $0xffffffff,%edx
		je     jump_114e84
		mov    %edx,%esi
		movl   $0xffffffff,0x2d4(%eax)
	jump_114e84:
		mov    0xc(%esp),%edx
		mov    0x4(%esp),%eax
		lea    0x0(,%edx,4),%edx
		lea    0x0(,%eax,4),%eax
		lea    (%ebx,%edx,1),%ecx
		add    %ebp,%eax
		mov    %ecx,(%esp)
		cmp    $0x6f,%edi
		jb     jump_114edf
		jbe    jump_115119
		cmp    $0x75,%edi
		jb     jump_114ecf
		jbe    jump_11508e
		cmp    $0x76,%edi
		jbe    jump_114ffb
		cmp    $0x77,%edi
		je     jump_11503a
		jmp    jump_114f8a
	jump_114ecf:
		cmp    $0x73,%edi
		jb     jump_114f8a
		jbe    jump_114f0d
		jmp    jump_115059
	jump_114edf:
		cmp    $0x6c,%edi
		jb     jump_114ef4
		jbe    jump_114f23
		cmp    $0x6d,%edi
		jbe    jump_115107
		jmp    jump_115146
	jump_114ef4:
		cmp    $0x6,%edi
		jb     jump_114f8a
		jbe    jump_114f48
		cmp    $0x7,%edi
		je     jump_114fce
		jmp    jump_114f8a
	jump_114f0d:
		mov    0x18(%ebx),%eax
		mov    (%esi,%eax,1),%al
		and    $0xff,%eax
		mov    %eax,0x2d4(%ecx)
		jmp    jump_114f8a
	jump_114f23:
		cmpl   $0x0,0x1c(%ebx)
		je     jump_114f8a
		push   %esi
		mov    0x10(%esp),%eax
		push   %eax
		push   %ebx
		call   *0x1c(%ebx)
		add    $0xc,%esp
		mov    (%esp),%edx
		mov    %eax,0x2d4(%edx)
		jmp    jump_114f8a
	jump_114f48:
		push   $0x0
		push   $0x0
		mov    0x14(%esp),%eax
		push   $0x64
		or     $0xb0,%al
		push   %eax
		push   %ebx
		call   func_114de0
		add    $0x14,%esp
		push   $0x0
		push   $0x0
		mov    0x14(%esp),%eax
		push   $0x65
		or     $0xb0,%al
		push   %eax
		push   %ebx
		call   func_114de0
		add    $0x14,%esp
		push   $0x0
		push   $0x0
		mov    0x14(%esp),%eax
		push   $0x26
		or     $0xb0,%al
		push   %eax
		push   %ebx
		call   func_114de0
		add    $0x14,%esp
	jump_114f8a:
		mov    0x4(%esp),%eax
		lea    0x0(,%eax,4),%eax
		add    %ebp,%eax
		cmpl   $0x1,0x20(%eax)
		jne    jump_114fa6
		cmp    0x60(%eax),%ebx
		jne    jump_11522a
	jump_114fa6:
		mov    0x4(%esp),%eax
		lea    0x0(,%eax,4),%eax
		mov    0x8(%esp),%edx
		add    %ebp,%eax
		cmp    $0x90,%edx
		jne    jump_1151be
		incl   0x160(%eax)
		jmp    jump_1151cc
	jump_114fce:
		mov    0x38(%ebx),%edx
		imul   %esi,%edx
		imul   0x1b0(%ebp),%edx
		mov    $0x3f01,%esi
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %esi
		mov    %eax,%esi
		cmp    $0x7f,%eax
		jle    jump_114ff3
		mov    $0x7f,%esi
	jump_114ff3:
		test   %esi,%esi
		jge    jump_114f8a
		xor    %esi,%esi
		jmp    jump_114f8a
	jump_114ffb:
		movl   $0x0,0x5c(%ebx)
		movl   $0x0,0x6c(%ebx)
		mov    0x68(%ebx),%eax
		mov    0x6c(%ebx),%edi
		movl   $0x0,0x60(%ebx)
		sub    %eax,%edi
		mov    0x24(%ebx),%eax
		mov    %edi,0x6c(%ebx)
		test   %eax,%eax
		je     jump_11522a
		push   $0x0
		push   $0x0
		push   %ebx
		push   %ebp
		call   *0x24(%ebx)
		add    $0x10,%esp
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_11503a:
		cmpl   $0x0,0x20(%ebx)
		je     jump_11522a
		push   %esi
		mov    0x10(%esp),%esi
		push   %esi
		push   %ebx
		call   *0x20(%ebx)
		add    $0xc,%esp
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115059:
		mov    %ebx,%edx
		xor    %eax,%eax
	jump_11505d:
		cmpl   $0xffffffff,0x84(%edx)
		je     jump_11506f
		inc    %eax
		add    $0x4,%edx
		cmp    $0x4,%eax
		jl     jump_11505d
	jump_11506f:
		cmp    $0x4,%eax
		je     jump_11522a
		mov    %esi,0x84(%ebx,%eax,4)
		mov    0x14(%ebx),%edx
		mov    %edx,0x74(%ebx,%eax,4)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_11508e:
		cmp    $0x40,%esi
		jl     jump_11522a
		mov    $0x3,%eax
		lea    0xc(%ebx),%edx
	jump_11509f:
		cmpl   $0xffffffff,0x84(%edx)
		jne    jump_1150b0
		dec    %eax
		sub    $0x4,%edx
		test   %eax,%eax
		jge    jump_11509f
	jump_1150b0:
		cmp    $0xffffffff,%eax
		je     jump_11522a
		lea    0x0(,%eax,4),%eax
		add    %ebx,%eax
		mov    0x84(%eax),%esi
		test   %esi,%esi
		jne    jump_1150da
		mov    0x74(%eax),%eax
		mov    %eax,0x14(%ebx)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1150da:
		lea    -0x1(%esi),%edi
		mov    %edi,0x84(%eax)
		test   %edi,%edi
		je     jump_1150f5
		mov    0x74(%eax),%eax
		mov    %eax,0x14(%ebx)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1150f5:
		movl   $0xffffffff,0x84(%eax)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115107:
		push   %esi
		push   %ebx
		call   AIL_branch_index
		add    $0x8,%esp
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115119:
		cmpl   $0x1,0x20(%eax)
		je     jump_11522a
		cmp    $0x40,%esi
		jge    jump_115137
		movl   $0x0,0x20(%eax)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115137:
		movl   $0x2,0x20(%eax)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115146:
		mov    0xc(%esp),%edi
		inc    %edi
		cmp    $0x40,%esi
		jl     jump_115184
		cmpl   $0x1,0x20(%eax)
		je     jump_11522a
		push   %ebp
		call   AIL_lock_channel
		mov    %eax,%esi
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_11522a
		push   %eax
		push   %edi
		push   %ebx
		call   AIL_map_sequence_channel
		add    $0xc,%esp
		mov    %ebx,0x5c(%ebp,%esi,4)
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115184:
		cmpl   $0x1,0x20(%eax)
		jne    jump_11522a
		mov    0xc(%esp),%esi
		push   %esi
		push   %ebx
		call   func_1152d0
		add    $0x8,%esp
		mov    0x4(%esp),%eax
		inc    %eax
		push   %eax
		push   %ebp
		call   AIL_release_channel
		add    $0x8,%esp
		push   %edi
		push   %edi
		push   %ebx
		call   AIL_map_sequence_channel
		add    $0xc,%esp
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1151be:
		cmp    $0x80,%edx
		jne    jump_1151cc
		decl   0x160(%eax)
	jump_1151cc:
		mov    0x4(%esp),%eax
		mov    %ebx,0xe0(%ebp,%eax,4)
		cmpl   $0x90,0x8(%esp)
		jne    jump_1151ef
		mov    0xc(%esp),%eax
		cmpl   $0x40,0x214(%ebx,%eax,4)
		jge    jump_11522a
	jump_1151ef:
		cmpl   $0x0,0x1a0(%ebp)
		je     jump_115214
		push   %esi
		mov    0xc(%esp),%eax
		mov    0x8(%esp),%edx
		push   %edi
		or     %edx,%eax
		push   %eax
		push   %ebx
		push   %ebp
		call   *0x1a0(%ebp)
		add    $0x14,%esp
		test   %eax,%eax
		jne    jump_11522a
	jump_115214:
		push   %esi
		mov    0xc(%esp),%eax
		mov    0x8(%esp),%ebx
		push   %edi
		or     %ebx,%eax
		push   %eax
		push   %ebp
		call   func_114800
		add    $0x10,%esp
	jump_11522a:
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115240:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%edi
		mov    %edi,%ebx
		xor    %esi,%esi
		lea    0x80(%edi),%ebp
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		mov    %eax,%eax
	jump_115260:
		mov    0x558(%ebx),%ecx
		cmp    $0xffffffff,%ecx
		je     jump_115290
		push   $0x0
		push   $0x0
		mov    0x5d8(%ebx),%eax
		push   %eax
		mov    %ecx,%eax
		or     $0x80,%al
		push   %eax
		push   %edi
		inc    %esi
		call   func_114de0
		add    $0x14,%esp
		movl   $0xffffffff,0x558(%ebx)
		nop
	jump_115290:
		add    $0x4,%ebx
		cmp    %ebp,%ebx
		jne    jump_115260
		mov    (%edi),%edx
		push   %edx
		movl   $0x0,0x554(%edi)
		call   func_1147b0
		add    $0x4,%esp
		test   %esi,%esi
		je     jump_1152c3
		call   AIL_background
		test   %eax,%eax
		jne    jump_1152c3
		push   $0x3
		call   AIL_delay
		add    $0x4,%esp
	jump_1152c3:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1152d0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%esi
		mov    0x18(%esp),%ebp
		mov    %esi,%ebx
		lea    0x80(%esi),%edi
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_1152f0:
		mov    0x558(%ebx),%edx
		cmp    %edx,%ebp
		jne    jump_115320
		push   $0x0
		push   $0x0
		mov    0x5d8(%ebx),%ecx
		mov    %edx,%eax
		push   %ecx
		or     $0x80,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
		movl   $0xffffffff,0x558(%ebx)
		lea    0x0(%eax),%eax
	jump_115320:
		add    $0x4,%ebx
		cmp    %edi,%ebx
		jne    jump_1152f0
		mov    (%esi),%edi
		push   %edi
		call   func_1147b0
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115340:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%esi
		mov    0x18(%esp),%ebx
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x294(%eax),%edx
		cmp    $0xffffffff,%edx
		je     jump_115373
		push   $0x0
		push   %edx
		mov    %ebx,%eax
		push   $0x72
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_115373:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0xd4(%eax),%edi
		cmp    $0xffffffff,%edi
		je     jump_11539a
		push   $0x0
		push   $0x0
		mov    %ebx,%eax
		push   %edi
		or     $0xc0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_11539a:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x154(%eax),%edx
		cmp    $0xffffffff,%edx
		je     jump_1153c6
		push   $0x0
		push   %edx
		mov    0x114(%eax),%edi
		mov    %ebx,%eax
		push   %edi
		or     $0xe0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_1153c6:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x214(%eax),%ebp
		cmp    $0xffffffff,%ebp
		je     jump_1153ed
		push   $0x0
		push   %ebp
		mov    %ebx,%eax
		push   $0x6b
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_1153ed:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x1d4(%eax),%ecx
		cmp    $0xffffffff,%ecx
		je     jump_115414
		push   $0x0
		push   %ecx
		mov    %ebx,%eax
		push   $0x6f
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_115414:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x254(%eax),%ebp
		cmp    $0xffffffff,%ebp
		je     jump_11543b
		push   $0x0
		push   %ebp
		mov    %ebx,%eax
		push   $0x70
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_11543b:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x354(%eax),%ecx
		cmp    $0xffffffff,%ecx
		je     jump_115462
		push   $0x0
		push   %ecx
		mov    %ebx,%eax
		push   $0x1
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_115462:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x394(%eax),%ebp
		cmp    $0xffffffff,%ebp
		je     jump_115489
		push   $0x0
		push   %ebp
		mov    %ebx,%eax
		push   $0x7
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_115489:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x3d4(%eax),%ecx
		cmp    $0xffffffff,%ecx
		je     jump_1154b0
		push   $0x0
		push   %ecx
		mov    %ebx,%eax
		push   $0xa
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_1154b0:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x414(%eax),%ebp
		cmp    $0xffffffff,%ebp
		je     jump_1154d7
		push   $0x0
		push   %ebp
		mov    %ebx,%eax
		push   $0xb
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_1154d7:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x454(%eax),%ecx
		cmp    $0xffffffff,%ecx
		je     jump_1154fe
		push   $0x0
		push   %ecx
		mov    %ebx,%eax
		push   $0x40
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_1154fe:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x494(%eax),%ebp
		cmp    $0xffffffff,%ebp
		je     jump_115525
		push   $0x0
		push   %ebp
		mov    %ebx,%eax
		push   $0x5b
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_115525:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x4d4(%eax),%ecx
		cmp    $0xffffffff,%ecx
		je     jump_11554c
		push   $0x0
		push   %ecx
		mov    %ebx,%eax
		push   $0x5d
		or     $0xb0,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_11554c:
		lea    0x0(,%ebx,4),%eax
		add    %esi,%eax
		mov    0x514(%eax),%ebp
		cmp    $0xffffffff,%ebp
		je     jump_115572
		push   $0x0
		push   %ebp
		push   $0x6
		or     $0xb0,%bl
		push   %ebx
		push   %esi
		call   func_114de0
		add    $0x14,%esp
	jump_115572:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115580:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ecx
		mov    %ecx,%edx
		xor    %eax,%eax
		lea    0x0(%eax),%eax
		nop
	jump_115590:
		mov    %eax,0x94(%edx)
		inc    %eax
		add    $0x4,%edx
		cmp    $0x10,%eax
		jl     jump_115590
		mov    $0x480,%ebx
		mov    $0xffffffff,%edx
		lea    0xd4(%ecx),%eax
		call   ac_memset
		mov    %ecx,%eax
		lea    0x10(%ecx),%edx
	jump_1155b9:
		add    $0x4,%eax
		movl   $0xffffffff,0x80(%eax)
		cmp    %edx,%eax
		jne    jump_1155b9
		mov    %ecx,%eax
		lea    0x80(%ecx),%edx
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		mov    %eax,%eax
	jump_1155e0:
		add    $0x4,%eax
		movl   $0xffffffff,0x554(%eax)
		cmp    %edx,%eax
		jne    jump_1155e0
		movl   $0x0,0x554(%ecx)
		movl   $0x0,0x30(%ecx)
		movl   $0x0,0x5c(%ecx)
		movl   $0xffffffff,0x60(%ecx)
		movl   $0x0,0x6c(%ecx)
		movl   $0x0,0x68(%ecx)
		movl   $0x4,0x64(%ecx)
		movl   $0x7a1200,0x70(%ecx)
		movl   $0x0,0x34(%ecx)
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115640:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ebx
		push   %ebx
		call   func_115580
		mov    0x10(%ebx),%eax
		add    $0x8,%eax
		add    $0x4,%esp
		mov    %eax,0x14(%ebx)
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115660:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%edi
		mov    %edi,%ebx
		xor    %esi,%esi
		lea    0x0(%eax),%eax
		mov    %ecx,%ecx
	jump_115670:
		mov    0x394(%ebx),%edx
		cmp    $0xffffffff,%edx
		je     jump_115690
		push   $0x0
		push   %edx
		mov    %esi,%eax
		push   $0x7
		or     $0xb0,%al
		push   %eax
		push   %edi
		call   func_114de0
		add    $0x14,%esp
		mov    %eax,%eax
	jump_115690:
		inc    %esi
		add    $0x4,%ebx
		cmp    $0x10,%esi
		jl     jump_115670
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1156a0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%esi
		cmpl   $0x0,0x14(%esi)
		jne    jump_115d60
		cmpl   $0x0,data_15ab5c
		jne    jump_115d60
		mov    $0x1,%ecx
		mov    0x1c(%esi),%eax
		mov    %ecx,data_15ab5c
		mov    %eax,data_1ed904
		mov    0x18(%esi),%eax
		mov    data_1ed904,%edi
		mov    %eax,data_1ed8f8
		test   %edi,%edi
		je     jump_115d4f
		mov    $0xf42400,%ebp
		xor    %edi,%edi
	jump_1156ef:
		mov    data_1ed8f8,%eax
		cmpl   $0x4,0x4(%eax)
		jne    jump_115d28
		mov    0x34(%eax),%ebx
		mov    0x48(%eax),%edx
		mov    0x58(%eax),%ecx
		inc    %ebx
		add    %edx,%ecx
		mov    %ebx,0x34(%eax)
		mov    %edi,data_1ed910
		mov    %ecx,0x58(%eax)
	jump_115716:
		mov    data_1ed8f8,%eax
		mov    0x58(%eax),%edx
		cmp    $0x64,%edx
		jl     jump_115c63
		lea    -0x64(%edx),%ecx
		mov    0x554(%eax),%edx
		mov    %ecx,0x58(%eax)
		cmp    %edx,%edi
		jge    jump_1157ce
		mov    %edi,data_1ed8fc
		mov    $0xffffffff,%ebx
	jump_115746:
		mov    data_1ed8fc,%eax
		mov    data_1ed8f8,%edx
		lea    0x0(,%eax,4),%eax
		add    %edx,%eax
		cmp    0x558(%eax),%ebx
		je     jump_1157ba
		mov    0x658(%eax),%ecx
		add    %ebx,%ecx
		mov    %ecx,0x658(%eax)
		cmp    %ecx,%edi
		jl     jump_1157ba
		push   %edi
		mov    data_1ed8fc,%eax
		push   %edi
		mov    0x5d8(%edx,%eax,4),%ecx
		mov    0x558(%edx,%eax,4),%eax
		push   %ecx
		or     $0x80,%al
		push   %eax
		push   %edx
		call   func_114de0
		mov    data_1ed8f8,%eax
		mov    data_1ed8fc,%edx
		mov    %ebx,0x558(%eax,%edx,4)
		mov    0x554(%eax),%edx
		add    %ebx,%edx
		add    $0x14,%esp
		mov    %edx,0x554(%eax)
		cmp    %edx,%edi
		je     jump_1157ce
	jump_1157ba:
		mov    data_1ed8fc,%eax
		inc    %eax
		mov    %eax,data_1ed8fc
		cmp    $0x20,%eax
		jl     jump_115746
	jump_1157ce:
		mov    data_1ed8f8,%eax
		mov    0x30(%eax),%ebx
		dec    %ebx
		mov    %ebx,0x30(%eax)
		cmp    %ebx,%edi
		jl     jump_115bdc
	jump_1157e2:
		mov    data_1ed8f8,%ebx
		mov    0x14(%ebx),%edx
		xor    %eax,%eax
		mov    (%edx),%al
		mov    %eax,data_1ed8e8
		cmp    $0x80,%eax
		jb     jump_115bbb
		cmp    data_1ed910,%edi
		jne    jump_115bbb
		cmp    $0xf7,%eax
		jb     jump_115824
		jbe    jump_115a00
		cmp    $0xff,%eax
		je     jump_115834
		jmp    jump_115a58
	jump_115824:
		cmp    $0xf0,%eax
		je     jump_115a00
		jmp    jump_115a58
	jump_115834:
		add    $0x2,%edx
		xor    %eax,%eax
		add    $0x14,%ebx
		mov    -0x1(%edx),%al
		push   %ebx
		mov    %eax,data_1ed8f0
		mov    %edx,(%ebx)
		call   func_1148f0
		mov    %eax,data_1ed8ec
		mov    data_1ed8f0,%eax
		add    $0x4,%esp
		cmp    $0x51,%eax
		jb     jump_115872
		jbe    jump_11590f
		cmp    $0x58,%eax
		je     jump_115956
		jmp    jump_1159ed
	jump_115872:
		cmp    $0x2f,%eax
		jne    jump_1159ed
		mov    data_1ed8f8,%eax
		mov    $0x1,%ecx
		mov    0x2c(%eax),%edx
		mov    %ecx,data_1ed910
		cmp    %edx,%edi
		je     jump_11589d
		mov    %edx,%ebx
		sub    %ecx,%ebx
		mov    %ebx,0x2c(%eax)
		cmp    %ebx,%edi
		je     jump_1158d0
	jump_11589d:
		mov    data_1ed8f8,%eax
		movl   $0xffffffff,0x60(%eax)
		mov    %edi,0x5c(%eax)
		mov    0x10(%eax),%edx
		mov    %edi,0x6c(%eax)
		add    $0x8,%edx
		mov    0x24(%eax),%ebx
		mov    %edx,0x14(%eax)
		cmp    %ebx,%edi
		je     jump_1159ed
		push   %edi
		push   %edi
		push   %eax
		mov    (%eax),%ecx
		mov    %eax,%edx
		push   %ecx
		jmp    jump_1159e7
	jump_1158d0:
		push   %eax
		mov    %ecx,0x2c(%eax)
		call   AIL_stop_sequence
		mov    data_1ed8f8,%eax
		add    $0x4,%esp
		mov    0x28(%eax),%edx
		movl   $0x2,0x4(%eax)
		cmp    %edx,%ebx
		je     jump_1159ed
		mov    %eax,%edx
		push   %eax
		call   *0x28(%edx)
		add    $0x4,%esp
		mov    data_1ed8f8,%eax
		mov    data_1ed8ec,%edx
		add    %edx,0x14(%eax)
		jmp    jump_1157e2
	jump_11590f:
		mov    data_1ed8f8,%edx
		mov    0x14(%edx),%eax
		xor    %ebx,%ebx
		mov    0x1(%eax),%bl
		mov    %ebx,%ecx
		xor    %ebx,%ebx
		mov    (%eax),%bl
		shl    $0x8,%ecx
		shl    $0x10,%ebx
		mov    0x2(%eax),%al
		add    %ecx,%ebx
		and    $0xff,%eax
		add    %eax,%ebx
		mov    %ebx,%eax
		shl    $0x4,%eax
		mov    %ebx,data_1ed90c
		mov    %eax,0x70(%edx)
		mov    data_1ed8f8,%eax
		mov    data_1ed8ec,%edx
		add    %edx,0x14(%eax)
		jmp    jump_1157e2
	jump_115956:
		mov    data_1ed8f8,%ebx
		mov    0x14(%ebx),%eax
		mov    (%eax),%al
		and    $0xff,%eax
		mov    %eax,0x64(%ebx)
		mov    0x14(%ebx),%eax
		mov    0x1(%eax),%al
		mov    data_1ed838,%ecx
		and    $0xff,%eax
		mov    %ebp,%edx
		sub    $0x2,%eax
		sar    $0x1f,%edx
		mov    %eax,data_1ed90c
		mov    %ebp,%eax
		idiv   %ecx
		mov    data_1ed90c,%edx
		mov    %eax,data_1ed908
		cmp    %edx,%edi
		jle    jump_1159ae
		mov    %edx,%ecx
		neg    %ecx
		mov    %ecx,data_1ed90c
		mov    data_1ed90c,%cl
		sar    %cl,%eax
		jmp    jump_1159b6
	jump_1159ae:
		mov    data_1ed90c,%cl
		shl    %cl,%eax
	jump_1159b6:
		mov    %eax,0x68(%ebx)
		mov    data_1ed8f8,%eax
		mov    %edi,0x6c(%eax)
		mov    %edi,%ebx
		mov    0x68(%eax),%edx
		mov    %edi,0x5c(%eax)
		sub    %edx,%ebx
		mov    0x60(%eax),%ecx
		mov    %ebx,0x6c(%eax)
		inc    %ecx
		mov    0x24(%eax),%edx
		mov    %ecx,0x60(%eax)
		cmp    %edx,%edi
		je     jump_1159ed
		push   %ecx
		mov    0x5c(%eax),%ecx
		push   %ecx
		push   %eax
		mov    (%eax),%ebx
		mov    %eax,%edx
		push   %ebx
	jump_1159e7:
		call   *0x24(%edx)
		add    $0x10,%esp
	jump_1159ed:
		mov    data_1ed8f8,%eax
		mov    data_1ed8ec,%edx
		add    %edx,0x14(%eax)
		jmp    jump_1157e2
	jump_115a00:
		mov    data_1ed8f8,%eax
		mov    0x14(%eax),%eax
		inc    %eax
		push   $data_1ed8e0
		mov    %eax,data_1ed8e0
		call   func_1148f0
		mov    data_1ed8f8,%ebx
		mov    %eax,%edx
		mov    data_1ed8e0,%eax
		mov    0x14(%ebx),%ecx
		sub    %ecx,%eax
		add    $0x4,%esp
		add    %eax,%edx
		push   %edx
		push   %ecx
		push   %esi
		mov    %edx,data_1ed8ec
		call   func_1148a0
		mov    data_1ed8f8,%eax
		mov    data_1ed8ec,%edx
		mov    0x14(%eax),%ebx
		add    %edx,%ebx
		add    $0xc,%esp
		mov    %ebx,0x14(%eax)
		jmp    jump_1157e2
	jump_115a58:
		mov    data_1ed8f8,%edx
		mov    0x14(%edx),%eax
		mov    %eax,data_1ed8e4
		mov    data_1ed8e8,%eax
		and    $0xf,%eax
		mov    %eax,data_1ed8f4
		mov    0x14(%edx),%eax
		xor    %ebx,%ebx
		push   $0x1
		mov    0x2(%eax),%bl
		mov    data_1ed8e8,%ecx
		push   %ebx
		xor    %ebx,%ebx
		and    $0xf0,%ecx
		mov    0x1(%eax),%bl
		mov    %ecx,data_1ed8e8
		push   %ebx
		mov    (%eax),%al
		and    $0xff,%eax
		push   %eax
		push   %edx
		call   func_114de0
		mov    data_1ed8e8,%eax
		add    $0x14,%esp
		cmp    $0x90,%eax
		je     jump_115ae6
		mov    data_1ed8f8,%ebx
		mov    data_1ed8e4,%eax
		mov    0x14(%ebx),%edx
		cmp    %edx,%eax
		jne    jump_1157e2
		mov    (%edx),%al
		and    $0xff,%eax
		push   %eax
		call   func_114750
		mov    0x14(%ebx),%ecx
		add    %eax,%ecx
		add    $0x4,%esp
		mov    %ecx,0x14(%ebx)
		jmp    jump_1157e2
	jump_115ae6:
		mov    %edi,data_1ed8fc
		mov    %edi,%eax
	jump_115aee:
		mov    data_1ed8f8,%edx
		cmpl   $0xffffffff,0x558(%edx,%eax,1)
		je     jump_115b15
		mov    data_1ed8fc,%edx
		inc    %edx
		add    $0x4,%eax
		mov    %edx,data_1ed8fc
		cmp    $0x80,%eax
		jl     jump_115aee
	jump_115b15:
		mov    data_1ed8fc,%ebx
		cmp    $0x20,%ebx
		jne    jump_115b5b
		mov    $0x7,%ecx
		mov    $data_1ed6f0,%edi
		mov    data_1ed8f8,%ebx
		mov    $data_161b5c,%esi
		push   %ebx
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		call   AIL_stop_sequence
		mov    data_1ed8f8,%eax
		xor    %ecx,%ecx
		add    $0x4,%esp
		mov    %ecx,data_15ab5c
		movl   $0x2,0x4(%eax)
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115b5b:
		mov    data_1ed8f8,%eax
		mov    0x554(%eax),%ecx
		inc    %ecx
		mov    data_1ed8f4,%edx
		mov    %ecx,0x554(%eax)
		mov    %edx,0x558(%eax,%ebx,4)
		mov    0x14(%eax),%edx
		xor    %ebx,%ebx
		mov    0x1(%edx),%bl
		mov    data_1ed8fc,%edx
		mov    %ebx,0x5d8(%eax,%edx,4)
		mov    0x14(%eax),%edx
		add    $0x14,%eax
		add    $0x3,%edx
		push   %eax
		mov    %edx,(%eax)
		call   func_1148f0
		mov    data_1ed8f8,%edx
		mov    data_1ed8fc,%ebx
		add    $0x4,%esp
		mov    %eax,0x658(%edx,%ebx,4)
		jmp    jump_1157e2
	jump_115bbb:
		cmp    data_1ed910,%edi
		jne    jump_115bdc
		mov    data_1ed8f8,%eax
		mov    0x14(%eax),%edx
		lea    0x1(%edx),%ebx
		mov    %ebx,0x14(%eax)
		mov    (%edx),%dl
		and    $0xff,%edx
		mov    %edx,0x30(%eax)
	jump_115bdc:
		cmp    data_1ed910,%edi
		jne    jump_115716
		mov    data_1ed8f8,%eax
		mov    0x68(%eax),%edx
		mov    0x6c(%eax),%ebx
		add    %edx,%ebx
		mov    0x70(%eax),%ecx
		mov    %ebx,0x6c(%eax)
		cmp    %ecx,%ebx
		jl     jump_115716
		sub    %ecx,%ebx
		mov    0x5c(%eax),%ecx
		mov    %ebx,0x6c(%eax)
		inc    %ecx
		mov    0x64(%eax),%ebx
		mov    %ecx,0x5c(%eax)
		cmp    %ebx,%ecx
		jl     jump_115c20
		mov    0x60(%eax),%ecx
		mov    %edi,0x5c(%eax)
		inc    %ecx
		mov    %ecx,0x60(%eax)
	jump_115c20:
		mov    data_1ed8f8,%eax
		cmp    0x24(%eax),%edi
		je     jump_115716
		push   $data_1ed900
		push   $data_1ed8fc
		push   %eax
		call   AIL_sequence_position
		add    $0xc,%esp
		mov    data_1ed900,%ebx
		push   %ebx
		mov    data_1ed8fc,%ecx
		push   %ecx
		mov    data_1ed8f8,%eax
		push   %eax
		mov    (%eax),%edx
		push   %edx
		call   *0x24(%eax)
		add    $0x10,%esp
		jmp    jump_115716
	jump_115c63:
		cmp    data_1ed910,%edi
		jne    jump_115d28
		mov    0x38(%eax),%edx
		cmp    0x3c(%eax),%edx
		je     jump_115cd3
		mov    (%eax),%edx
		mov    0x40(%eax),%ebx
		mov    0x10(%edx),%edx
		add    %edx,%ebx
		mov    %ebx,0x40(%eax)
	jump_115c84:
		mov    data_1ed8f8,%eax
		mov    0x40(%eax),%edx
		mov    0x44(%eax),%ebx
		cmp    %ebx,%edx
		jl     jump_115cbf
		mov    %edx,%ecx
		mov    0x3c(%eax),%edx
		sub    %ebx,%ecx
		mov    0x38(%eax),%ebx
		mov    %ecx,0x40(%eax)
		cmp    %ebx,%edx
		jle    jump_115cac
		lea    0x1(%ebx),%edx
		mov    %edx,0x38(%eax)
		jmp    jump_115cb2
	jump_115cac:
		lea    -0x1(%ebx),%ecx
		mov    %ecx,0x38(%eax)
	jump_115cb2:
		mov    data_1ed8f8,%eax
		mov    0x38(%eax),%edx
		cmp    0x3c(%eax),%edx
		jne    jump_115c84
	jump_115cbf:
		mov    data_1ed8f8,%eax
		testb  $0x7,0x34(%eax)
		jne    jump_115cd3
		push   %eax
		call   func_115660
		add    $0x4,%esp
	jump_115cd3:
		mov    data_1ed8f8,%eax
		mov    0x48(%eax),%edx
		cmp    0x4c(%eax),%edx
		je     jump_115d28
		mov    (%eax),%edx
		mov    0x50(%eax),%ebx
		mov    0x10(%edx),%edx
		add    %edx,%ebx
		mov    %ebx,0x50(%eax)
	jump_115ced:
		mov    data_1ed8f8,%eax
		mov    0x50(%eax),%edx
		mov    0x54(%eax),%ecx
		cmp    %ecx,%edx
		jl     jump_115d28
		mov    %edx,%ebx
		mov    0x4c(%eax),%edx
		sub    %ecx,%ebx
		mov    0x48(%eax),%ecx
		mov    %ebx,0x50(%eax)
		cmp    %ecx,%edx
		jle    jump_115d15
		lea    0x1(%ecx),%ebx
		mov    %ebx,0x48(%eax)
		jmp    jump_115d1b
	jump_115d15:
		lea    -0x1(%ecx),%edx
		mov    %edx,0x48(%eax)
	jump_115d1b:
		mov    data_1ed8f8,%eax
		mov    0x48(%eax),%edx
		cmp    0x4c(%eax),%edx
		jne    jump_115ced
	jump_115d28:
		mov    data_1ed904,%ebx
		mov    data_1ed8f8,%ecx
		dec    %ebx
		add    $0x718,%ecx
		mov    %ebx,data_1ed904
		mov    %ecx,data_1ed8f8
		cmp    %ebx,%edi
		jne    jump_1156ef
	jump_115d4f:
		push   %esi
		call   func_1147b0
		xor    %edx,%edx
		add    $0x4,%esp
		mov    %edx,data_15ab5c
	jump_115d60:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115d70:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x18,%esp
		mov    0x2c(%esp),%ebp
		mov    0x30(%esp),%esi
		mov    $0x6,%ecx
		mov    %esp,%edi
		rep movsl %ds:(%esi),%es:(%edi)
		mov    0x0(%ebp),%eax
		mov    0x10(%eax),%eax
		cmpw   $0x0,0x10(%eax)
		jbe    jump_115e0f
		mov    0xc(%eax),%edx
		mov    0xc(%eax),%ebx
		shr    $0x10,%edx
		and    $0xffff,%ebx
		shl    $0x4,%edx
		movswl (%esp),%eax
		add    %edx,%ebx
		cmp    $0x1,%eax
		jge    jump_115dbd
		mov    (%ebx),%ax
		mov    %ax,(%esp)
	jump_115dbd:
		movswl 0x2(%esp),%eax
		cmp    $0x1,%eax
		jge    jump_115dd0
		mov    0x2(%ebx),%ax
		mov    %ax,0x2(%esp)
	jump_115dd0:
		movswl 0x4(%esp),%eax
		cmp    $0x1,%eax
		jge    jump_115de3
		mov    0x4(%ebx),%ax
		mov    %ax,0x4(%esp)
	jump_115de3:
		movswl 0x6(%esp),%eax
		cmp    $0x1,%eax
		jge    jump_115df6
		mov    0x6(%ebx),%ax
		mov    %ax,0x6(%esp)
	jump_115df6:
		xor    %eax,%eax
	jump_115df8:
		cmpl   $0x1,0x8(%esp,%eax,1)
		jge    jump_115e07
		mov    0x8(%ebx,%eax,1),%edx
		mov    %edx,0x8(%esp,%eax,1)
	jump_115e07:
		add    $0x4,%eax
		cmp    $0x10,%eax
		jne    jump_115df8
	jump_115e0f:
		mov    0x0(%ebp),%eax
		mov    0x10(%eax),%esi
		mov    $0x6,%ecx
		push   $0x0
		lea    0x16(%esi),%edi
		lea    0x4(%esp),%esi
		push   $0x0
		rep movsl %ds:(%esi),%es:(%edi)
		push   $0x304
		mov    0x0(%ebp),%ebx
		push   %ebx
		call   AIL_call_driver
		add    $0x10,%esp
		add    $0x18,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115e40:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%edi
		mov    0x1c(%edi),%edx
		xor    %esi,%esi
		test   %edx,%edx
		jle    jump_115e6e
		xor    %ebx,%ebx
	jump_115e52:
		mov    0x18(%edi),%eax
		add    %ebx,%eax
		push   %eax
		inc    %esi
		call   AIL_end_sequence
		add    $0x718,%ebx
		mov    0x1c(%edi),%ecx
		add    $0x4,%esp
		cmp    %ecx,%esi
		jl     jump_115e52
	jump_115e6e:
		mov    0xc(%edi),%esi
		push   %esi
		call   AIL_release_timer_handle
		imul   $0x718,0x1c(%edi),%eax
		add    $0x4,%esp
		push   %eax
		mov    0x18(%edi),%eax
		push   %eax
		call   MEM_free_lock
		add    $0x8,%esp
		push   $0x1d4
		push   %edi
		call   MEM_free_lock
		add    $0x8,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_115ea0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x30,%esp
		call   AILXMIDI_start_
		push   $0x1d4
		call   MEM_alloc_lock
		mov    %eax,%ebx
		add    $0x4,%esp
		mov    %eax,%ebp
		test   %eax,%eax
		jne    jump_115ed9
		mov    $0x9,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161b7c,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		jmp    jump_1164db
	jump_115ed9:
		mov    0x44(%esp),%eax
		mov    %eax,(%ebx)
		cmpl   $0x1,0x14(%eax)
		je     jump_115f10
		mov    $0x5,%ecx
		push   $0x1d4
		mov    $data_1ed6f0,%edi
		mov    $data_161ba4,%esi
		push   %ebx
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x30,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_115f10:
		lea    0x18(%esp),%esi
		push   %esi
		push   $0x0
		push   $0x301
		push   %eax
		call   AIL_call_driver
		add    $0x10,%esp
		xor    %eax,%eax
		mov    0x1e(%esp),%ax
		mov    %eax,%esi
		xor    %eax,%eax
		shl    $0x4,%esi
		mov    0x18(%esp),%ax
		add    %eax,%esi
		xor    %eax,%eax
		mov    %esi,0x4(%ebx)
		xor    %esi,%esi
		mov    0x1c(%esp),%ax
		mov    0x1a(%esp),%si
		shl    $0x4,%eax
		add    %esi,%eax
		mov    %eax,0x8(%ebx)
		mov    0x4(%ebx),%eax
		mov    (%eax),%esi
		shr    $0x10,%esi
		mov    (%eax),%eax
		shl    $0x4,%esi
		and    $0xffff,%eax
		add    %esi,%eax
		je     jump_115f8d
		cmpb   $0x0,(%eax)
		je     jump_115f8d
		call   ac_getenv
		test   %eax,%eax
		je     jump_115f8d
		cmpb   $0x0,(%eax)
		je     jump_115f8d
		mov    %eax,%edx
		mov    0x8(%ebx),%esi
		mov    $0x80,%ebx
		mov    %esi,%eax
		call   ac_strncpy
	jump_115f8d:
		mov    0x4(%ebp),%eax
		mov    0x4(%eax),%esi
		mov    0x4(%eax),%ebx
		shr    $0x10,%esi
		and    $0xffff,%ebx
		shl    $0x4,%esi
		add    %esi,%ebx
		je     jump_116002
		cmpb   $0x0,(%ebx)
		je     jump_116002
		mov    0x8(%ebp),%edi
		mov    $data_15aadc,%esi
		add    $0x80,%edi
		push   %edi
	jump_115fba:
		mov    (%esi),%al
		mov    %al,(%edi)
		cmp    $0x0,%al
		je     jump_115fd2
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    %al,0x1(%edi)
		add    $0x2,%edi
		cmp    $0x0,%al
		jne    jump_115fba
	jump_115fd2:
		pop    %edi
		mov    0x8(%ebp),%edi
		mov    %ebx,%esi
		add    $0x80,%edi
		push   %edi
		sub    %ecx,%ecx
		dec    %ecx
		mov    $0x0,%al
		repnz scas %es:(%edi),%al
		dec    %edi
	jump_115fe7:
		mov    (%esi),%al
		mov    %al,(%edi)
		cmp    $0x0,%al
		je     jump_115fff
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    %al,0x1(%edi)
		add    $0x2,%edi
		cmp    $0x0,%al
		jne    jump_115fe7
	jump_115fff:
		pop    %edi
		jmp    jump_11600c
	jump_116002:
		mov    0x8(%ebp),%eax
		movb   $0x0,0x80(%eax)
	jump_11600c:
		mov    $0x18,%ebx
		mov    $0xffffffff,%edx
		mov    $data_1ed7f0,%eax
		call   ac_memset
		xor    %ebx,%ebx
		mov    0x48(%esp),%ecx
		mov    %ebx,0x24(%esp)
		test   %ecx,%ecx
		je     jump_116062
		mov    $0x6,%ecx
		mov    0x48(%esp),%esi
		mov    $data_1ed7f0,%edi
		rep movsl %ds:(%esi),%es:(%edi)
		mov    0x48(%esp),%esi
		push   %esi
		push   %ebp
		call   func_115d70
		add    $0x8,%esp
		test   %eax,%eax
		je     jump_116062
		mov    $0x1,%edi
		mov    $0x6,%ecx
		mov    %edi,0x24(%esp)
		mov    %esp,%edi
		rep movsl %ds:(%esi),%es:(%edi)
	jump_116062:
		cmpl   $0x0,0x24(%esp)
		jne    jump_1160ab
		mov    0x0(%ebp),%edx
		push   %edx
		call   AIL_get_IO_environment
		mov    %eax,%ebx
		add    $0x4,%esp
		test   %eax,%eax
		je     jump_1160ab
		mov    $0x6,%ecx
		push   %eax
		mov    $data_1ed7f0,%edi
		mov    %eax,%esi
		push   %ebp
		rep movsl %ds:(%esi),%es:(%edi)
		call   func_115d70
		add    $0x8,%esp
		test   %eax,%eax
		je     jump_1160ab
		mov    $0x1,%ecx
		mov    %esp,%edi
		mov    %ebx,%esi
		mov    %ecx,0x24(%esp)
		mov    $0x6,%ecx
		rep movsl %ds:(%esi),%es:(%edi)
	jump_1160ab:
		mov    0x24(%esp),%esi
		test   %esi,%esi
		jne    jump_116145
		cmpl   $0x1,data_1ed850
		jne    jump_116145
		mov    %esi,0x2c(%esp)
		mov    %esi,0x28(%esp)
		jmp    jump_116131
	jump_1160ce:
		mov    0xc(%eax),%ebx
		shr    $0x10,%ebx
		mov    0xc(%eax),%eax
		shl    $0x4,%ebx
		and    $0xffff,%eax
		add    %ebx,%eax
		mov    0x28(%esp),%ebx
		add    %eax,%ebx
		test   %ecx,%ecx
		jne    jump_1160f9
		mov    $0x6,%ecx
		mov    $data_1ed7f0,%edi
		mov    %ebx,%esi
		rep movsl %ds:(%esi),%es:(%edi)
	jump_1160f9:
		push   %ebx
		push   %ebp
		call   func_115d70
		add    $0x8,%esp
		test   %eax,%eax
		je     jump_11611d
		mov    $0x1,%edx
		mov    $0x6,%ecx
		mov    %esp,%edi
		mov    %ebx,%esi
		mov    %edx,0x24(%esp)
		rep movsl %ds:(%esi),%es:(%edi)
		jmp    jump_116145
	jump_11611d:
		mov    0x28(%esp),%edi
		mov    0x2c(%esp),%eax
		add    $0x18,%edi
		inc    %eax
		mov    %edi,0x28(%esp)
		mov    %eax,0x2c(%esp)
	jump_116131:
		mov    0x0(%ebp),%eax
		mov    0x10(%eax),%eax
		xor    %ebx,%ebx
		mov    0x2c(%esp),%ecx
		mov    0x10(%eax),%bx
		cmp    %ecx,%ebx
		jg     jump_1160ce
	jump_116145:
		cmpl   $0x0,0x24(%esp)
		jne    jump_116175
		mov    $0x8,%ecx
		push   $0x1d4
		mov    $data_1ed6f0,%edi
		mov    $data_161bbc,%esi
		push   %ebp
		rep movsl %ds:(%esi),%es:(%edi)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x30,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116175:
		mov    $0x6,%ecx
		push   $0x0
		lea    0x4(%esp),%esi
		mov    $data_1ed7f0,%edi
		push   $0x0
		rep movsl %ds:(%esi),%es:(%edi)
		push   $0x305
		mov    0x0(%ebp),%ecx
		push   %ecx
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		add    $0x10,%esp
		movl   $0x1,0x18(%eax)
		lea    0x18(%esp),%eax
		push   %eax
		push   $0x0
		push   $0x501
		mov    0x0(%ebp),%esi
		push   %esi
		call   AIL_call_driver
		add    $0x10,%esp
		cmpw   $0x0,0x18(%esp)
		jne    jump_11620d
		mov    $0xa,%ecx
		push   $0x0
		mov    $data_1ed6f0,%edi
		mov    $data_161bdc,%esi
		push   $0x0
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		push   $0x306
		mov    0x0(%ebp),%ecx
		push   %ecx
		call   AIL_call_driver
		add    $0x10,%esp
		push   $0x1d4
		mov    0x0(%ebp),%eax
		push   %ebp
		movl   $0x0,0x18(%eax)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x30,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_11620d:
		mov    data_1ed83c,%eax
		mov    %eax,0x1c(%ebp)
		imul   $0x718,%eax,%eax
		push   %eax
		call   MEM_alloc_lock
		add    $0x4,%esp
		mov    %eax,0x18(%ebp)
		test   %eax,%eax
		jne    jump_116271
		mov    $0xa,%ecx
		push   %eax
		mov    $data_1ed6f0,%edi
		mov    $data_161c08,%esi
		push   %eax
		rep movsl %ds:(%esi),%es:(%edi)
		push   $0x306
		mov    0x0(%ebp),%ebx
		push   %ebx
		call   AIL_call_driver
		add    $0x10,%esp
		push   $0x1d4
		mov    0x0(%ebp),%eax
		push   %ebp
		movl   $0x0,0x18(%eax)
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x30,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116271:
		mov    0x1c(%ebp),%edx
		xor    %esi,%esi
		test   %edx,%edx
		jle    jump_11629a
		xor    %eax,%eax
	jump_11627c:
		mov    0x18(%ebp),%ebx
		movl   $0x1,0x4(%ebx,%eax,1)
		mov    0x18(%ebp),%ebx
		mov    %ebp,(%ebx,%eax,1)
		inc    %esi
		mov    0x1c(%ebp),%edi
		add    $0x718,%eax
		cmp    %edi,%esi
		jl     jump_11627c
	jump_11629a:
		mov    $0xf4240,%eax
		mov    %eax,%edx
		mov    data_1ed838,%ebx
		sar    $0x1f,%edx
		idiv   %ebx
		movl   $0x0,0x1a0(%ebp)
		movl   $0x0,0x1a4(%ebp)
		movl   $0x0,0x1a8(%ebp)
		movl   $0x0,0x1ac(%ebp)
		movl   $0x0,0x14(%ebp)
		movl   $0x7f,0x1b0(%ebp)
		mov    %ebp,%ebx
		mov    %eax,0x10(%ebp)
		lea    0x40(%ebp),%eax
		xor    %esi,%esi
		nop
	jump_1162f0:
		add    $0x4,%ebx
		mov    %esi,0x1c(%ebx)
		mov    %esi,0x5c(%ebx)
		mov    %esi,0x9c(%ebx)
		mov    %esi,0xdc(%ebx)
		mov    %esi,0x11c(%ebx)
		mov    %esi,0x15c(%ebx)
		cmp    %eax,%ebx
		jne    jump_1162f0
		push   $func_1156a0
		call   AIL_register_timer
		add    $0x4,%esp
		mov    %eax,0xc(%ebp)
		cmp    $0xffffffff,%eax
		jne    jump_116388
		mov    $0x5,%ecx
		push   $0x0
		mov    $data_1ed6f0,%edi
		mov    $data_161c30,%esi
		push   $0x0
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		push   $0x306
		mov    0x0(%ebp),%ebx
		push   %ebx
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		movl   $0x0,0x18(%eax)
		imul   $0x718,0x1c(%ebp),%eax
		add    $0x10,%esp
		push   %eax
		mov    0x18(%ebp),%esi
		push   %esi
		call   MEM_free_lock
		add    $0x8,%esp
		push   $0x1d4
		push   %ebp
		call   MEM_free_lock
		add    $0x8,%esp
		xor    %eax,%eax
		add    $0x30,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116388:
		push   %ebp
		push   %eax
		call   AIL_set_timer_user
		mov    0x0(%ebp),%eax
		movl   $func_115e40,0x24(%eax)
		mov    0x0(%ebp),%eax
		xor    %esi,%esi
		add    $0x8,%esp
		mov    %ebp,0x28(%eax)
		xor    %edi,%edi
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_1163b0:
		push   %edi
		mov    %esi,%ebx
		push   $0x72
		or     $0xb0,%bl
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		mov    %esi,%eax
		push   %edi
		or     $0xc0,%al
		push   %eax
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   $0x40
		mov    %esi,%eax
		push   %edi
		or     $0xe0,%al
		push   %eax
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x70
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x1
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		mov    data_1ed840,%ecx
		push   %ecx
		push   $0x7
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   $0x40
		push   $0xa
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   $0x7f
		push   $0xb
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x40
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   $0x28
		push   $0x5b
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x5d
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x64
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x65
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %edi
		push   $0x26
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		mov    data_1ed84c,%eax
		push   %eax
		push   $0x6
		push   %ebx
		push   %ebp
		call   func_114800
		add    $0x10,%esp
		push   %ebp
		call   func_1147b0
		add    $0x4,%esp
		test   $0x3,%si
		jne    jump_1164b0
		push   $0x3
		call   AIL_delay
		add    $0x4,%esp
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
	jump_1164b0:
		inc    %esi
		cmp    $0x10,%esi
		jl     jump_1163b0
		mov    data_1ed838,%edi
		push   %edi
		mov    0xc(%ebp),%eax
		push   %eax
		call   AIL_set_timer_frequency
		add    $0x8,%esp
		mov    0xc(%ebp),%edx
		push   %edx
		call   AIL_start_timer
		add    $0x4,%esp
		mov    %ebp,%eax
	jump_1164db:
		add    $0x30,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1164f0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		sub    $0x90,%esp
		mov    0xa0(%esp),%edx
		push   %edx
		push   $EXPORT_SYMBOL(sound_driver_directory)
		push   $data_161c48
		lea    0xc(%esp),%eax
		push   %eax
		call   ac_sprintf
		add    $0x10,%esp
		push   $0x0
		lea    0x4(%esp),%eax
		push   %eax
		call   FILE_read
		mov    %eax,%ebx
		add    $0x8,%esp
		test   %eax,%eax
		jne    jump_116543
		mov    $0x5,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161c50,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		jmp    jump_116594
	jump_116543:
		mov    %esp,%eax
		push   %eax
		call   FILE_size
		add    $0x4,%esp
		push   %eax
		push   %ebx
		call   AIL_install_driver
		add    $0x8,%esp
		mov    %eax,%esi
		mov    %ebx,%eax
		call   *EXPORT_SYMBOL(data_159790)
		test   %esi,%esi
		jne    jump_116572
		xor    %eax,%eax
		add    $0x90,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116572:
		mov    0xa4(%esp),%ebx
		push   %ebx
		push   %esi
		call   func_115ea0
		add    $0x8,%esp
		mov    %eax,%ebx
		test   %eax,%eax
		jne    jump_116592
		push   %esi
		call   AIL_uninstall_driver
		add    $0x4,%esp
	jump_116592:
		mov    %ebx,%eax
	jump_116594:
		add    $0x90,%esp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
ailimpl_install_mdi_ini:	/* 1165e0 */
/*----------------------------------------------------------------*/
		push   %esi
		push   %edi
		sub    $0x118,%esp
		push   $EXPORT_SYMBOL(sound_mdi_ini_filename)
		lea    0x4(%esp),%eax
		push   %eax
		call   AIL_read_INI
		add    $0x8,%esp
		test   %eax,%eax
		jne    jump_116617
		mov    $0x7,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161c68,%esi
		mov    $0x1,%eax
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		jmp    jump_11664c
	jump_116617:
		lea    0x100(%esp),%eax
		push   %eax
		lea    0x84(%esp),%eax
		push   %eax
		call   ail_install_mdi_driver_file
		add    $0x8,%esp
		mov    0x124(%esp),%edx
		mov    %eax,(%edx)
		test   %eax,%eax
		jne    jump_11664a
		mov    $0x2,%eax
		add    $0x118,%esp
		pop    %edi
		pop    %esi
		ret
	jump_11664a:
		xor    %eax,%eax
	jump_11664c:
		add    $0x118,%esp
		pop    %edi
		pop    %esi
		ret


/*----------------------------------------------------------------*/
func_116660:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		mov    (%eax),%edx
		push   %edx
		call   AIL_uninstall_driver
		add    $0x4,%esp
		ret


/*----------------------------------------------------------------*/
func_116670:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ecx
		mov    (%ecx),%ebx
		mov    0x10(%ebx),%ebx
		cmpl   $0x112,0x8(%ebx)
		jb     jump_1166b7
		add    $0xba,%ebx
		mov    $data_161c88,%edx
		mov    %ebx,%eax
		call   ac_stricmp
		test   %eax,%eax
		jne    jump_1166a0
		mov    $0x3,%eax
		pop    %ebx
		ret
	jump_1166a0:
		mov    $data_161c9c,%edx
		mov    %ebx,%eax
		call   ac_stricmp
		test   %eax,%eax
		jne    jump_1166b7
		mov    $0x3,%eax
		pop    %ebx
		ret
	jump_1166b7:
		mov    0x4(%ecx),%eax
		mov    0x4(%eax),%edx
		mov    0x4(%eax),%ebx
		shr    $0x10,%edx
		and    $0xffff,%ebx
		shl    $0x4,%edx
		add    %edx,%ebx
		je     jump_11670e
		cmpb   $0x0,(%ebx)
		je     jump_11670e
		mov    $data_161cb8,%edx
		mov    %ebx,%eax
		call   ac_stricmp
		test   %eax,%eax
		jne    jump_1166f7
		mov    (%ecx),%eax
		cmpl   $0x5000,0xc(%eax)
		ja     jump_11670e
		mov    $0x1,%eax
		pop    %ebx
		ret
	jump_1166f7:
		mov    $data_161cbc,%edx
		mov    %ebx,%eax
		call   ac_stricmp
		test   %eax,%eax
		jne    jump_11670e
		mov    $0x2,%eax
		pop    %ebx
		ret
	jump_11670e:
		xor    %eax,%eax
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116720:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%esi
		mov    $data_15aadc,%edi
		push   %edi
	jump_11672d:
		mov    (%esi),%al
		mov    %al,(%edi)
		cmp    $0x0,%al
		je     jump_116745
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    %al,0x1(%edi)
		add    $0x2,%edi
		cmp    $0x0,%al
		jne    jump_11672d
	jump_116745:
		pop    %edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		lea    -0x1(%ecx),%edx
		test   %edx,%edx
		je     jump_116796
	jump_116757:
		mov    data_15aadc(%edx),%ah
		cmp    $0x5c,%ah
		jne    jump_116782
		mov    $data_15aadc,%edi
		sub    %ecx,%ecx
		dec    %ecx
		xor    %eax,%eax
		repnz scas %es:(%edi),%al
		not    %ecx
		dec    %ecx
		dec    %ecx
		cmp    %ecx,%edx
		jne    jump_116796
		xor    %cl,%cl
		mov    %cl,data_15aadc(%edx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116782:
		cmp    $0x2e,%ah
		jne    jump_116793
		xor    %bh,%bh
		mov    %bh,data_15aadc(%edx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116793:
		dec    %edx
		jne    jump_116757
	jump_116796:
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1167a0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%ebx
		call   AIL_lock
		mov    0x1c(%ebx),%edx
		xor    %eax,%eax
		test   %edx,%edx
		jle    jump_1167cc
		mov    0x18(%ebx),%edx
	jump_1167b8:
		cmpl   $0x1,0x4(%edx)
		je     jump_1167cc
		inc    %eax
		mov    0x1c(%ebx),%ecx
		add    $0x718,%edx
		cmp    %ecx,%eax
		jl     jump_1167b8
	jump_1167cc:
		cmp    0x1c(%ebx),%eax
		jne    jump_1167ee
		mov    $0x6,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161cc4,%esi
		rep movsl %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		call   AIL_unlock
		xor    %eax,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1167ee:
		imul   $0x718,%eax,%eax
		mov    0x18(%ebx),%ebx
		add    %eax,%ebx
		push   %ebx
		movl   $0x2,0x4(%ebx)
		call   func_115580
		add    $0x4,%esp
		movl   $0x0,0x28(%ebx)
		call   AIL_unlock
		mov    %ebx,%eax
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116840:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0xc,%esp
		mov    0x20(%esp),%ebp
		test   %ebp,%ebp
		jne    jump_116856
		xor    %ebx,%ebx
		jmp    jump_116b64
	jump_116856:
		mov    0x28(%esp),%edx
		push   %edx
		mov    0x28(%esp),%ebx
		push   %ebx
		movl   $0x2,0x4(%ebp)
		call   func_114960
		mov    %eax,%esi
		add    $0x8,%esp
		test   %eax,%eax
		jne    jump_116892
		mov    $0x6,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161ce0,%esi
		xor    %ebx,%ebx
		rep movsl %ds:(%esi),%es:(%edi)
		mov    %ebx,%eax
		add    $0xc,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116892:
		mov    0x4(%eax),%ecx
		push   %ecx
		call   func_114920
		add    $0x4,%esp
		add    $0x8,%eax
		movl   $0x0,0x8(%ebp)
		lea    (%esi,%eax,1),%edi
		movl   $0x0,0xc(%ebp)
		add    $0xc,%esi
		movl   $0x0,0x10(%ebp)
		cmp    %edi,%esi
		jae    jump_11691d
	jump_1168c0:
		mov    $0x4,%ebx
		mov    $data_161cf8,%edx
		mov    %esi,%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_1168d8
		mov    %esi,0x8(%ebp)
	jump_1168d8:
		mov    $0x4,%ebx
		mov    $data_161d00,%edx
		mov    %esi,%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_1168f0
		mov    %esi,0xc(%ebp)
	jump_1168f0:
		mov    $0x4,%ebx
		mov    $data_161d08,%edx
		mov    %esi,%eax
		call   ac_strncmp
		test   %eax,%eax
		jne    jump_116908
		mov    %esi,0x10(%ebp)
	jump_116908:
		mov    0x4(%esi),%eax
		push   %eax
		call   func_114920
		add    $0x8,%eax
		add    %eax,%esi
		add    $0x4,%esp
		cmp    %edi,%esi
		jb     jump_1168c0
	jump_11691d:
		cmpl   $0x0,0x10(%ebp)
		jne    jump_116940
		mov    $0x6,%ecx
		mov    $data_1ed6f0,%edi
		mov    $data_161ce0,%esi
		xor    %ebx,%ebx
		rep movsl %ds:(%esi),%es:(%edi)
		mov    %ebx,%eax
		add    $0xc,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116940:
		movl   $0x0,0x18(%ebp)
		movl   $0x0,0x1c(%ebp)
		movl   $0x0,0x20(%ebp)
		movl   $0x0,0x24(%ebp)
		movl   $0x0,0x28(%ebp)
		push   %ebp
		movl   $0x1,0x2c(%ebp)
		call   func_115640
		movl   $0x0,0x44(%ebp)
		movl   $0x0,0x40(%ebp)
		movl   $0x64,0x48(%ebp)
		movl   $0x64,0x4c(%ebp)
		movl   $0x0,0x54(%ebp)
		movl   $0x0,0x50(%ebp)
		mov    data_1ed840,%eax
		movl   $0x0,0x58(%ebp)
		mov    %eax,0x38(%ebp)
		add    $0x4,%esp
		mov    0x8(%ebp),%ebx
		mov    %eax,0x3c(%ebp)
		test   %ebx,%ebx
		je     jump_116b5f
		mov    0x4(%ebx),%ecx
		push   %ecx
		call   func_114920
		add    $0x8,%eax
		add    $0x4,%esp
		cmp    $0x200,%eax
		jbe    jump_1169d7
		mov    $0x200,%ebx
		jmp    jump_1169e9
	jump_1169d7:
		mov    0x8(%ebp),%eax
		mov    0x4(%eax),%esi
		push   %esi
		call   func_114920
		add    $0x4,%esp
		lea    0x8(%eax),%ebx
	jump_1169e9:
		mov    $data_1ed914,%eax
		mov    0x8(%ebp),%edx
		call   ac_memmove
		mov    0x0(%ebp),%eax
		mov    0x1a4(%eax),%edx
		mov    $data_1ed914,%edi
		test   %edx,%edx
		je     jump_116aa7
		mov    %edi,%esi
		xor    %ebx,%ebx
	jump_116a10:
		xor    %eax,%eax
		mov    0x8(%edi),%ax
		cmp    %eax,%ebx
		jae    jump_116aa7
		xor    %eax,%eax
		mov    0xa(%esi),%ax
		mov    %eax,%edx
		mov    %eax,%ecx
		and    $0xff,%edx
		and    $0xff00,%ecx
		push   %edx
		shr    $0x8,%ecx
		push   %ecx
		mov    0x0(%ebp),%eax
		push   %eax
		call   *0x1a4(%eax)
		add    $0xc,%esp
		lea    0x1(%ebx),%ecx
		test   %eax,%eax
		jne    jump_116a54
		add    $0x2,%esi
		mov    %ecx,%ebx
		jmp    jump_116a10
	jump_116a54:
		mov    %ecx,%edx
		lea    (%ecx,%ecx,1),%eax
		add    $data_1ed914,%eax
		jmp    jump_116a6c
	jump_116a60:
		add    $0x2,%eax
		mov    0x8(%eax),%cx
		inc    %edx
		mov    %cx,0x6(%eax)
	jump_116a6c:
		xor    %ecx,%ecx
		mov    0x8(%edi),%cx
		cmp    %ecx,%edx
		jb     jump_116a60
		mov    %ecx,%edx
		dec    %edx
		mov    0x5(%edi),%ah
		mov    %dx,0x8(%edi)
		cmp    $0x2,%ah
		jae    jump_116a9a
		mov    %ah,%dh
		mov    0x4(%edi),%cl
		sub    $0x2,%dh
		dec    %cl
		mov    %dh,0x5(%edi)
		mov    %cl,0x4(%edi)
		jmp    jump_116a10
	jump_116a9a:
		mov    %ah,%dl
		sub    $0x2,%dl
		mov    %dl,0x5(%edi)
		jmp    jump_116a10
	jump_116aa7:
		cmpw   $0x0,0x8(%edi)
		je     jump_116b5f
		call   AIL_background
		test   %eax,%eax
		je     jump_116adb
		mov    $data_1ed6f0,%edi
		mov    $data_161d10,%esi
		mov    $0xffffffff,%ebx
		movsl  %ds:(%esi),%es:(%edi)
		movsl  %ds:(%esi),%es:(%edi)
		movsl  %ds:(%esi),%es:(%edi)
		movsl  %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		mov    %ebx,%eax
		add    $0xc,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116adb:
		mov    0x0(%ebp),%eax
		incl   0x14(%eax)
		mov    0x0(%ebp),%ecx
		push   %ecx
		call   func_1147b0
		mov    0x0(%ebp),%eax
		mov    $0x200,%ebx
		add    $0x4,%esp
		mov    0x8(%eax),%eax
		mov    %edi,%edx
		add    $0x100,%eax
		call   ac_memmove
		mov    %esp,%eax
		push   %eax
		push   $0x0
		mov    0x0(%ebp),%eax
		push   $0x503
		mov    (%eax),%esi
		push   %esi
		call   AIL_call_driver
		mov    0x0(%ebp),%eax
		mov    0x14(%eax),%edi
		dec    %edi
		add    $0x10,%esp
		mov    %edi,0x14(%eax)
		cmpw   $0x0,(%esp)
		jne    jump_116b5f
		mov    0x2(%esp),%eax
		xor    %ah,%ah
		cwtl
		push   %eax
		movswl 0x6(%esp),%eax
		sar    $0x8,%eax
		push   %eax
		push   $data_161d24
		push   $data_1ed6f0
		mov    $0xffffffff,%ebx
		call   ac_sprintf
		add    $0x10,%esp
		mov    %ebx,%eax
		add    $0xc,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_116b5f:
		mov    $0x1,%ebx
	jump_116b64:
		mov    %ebx,%eax
		add    $0xc,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116b70:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%ebx
		test   %ebx,%ebx
		je     jump_116b98
		cmpl   $0x1,0x4(%ebx)
		je     jump_116b98
		push   %ebx
		call   AIL_stop_sequence
		add    $0x4,%esp
		push   %ebx
		call   func_115640
		add    $0x4,%esp
		movl   $0x4,0x4(%ebx)
	jump_116b98:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116ba0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebp
		test   %ebp,%ebp
		je     jump_116c57
		cmpl   $0x4,0x4(%ebp)
		jne    jump_116c57
		push   %ebp
		mov    %ebp,%ebx
		movl   $0x8,0x4(%ebp)
		add    $0x40,%ebp
		call   func_115240
		add    $0x4,%esp
		mov    -0x40(%ebp),%edi
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		mov    %eax,%eax
	jump_116be0:
		mov    0x454(%ebx),%ecx
		mov    0x94(%ebx),%esi
		cmp    $0x40,%ecx
		jl     jump_116c03
		push   $0x0
		mov    %esi,%eax
		push   $0x40
		or     $0xb0,%al
		push   %eax
		push   %edi
		call   func_114800
		add    $0x10,%esp
	jump_116c03:
		cmpl   $0x40,0x1d4(%ebx)
		jl     jump_116c14
		movl   $0x0,0x20(%edi,%esi,4)
	jump_116c14:
		cmpl   $0x40,0x254(%ebx)
		jl     jump_116c2f
		push   $0x0
		mov    %esi,%eax
		push   $0x70
		or     $0xb0,%al
		push   %eax
		push   %edi
		call   func_114800
		add    $0x10,%esp
	jump_116c2f:
		cmpl   $0x40,0x194(%ebx)
		jl     jump_116c50
		inc    %esi
		push   %esi
		push   %edi
		call   AIL_release_channel
		add    $0x8,%esp
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		nop
	jump_116c50:
		add    $0x4,%ebx
		cmp    %ebp,%ebx
		jne    jump_116be0
	jump_116c57:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116c60:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%edi
		test   %edi,%edi
		je     jump_116cc7
		cmpl   $0x8,0x4(%edi)
		jne    jump_116cc7
		mov    %edi,%esi
		mov    (%edi),%ebp
		xor    %ebx,%ebx
	jump_116c80:
		cmpl   $0x40,0x194(%esi)
		jl     jump_116ca0
		push   %ebp
		call   AIL_lock_channel
		dec    %eax
		add    $0x4,%esp
		cmp    $0xffffffff,%eax
		jne    jump_116c9a
		mov    %ebx,%eax
	jump_116c9a:
		mov    %eax,0x94(%esi)
	jump_116ca0:
		inc    %ebx
		add    $0x4,%esi
		cmp    $0x10,%ebx
		jl     jump_116c80
		xor    %ebx,%ebx
		lea    0x0(%eax),%eax
		mov    %ecx,%ecx
	jump_116cb0:
		push   %ebx
		push   %edi
		call   func_115340
		inc    %ebx
		add    $0x8,%esp
		cmp    $0x10,%ebx
		jl     jump_116cb0
		movl   $0x4,0x4(%edi)
	jump_116cc7:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116cd0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		mov    0xc(%esp),%ebx
		test   %ebx,%ebx
		je     jump_116d05
		mov    0x4(%ebx),%edx
		cmp    $0x1,%edx
		je     jump_116d05
		cmp    $0x2,%edx
		je     jump_116d05
		push   %ebx
		call   AIL_stop_sequence
		add    $0x4,%esp
		mov    0x28(%ebx),%esi
		movl   $0x2,0x4(%ebx)
		test   %esi,%esi
		je     jump_116d05
		push   %ebx
		call   *0x28(%ebx)
		add    $0x4,%esp
	jump_116d05:
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116d20:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		mov    0xc(%esp),%ebx
		mov    0x14(%esp),%ecx
		test   %ebx,%ebx
		je     jump_116d88
		mov    (%ebx),%eax
		incl   0x14(%eax)
		mov    0x10(%esp),%eax
		mov    %eax,0x4c(%ebx)
		mov    0x48(%ebx),%eax
		mov    0x4c(%ebx),%esi
		cmp    %esi,%eax
		je     jump_116d83
		test   %ecx,%ecx
		jne    jump_116d4d
		mov    %esi,0x48(%ebx)
		jmp    jump_116d83
	jump_116d4d:
		mov    %ecx,%eax
		shl    $0x5,%eax
		sub    %ecx,%eax
		lea    0x0(,%eax,4),%eax
		add    %eax,%ecx
		mov    0x48(%ebx),%eax
		sub    %esi,%eax
		lea    0x0(,%ecx,8),%ecx
		cltd
		xor    %edx,%eax
		sub    %edx,%eax
		mov    %eax,%esi
		mov    %ecx,%edx
		mov    %ecx,%eax
		sar    $0x1f,%edx
		idiv   %esi
		movl   $0x0,0x50(%ebx)
		mov    %eax,0x54(%ebx)
	jump_116d83:
		mov    (%ebx),%eax
		decl   0x14(%eax)
	jump_116d88:
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116d90:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %ebp
		mov    0x10(%esp),%ebx
		mov    0x18(%esp),%ecx
		test   %ebx,%ebx
		je     jump_116e0f
		mov    (%ebx),%eax
		incl   0x14(%eax)
		mov    0x14(%esp),%eax
		mov    %eax,0x3c(%ebx)
		mov    0x38(%ebx),%eax
		mov    0x3c(%ebx),%esi
		cmp    %esi,%eax
		jne    jump_116dbe
		mov    (%ebx),%eax
		decl   0x14(%eax)
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret
	jump_116dbe:
		test   %ecx,%ecx
		jne    jump_116dc7
		mov    %esi,0x38(%ebx)
		jmp    jump_116dfd
	jump_116dc7:
		mov    %ecx,%eax
		shl    $0x5,%eax
		sub    %ecx,%eax
		lea    0x0(,%eax,4),%eax
		add    %eax,%ecx
		mov    0x38(%ebx),%eax
		sub    %esi,%eax
		lea    0x0(,%ecx,8),%ecx
		cltd
		xor    %edx,%eax
		sub    %edx,%eax
		mov    %eax,%esi
		mov    %ecx,%edx
		mov    %ecx,%eax
		sar    $0x1f,%edx
		idiv   %esi
		movl   $0x0,0x40(%ebx)
		mov    %eax,0x44(%ebx)
	jump_116dfd:
		push   %ebx
		call   func_115660
		mov    (%ebx),%eax
		mov    0x14(%eax),%ebp
		dec    %ebp
		add    $0x4,%esp
		mov    %ebp,0x14(%eax)
	jump_116e0f:
		pop    %ebp
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_116e20:
/*----------------------------------------------------------------*/
		mov    0x4(%esp),%eax
		test   %eax,%eax
		jne    jump_116e29
		ret
	jump_116e29:
		mov    0x4(%eax),%eax
		ret


/*----------------------------------------------------------------*/
AIL_API_set_XMIDI_master_volume:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%edi
		mov    0x14(%esp),%ebx
		cmp    0x1b0(%edi),%ebx
		je     jump_116eb3
		mov    %ebx,0x1b0(%edi)
		incl   0x14(%edi)
		mov    0x1c(%edi),%esi
		mov    0x18(%edi),%ebx
		test   %esi,%esi
		je     jump_116eb0
	jump_116e96:
		cmpl   $0x4,0x4(%ebx)
		jne    jump_116ea5
		push   %ebx
		call   func_115660
		add    $0x4,%esp
	jump_116ea5:
		dec    %esi
		add    $0x718,%ebx
		test   %esi,%esi
		jne    jump_116e96
	jump_116eb0:
		decl   0x14(%edi)
	jump_116eb3:
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117100:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%edx
		test   %edx,%edx
		je     jump_11716b
		mov    (%edx),%eax
		mov    0x14(%eax),%ebx
		inc    %ebx
		mov    data_1ed844,%edi
		mov    %ebx,0x14(%eax)
		xor    %ecx,%ecx
		mov    0x5c(%edx),%ebx
		mov    0x60(%edx),%esi
		mov    0x6c(%edx),%eax
		test   %edi,%edi
		jle    jump_11714c
	jump_11712a:
		mov    0x68(%edx),%edi
		mov    0x70(%edx),%ebp
		add    %edi,%eax
		cmp    %ebp,%eax
		jl     jump_117141
		inc    %ebx
		sub    %ebp,%eax
		cmp    0x64(%edx),%ebx
		jl     jump_117141
		inc    %esi
		xor    %ebx,%ebx
	jump_117141:
		mov    data_1ed844,%ebp
		inc    %ecx
		cmp    %ebp,%ecx
		jl     jump_11712a
	jump_11714c:
		test   %esi,%esi
		jge    jump_117152
		xor    %esi,%esi
	jump_117152:
		mov    0x1c(%esp),%eax
		test   %eax,%eax
		je     jump_11715c
		mov    %esi,(%eax)
	jump_11715c:
		mov    0x18(%esp),%ecx
		test   %ecx,%ecx
		je     jump_117166
		mov    %ebx,(%ecx)
	jump_117166:
		mov    (%edx),%eax
		decl   0x14(%eax)
	jump_11716b:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117170:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%edi
		mov    0x18(%esp),%esi
		test   %edi,%edi
		je     jump_1171f9
		mov    0xc(%edi),%edx
		test   %edx,%edx
		je     jump_1171f9
		mov    %edx,%eax
		lea    0xa(%edx),%ebp
		movswl 0x8(%edx),%ecx
		xor    %edx,%eax
		test   %ecx,%ecx
		jle    jump_1171b1
		mov    %ebp,%edx
	jump_1171a0:
		xor    %ebx,%ebx
		mov    (%edx),%bx
		cmp    %esi,%ebx
		je     jump_1171b1
		inc    %eax
		add    $0x6,%edx
		cmp    %ecx,%eax
		jl     jump_1171a0
	jump_1171b1:
		cmp    %ecx,%eax
		je     jump_1171f9
		mov    %eax,%edx
		lea    0x0(,%eax,4),%eax
		sub    %edx,%eax
		add    %eax,%eax
		add    %eax,%ebp
		mov    0x10(%edi),%eax
		mov    0x2(%ebp),%edx
		add    $0x8,%eax
		movl   $0x0,0x30(%edi)
		add    %edx,%eax
		mov    data_1ed848,%ebx
		mov    %eax,0x14(%edi)
		test   %ebx,%ebx
		jne    jump_1171f9
		mov    %edi,%eax
		lea    0x10(%edi),%edx
	jump_1171e8:
		add    $0x4,%eax
		movl   $0xffffffff,0x80(%eax)
		cmp    %edx,%eax
		jne    jump_1171e8
	jump_1171f9:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117220:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		test   %eax,%eax
		je     jump_117235
		mov    0xc(%esp),%ebx
		mov    0x20(%eax),%edx
		mov    %ebx,0x20(%eax)
		mov    %edx,%eax
	jump_117235:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117310:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x8,%esp
		mov    0x1c(%esp),%eax
		mov    $0xffffffff,%edi
		mov    $0x7fffffff,%esi
		mov    0x14(%eax),%edx
		add    $0x20,%eax
		inc    %edx
		mov    $0x8,%ebx
		mov    %edx,-0xc(%eax)
		mov    $0x1,%ebp
	jump_117339:
		cmp    $0x9,%ebx
		je     jump_117358
		mov    0x20(%eax),%ecx
		cmp    %ecx,%ebp
		je     jump_117358
		cmp    $0x2,%ecx
		je     jump_117358
		mov    0x160(%eax),%ecx
		cmp    %ecx,%esi
		jle    jump_117358
		mov    %ecx,%esi
		mov    %ebx,%edi
	jump_117358:
		dec    %ebx
		sub    $0x4,%eax
		cmp    $0x1,%ebx
		jge    jump_117339
		cmp    $0xffffffff,%edi
		jne    jump_117398
		mov    0x1c(%esp),%eax
		mov    $0x8,%ebx
		add    $0x20,%eax
		mov    $0x1,%ebp
	jump_117377:
		cmp    $0x9,%ebx
		je     jump_11738f
		cmp    0x20(%eax),%ebp
		je     jump_11738f
		mov    0x160(%eax),%ecx
		cmp    %ecx,%esi
		jle    jump_11738f
		mov    %ecx,%esi
		mov    %ebx,%edi
	jump_11738f:
		dec    %ebx
		sub    $0x4,%eax
		cmp    $0x1,%ebx
		jge    jump_117377
	jump_117398:
		cmp    $0xffffffff,%edi
		jne    jump_1173af
		mov    0x1c(%esp),%ebx
		mov    0x14(%ebx),%edx
		dec    %edx
		xor    %eax,%eax
		mov    %edx,0x14(%ebx)
		jmp    jump_117490
	jump_1173af:
		push   $0x0
		mov    %edi,%eax
		push   $0x40
		or     $0xb0,%al
		push   %eax
		mov    0x28(%esp),%esi
		push   %esi
		call   func_114800
		add    $0x10,%esp
		mov    0x1c(%esi),%eax
		mov    %eax,0x4(%esp)
		mov    0x18(%esi),%esi
		test   %eax,%eax
		je     jump_117456
		lea    0x80(%esi),%eax
		mov    %eax,(%esp)
	jump_1173e0:
		cmpl   $0x1,0x4(%esi)
		je     jump_117437
		mov    (%esp),%ebp
		mov    %esi,%ebx
		lea    0x0(%eax),%eax
		mov    %ecx,%ecx
	jump_1173f0:
		mov    0x558(%ebx),%eax
		cmp    $0xffffffff,%eax
		je     jump_117430
		cmp    0x94(%esi,%eax,4),%edi
		jne    jump_117430
		push   $0x0
		push   $0x0
		mov    0x5d8(%ebx),%ecx
		push   %ecx
		or     $0x80,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
		movl   $0xffffffff,0x558(%ebx)
		lea    0x0(%eax),%eax
		lea    0x0(%edx),%edx
		mov    %ebx,%ebx
	jump_117430:
		add    $0x4,%ebx
		cmp    %ebp,%ebx
		jne    jump_1173f0
	jump_117437:
		mov    0x4(%esp),%ebx
		mov    (%esp),%ecx
		add    $0x718,%esi
		dec    %ebx
		add    $0x718,%ecx
		mov    %ebx,0x4(%esp)
		mov    %ecx,(%esp)
		test   %ebx,%ebx
		jne    jump_1173e0
	jump_117456:
		mov    0x1c(%esp),%edx
		lea    0x0(,%edi,4),%eax
		add    %edx,%eax
		movl   $0x0,0x60(%eax)
		mov    0x20(%eax),%ebx
		movl   $0x1,0x20(%eax)
		mov    %ebx,0x120(%eax)
		mov    0xe0(%eax),%ebx
		mov    %ebx,0xa0(%eax)
		mov    0x14(%edx),%ebx
		dec    %ebx
		lea    0x1(%edi),%eax
		mov    %ebx,0x14(%edx)
	jump_117490:
		add    $0x8,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1174a0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x8,%esp
		mov    0x20(%esp),%ebp
		dec    %ebp
		mov    0x1c(%esp),%edx
		lea    0x0(,%ebp,4),%eax
		add    %edx,%eax
		mov    0x20(%eax),%ebx
		cmp    $0x1,%ebx
		jne    jump_1175b8
		add    %ebx,0x14(%edx)
		mov    0x120(%eax),%ebx
		mov    %ebx,0x20(%eax)
		mov    0xa0(%eax),%ebx
		push   $0x0
		mov    %ebx,0xe0(%eax)
		mov    %ebp,%eax
		push   $0x40
		or     $0xb0,%al
		push   %eax
		push   %edx
		mov    %edx,%esi
		call   func_114800
		mov    %esi,%eax
		add    $0x10,%esp
		mov    0x1c(%eax),%eax
		mov    0x18(%esi),%esi
		mov    %eax,0x4(%esp)
		test   %eax,%eax
		je     jump_117586
		lea    0x80(%esi),%eax
		mov    %eax,(%esp)
	jump_11750e:
		cmpl   $0x1,0x4(%esi)
		je     jump_117567
		mov    (%esp),%edi
		mov    %esi,%ebx
		lea    0x0(%eax),%eax
		nop
	jump_117520:
		mov    0x558(%ebx),%edx
		cmp    $0xffffffff,%edx
		je     jump_117560
		mov    %edx,%eax
		cmp    0x94(%esi,%eax,4),%ebp
		jne    jump_117560
		push   $0x0
		push   $0x0
		mov    0x5d8(%ebx),%eax
		push   %eax
		mov    %edx,%eax
		or     $0x80,%al
		push   %eax
		push   %esi
		call   func_114de0
		add    $0x14,%esp
		movl   $0xffffffff,0x558(%ebx)
		lea    0x0(%eax),%eax
		nop
	jump_117560:
		add    $0x4,%ebx
		cmp    %edi,%ebx
		jne    jump_117520
	jump_117567:
		mov    0x4(%esp),%eax
		mov    (%esp),%edx
		add    $0x718,%esi
		dec    %eax
		add    $0x718,%edx
		mov    %eax,0x4(%esp)
		mov    %edx,(%esp)
		test   %eax,%eax
		jne    jump_11750e
	jump_117586:
		mov    0x1c(%esp),%ecx
		lea    0x0(,%ebp,4),%eax
		add    %ecx,%eax
		mov    0xa0(%eax),%esi
		test   %esi,%esi
		je     jump_1175b1
		mov    0x4(%esi),%edi
		mov    %esi,%eax
		cmp    $0x1,%edi
		je     jump_1175b1
		push   %ebp
		push   %esi
		call   func_115340
		add    $0x8,%esp
	jump_1175b1:
		mov    0x1c(%esp),%eax
		decl   0x14(%eax)
	jump_1175b8:
		add    $0x8,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_1175c0:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0x8(%esp),%eax
		mov    0x10(%esp),%ebx
		test   %eax,%eax
		je     jump_1175f4
		mov    0xc(%esp),%edx
		lea    -0x1(%ebx),%ecx
		mov    %ecx,0x90(%eax,%edx,4)
		lea    0x0(,%ebx,4),%edx
		mov    (%eax),%ebx
		add    %ebx,%edx
		cmpl   $0x1,0x1c(%edx)
		jne    jump_1175f4
		cmp    0x5c(%edx),%eax
		je     jump_1175f4
		mov    %eax,0x5c(%edx)
	jump_1175f4:
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117620:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x14(%esp),%ebx
		mov    0x18(%esp),%eax
		mov    0x1c(%esp),%ebp
		mov    0x20(%esp),%edi
		mov    0x24(%esp),%esi
		incl   0x14(%ebx)
		test   %eax,%eax
		jne    jump_1176a7
		mov    %ebp,%eax
		and    $0xf0,%eax
		cmp    $0xb0,%eax
		jne    jump_11767d
		cmp    $0x7,%edi
		jne    jump_11767d
		mov    0x1b0(%ebx),%edx
		imul   %esi,%edx
		mov    $0x7f,%esi
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %esi
		mov    %eax,%esi
		cmp    $0x7f,%eax
		jle    jump_117677
		mov    $0x7f,%esi
	jump_117677:
		test   %esi,%esi
		jge    jump_11767d
		xor    %esi,%esi
	jump_11767d:
		cmpl   $0x0,0x1a0(%ebx)
		je     jump_117699
		push   %esi
		push   %edi
		push   %ebp
		push   $0x0
		push   %ebx
		call   *0x1a0(%ebx)
		add    $0x14,%esp
		test   %eax,%eax
		jne    jump_1176b5
	jump_117699:
		push   %esi
		push   %edi
		push   %ebp
		push   %ebx
		call   func_114800
		add    $0x10,%esp
		jmp    jump_1176b5
	jump_1176a7:
		push   $0x0
		push   %esi
		push   %edi
		push   %ebp
		push   %eax
		call   func_114de0
		add    $0x14,%esp
	jump_1176b5:
		push   %ebx
		call   func_1147b0
		mov    0x14(%ebx),%esi
		dec    %esi
		add    $0x4,%esp
		mov    %esi,0x14(%ebx)
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILXMIDI_end_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15ab60
		je     jump_11781f
		push   $AILXMIDI_end_
		push   $AILXMIDI_start_
		call   VMM_unlock_range
		add    $0x8,%esp
		push   $0x80
		push   $data_15aadc
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_15ab5c
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8f8
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8fc
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed904
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed910
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed908
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed90c
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8f4
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8e8
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8f0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8ec
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8e0
		call   AIL_vmm_unlock
		add    $0x8,%esp
		push   $0x4
		push   $data_1ed8e4
		xor    %ebx,%ebx
		call   AIL_vmm_unlock
		add    $0x8,%esp
		mov    %ebx,data_15ab60
	jump_11781f:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret

.section .rodata

data_117830:
		.ascii  "\x08\x00\x00\x00\x11\x00\x00\x00"
		.ascii  "\x12\x00\x00\x00\x13\x00\x00\x00"
		.ascii  "\x14\x00\x00\x00\x15\x00\x00\x00"
		.ascii  "\x17\x00\x00\x00\x18\x00\x00\x00"
		.ascii  "\x1a\x00\x00\x00\x1b\x00\x00\x00"
		.ascii  "\x1d\x00\x00\x00\x1e\x00\x00\x00"
		.ascii  "\x20\x00\x00\x00\x22\x00\x00\x00"
		.ascii  "\x24\x00\x00\x00\x26\x00\x00\x00"
		.ascii  "\x29\x00\x00\x00\x2b\x00\x00\x00"
		.ascii  "\x2e\x00\x00\x00\x31\x00\x00\x00"
		.ascii  "\x33\x00\x00\x00\x37\x00\x00\x00"
		.ascii  "\x3a\x00\x00\x00\x3d\x00\x00\x00"
		.ascii  "\x41\x00\x00\x00\x45\x00\x00\x00"
		.ascii  "\x49\x00\x00\x00\x4d\x00\x00\x00"
		.ascii  "\x52\x00\x00\x00\x57\x00\x00\x00"
		.ascii  "\x5c\x00\x00\x00\x62\x00\x00\x00"
		.ascii  "\x67\x00\x00\x00\x6e\x00\x00\x00"
		.ascii  "\x74\x00\x00\x00\x7b\x00\x00\x00"
		.ascii  "\x82\x00\x00\x00\x8a\x00\x00\x00"
		.ascii  "\x92\x00\x00\x00\x9b\x00\x00\x00"
		.ascii  "\xa4\x00\x00\x00\xae\x00\x00\x00"
		.ascii  "\xb9\x00\x00\x00\xc4\x00\x00\x00"
		.ascii  "\xcf\x00\x00\x00\xdc\x00\x00\x00"
		.ascii  "\xe9\x00\x00\x00\xf7\x00\x00\x00"
		.ascii  "\x05\x01\x00\x00\x15\x01\x00\x00"
		.ascii  "\x25\x01\x00\x00\x37\x01\x00\x00"
		.ascii  "\x49\x01\x00\x00\x5d\x01\x00\x00"
		.ascii  "\x72\x01\x00\x00\x88\x01\x00\x00"
		.ascii  "\x9f\x01\x00\x00\xb8\x01\x00\x00"
		.ascii  "\xd2\x01\x00\x00\xed\x01\x00\x00"
		.ascii  "\x0b\x02\x00\x00\x2a\x02\x00\x00"
		.ascii  "\x4b\x02\x00\x00\x6e\x02\x00\x00"
		.ascii  "\x93\x02\x00\x00\xba\x02\x00\x00"
		.ascii  "\xe4\x02\x00\x00\x10\x03\x00\x00"
		.ascii  "\x3e\x03\x00\x00\x70\x03\x00\x00"
		.ascii  "\xa4\x03\x00\x00\xdb\x03\x00\x00"
		.ascii  "\x16\x04\x00\x00\x54\x04\x00\x00"
		.ascii  "\x96\x04\x00\x00\xdc\x04\x00\x00"
		.ascii  "\x26\x05\x00\x00\x74\x05\x00\x00"
		.ascii  "\xc8\x05\x00\x00\x20\x06\x00\x00"
		.ascii  "\x7d\x06\x00\x00\xe0\x06\x00\x00"
		.ascii  "\x48\x07\x00\x00\xb7\x07\x00\x00"
		.ascii  "\x2d\x08\x00\x00\xa9\x08\x00\x00"
		.ascii  "\x2d\x09\x00\x00\xb8\x09\x00\x00"
		.ascii  "\x4c\x0a\x00\x00\xe9\x0a\x00\x00"
		.ascii  "\x90\x0b\x00\x00\x40\x0c\x00\x00"
		.ascii  "\xfa\x0c\x00\x00\xc0\x0d\x00\x00"
		.ascii  "\x91\x0e\x00\x00\x6f\x0f\x00\x00"
		.ascii  "\x5a\x10\x00\x00\x53\x11\x00\x00"
		.ascii  "\x5b\x12\x00\x00\x71\x13\x00\x00"
		.ascii  "\x99\x14\x00\x00\xd3\x15\x00\x00"
		.ascii  "\x20\x17\x00\x00\x80\x18\x00\x00"
		.ascii  "\xf4\x19\x00\x00\x80\x1b\x00\x00"
		.ascii  "\x23\x1d\x00\x00\xde\x1e\x00\x00"
		.ascii  "\xb4\x20\x00\x00\xa6\x22\x00\x00"
		.ascii  "\xb6\x24\x00\x00\xe3\x26\x00\x00"
		.ascii  "\x33\x29\x00\x00\xa6\x2b\x00\x00"
		.ascii  "\x40\x2e\x00\x00\x00\x31\x00\x00"
		.ascii  "\xe9\x33\x00\x00\x00\x37\x00\x00"
		.ascii  "\x46\x3a\x00\x00\xbc\x3d\x00\x00"
		.ascii  "\x69\x41\x00\x00\x4c\x45\x00\x00"
		.ascii  "\x6c\x49\x00\x00\xc6\x4d\x00\x00"
		.ascii  "\x66\x52\x00\x00\x4c\x57\x00\x00"
		.ascii  "\x80\x5c\x00\x00\x00\x62\x00\x00"
.text


/*----------------------------------------------------------------*/
AILXDIG_start_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15ab70
		jne    jump_117a59
		push   $AILXDIG_end_
		push   $AILXDIG_start_
		mov    $0x1,%ebx
		call   VMM_lock_range
		add    $0x8,%esp
		mov    %ebx,data_15ab70
	jump_117a59:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117a60:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		mov    0x10(%esp),%esi
		mov    0x14(%esp),%ecx
		mov    0x18(%esp),%eax
		mov    0x1c(%esp),%edx
		mov    %ecx,%edi
		and    $0xf,%ecx
		lea    0x0(,%ecx,4),%ebx
		and    $0xf0,%edi
		add    %esi,%ebx
		cmp    $0xc0,%edi
		jb     jump_117a9d
		jbe    jump_117aa9
		cmp    $0xe0,%edi
		je     jump_117ab4
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117a9d:
		cmp    $0xb0,%edi
		je     jump_117aca
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117aa9:
		and    $0xff,%eax
		mov    %eax,(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117ab4:
		and    $0xff,%eax
		mov    %eax,0x40(%ebx)
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x80(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117aca:
		cmp    $0x5b,%eax
		jb     jump_117b1b
		jbe    jump_117c01
		cmp    $0x70,%eax
		jb     jump_117b05
		jbe    jump_117b7f
		cmp    $0x73,%eax
		jb     jump_117af8
		jbe    jump_117b9b
		cmp    $0x77,%eax
		je     jump_117ba9
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117af8:
		cmp    $0x72,%eax
		je     jump_117b8d
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b05:
		cmp    $0x6e,%eax
		jb     jump_117b0e
		jbe    jump_117b63
		jmp    jump_117b71
	jump_117b0e:
		cmp    $0x5d,%eax
		je     jump_117c0f
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b1b:
		cmp    $0x7,%eax
		jb     jump_117b4b
		jbe    jump_117bc6
		cmp    $0xb,%eax
		jb     jump_117b3e
		jbe    jump_117be4
		cmp    $0x40,%eax
		je     jump_117bf3
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b3e:
		cmp    $0xa,%eax
		je     jump_117bd5
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b4b:
		cmp    $0x1,%eax
		jb     jump_117c28
		jbe    jump_117bb7
		cmp    $0x6,%eax
		je     jump_117c1d
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b63:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0xc0(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b71:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x100(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b7f:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x180(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b8d:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x1c0(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117b9b:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x200(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117ba9:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x240(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117bb7:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x280(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117bc6:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x2c0(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117bd5:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x300(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117be4:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x340(%esi,%ecx,4)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117bf3:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x380(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117c01:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x3c0(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117c0f:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x400(%ebx)
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117c1d:
		xor    %eax,%eax
		mov    %dl,%al
		mov    %eax,0x440(%esi,%ecx,4)
	jump_117c28:
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117c30:
/*----------------------------------------------------------------*/
		push   %ecx
		push   %esi
		mov    %edx,%ecx
		xor    %edx,%edx
	jump_117c36:
		mov    (%eax),%esi
		cmp    $0xffffffff,%esi
		je     jump_117c52
		cmp    %esi,%ecx
		jne    jump_117c46
		cmp    0x4(%eax),%ebx
		je     jump_117c54
	jump_117c46:
		inc    %edx
		add    $0x20,%eax
		cmp    $0x200,%edx
		jl     jump_117c36
	jump_117c52:
		xor    %eax,%eax
	jump_117c54:
		pop    %esi
		pop    %ecx
		ret


/*----------------------------------------------------------------*/
func_117c60:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %esi
		push   %edi
		push   %ebp
		lea    0x0(,%edx,4),%edx
		lea    (%eax,%edx,1),%ebx
		mov    0x518(%ebx),%edx
		lea    0x0(,%edx,4),%edx
		lea    (%eax,%edx,1),%esi
		mov    0x2d4(%esi),%edx
		imul   0x354(%esi),%edx
		mov    $0x7f,%ecx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ecx
		mov    0x618(%ebx),%edx
		imul   %eax,%edx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ecx
		push   %eax
		mov    0x4d4(%ebx),%edi
		push   %edi
		call   AIL_set_sample_volume
		add    $0x8,%esp
		mov    0x314(%esi),%ebp
		push   %ebp
		mov    0x4d4(%ebx),%eax
		push   %eax
		call   AIL_set_sample_pan
		add    $0x8,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117ce0:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %esi
		push   %edi
		push   %ebp
		sub    $0x10,%esp
		mov    %eax,%esi
		mov    %edx,0xc(%esp)
		mov    %edx,%eax
		mov    0x518(%esi,%eax,4),%edi
		mov    0x598(%esi,%eax,4),%edx
		mov    0x5d8(%esi,%eax,4),%ebx
		mov    %edx,(%esp)
		mov    0x558(%esi,%eax,4),%eax
		mov    0x94(%esi,%edi,4),%edx
		mov    %eax,0x8(%esp)
		shl    $0x7,%edx
		mov    0x54(%esi,%edi,4),%eax
		or     %edx,%eax
		cmp    $0x2000,%eax
		jle    jump_117d36
		mov    $0x1,%edx
		sub    $0x1fff,%eax
		jmp    jump_117d4c
	jump_117d36:
		jge    jump_117d48
		mov    $0x2000,%edx
		sub    %eax,%edx
		mov    %edx,%eax
		mov    $0xffffffff,%edx
		jmp    jump_117d4c
	jump_117d48:
		xor    %eax,%eax
		xor    %edx,%edx
	jump_117d4c:
		imul   0x454(%esi,%edi,4),%edx
		add    0x8(%esp),%edx
		test   %edx,%edx
		jge    jump_117d5e
		xor    %edx,%edx
	jump_117d5e:
		cmp    $0x7f,%edx
		jle    jump_117d68
		mov    $0x7f,%edx
	jump_117d68:
		mov    (%esp),%ecx
		mov    data_117830(,%ecx,4),%ecx
		mov    %ecx,0x4(%esp)
		mov    0x8(%esp),%ecx
		mov    data_117830(,%edx,4),%edx
		mov    data_117830(,%ecx,4),%ecx
		sub    %ecx,%edx
		imul   %eax,%edx
		mov    %edx,%eax
		sar    $0x1f,%edx
		shl    $0xd,%edx
		sbb    %edx,%eax
		sar    $0xd,%eax
		lea    (%ecx,%eax,1),%ebp
		cmp    $0x9,%edi
		je     jump_117db9
		mov    %ebx,%edx
		imul   %ecx,%edx
		mov    0x4(%esp),%ebx
		mov    %edx,%eax
		sar    $0x1f,%edx
		idiv   %ebx
		imul   %ebp,%eax
		mov    %eax,%edx
		jmp    jump_117dc0
	jump_117db9:
		mov    %ebx,%edx
		imul   %ebp,%edx
		mov    %edx,%eax
	jump_117dc0:
		sar    $0x1f,%edx
		idiv   %ecx
		mov    %eax,%ebx
		mov    0xc(%esp),%eax
		push   %ebx
		mov    0x4d4(%esi,%eax,4),%ecx
		push   %ecx
		call   AIL_set_sample_playback_rate
		add    $0x8,%esp
		add    $0x10,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117df0:
/*----------------------------------------------------------------*/
		push   %ebx
		mov    0xc(%esp),%edx
		mov    0x8(%esp),%eax
		mov    0x1b4(%eax),%eax
		mov    0x10(%esp),%ebx
		mov    0x8(%eax),%eax
		call   func_117c30
		test   %eax,%eax
		setne  %al
		and    $0xff,%eax
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
func_117e20:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ebp
		mov    0x1c(%esp),%eax
		mov    0x14(%esp),%esi
		mov    %eax,%ebx
		mov    %eax,%edi
		and    $0xf0,%ebx
		and    $0xf,%edi
		mov    0x1b4(%esi),%esi
		cmp    $0xb0,%ebx
		je     jump_117e57
		cmp    $0xc0,%ebx
		je     jump_117e57
		cmp    $0xe0,%ebx
		jne    jump_117e6e
	jump_117e57:
		mov    0x24(%esp),%edx
		push   %edx
		mov    0x24(%esp),%ecx
		push   %ecx
		push   %eax
		lea    0x14(%esi),%eax
		push   %eax
		call   func_117a60
		add    $0x10,%esp
	jump_117e6e:
		cmp    $0x90,%ebx
		jne    jump_117e82
		cmpl   $0x0,0x24(%esp)
		jne    jump_117e82
		mov    $0x80,%ebx
	jump_117e82:
		lea    0x0(,%edi,4),%ebp
		add    %esi,%ebp
		cmp    $0xb0,%ebx
		jb     jump_117eb8
		jbe    jump_117edb
		cmp    $0xc0,%ebx
		jb     jump_118234
		jbe    jump_117ff7
		cmp    $0xe0,%ebx
		je     jump_118016
		jmp    jump_118234
	jump_117eb8:
		cmp    $0x80,%ebx
		jb     jump_118234
		jbe    jump_1181d2
		cmp    $0x90,%ebx
		je     jump_118061
		jmp    jump_118234
	jump_117edb:
		mov    0x20(%esp),%edx
		cmp    $0x7,%edx
		jb     jump_117f04
		jbe    jump_117f10
		cmp    $0xa,%edx
		jb     jump_118234
		cmp    $0xb,%edx
		jbe    jump_117f10
		cmp    $0x7b,%edx
		je     jump_117fa6
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117f04:
		cmp    $0x6,%edx
		je     jump_117f5b
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_117f10:
		mov    0x514(%esi),%ecx
		xor    %ebx,%ebx
		test   %ecx,%ecx
		jle    jump_118234
		mov    %esi,%ebp
	jump_117f22:
		cmp    0x518(%ebp),%edi
		jne    jump_117f47
		mov    0x4d4(%ebp),%edx
		push   %edx
		call   ail_sample_status
		add    $0x4,%esp
		cmp    $0x4,%eax
		jne    jump_117f47
		mov    %ebx,%edx
		mov    %esi,%eax
		call   func_117c60
	jump_117f47:
		inc    %ebx
		mov    0x514(%esi),%ecx
		add    $0x4,%ebp
		cmp    %ecx,%ebx
		jge    jump_118234
		jmp    jump_117f22
	jump_117f5b:
		mov    0x514(%esi),%eax
		xor    %ebx,%ebx
		test   %eax,%eax
		jle    jump_118234
		mov    %esi,%ebp
	jump_117f6d:
		cmp    0x518(%ebp),%edi
		jne    jump_117f92
		mov    0x4d4(%ebp),%edx
		push   %edx
		call   ail_sample_status
		add    $0x4,%esp
		cmp    $0x4,%eax
		jne    jump_117f92
		mov    %ebx,%edx
		mov    %esi,%eax
		call   func_117ce0
	jump_117f92:
		inc    %ebx
		mov    0x514(%esi),%ecx
		add    $0x4,%ebp
		cmp    %ecx,%ebx
		jge    jump_118234
		jmp    jump_117f6d
	jump_117fa6:
		mov    0x514(%esi),%edx
		xor    %ebp,%ebp
		test   %edx,%edx
		jle    jump_118234
		mov    %esi,%ebx
	jump_117fb8:
		cmp    0x518(%ebx),%edi
		jne    jump_117fe3
		mov    0x4d4(%ebx),%eax
		push   %eax
		call   ail_sample_status
		add    $0x4,%esp
		cmp    $0x4,%eax
		jne    jump_117fe3
		mov    0x4d4(%ebx),%edx
		push   %edx
		call   AIL_end_sample
		add    $0x4,%esp
	jump_117fe3:
		inc    %ebp
		mov    0x514(%esi),%edx
		add    $0x4,%ebx
		cmp    %edx,%ebp
		jge    jump_118234
		jmp    jump_117fb8
	jump_117ff7:
		mov    0x20(%esp),%ebx
		mov    0x1d4(%ebp),%edx
		mov    0x8(%esi),%eax
		call   func_117c30
		mov    %eax,0x494(%ebp)
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_118016:
		mov    0x514(%esi),%eax
		xor    %ebx,%ebx
		test   %eax,%eax
		jle    jump_118234
		mov    %esi,%ebp
	jump_118028:
		cmp    0x518(%ebp),%edi
		jne    jump_11804d
		mov    0x4d4(%ebp),%eax
		push   %eax
		call   ail_sample_status
		add    $0x4,%esp
		cmp    $0x4,%eax
		jne    jump_11804d
		mov    %ebx,%edx
		mov    %esi,%eax
		call   func_117ce0
	jump_11804d:
		inc    %ebx
		mov    0x514(%esi),%edx
		add    $0x4,%ebp
		cmp    %edx,%ebx
		jge    jump_118234
		jmp    jump_118028
	jump_118061:
		cmp    $0x9,%edi
		jne    jump_11807d
		mov    0x20(%esp),%ebx
		mov    $0x7f,%edx
		mov    0x8(%esi),%eax
		call   func_117c30
		mov    %eax,0x494(%ebp)
	jump_11807d:
		cmpl   $0x0,0x494(%esi,%edi,4)
		je     jump_118234
		mov    0x514(%esi),%ecx
		xor    %ebx,%ebx
		test   %ecx,%ecx
		jle    jump_1180bb
		mov    %esi,%ebp
	jump_118099:
		mov    0x4d4(%ebp),%eax
		push   %eax
		call   ail_sample_status
		add    $0x4,%esp
		cmp    $0x2,%eax
		je     jump_1180bb
		inc    %ebx
		mov    0x514(%esi),%ecx
		add    $0x4,%ebp
		cmp    %ecx,%ebx
		jl     jump_118099
	jump_1180bb:
		cmp    0x514(%esi),%ebx
		jne    jump_1180fe
		mov    $0xffffffff,%edx
		mov    %ebx,%ecx
		xor    %ebp,%ebp
		test   %ecx,%ecx
		jle    jump_1180ee
		mov    %esi,%eax
	jump_1180d2:
		mov    0x658(%eax),%ecx
		cmp    %ecx,%edx
		jb     jump_1180e0
		mov    %ecx,%edx
		mov    %ebp,%ebx
	jump_1180e0:
		inc    %ebp
		mov    0x514(%esi),%ecx
		add    $0x4,%eax
		cmp    %ecx,%ebp
		jl     jump_1180d2
	jump_1180ee:
		mov    0x4d4(%esi,%ebx,4),%ebp
		push   %ebp
		call   AIL_end_sample
		add    $0x4,%esp
	jump_1180fe:
		mov    0x20(%esp),%eax
		mov    %edi,0x518(%esi,%ebx,4)
		mov    %eax,0x558(%esi,%ebx,4)
		mov    0x494(%esi,%edi,4),%eax
		mov    0x8(%eax),%eax
		mov    %eax,0x598(%esi,%ebx,4)
		mov    0x494(%esi,%edi,4),%eax
		mov    0x1c(%eax),%eax
		mov    %eax,0x5d8(%esi,%ebx,4)
		mov    0x24(%esp),%eax
		mov    %eax,0x618(%esi,%ebx,4)
		mov    0x698(%esi),%eax
		lea    0x1(%eax),%edx
		mov    %edx,0x698(%esi)
		mov    0x4d4(%esi,%ebx,4),%ebp
		push   %ebp
		mov    %eax,0x658(%esi,%ebx,4)
		call   AIL_init_sample
		mov    0x494(%esi,%edi,4),%eax
		add    $0x4,%esp
		mov    0x18(%eax),%edx
		push   %edx
		mov    0x14(%eax),%ecx
		push   %ecx
		mov    0x4d4(%esi,%ebx,4),%ebp
		push   %ebp
		call   AIL_set_sample_type
		mov    0x494(%esi,%edi,4),%eax
		add    $0xc,%esp
		mov    0x10(%eax),%edx
		push   %edx
		mov    0xc(%eax),%eax
		mov    0x8(%esi),%edx
		add    %edx,%eax
		push   %eax
		mov    0x4d4(%esi,%ebx,4),%ecx
		push   %ecx
		call   AIL_set_sample_address
		add    $0xc,%esp
		mov    %ebx,%edx
		mov    %esi,%eax
		call   func_117ce0
		mov    %ebx,%edx
		mov    %esi,%eax
		call   func_117c60
		mov    0x4d4(%esi,%ebx,4),%edi
		push   %edi
		call   AIL_start_sample
		mov    $0x1,%eax
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_1181d2:
		cmp    $0x9,%edi
		je     jump_118234
		mov    0x514(%esi),%eax
		xor    %ebp,%ebp
		test   %eax,%eax
		jle    jump_118234
		mov    %esi,%ebx
	jump_1181e5:
		cmp    0x518(%ebx),%edi
		jne    jump_118226
		mov    0x20(%esp),%ecx
		cmp    0x558(%ebx),%ecx
		jne    jump_118226
		mov    0x4d4(%ebx),%eax
		push   %eax
		call   ail_sample_status
		add    $0x4,%esp
		cmp    $0x4,%eax
		jne    jump_118226
		mov    0x4d4(%ebx),%edx
		push   %edx
		call   AIL_end_sample
		mov    $0x1,%eax
		add    $0x4,%esp
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret
	jump_118226:
		inc    %ebp
		mov    0x514(%esi),%eax
		add    $0x4,%ebx
		cmp    %eax,%ebp
		jl     jump_1181e5
	jump_118234:
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
AILXDIG_end_:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpl   $0x0,data_15ab70
		je     jump_118456
		push   $AILXDIG_end_
		push   $AILXDIG_start_
		xor    %ebx,%ebx
		call   VMM_unlock_range
		add    $0x8,%esp
		mov    %ebx,data_15ab70
	jump_118456:
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


vtable_11c07c:
		.long   snd_DC_0
		.long   snd_DC_1
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   snd_DC_16
		.long   snd_DC_17
		.long   snd_DC_18
		.long   snd_DC_19
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11c6ff
		.long   func_11c71c
		.long   func_11c72e
		.long   func_11c74b
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11c75d
		.long   func_11c771
		.long   0
		.long   0
		.long   func_11c780
		.long   func_11c796
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11c7a7
		.long   func_11c7c8
		.long   func_11c7de
		.long   func_11c7ff
		.long   func_11c815
		.long   func_11c83a
		.long   func_11c854
		.long   func_11c879
		.long   func_11c893
		.long   func_11c8b6
		.long   func_11c8ce
		.long   func_11c8f1
		.long   func_11c909
		.long   func_11c930
		.long   func_11c94c
		.long   func_11c973
		.long   func_11c98f
		.long   func_11c9bc
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11c9e4
		.long   func_11ca3d
		.long   func_11ca8b
		.long   func_11cae4
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11cb32
		.long   func_11cb89
		.long   func_11cbd5
		.long   func_11cc2c
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11cc78
		.long   func_11cca8
		.long   0
		.long   0
		.long   func_11ccd3
		.long   func_11cd05
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11cd32
		.long   func_11cd8d
		.long   func_11cddd
		.long   func_11ce38
		.long   func_11ce88
		.long   func_11cee7
		.long   func_11cf3b
		.long   func_11cf9a
		.long   func_11cfee
		.long   func_11d04b
		.long   func_11d09d
		.long   func_11d0fa
		.long   func_11d14c
		.long   func_11d1ad
		.long   func_11d203
		.long   func_11d264

vtable_11c27c:
		.long   snd_M_0
		.long   snd_M_1
		.long   0
		.long   func_11d305
		.long   0
		.long   0
		.long   0
		.long   func_11d33d
		.long   func_11d375
		.long   func_11d39c
		.long   0
		.long   func_11d3c6
		.long   0
		.long   0
		.long   0
		.long   func_11d400
		.long   func_11d43a
		.long   func_11d459
		.long   0
		.long   func_11d47b
		.long   0
		.long   0
		.long   0
		.long   func_11d4a8
		.long   func_11d4d5
		.long   func_11d4f7
		.long   0
		.long   func_11d51c
		.long   0
		.long   0
		.long   0
		.long   func_11d54b
		.long   func_11d57a
		.long   func_11d5a9
		.long   0
		.long   func_11d5db
		.long   0
		.long   0
		.long   0
		.long   func_11d621
		.long   func_11d667
		.long   func_11d69c
		.long   0
		.long   func_11d6d4
		.long   0
		.long   0
		.long   0
		.long   func_11d71c
		.long   func_11d764
		.long   func_11d78e
		.long   0
		.long   func_11d7bb
		.long   0
		.long   0
		.long   0
		.long   func_11d7f6
		.long   func_11d831
		.long   func_11d861
		.long   0
		.long   func_11d894
		.long   0
		.long   0
		.long   0
		.long   func_11d8d1
		.long   func_11d90e
		.long   func_11d92a
		.long   func_11d950
		.long   func_11d97a
		.long   0
		.long   0
		.long   func_11d9a5
		.long   func_11d9cf
		.long   func_11d9fa
		.long   func_11da27
		.long   func_11da63
		.long   func_11daa9
		.long   0
		.long   0
		.long   func_11daf3
		.long   func_11db39
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11db83
		.long   func_11dbab
		.long   func_11dbe2
		.long   func_11dc1d
		.long   0
		.long   0
		.long   func_11dc5c
		.long   func_11dc97
		.long   func_11dcd6
		.long   func_11dcfd
		.long   func_11dd2e
		.long   func_11dd66
		.long   0
		.long   0
		.long   func_11dd9f
		.long   func_11ddd7
		.long   func_11de10
		.long   func_11de4b
		.long   func_11de95
		.long   func_11dee9
		.long   0
		.long   0
		.long   func_11df41
		.long   func_11df95
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11dfed
		.long   func_11e023
		.long   func_11e068
		.long   func_11e0b1
		.long   0
		.long   0
		.long   func_11e0fe
		.long   func_11e147
		.long   func_11e194
		.long   func_11e1b8
		.long   0
		.long   func_11e1df
		.long   0
		.long   0
		.long   0
		.long   func_11e21b
		.long   func_11e257
		.long   func_11e27e
		.long   0
		.long   func_11e2a8
		.long   0
		.long   0
		.long   0
		.long   func_11e2e6
		.long   func_11e324
		.long   func_11e343
		.long   0
		.long   func_11e365
		.long   0
		.long   0
		.long   0
		.long   func_11e396
		.long   func_11e3c7
		.long   func_11e3e9
		.long   0
		.long   func_11e40e
		.long   0
		.long   0
		.long   0
		.long   func_11e441
		.long   func_11e474
		.long   func_11e4a3
		.long   0
		.long   func_11e4d5
		.long   0
		.long   0
		.long   0
		.long   func_11e51f
		.long   func_11e569
		.long   func_11e59e
		.long   0
		.long   func_11e5d6
		.long   0
		.long   0
		.long   0
		.long   func_11e622
		.long   func_11e66e
		.long   func_11e698
		.long   0
		.long   func_11e6c5
		.long   0
		.long   0
		.long   0
		.long   func_11e704
		.long   func_11e743
		.long   func_11e773
		.long   0
		.long   func_11e7a6
		.long   0
		.long   0
		.long   0
		.long   func_11e7e7
		.long   func_11e828
		.long   func_11e844
		.long   func_11e86a
		.long   func_11e894
		.long   0
		.long   0
		.long   func_11e8c3
		.long   func_11e8ed
		.long   func_11e91c
		.long   func_11e949
		.long   func_11e985
		.long   func_11e9cb
		.long   0
		.long   0
		.long   func_11ea14
		.long   func_11ea5a
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11eaa3
		.long   func_11eacb
		.long   func_11eb02
		.long   func_11eb3d
		.long   0
		.long   0
		.long   func_11eb7b
		.long   func_11ebb6
		.long   func_11ebf4
		.long   func_11ec1b
		.long   func_11ec4c
		.long   func_11ec84
		.long   0
		.long   0
		.long   func_11ecc1
		.long   func_11ecf9
		.long   func_11ed36
		.long   func_11ed71
		.long   func_11edbb
		.long   func_11ee0f
		.long   0
		.long   0
		.long   func_11ee66
		.long   func_11eeba
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   0
		.long   func_11ef11
		.long   func_11ef47
		.long   func_11ef8c
		.long   func_11efd5
		.long   0
		.long   0
		.long   func_11f021
		.long   snd_M_255


/*----------------------------------------------------------------*/
snd_DC_0:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		xor    $0x8000,%eax
		mov    %ah,(%edi)
		inc    %edi
		dec    %ecx
		jne    snd_DC_0
		ret


/*----------------------------------------------------------------*/
snd_DC_1:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		mov    %ah,(%edi)
		inc    %edi
		dec    %ecx
		jne    snd_DC_1
		ret


/*----------------------------------------------------------------*/
snd_DC_16:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ah,%dl
		mov    %dx,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    snd_DC_16
		ret


/*----------------------------------------------------------------*/
snd_DC_17:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %ah,%dl
		mov    %dx,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    snd_DC_17
		ret


/*----------------------------------------------------------------*/
snd_DC_18:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dh,%al
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    snd_DC_18
		ret


/*----------------------------------------------------------------*/
snd_DC_19:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %dh,%al
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    snd_DC_19
		ret


/*----------------------------------------------------------------*/
func_11c6ff:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ah,(%edi)
		mov    %dh,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11c6ff
		ret


/*----------------------------------------------------------------*/
func_11c71c:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %ah,(%edi)
		mov    %dh,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11c71c
		ret


/*----------------------------------------------------------------*/
func_11c72e:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dh,(%edi)
		mov    %ah,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11c72e
		ret


/*----------------------------------------------------------------*/
func_11c74b:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %dh,(%edi)
		mov    %ah,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11c74b
		ret


/*----------------------------------------------------------------*/
func_11c75d:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		xor    $0x8000,%eax
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11c75d
		ret


/*----------------------------------------------------------------*/
func_11c771:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11c771
		ret


/*----------------------------------------------------------------*/
func_11c780:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		xor    $0x8000,%eax
		xchg   %al,%ah
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11c780
		ret


/*----------------------------------------------------------------*/
func_11c796:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		xchg   %al,%ah
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11c796
		ret


/*----------------------------------------------------------------*/
func_11c7a7:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c7a7
		ret


/*----------------------------------------------------------------*/
func_11c7c8:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c7c8
		ret


/*----------------------------------------------------------------*/
func_11c7de:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c7de
		ret


/*----------------------------------------------------------------*/
func_11c7ff:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c7ff
		ret


/*----------------------------------------------------------------*/
func_11c815:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c815
		ret


/*----------------------------------------------------------------*/
func_11c83a:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c83a
		ret


/*----------------------------------------------------------------*/
func_11c854:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c854
		ret


/*----------------------------------------------------------------*/
func_11c879:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11c879
		ret


/*----------------------------------------------------------------*/
func_11c893:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c893
		ret


/*----------------------------------------------------------------*/
func_11c8b6:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c8b6
		ret


/*----------------------------------------------------------------*/
func_11c8ce:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c8ce
		ret


/*----------------------------------------------------------------*/
func_11c8f1:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c8f1
		ret


/*----------------------------------------------------------------*/
func_11c909:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c909
		ret


/*----------------------------------------------------------------*/
func_11c930:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c930
		ret


/*----------------------------------------------------------------*/
func_11c94c:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c94c
		ret


/*----------------------------------------------------------------*/
func_11c973:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11c973
		ret


/*----------------------------------------------------------------*/
func_11c98f:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		cmp    $0x7fff,%eax
		jg     jump_11c9ae
		cmp    $0xffff8000,%eax
		jl     jump_11c9b5
	jump_11c9a2:
		xor    $0x8000,%eax
		mov    %ah,(%edi)
		inc    %edi
		dec    %ecx
		jne    func_11c98f
		ret
	jump_11c9ae:
		mov    $0x7fff,%eax
		jmp    jump_11c9a2
	jump_11c9b5:
		mov    $0xffff8000,%eax
		jmp    jump_11c9a2


/*----------------------------------------------------------------*/
func_11c9bc:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		cmp    $0x7fff,%eax
		jg     jump_11c9d6
		cmp    $0xffff8000,%eax
		jl     jump_11c9dd
	jump_11c9cf:
		mov    %ah,(%edi)
		inc    %edi
		dec    %ecx
		jne    func_11c9bc
		ret
	jump_11c9d6:
		mov    $0x7fff,%eax
		jmp    jump_11c9cf
	jump_11c9dd:
		mov    $0xffff8000,%eax
		jmp    jump_11c9cf


/*----------------------------------------------------------------*/
func_11c9e4:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11ca21
		cmp    $0xffff8000,%eax
		jl     jump_11ca28
	jump_11c9fa:
		cmp    $0x7fff,%edx
		jg     jump_11ca2f
		cmp    $0xffff8000,%edx
		jl     jump_11ca36
	jump_11ca0a:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ah,%dl
		mov    %dx,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11c9e4
		ret
	jump_11ca21:
		mov    $0x7fff,%eax
		jmp    jump_11c9fa
	jump_11ca28:
		mov    $0xffff8000,%eax
		jmp    jump_11c9fa
	jump_11ca2f:
		mov    $0x7fff,%edx
		jmp    jump_11ca0a
	jump_11ca36:
		mov    $0xffff8000,%edx
		jmp    jump_11ca0a


/*----------------------------------------------------------------*/
func_11ca3d:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11ca6f
		cmp    $0xffff8000,%eax
		jl     jump_11ca76
	jump_11ca53:
		cmp    $0x7fff,%edx
		jg     jump_11ca7d
		cmp    $0xffff8000,%edx
		jl     jump_11ca84
	jump_11ca63:
		mov    %ah,%dl
		mov    %dx,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11ca3d
		ret
	jump_11ca6f:
		mov    $0x7fff,%eax
		jmp    jump_11ca53
	jump_11ca76:
		mov    $0xffff8000,%eax
		jmp    jump_11ca53
	jump_11ca7d:
		mov    $0x7fff,%edx
		jmp    jump_11ca63
	jump_11ca84:
		mov    $0xffff8000,%edx
		jmp    jump_11ca63


/*----------------------------------------------------------------*/
func_11ca8b:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cac8
		cmp    $0xffff8000,%eax
		jl     jump_11cacf
	jump_11caa1:
		cmp    $0x7fff,%edx
		jg     jump_11cad6
		cmp    $0xffff8000,%edx
		jl     jump_11cadd
	jump_11cab1:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dh,%al
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11ca8b
		ret
	jump_11cac8:
		mov    $0x7fff,%eax
		jmp    jump_11caa1
	jump_11cacf:
		mov    $0xffff8000,%eax
		jmp    jump_11caa1
	jump_11cad6:
		mov    $0x7fff,%edx
		jmp    jump_11cab1
	jump_11cadd:
		mov    $0xffff8000,%edx
		jmp    jump_11cab1


/*----------------------------------------------------------------*/
func_11cae4:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cb16
		cmp    $0xffff8000,%eax
		jl     jump_11cb1d
	jump_11cafa:
		cmp    $0x7fff,%edx
		jg     jump_11cb24
		cmp    $0xffff8000,%edx
		jl     jump_11cb2b
	jump_11cb0a:
		mov    %dh,%al
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11cae4
		ret
	jump_11cb16:
		mov    $0x7fff,%eax
		jmp    jump_11cafa
	jump_11cb1d:
		mov    $0xffff8000,%eax
		jmp    jump_11cafa
	jump_11cb24:
		mov    $0x7fff,%edx
		jmp    jump_11cb0a
	jump_11cb2b:
		mov    $0xffff8000,%edx
		jmp    jump_11cb0a


/*----------------------------------------------------------------*/
func_11cb32:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cb6d
		cmp    $0xffff8000,%eax
		jl     jump_11cb74
	jump_11cb48:
		cmp    $0x7fff,%edx
		jg     jump_11cb7b
		cmp    $0xffff8000,%edx
		jl     jump_11cb82
	jump_11cb58:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ah,(%edi)
		mov    %dh,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11cb32
		ret
	jump_11cb6d:
		mov    $0x7fff,%eax
		jmp    jump_11cb48
	jump_11cb74:
		mov    $0xffff8000,%eax
		jmp    jump_11cb48
	jump_11cb7b:
		mov    $0x7fff,%edx
		jmp    jump_11cb58
	jump_11cb82:
		mov    $0xffff8000,%edx
		jmp    jump_11cb58


/*----------------------------------------------------------------*/
func_11cb89:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cbb9
		cmp    $0xffff8000,%eax
		jl     jump_11cbc0
	jump_11cb9f:
		cmp    $0x7fff,%edx
		jg     jump_11cbc7
		cmp    $0xffff8000,%edx
		jl     jump_11cbce
	jump_11cbaf:
		mov    %ah,(%edi)
		mov    %dh,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11cb89
		ret
	jump_11cbb9:
		mov    $0x7fff,%eax
		jmp    jump_11cb9f
	jump_11cbc0:
		mov    $0xffff8000,%eax
		jmp    jump_11cb9f
	jump_11cbc7:
		mov    $0x7fff,%edx
		jmp    jump_11cbaf
	jump_11cbce:
		mov    $0xffff8000,%edx
		jmp    jump_11cbaf


/*----------------------------------------------------------------*/
func_11cbd5:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cc10
		cmp    $0xffff8000,%eax
		jl     jump_11cc17
	jump_11cbeb:
		cmp    $0x7fff,%edx
		jg     jump_11cc1e
		cmp    $0xffff8000,%edx
		jl     jump_11cc25
	jump_11cbfb:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dh,(%edi)
		mov    %ah,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11cbd5
		ret
	jump_11cc10:
		mov    $0x7fff,%eax
		jmp    jump_11cbeb
	jump_11cc17:
		mov    $0xffff8000,%eax
		jmp    jump_11cbeb
	jump_11cc1e:
		mov    $0x7fff,%edx
		jmp    jump_11cbfb
	jump_11cc25:
		mov    $0xffff8000,%edx
		jmp    jump_11cbfb


/*----------------------------------------------------------------*/
func_11cc2c:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cc5c
		cmp    $0xffff8000,%eax
		jl     jump_11cc63
	jump_11cc42:
		cmp    $0x7fff,%edx
		jg     jump_11cc6a
		cmp    $0xffff8000,%edx
		jl     jump_11cc71
	jump_11cc52:
		mov    %dh,(%edi)
		mov    %ah,(%ebx)
		inc    %edi
		inc    %ebx
		dec    %ecx
		jne    func_11cc2c
		ret
	jump_11cc5c:
		mov    $0x7fff,%eax
		jmp    jump_11cc42
	jump_11cc63:
		mov    $0xffff8000,%eax
		jmp    jump_11cc42
	jump_11cc6a:
		mov    $0x7fff,%edx
		jmp    jump_11cc52
	jump_11cc71:
		mov    $0xffff8000,%edx
		jmp    jump_11cc52


/*----------------------------------------------------------------*/
func_11cc78:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cc9a
		cmp    $0xffff8000,%eax
		jl     jump_11cca1
	jump_11cc8b:
		xor    $0x8000,%eax
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11cc78
		ret
	jump_11cc9a:
		mov    $0x7fff,%eax
		jmp    jump_11cc8b
	jump_11cca1:
		mov    $0xffff8000,%eax
		jmp    jump_11cc8b


/*----------------------------------------------------------------*/
func_11cca8:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		cmp    $0x7fff,%eax
		jg     jump_11ccc5
		cmp    $0xffff8000,%eax
		jl     jump_11cccc
	jump_11ccbb:
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11cca8
		ret
	jump_11ccc5:
		mov    $0x7fff,%eax
		jmp    jump_11ccbb
	jump_11cccc:
		mov    $0xffff8000,%eax
		jmp    jump_11ccbb


/*----------------------------------------------------------------*/
func_11ccd3:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		cmp    $0x7fff,%eax
		jg     jump_11ccf7
		cmp    $0xffff8000,%eax
		jl     jump_11ccfe
	jump_11cce6:
		xor    $0x8000,%eax
		xchg   %al,%ah
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11ccd3
		ret
	jump_11ccf7:
		mov    $0x7fff,%eax
		jmp    jump_11cce6
	jump_11ccfe:
		mov    $0xffff8000,%eax
		jmp    jump_11cce6


/*----------------------------------------------------------------*/
func_11cd05:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		add    $0x4,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cd24
		cmp    $0xffff8000,%eax
		jl     jump_11cd2b
	jump_11cd18:
		xchg   %al,%ah
		mov    %ax,(%edi)
		add    $0x2,%edi
		dec    %ecx
		jne    func_11cd05
		ret
	jump_11cd24:
		mov    $0x7fff,%eax
		jmp    jump_11cd18
	jump_11cd2b:
		mov    $0xffff8000,%eax
		jmp    jump_11cd18


/*----------------------------------------------------------------*/
func_11cd32:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cd71
		cmp    $0xffff8000,%eax
		jl     jump_11cd78
	jump_11cd48:
		cmp    $0x7fff,%edx
		jg     jump_11cd7f
		cmp    $0xffff8000,%edx
		jl     jump_11cd86
	jump_11cd58:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11cd32
		ret
	jump_11cd71:
		mov    $0x7fff,%eax
		jmp    jump_11cd48
	jump_11cd78:
		mov    $0xffff8000,%eax
		jmp    jump_11cd48
	jump_11cd7f:
		mov    $0x7fff,%edx
		jmp    jump_11cd58
	jump_11cd86:
		mov    $0xffff8000,%edx
		jmp    jump_11cd58


/*----------------------------------------------------------------*/
func_11cd8d:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cdc1
		cmp    $0xffff8000,%eax
		jl     jump_11cdc8
	jump_11cda3:
		cmp    $0x7fff,%edx
		jg     jump_11cdcf
		cmp    $0xffff8000,%edx
		jl     jump_11cdd6
	jump_11cdb3:
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11cd8d
		ret
	jump_11cdc1:
		mov    $0x7fff,%eax
		jmp    jump_11cda3
	jump_11cdc8:
		mov    $0xffff8000,%eax
		jmp    jump_11cda3
	jump_11cdcf:
		mov    $0x7fff,%edx
		jmp    jump_11cdb3
	jump_11cdd6:
		mov    $0xffff8000,%edx
		jmp    jump_11cdb3


/*----------------------------------------------------------------*/
func_11cddd:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11ce1c
		cmp    $0xffff8000,%eax
		jl     jump_11ce23
	jump_11cdf3:
		cmp    $0x7fff,%edx
		jg     jump_11ce2a
		cmp    $0xffff8000,%edx
		jl     jump_11ce31
	jump_11ce03:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11cddd
		ret
	jump_11ce1c:
		mov    $0x7fff,%eax
		jmp    jump_11cdf3
	jump_11ce23:
		mov    $0xffff8000,%eax
		jmp    jump_11cdf3
	jump_11ce2a:
		mov    $0x7fff,%edx
		jmp    jump_11ce03
	jump_11ce31:
		mov    $0xffff8000,%edx
		jmp    jump_11ce03


/*----------------------------------------------------------------*/
func_11ce38:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11ce6c
		cmp    $0xffff8000,%eax
		jl     jump_11ce73
	jump_11ce4e:
		cmp    $0x7fff,%edx
		jg     jump_11ce7a
		cmp    $0xffff8000,%edx
		jl     jump_11ce81
	jump_11ce5e:
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11ce38
		ret
	jump_11ce6c:
		mov    $0x7fff,%eax
		jmp    jump_11ce4e
	jump_11ce73:
		mov    $0xffff8000,%eax
		jmp    jump_11ce4e
	jump_11ce7a:
		mov    $0x7fff,%edx
		jmp    jump_11ce5e
	jump_11ce81:
		mov    $0xffff8000,%edx
		jmp    jump_11ce5e


/*----------------------------------------------------------------*/
func_11ce88:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cecb
		cmp    $0xffff8000,%eax
		jl     jump_11ced2
	jump_11ce9e:
		cmp    $0x7fff,%edx
		jg     jump_11ced9
		cmp    $0xffff8000,%edx
		jl     jump_11cee0
	jump_11ceae:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11ce88
		ret
	jump_11cecb:
		mov    $0x7fff,%eax
		jmp    jump_11ce9e
	jump_11ced2:
		mov    $0xffff8000,%eax
		jmp    jump_11ce9e
	jump_11ced9:
		mov    $0x7fff,%edx
		jmp    jump_11ceae
	jump_11cee0:
		mov    $0xffff8000,%edx
		jmp    jump_11ceae


/*----------------------------------------------------------------*/
func_11cee7:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cf1f
		cmp    $0xffff8000,%eax
		jl     jump_11cf26
	jump_11cefd:
		cmp    $0x7fff,%edx
		jg     jump_11cf2d
		cmp    $0xffff8000,%edx
		jl     jump_11cf34
	jump_11cf0d:
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11cee7
		ret
	jump_11cf1f:
		mov    $0x7fff,%eax
		jmp    jump_11cefd
	jump_11cf26:
		mov    $0xffff8000,%eax
		jmp    jump_11cefd
	jump_11cf2d:
		mov    $0x7fff,%edx
		jmp    jump_11cf0d
	jump_11cf34:
		mov    $0xffff8000,%edx
		jmp    jump_11cf0d


/*----------------------------------------------------------------*/
func_11cf3b:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cf7e
		cmp    $0xffff8000,%eax
		jl     jump_11cf85
	jump_11cf51:
		cmp    $0x7fff,%edx
		jg     jump_11cf8c
		cmp    $0xffff8000,%edx
		jl     jump_11cf93
	jump_11cf61:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11cf3b
		ret
	jump_11cf7e:
		mov    $0x7fff,%eax
		jmp    jump_11cf51
	jump_11cf85:
		mov    $0xffff8000,%eax
		jmp    jump_11cf51
	jump_11cf8c:
		mov    $0x7fff,%edx
		jmp    jump_11cf61
	jump_11cf93:
		mov    $0xffff8000,%edx
		jmp    jump_11cf61


/*----------------------------------------------------------------*/
func_11cf9a:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11cfd2
		cmp    $0xffff8000,%eax
		jl     jump_11cfd9
	jump_11cfb0:
		cmp    $0x7fff,%edx
		jg     jump_11cfe0
		cmp    $0xffff8000,%edx
		jl     jump_11cfe7
	jump_11cfc0:
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,0x2(%edi)
		add    $0x4,%edi
		dec    %ecx
		jne    func_11cf9a
		ret
	jump_11cfd2:
		mov    $0x7fff,%eax
		jmp    jump_11cfb0
	jump_11cfd9:
		mov    $0xffff8000,%eax
		jmp    jump_11cfb0
	jump_11cfe0:
		mov    $0x7fff,%edx
		jmp    jump_11cfc0
	jump_11cfe7:
		mov    $0xffff8000,%edx
		jmp    jump_11cfc0


/*----------------------------------------------------------------*/
func_11cfee:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d02f
		cmp    $0xffff8000,%eax
		jl     jump_11d036
	jump_11d004:
		cmp    $0x7fff,%edx
		jg     jump_11d03d
		cmp    $0xffff8000,%edx
		jl     jump_11d044
	jump_11d014:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11cfee
		ret
	jump_11d02f:
		mov    $0x7fff,%eax
		jmp    jump_11d004
	jump_11d036:
		mov    $0xffff8000,%eax
		jmp    jump_11d004
	jump_11d03d:
		mov    $0x7fff,%edx
		jmp    jump_11d014
	jump_11d044:
		mov    $0xffff8000,%edx
		jmp    jump_11d014


/*----------------------------------------------------------------*/
func_11d04b:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d081
		cmp    $0xffff8000,%eax
		jl     jump_11d088
	jump_11d061:
		cmp    $0x7fff,%edx
		jg     jump_11d08f
		cmp    $0xffff8000,%edx
		jl     jump_11d096
	jump_11d071:
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d04b
		ret
	jump_11d081:
		mov    $0x7fff,%eax
		jmp    jump_11d061
	jump_11d088:
		mov    $0xffff8000,%eax
		jmp    jump_11d061
	jump_11d08f:
		mov    $0x7fff,%edx
		jmp    jump_11d071
	jump_11d096:
		mov    $0xffff8000,%edx
		jmp    jump_11d071


/*----------------------------------------------------------------*/
func_11d09d:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d0de
		cmp    $0xffff8000,%eax
		jl     jump_11d0e5
	jump_11d0b3:
		cmp    $0x7fff,%edx
		jg     jump_11d0ec
		cmp    $0xffff8000,%edx
		jl     jump_11d0f3
	jump_11d0c3:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d09d
		ret
	jump_11d0de:
		mov    $0x7fff,%eax
		jmp    jump_11d0b3
	jump_11d0e5:
		mov    $0xffff8000,%eax
		jmp    jump_11d0b3
	jump_11d0ec:
		mov    $0x7fff,%edx
		jmp    jump_11d0c3
	jump_11d0f3:
		mov    $0xffff8000,%edx
		jmp    jump_11d0c3


/*----------------------------------------------------------------*/
func_11d0fa:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d130
		cmp    $0xffff8000,%eax
		jl     jump_11d137
	jump_11d110:
		cmp    $0x7fff,%edx
		jg     jump_11d13e
		cmp    $0xffff8000,%edx
		jl     jump_11d145
	jump_11d120:
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d0fa
		ret
	jump_11d130:
		mov    $0x7fff,%eax
		jmp    jump_11d110
	jump_11d137:
		mov    $0xffff8000,%eax
		jmp    jump_11d110
	jump_11d13e:
		mov    $0x7fff,%edx
		jmp    jump_11d120
	jump_11d145:
		mov    $0xffff8000,%edx
		jmp    jump_11d120


/*----------------------------------------------------------------*/
func_11d14c:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d191
		cmp    $0xffff8000,%eax
		jl     jump_11d198
	jump_11d162:
		cmp    $0x7fff,%edx
		jg     jump_11d19f
		cmp    $0xffff8000,%edx
		jl     jump_11d1a6
	jump_11d172:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d14c
		ret
	jump_11d191:
		mov    $0x7fff,%eax
		jmp    jump_11d162
	jump_11d198:
		mov    $0xffff8000,%eax
		jmp    jump_11d162
	jump_11d19f:
		mov    $0x7fff,%edx
		jmp    jump_11d172
	jump_11d1a6:
		mov    $0xffff8000,%edx
		jmp    jump_11d172


/*----------------------------------------------------------------*/
func_11d1ad:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d1e7
		cmp    $0xffff8000,%eax
		jl     jump_11d1ee
	jump_11d1c3:
		cmp    $0x7fff,%edx
		jg     jump_11d1f5
		cmp    $0xffff8000,%edx
		jl     jump_11d1fc
	jump_11d1d3:
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %ax,(%edi)
		mov    %dx,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d1ad
		ret
	jump_11d1e7:
		mov    $0x7fff,%eax
		jmp    jump_11d1c3
	jump_11d1ee:
		mov    $0xffff8000,%eax
		jmp    jump_11d1c3
	jump_11d1f5:
		mov    $0x7fff,%edx
		jmp    jump_11d1d3
	jump_11d1fc:
		mov    $0xffff8000,%edx
		jmp    jump_11d1d3


/*----------------------------------------------------------------*/
func_11d203:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d248
		cmp    $0xffff8000,%eax
		jl     jump_11d24f
	jump_11d219:
		cmp    $0x7fff,%edx
		jg     jump_11d256
		cmp    $0xffff8000,%edx
		jl     jump_11d25d
	jump_11d229:
		xor    $0x8000,%eax
		xor    $0x8000,%edx
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d203
		ret
	jump_11d248:
		mov    $0x7fff,%eax
		jmp    jump_11d219
	jump_11d24f:
		mov    $0xffff8000,%eax
		jmp    jump_11d219
	jump_11d256:
		mov    $0x7fff,%edx
		jmp    jump_11d229
	jump_11d25d:
		mov    $0xffff8000,%edx
		jmp    jump_11d229


/*----------------------------------------------------------------*/
func_11d264:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		mov    0x4(%esi),%edx
		add    $0x8,%esi
		cmp    $0x7fff,%eax
		jg     jump_11d29e
		cmp    $0xffff8000,%eax
		jl     jump_11d2a5
	jump_11d27a:
		cmp    $0x7fff,%edx
		jg     jump_11d2ac
		cmp    $0xffff8000,%edx
		jl     jump_11d2b3
	jump_11d28a:
		xchg   %al,%ah
		xchg   %dl,%dh
		mov    %dx,(%edi)
		mov    %ax,(%ebx)
		add    $0x2,%edi
		add    $0x2,%ebx
		dec    %ecx
		jne    func_11d264
		ret
	jump_11d29e:
		mov    $0x7fff,%eax
		jmp    jump_11d27a
	jump_11d2a5:
		mov    $0xffff8000,%eax
		jmp    jump_11d27a
	jump_11d2ac:
		mov    $0x7fff,%edx
		jmp    jump_11d28a
	jump_11d2b3:
		mov    $0xffff8000,%edx
		jmp    jump_11d28a


/*----------------------------------------------------------------*/
snd_M_0:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d2dd
		mov    (%esi),%ah
		xor    $0x8000,%eax
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     snd_M_0
	jump_11d2dd:
		ret


/*----------------------------------------------------------------*/
snd_M_1:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d304
		mov    (%esi),%ah
		xor    $0x8000,%eax
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     snd_M_1
	jump_11d304:
		ret


/*----------------------------------------------------------------*/
func_11d305:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d33c
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d305
	jump_11d33c:
		ret


/*----------------------------------------------------------------*/
func_11d33d:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d374
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d33d
	jump_11d374:
		ret


/*----------------------------------------------------------------*/
func_11d375:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d39b
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d375
	jump_11d39b:
		ret


/*----------------------------------------------------------------*/
func_11d39c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d3c5
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d39c
	jump_11d3c5:
		ret


/*----------------------------------------------------------------*/
func_11d3c6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d3ff
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d3c6
	jump_11d3ff:
		ret


/*----------------------------------------------------------------*/
func_11d400:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d439
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d400
	jump_11d439:
		ret


/*----------------------------------------------------------------*/
func_11d43a:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d458
		mov    (%esi),%ah
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d43a
	jump_11d458:
		ret


/*----------------------------------------------------------------*/
func_11d459:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d47a
		mov    (%esi),%ah
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d459
	jump_11d47a:
		ret


/*----------------------------------------------------------------*/
func_11d47b:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d4a7
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d47b
	jump_11d4a7:
		ret


/*----------------------------------------------------------------*/
func_11d4a8:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d4d4
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d4a8
	jump_11d4d4:
		ret


/*----------------------------------------------------------------*/
func_11d4d5:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d4f6
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d4d5
	jump_11d4f6:
		ret


/*----------------------------------------------------------------*/
func_11d4f7:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d51b
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d4f7
	jump_11d51b:
		ret


/*----------------------------------------------------------------*/
func_11d51c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d54a
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d51c
	jump_11d54a:
		ret


/*----------------------------------------------------------------*/
func_11d54b:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d579
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d54b
	jump_11d579:
		ret


/*----------------------------------------------------------------*/
func_11d57a:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d5a8
		mov    (%esi),%ah
		xor    $0x8000,%eax
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d57a
	jump_11d5a8:
		ret


/*----------------------------------------------------------------*/
func_11d5a9:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d5da
		mov    (%esi),%ah
		xor    $0x8000,%eax
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d5a9
	jump_11d5da:
		ret


/*----------------------------------------------------------------*/
func_11d5db:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d620
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d5db
	jump_11d620:
		ret


/*----------------------------------------------------------------*/
func_11d621:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d666
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d621
	jump_11d666:
		ret


/*----------------------------------------------------------------*/
func_11d667:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d69b
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d667
	jump_11d69b:
		ret


/*----------------------------------------------------------------*/
func_11d69c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d6d3
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d69c
	jump_11d6d3:
		ret


/*----------------------------------------------------------------*/
func_11d6d4:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d71b
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d6d4
	jump_11d71b:
		ret


/*----------------------------------------------------------------*/
func_11d71c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d763
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d71c
	jump_11d763:
		ret


/*----------------------------------------------------------------*/
func_11d764:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d78d
		mov    (%esi),%ah
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d764
	jump_11d78d:
		ret


/*----------------------------------------------------------------*/
func_11d78e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d7ba
		mov    (%esi),%ah
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d78e
	jump_11d7ba:
		ret


/*----------------------------------------------------------------*/
func_11d7bb:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d7f5
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d7bb
	jump_11d7f5:
		ret


/*----------------------------------------------------------------*/
func_11d7f6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d830
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d7f6
	jump_11d830:
		ret


/*----------------------------------------------------------------*/
func_11d831:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d860
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d831
	jump_11d860:
		ret


/*----------------------------------------------------------------*/
func_11d861:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d893
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d861
	jump_11d893:
		ret


/*----------------------------------------------------------------*/
func_11d894:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d8d0
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d894
	jump_11d8d0:
		ret


/*----------------------------------------------------------------*/
func_11d8d1:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d90d
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d8d1
	jump_11d90d:
		ret


/*----------------------------------------------------------------*/
func_11d90e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d929
		mov    (%esi),%al
		inc    %esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d90e
	jump_11d929:
		ret


/*----------------------------------------------------------------*/
func_11d92a:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d94f
		mov    (%esi),%al
		inc    %esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%eax,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d92a
	jump_11d94f:
		ret


/*----------------------------------------------------------------*/
func_11d950:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d979
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d950
	jump_11d979:
		ret


/*----------------------------------------------------------------*/
func_11d97a:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d9a4
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d97a
	jump_11d9a4:
		ret


/*----------------------------------------------------------------*/
func_11d9a5:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d9ce
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d9a5
	jump_11d9ce:
		ret


/*----------------------------------------------------------------*/
func_11d9cf:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11d9f9
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11d9cf
	jump_11d9f9:
		ret


/*----------------------------------------------------------------*/
func_11d9fa:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11da26
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11d9fa
	jump_11da26:
		ret


/*----------------------------------------------------------------*/
func_11da27:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11da62
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11da27
	jump_11da62:
		ret


/*----------------------------------------------------------------*/
func_11da63:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11daa8
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11da63
	jump_11daa8:
		ret


/*----------------------------------------------------------------*/
func_11daa9:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11daf2
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11daa9
	jump_11daf2:
		ret


/*----------------------------------------------------------------*/
func_11daf3:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11db38
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11daf3
	jump_11db38:
		ret


/*----------------------------------------------------------------*/
func_11db39:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11db82
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11db39
	jump_11db82:
		ret


/*----------------------------------------------------------------*/
func_11db83:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dbaa
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11db83
	jump_11dbaa:
		ret


/*----------------------------------------------------------------*/
func_11dbab:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dbe1
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11dbab
	jump_11dbe1:
		ret


/*----------------------------------------------------------------*/
func_11dbe2:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dc1c
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11dbe2
	jump_11dc1c:
		ret


/*----------------------------------------------------------------*/
func_11dc1d:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dc5b
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11dc1d
	jump_11dc5b:
		ret


/*----------------------------------------------------------------*/
func_11dc5c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dc96
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11dc5c
	jump_11dc96:
		ret


/*----------------------------------------------------------------*/
func_11dc97:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dcd5
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11dc97
	jump_11dcd5:
		ret


/*----------------------------------------------------------------*/
func_11dcd6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dcfc
		mov    (%esi),%al
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11dcd6
	jump_11dcfc:
		ret


/*----------------------------------------------------------------*/
func_11dcfd:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dd2d
		mov    (%esi),%al
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%eax,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11dcfd
	jump_11dd2d:
		ret


/*----------------------------------------------------------------*/
func_11dd2e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dd65
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11dd2e
	jump_11dd65:
		ret


/*----------------------------------------------------------------*/
func_11dd66:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dd9e
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11dd66
	jump_11dd9e:
		ret


/*----------------------------------------------------------------*/
func_11dd9f:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ddd6
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11dd9f
	jump_11ddd6:
		ret


/*----------------------------------------------------------------*/
func_11ddd7:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11de0f
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ddd7
	jump_11de0f:
		ret


/*----------------------------------------------------------------*/
func_11de10:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11de4a
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11de10
	jump_11de4a:
		ret


/*----------------------------------------------------------------*/
func_11de4b:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11de94
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11de4b
	jump_11de94:
		ret


/*----------------------------------------------------------------*/
func_11de95:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dee8
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11de95
	jump_11dee8:
		ret


/*----------------------------------------------------------------*/
func_11dee9:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11df40
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11dee9
	jump_11df40:
		ret


/*----------------------------------------------------------------*/
func_11df41:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11df94
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11df41
	jump_11df94:
		ret


/*----------------------------------------------------------------*/
func_11df95:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11dfec
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11df95
	jump_11dfec:
		ret


/*----------------------------------------------------------------*/
func_11dfed:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e022
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11dfed
	jump_11e022:
		ret


/*----------------------------------------------------------------*/
func_11e023:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e067
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e023
	jump_11e067:
		ret


/*----------------------------------------------------------------*/
func_11e068:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e0b0
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e068
	jump_11e0b0:
		ret


/*----------------------------------------------------------------*/
func_11e0b1:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e0fd
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e0b1
	jump_11e0fd:
		ret


/*----------------------------------------------------------------*/
func_11e0fe:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e146
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e0fe
	jump_11e146:
		ret


/*----------------------------------------------------------------*/
func_11e147:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e193
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e147
	jump_11e193:
		ret


/*----------------------------------------------------------------*/
func_11e194:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e1b7
		mov    (%esi),%ah
		xor    $0x8000,%eax
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e194
	jump_11e1b7:
		ret


/*----------------------------------------------------------------*/
func_11e1b8:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e1de
		mov    (%esi),%ah
		xor    $0x8000,%eax
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e1b8
	jump_11e1de:
		ret


/*----------------------------------------------------------------*/
func_11e1df:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e21a
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e1df
	jump_11e21a:
		ret


/*----------------------------------------------------------------*/
func_11e21b:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e256
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e21b
	jump_11e256:
		ret


/*----------------------------------------------------------------*/
func_11e257:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e27d
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e257
	jump_11e27d:
		ret


/*----------------------------------------------------------------*/
func_11e27e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e2a7
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e27e
	jump_11e2a7:
		ret


/*----------------------------------------------------------------*/
func_11e2a8:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e2e5
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e2a8
	jump_11e2e5:
		ret


/*----------------------------------------------------------------*/
func_11e2e6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e323
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e2e6
	jump_11e323:
		ret


/*----------------------------------------------------------------*/
func_11e324:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e342
		mov    (%esi),%ah
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e324
	jump_11e342:
		ret


/*----------------------------------------------------------------*/
func_11e343:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e364
		mov    (%esi),%ah
		inc    %esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e343
	jump_11e364:
		ret


/*----------------------------------------------------------------*/
func_11e365:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e395
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e365
	jump_11e395:
		ret


/*----------------------------------------------------------------*/
func_11e396:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e3c6
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		add    $0x2,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e396
	jump_11e3c6:
		ret


/*----------------------------------------------------------------*/
func_11e3c7:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e3e8
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e3c7
	jump_11e3e8:
		ret


/*----------------------------------------------------------------*/
func_11e3e9:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e40d
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e3e9
	jump_11e40d:
		ret


/*----------------------------------------------------------------*/
func_11e40e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e440
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e40e
	jump_11e440:
		ret


/*----------------------------------------------------------------*/
func_11e441:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e473
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e441
	jump_11e473:
		ret


/*----------------------------------------------------------------*/
func_11e474:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e4a2
		mov    (%esi),%ah
		xor    $0x8000,%eax
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e474
	jump_11e4a2:
		ret


/*----------------------------------------------------------------*/
func_11e4a3:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e4d4
		mov    (%esi),%ah
		xor    $0x8000,%eax
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e4a3
	jump_11e4d4:
		ret


/*----------------------------------------------------------------*/
func_11e4d5:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e51e
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e4d5
	jump_11e51e:
		ret


/*----------------------------------------------------------------*/
func_11e51f:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e568
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e51f
	jump_11e568:
		ret


/*----------------------------------------------------------------*/
func_11e569:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e59d
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e569
	jump_11e59d:
		ret


/*----------------------------------------------------------------*/
func_11e59e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e5d5
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e59e
	jump_11e5d5:
		ret


/*----------------------------------------------------------------*/
func_11e5d6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e621
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e5d6
	jump_11e621:
		ret


/*----------------------------------------------------------------*/
func_11e622:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e66d
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e622
	jump_11e66d:
		ret


/*----------------------------------------------------------------*/
func_11e66e:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e697
		mov    (%esi),%ah
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e66e
	jump_11e697:
		ret


/*----------------------------------------------------------------*/
func_11e698:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e6c4
		mov    (%esi),%ah
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e698
	jump_11e6c4:
		ret


/*----------------------------------------------------------------*/
func_11e6c5:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e703
		mov    (%esi),%ah
		mov    0x1(%esi),%bh
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e6c5
	jump_11e703:
		ret


/*----------------------------------------------------------------*/
func_11e704:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e742
		mov    (%esi),%bh
		mov    0x1(%esi),%ah
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e704
	jump_11e742:
		ret


/*----------------------------------------------------------------*/
func_11e743:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e772
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e743
	jump_11e772:
		ret


/*----------------------------------------------------------------*/
func_11e773:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e7a5
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e773
	jump_11e7a5:
		ret


/*----------------------------------------------------------------*/
func_11e7a6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e7e6
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e7a6
	jump_11e7e6:
		ret


/*----------------------------------------------------------------*/
func_11e7e7:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e827
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		add    %ebx,%eax
		sar    %eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e7e7
	jump_11e827:
		ret


/*----------------------------------------------------------------*/
func_11e828:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e843
		mov    (%esi),%al
		inc    %esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e828
	jump_11e843:
		ret


/*----------------------------------------------------------------*/
func_11e844:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e869
		mov    (%esi),%al
		inc    %esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%eax,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e844
	jump_11e869:
		ret


/*----------------------------------------------------------------*/
func_11e86a:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e893
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e86a
	jump_11e893:
		ret


/*----------------------------------------------------------------*/
func_11e894:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e8c2
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		mov    %ebp,%eax
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e894
	jump_11e8c2:
		ret


/*----------------------------------------------------------------*/
func_11e8c3:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e8ec
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e8c3
	jump_11e8ec:
		ret


/*----------------------------------------------------------------*/
func_11e8ed:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e91b
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		add    $0x2,%esi
		mov    (%edx,%eax,4),%ebp
		mov    %ebp,%eax
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e8ed
	jump_11e91b:
		ret


/*----------------------------------------------------------------*/
func_11e91c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e948
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e91c
	jump_11e948:
		ret


/*----------------------------------------------------------------*/
func_11e949:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e984
		mov    (%esi),%ax
		xor    $0x8000,%eax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e949
	jump_11e984:
		ret


/*----------------------------------------------------------------*/
func_11e985:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11e9ca
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11e985
	jump_11e9ca:
		ret


/*----------------------------------------------------------------*/
func_11e9cb:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ea13
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11e9cb
	jump_11ea13:
		ret


/*----------------------------------------------------------------*/
func_11ea14:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ea59
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ea14
	jump_11ea59:
		ret


/*----------------------------------------------------------------*/
func_11ea5a:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11eaa2
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ea5a
	jump_11eaa2:
		ret


/*----------------------------------------------------------------*/
func_11eaa3:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11eaca
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11eaa3
	jump_11eaca:
		ret


/*----------------------------------------------------------------*/
func_11eacb:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11eb01
		mov    (%esi),%ax
		add    $0x2,%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11eacb
	jump_11eb01:
		ret


/*----------------------------------------------------------------*/
func_11eb02:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11eb3c
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11eb02
	jump_11eb3c:
		ret


/*----------------------------------------------------------------*/
func_11eb3d:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11eb7a
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11eb3d
	jump_11eb7a:
		ret


/*----------------------------------------------------------------*/
func_11eb7b:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ebb5
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11eb7b
	jump_11ebb5:
		ret


/*----------------------------------------------------------------*/
func_11ebb6:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ebf3
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		add    $0x4,%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ebb6
	jump_11ebf3:
		ret


/*----------------------------------------------------------------*/
func_11ebf4:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ec1a
		mov    (%esi),%al
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ebf4
	jump_11ec1a:
		ret


/*----------------------------------------------------------------*/
func_11ec1b:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ec4b
		mov    (%esi),%al
		add    data_15ac04,%ecx
		adc    data_15ac08,%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%eax,4),%ebp
		add    %ebp,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ec1b
	jump_11ec4b:
		ret


/*----------------------------------------------------------------*/
func_11ec4c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ec83
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ec4c
	jump_11ec83:
		ret


/*----------------------------------------------------------------*/
func_11ec84:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ecc0
		mov    (%esi),%al
		mov    0x1(%esi),%bl
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		mov    %ebp,%eax
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ec84
	jump_11ecc0:
		ret


/*----------------------------------------------------------------*/
func_11ecc1:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ecf8
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		add    %ebp,(%edi)
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ecc1
	jump_11ecf8:
		ret


/*----------------------------------------------------------------*/
func_11ecf9:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ed35
		mov    (%esi),%bl
		mov    0x1(%esi),%al
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		mov    (%edx,%eax,4),%ebp
		mov    %ebp,%eax
		mov    0x400(%edx,%ebx,4),%ebp
		add    %ebp,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ecf9
	jump_11ed35:
		ret


/*----------------------------------------------------------------*/
func_11ed36:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ed70
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ed36
	jump_11ed70:
		ret


/*----------------------------------------------------------------*/
func_11ed71:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11edba
		mov    (%esi),%ax
		xor    $0x8000,%eax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ed71
	jump_11edba:
		ret


/*----------------------------------------------------------------*/
func_11edbb:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ee0e
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11edbb
	jump_11ee0e:
		ret


/*----------------------------------------------------------------*/
func_11ee0f:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ee65
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ee0f
	jump_11ee65:
		ret


/*----------------------------------------------------------------*/
func_11ee66:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11eeb9
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ee66
	jump_11eeb9:
		ret


/*----------------------------------------------------------------*/
func_11eeba:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ef10
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    $0x8000,%eax
		xor    $0x8000,%ebx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11eeba
	jump_11ef10:
		ret


/*----------------------------------------------------------------*/
func_11ef11:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ef46
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		imul   (%edx),%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ef11
	jump_11ef46:
		ret


/*----------------------------------------------------------------*/
func_11ef47:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11ef8b
		mov    (%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		sar    $0x10,%eax
		mov    %eax,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		sar    $0x7,%eax
		sar    $0x7,%ebx
		add    %eax,(%edi)
		add    %ebx,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11ef47
	jump_11ef8b:
		ret


/*----------------------------------------------------------------*/
func_11ef8c:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11efd4
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11ef8c
	jump_11efd4:
		ret


/*----------------------------------------------------------------*/
func_11efd5:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11f020
		mov    (%esi),%ax
		mov    0x2(%esi),%bx
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     func_11efd5
	jump_11f020:
		ret


/*----------------------------------------------------------------*/
func_11f021:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11f069
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x7,%eax
		add    %eax,(%edi)
		add    $0x4,%edi
		cmp    data_15ac00,%edi
		jb     func_11f021
	jump_11f069:
		ret


/*----------------------------------------------------------------*/
snd_M_255:
/*----------------------------------------------------------------*/
		cmp    data_15abf8,%esi
		jae    jump_11f0b5
		mov    (%esi),%bx
		mov    0x2(%esi),%ax
		xor    %ebp,%ebp
		add    data_15ac04,%ecx
		adc    %ebp,%ebp
		add    data_15ac08(,%ebp,4),%esi
		shl    $0x10,%eax
		shl    $0x10,%ebx
		sar    $0x10,%eax
		sar    $0x10,%ebx
		imul   (%edx),%eax
		imul   0x400(%edx),%ebx
		add    %ebx,%eax
		sar    $0x8,%eax
		add    %eax,(%edi)
		add    %eax,0x4(%edi)
		add    $0x8,%edi
		cmp    data_15ac00,%edi
		jb     snd_M_255
	jump_11f0b5:
		ret


/*----------------------------------------------------------------*/
AILSSA_merge:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		push   %ds
		push   %es
		mov    0x8(%ebp),%ecx
		mov    (%ecx),%edi
		mov    $0x0,%eax
		cmpl   $0x2,0x18(%edi)
		je     jump_11f0d4
		cmpl   $0x3,0x18(%edi)
		jne    jump_11f0d7
	jump_11f0d4:
		or     $0x1,%eax
	jump_11f0d7:
		testl  $0x100,0x38(%ecx)
		je     jump_11f0e5
		or     $0x80,%eax
	jump_11f0e5:
		cmpl   $0x2,0x34(%ecx)
		je     jump_11f0f1
		cmpl   $0x3,0x34(%ecx)
		jne    jump_11f100
	jump_11f0f1:
		or     $0x2,%eax
		testl  $0x2,0x38(%ecx)
		je     jump_11f100
		or     $0x4,%eax
	jump_11f100:
		cmpl   $0x1,0x34(%ecx)
		je     jump_11f10c
		cmpl   $0x3,0x34(%ecx)
		jne    jump_11f10f
	jump_11f10c:
		or     $0x8,%eax
	jump_11f10f:
		test   $0x2,%eax
		je     jump_11f11d
		test   $0x1,%eax
		je     jump_11f12f
	jump_11f11d:
		cmpl   $0x7f,0x40(%ecx)
		jne    jump_11f12f
		cmpl   $0x7f,0x68(%edi)
		jne    jump_11f12f
		cmpl   $0x40,0x44(%ecx)
		je     jump_11f139
	jump_11f12f:
		or     $0x40,%eax
		test   $0x8,%eax
		je     jump_11f145
	jump_11f139:
		testl  $0x1,0x38(%ecx)
		je     jump_11f145
		or     $0x10,%eax
	jump_11f145:
		mov    %eax,data_15abf0
		mov    $0x0,%eax
		mov    0x3c(%ecx),%edx
		cmp    $0x0,%edx
		jg     jump_11f15c
		mov    $0x1,%edx
	jump_11f15c:
		mov    0x14(%edi),%ebx
		shl    $0x10,%ebx
		div    %ebx
		mov    %eax,%edx
		sub    $0x10000,%edx
		jg     jump_11f170
		neg    %edx
	jump_11f170:
		cmp    data_1ed824,%edx
		jbe    jump_11f1ba
		mov    %eax,%ebx
		shr    $0x10,%ebx
		shl    $0x10,%eax
		mov    %eax,data_15ac04
		mov    %ebx,%eax
		inc    %ebx
		testl  $0x2,data_15abf0
		je     jump_11f198
		shl    %eax
		shl    %ebx
	jump_11f198:
		testl  $0x8,data_15abf0
		je     jump_11f1a8
		shl    %eax
		shl    %ebx
	jump_11f1a8:
		mov    %eax,data_15ac08
		mov    %ebx,data_15ac0c
		orl    $0x20,data_15abf0
	jump_11f1ba:
		mov    0x50(%edi),%eax
		mov    %eax,data_15abfc
		add    0x4c(%edi),%eax
		mov    %eax,data_15ac00
		mov    data_15abfc,%edi
	jump_11f1d0:
		mov    0x28(%ecx),%ebx
		mov    0x8(%ecx,%ebx,4),%eax
		add    0x18(%ecx,%ebx,4),%eax
		mov    %eax,data_15abf4
		mov    0x8(%ecx,%ebx,4),%eax
		add    0x10(%ecx,%ebx,4),%eax
		mov    %eax,data_15abf8
		cmpl   $0x0,0x848(%ecx)
		jne    jump_11f2b7
	jump_11f1fa:
		mov    data_15abf4,%esi
		lea    0x48(%ecx),%edx
		mov    $0x0,%eax
		mov    $0x0,%ebx
		mov    $0x80000000,%ecx
		push   %ebp
		mov    data_15abf0,%ebp
		call   *%cs:vtable_11c27c(,%ebp,4)
		pop    %ebp
		mov    0x8(%ebp),%ecx
		mov    0x28(%ecx),%ebx
		mov    %esi,%eax
		sub    0x8(%ecx,%ebx,4),%eax
		mov    %eax,0x18(%ecx,%ebx,4)
		cmp    data_15abf8,%esi
		jb     jump_11f29f
		cmpl   $0x0,0x84c(%ecx)
		jne    jump_11f2cb
	jump_11f247:
		cmpl   $0x0,0x30(%ecx)
		je     jump_11f256
		cmpl   $0x1,0x30(%ecx)
		je     jump_11f26f
		decl   0x30(%ecx)
	jump_11f256:
		mov    0x28(%ecx),%ebx
		movl   $0x0,0x18(%ecx,%ebx,4)
		cmp    data_15ac00,%edi
		jb     jump_11f1d0
		jmp    jump_11f29f
	jump_11f26f:
		mov    0x28(%ecx),%ebx
		xor    $0x1,%ebx
		cmpl   $0x0,0x20(%ecx,%ebx,4)
		jne    jump_11f28f
		cmpl   $0x0,0x10(%ecx,%ebx,4)
		je     jump_11f29f
		cmpl   $0x0,0x18(%ecx,%ebx,4)
		jne    jump_11f29f
		mov    %ebx,0x28(%ecx)
		jmp    jump_11f256
	jump_11f28f:
		movl   $0x2,0x4(%ecx)
		cmpl   $0x0,0x850(%ecx)
		jne    jump_11f2a6
	jump_11f29f:
		pop    %es
		pop    %ds
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret
	jump_11f2a6:
		push   %ecx
		mov    %esp,%esi
		mov    %ecx,%eax
		push   %eax
		call   *0x850(%ecx)
		mov    %esi,%esp
		pop    %ecx
		jmp    jump_11f29f
	jump_11f2b7:
		push   %ecx
		mov    %esp,%esi
		mov    %ecx,%eax
		push   %eax
		call   *0x848(%ecx)
		mov    %esi,%esp
		pop    %ecx
		jmp    jump_11f1fa
	jump_11f2cb:
		push   %ecx
		mov    %esp,%esi
		mov    %ecx,%eax
		push   %eax
		call   *0x84c(%ecx)
		mov    %esi,%esp
		pop    %ecx
		jmp    jump_11f247


/*----------------------------------------------------------------*/
AILSSA_DMA_copy:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		push   %ds
		push   %es
		mov    0x8(%ebp),%ebx
		mov    0x1c(%ebx),%eax
		and    $0xf,%eax
		cmpl   $0x2,0x18(%ebx)
		je     jump_11f2fc
		cmpl   $0x3,0x18(%ebx)
		jne    jump_11f2ff
	jump_11f2fc:
		or     $0x10,%eax
	jump_11f2ff:
		cmpl   $0x1,0x18(%ebx)
		je     jump_11f30b
		cmpl   $0x3,0x18(%ebx)
		jne    jump_11f30e
	jump_11f30b:
		or     $0x20,%eax
	jump_11f30e:
		cmpl   $0x1,0x64(%ebx)
		jbe    jump_11f317
		or     $0x40,%eax
	jump_11f317:
		mov    %eax,data_15abf0
		mov    0x50(%ebx),%esi
		mov    0x48(%ebx),%ecx
		testl  $0x20,0x1c(%ebx)
		jne    jump_11f345
		mov    0xc(%ebp),%eax
		mov    0x2c(%ebx,%eax,4),%edi
		testl  $0x8,0x1c(%ebx)
		je     jump_11f35e
		mov    0x10(%ebx),%eax
		shr    %eax
		lea    (%eax,%edi,1),%ebx
		jmp    jump_11f35e
	jump_11f345:
		orl    $0x8,data_15abf0
		mov    0x10(%ebx),%eax
		mov    0x2c(%ebx),%edi
		lea    (%eax,%edi,1),%ebx
		shr    %eax
		mull   0xc(%ebp)
		add    %eax,%edi
		add    %eax,%ebx
	jump_11f35e:
		mov    data_15abf0,%eax
		call   *%cs:vtable_11c07c(,%eax,4)
		pop    %es
		pop    %ds
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AILSSA_flush_buffer:
/*----------------------------------------------------------------*/
		push   %ebp
		mov    %esp,%ebp
		push   %ebx
		push   %esi
		push   %edi
		push   %ds
		push   %es
		cld
		push   %ds
		pop    %es
		mov    0x8(%ebp),%ebx
		mov    0x50(%ebx),%edi
		mov    0x4c(%ebx),%ecx
		mov    $0x0,%eax
		push   %ecx
		and    $0x3,%ecx
		rep stos %al,%es:(%edi)
		pop    %ecx
		shr    $0x2,%ecx
		rep stos %eax,%es:(%edi)
		pop    %es
		pop    %ds
		pop    %edi
		pop    %esi
		pop    %ebx
		leave
		ret


/*----------------------------------------------------------------*/
AILSSA_VMM_lock:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %esi
		push   %edi
		push   %ds
		push   %es
		push   $data_15ac0c_after
		push   $data_15abf0
		call   VMM_lock_range
		add    $0x8,%esp
		push   $AILSSA_VMM_lock
		push   $vtable_11c07c
		call   VMM_lock_range
		add    $0x8,%esp
		pop    %es
		pop    %ds
		pop    %edi
		pop    %esi
		pop    %ebx
		ret




.data


data_159328:
		.long	0x0

GLOBAL (timer_callbacks)		/* 159e98 */
		.fill   0x40
GLOBAL (timer_callback_states)		/* 159ed8 */
		.fill   0x3c
data_159f14:
		.long	0x0

/* μs */
timer_callback_elapsed_times:	/* 159f18 */
		.fill   0x40

/* μs */
timer_callback_periods:		/* 159f58 */
		.fill   0x40

/* number of times to call the callback */
timer_callback_call_counts:	/* 159ed8 */
		.fill   0x3c

data_159fd4:
		.long	0x0
GLOBAL (timer_callback_arguments)	/* 159fd8 */
		.fill   0x40
timer_old_handler:		/* 15a018 */
		.long	0x0
timer_old_handler_segment:	/* 15a01c */
		.short  0x0
data_15a01e:
		.long	0x0
GLOBAL (timer_divisor)		/* 15a022 */
		.long	0x0
timer_period:			/* 15a026 */
		.long	0x0
timer_reentrance_lock:		/* 15a02a */
		.long	0x0
timer_lock:			/* 15a02e */
		.long	0x0
data_15a032:
		.short  0x0
data_15a034:
		.long	0x0
data_15a038:
		.long	0x0
data_15a03c:
		.long	0x0
data_15a040:
		.fill   0xa00
data_15aa40:
		.long	0x0
data_15aa44:
		.long	0x0
data_15aa48:
		.long	0x0
data_15aa4c:
		.long	0x0
data_15aa50:
		.ascii  "\x00\x02\x04\x06\x08\x0a\x0c\x0e"
		.ascii  "\x10\x12\x14\x16\x18\x1a\x1c\x1e"
		.ascii  " \"$&(*,.02468:<>@BDFHJLNPRTVXZ\\^`bdfhjlnprtvxz|"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.ascii  "\x80\x80\x80\x80\x80\x80\x80\x80"
		.byte	0x80
data_15aad0:
		.long	0x0
data_15aad4:
		.long	0x0
data_15aad8:
		.long	0x0
data_15aadc:
		.string "SAMPLE"
		.fill   0x79
data_15ab5c:
		.long	0x0
data_15ab60:
		.long	0x0
data_15ab64:
		.string "TIMB"
		.ascii  "\x00\x00\x04\x01\x00"
data_15ab6e:
		.byte	0xff
data_15ab6f:
		.byte	0xff
data_15ab70:
		.long	0x0


data_15abf0:
		.long	0x0
data_15abf4:
		.long	0x0
data_15abf8:
		.long	0x0
data_15abfc:
		.long	0x0
data_15ac00:
		.long	0x0
data_15ac04:
		.long	0x0
data_15ac08:
		.long	0x0
data_15ac0c:
		.long	0x0
data_15ac0c_after:
		.byte	0x0



data_1600f4:
		.string "[%.02u:%.02u:%.02u.%.02u] "
		.byte	0x0
data_160110:
		.ascii  "\x20\x00\x00\x00"
data_160114:
		.ascii  "\xfa\x00\x00\x00"
data_160118:
		.string "AIL_DEBUG"
		.short  0x0
data_160124:
		.string "AIL_SYS_DEBUG"
		.short  0x0
data_160134:
		.ascii  "\x77\x2b\x74\x00"
data_160138:
		.string "-------------------------------------------------------------------------------\n"
		.ascii  "\x00\x00\x00"
data_16018c:
		.string "3.03"
		.ascii  "\x00\x00\x00"
data_160194:
		.string "Audio Interface Library application usage script generated by AIL V%s\n"
		.byte	0x0
data_1601dc:
		.string "Start time: %s\n"
data_1601ec:
		.string "-------------------------------------------------------------------------------\n\n"
		.short  0x0
data_160240:
		.string "AIL_startup()\n"
		.byte	0x0
data_160250:
		.string "AIL_shutdown()\n"
data_160260:
		.string "AIL_set_preference(%d,%d)\n"
		.byte	0x0
data_16027c_result_decimal:
		.string "Result = %d\n"
		.ascii  "\x00\x00\x00"
data_16028c:
		.string "AIL_get_real_vect(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_1602a8_result_hex:
		.string "Result = 0x%X\n"
		.byte	0x0
data_1602b8:
		.string "AIL_set_real_vect(0x%X,0x%X)\n"
		.short  0x0
data_1602d8:
		.string "AIL_restore_USE16_ISR(%d,0x%X,%u)\n"
		.byte	0x0
data_1602f8:
		.string "AIL_restore_USE16_ISR(%d)\n"
		.byte	0x0
data_160314:
		.string "AIL_call_driver(0x%X,0x%X,0x%X,0x%X)\n"
		.short  0x0
data_16033c:
		.string "AIL_delay(%d)\n"
		.byte	0x0
data_16034c:
		.string "AIL_API_read_INI(0x%X,%s)\n"
		.byte	0x0
data_160368:
		.string "Driver = %s\n"
		.ascii  "\x00\x00\x00"
data_160378:
		.string "Device = %s\n"
		.ascii  "\x00\x00\x00"
data_160388:
		.string "IO     = %X\n"
		.ascii  "\x00\x00\x00"
data_160398:
		.string "IRQ    = %d\n"
		.ascii  "\x00\x00\x00"
data_1603a8:
		.string "DMA_8  = %d\n"
		.ascii  "\x00\x00\x00"
data_1603b8:
		.string "DMA_16 = %d\n"
		.ascii  "\x00\x00\x00"
data_1603c8:
		.string "Result = %u\n"
		.ascii  "\x00\x00\x00"
data_1603d8:
		.string "AIL_register_timer(0x%X)\n"
		.short  0x0
data_1603f4:
		.string "AIL_set_timer_user(%u,%u)\n"
		.byte	0x0
data_160410:
		.string "AIL_set_timer_period(%u,%u)\n"
		.ascii  "\x00\x00\x00"
data_160430:
		.string "AIL_set_timer_frequency(%u,%u)\n"
data_160450:
		.string "AIL_set_timer_divisor(%u,%u)\n"
		.short  0x0
data_160470:
		.string "AIL_interrupt_divisor()\n"
		.ascii  "\x00\x00\x00"
data_16048c:
		.string "AIL_start_timer(%u)\n"
		.ascii  "\x00\x00\x00"
data_1604a4:
		.string "AIL_start_all_timers()\n"
data_1604bc:
		.string "AIL_stop_timer(%u)\n"
data_1604d0:
		.string "AIL_stop_all_timers()\n"
		.byte	0x0
data_1604e8:
		.string "AIL_release_timer_handle(%u)\n"
		.short  0x0
data_160508:
		.string "AIL_release_all_timers()\n"
		.short  0x0
data_160524:
		.string "AIL_get_IO_environment(0x%X)\n"
		.short  0x0
data_160544:
		.string "AIL_install_driver(0x%X,%u)\n"
		.ascii  "\x00\x00\x00"
data_160564:
		.string "AIL_uninstall_driver(0x%X)\n"
data_160580:
		.string "AIL_install_DIG_INI(0x%X)\n"
		.byte	0x0
data_16059c:
		.string "AIL_install_DIG_driver_file(%s,0x%X)\n"
		.short  0x0
data_1605c4:
		.string "AIL_uninstall_DIG_driver(0x%X)\n"
data_1605e4:
		.string "AIL_allocate_sample_handle(0x%X)\n"
		.short  0x0
data_160608:
		.string "AIL_allocate_file_sample(0x%X,0x%X,%d)\n"
data_160630:
		.string "AIL_release_sample_handle(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160654:
		.string "AIL_init_sample(0x%X)\n"
		.byte	0x0
data_16066c:
		.string "AIL_set_sample_file(0x%X,0x%X,%d)\n"
		.byte	0x0
data_160690:
		.string "AIL_set_sample_address(0x%X,0x%X,%u)\n"
		.short  0x0
data_1606b8:
		.string "AIL_set_sample_type(0x%X,%d,%u)\n"
		.ascii  "\x00\x00\x00"
data_1606dc:
		.string "AIL_start_sample(0x%X)\n"
data_1606f4:
		.string "AIL_stop_sample(0x%X)\n"
		.byte	0x0
data_16070c:
		.string "AIL_resume_sample(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160728:
		.string "AIL_end_sample(0x%X)\n"
		.short  0x0
data_160740:
		.string "AIL_set_sample_playback_rate(0x%X,%d)\n"
		.byte	0x0
data_160768:
		.string "AIL_set_sample_volume(0x%X,%d)\n"
data_160788:
		.string "AIL_set_sample_pan(0x%X,%d)\n"
		.ascii  "\x00\x00\x00"
data_1607a8:
		.string "AIL_set_sample_loop_count(0x%X,%d)\n"
data_1607cc:
		.string "AIL_sample_status(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_1607e8:
		.string "AIL_sample_playback_rate(0x%X)\n"
data_160808:
		.string "AIL_sample_volume(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160824:
		.string "AIL_sample_pan(0x%X)\n"
		.short  0x0
data_16083c:
		.string "AIL_sample_loop_count(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_16085c:
		.string "AIL_set_digital_master_volume(0x%X,%d)\n"
data_160884:
		.string "AIL_digital_master_volume(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_1608a8:
		.string "AIL_install_DIG_driver_image(0x%X,%u,0x%X)\n"
data_1608d4:
		.string "AIL_minimum_sample_buffer_size(0x%X,%d,%d)\n"
data_160900:
		.string "AIL_sample_buffer_ready(0x%X)\n"
		.byte	0x0
data_160920:
		.string "AIL_load_sample_buffer(0x%X,%u,0x%X,%u)\n"
		.ascii  "\x00\x00\x00"
data_16094c:
		.string "AIL_set_sample_position(0x%X,%u)\n"
		.short  0x0
data_160970:
		.string "AIL_sample_position(0x%X)\n"
		.byte	0x0
data_16098c:
		.string "AIL_register_SOB_callback(0x%X,0x%X)\n"
		.short  0x0
data_1609b4:
		.string "AIL_register_EOB_callback(0x%X,0x%X)\n"
		.short  0x0
data_1609dc:
		.string "AIL_register_EOS_callback(0x%X,0x%X)\n"
		.short  0x0
data_160a04:
		.string "AIL_register_EOF_callback(0x%X,0x%X)\n"
		.short  0x0
data_160a2c:
		.string "AIL_set_sample_user_data(0x%X,%u,%d)\n"
		.short  0x0
data_160a54:
		.string "AIL_sample_user_data(0x%X,%u)\n"
		.byte	0x0
data_160a74:
		.string "AIL_active_sample_count(0x%X)\n"
		.byte	0x0
data_160a94:
		.string "AIL_install_MDI_INI(0x%X)\n"
		.byte	0x0
data_160ab0:
		.string "AIL_install_MDI_driver_file(%s,0x%X)\n"
		.short  0x0
data_160ad8:
		.string "AIL_uninstall_MDI_driver(0x%X)\n"
data_160af8:
		.string "AIL_allocate_sequence_handle(0x%X)\n"
data_160b1c:
		.string "AIL_release_sequence_handle(0x%X)\n"
		.byte	0x0
data_160b40:
		.string "AIL_init_sequence(0x%X,0x%X,%d)\n"
		.ascii  "\x00\x00\x00"
data_160b64:
		.string "AIL_start_sequence(0x%X)\n"
		.short  0x0
data_160b80:
		.string "AIL_stop_sequence(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160b9c:
		.string "AIL_resume_sequence(0x%X)\n"
		.byte	0x0
data_160bb8:
		.string "AIL_end_sequence(0x%X)\n"
data_160bd0:
		.string "AIL_set_sequence_tempo(0x%X,%d,%d)\n"
data_160bf4:
		.string "AIL_set_sequence_volume(0x%X,%d,%d)\n"
		.ascii  "\x00\x00\x00"
data_160c1c:
		.string "AIL_set_XMIDI_master_volume(0x%X,%d)\n"
		.short  0x0
data_160c44:
		.string "AIL_set_XMIDI_master_volume(0x%X)\n"
		.byte	0x0
data_160c60:
		.string "AIL_sequence_tempo(0x%X)\n"
		.short  0x0
data_160c7c:
		.string "AIL_sequence_volume(0x%X)\n"
		.byte	0x0
data_160c98:
		.string "AIL_sequence_loop_count(0x%X)\n"
		.byte	0x0
data_160cb8:
		.string "AIL_set_XMIDI_master_volume(0x%X,%d)\n"
		.short  0x0
data_160ce0:
		.string "AIL_XMIDI_master_volume(0x%X)\n"
		.byte	0x0
data_160d00:
		.string "AIL_install_MDI_driver_image(0x%X,%u,0x%X)\n"
data_160d2c:
		.string "AIL_MDI_driver_type(0x%X)\n"
		.byte	0x0
data_160d48:
		.string "AIL_set_GTL_filename_prefix(%s)\n"
		.ascii  "\x00\x00\x00"
data_160d6c:
		.string "AIL_timbre_status(0x%X,%d,%d)\n"
		.byte	0x0
data_160d8c:
		.string "AIL_install_timbre(0x%X,%d,%d)\n"
data_160dac:
		.string "AIL_protect_timbre(0x%X,%d,%d)\n"
data_160dcc:
		.string "AIL_unprotect_timbre(0x%X,%d,%d)\n"
		.short  0x0
data_160df0:
		.string "AIL_active_sequence_count(0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160e14:
		.string "AIL_controller_value(0x%X,%d,%d)\n"
		.short  0x0
data_160e38:
		.string "AIL_channel_notes(0x%X,%d)\n"
data_160e54:
		.string "AIL_sequence_position(0x%X,0x%X,0x%X)\n"
		.byte	0x0
data_160e7c:
		.string "Result = %d:%d\n"
data_160e8c:
		.string "AIL_branch_index(0x%X,%u)\n"
		.byte	0x0
data_160ea8:
		.string "AIL_register_prefix_callback(0x%X,0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160ed4:
		.string "AIL_register_trigger_callback(0x%X,0x%X)\n"
		.short  0x0
data_160f00:
		.string "AIL_register_sequence_callback(0x%X,0x%X)\n"
		.byte	0x0
data_160f2c:
		.string "AIL_register_beat_callback(0x%X,0x%X)\n"
		.byte	0x0
data_160f54:
		.string "AIL_register_event_callback(0x%X,0x%X)\n"
data_160f7c:
		.string "AIL_register_timbre_callback(0x%X,0x%X)\n"
		.ascii  "\x00\x00\x00"
data_160fa8:
		.string "AIL_set_sequence_user_data(0x%X,%u,%d)\n"
data_160fd0:
		.string "AIL_sequence_user_data(0x%X,%u)\n"
		.ascii  "\x00\x00\x00"
data_160ff4:
		.string "AIL_register_ICA_array(0x%X,0x%X)\n"
		.byte	0x0
data_161018:
		.string "AIL_lock_channel(0x%X)\n"
data_161030:
		.string "AIL_release_channel(0x%X,%d)\n"
		.short  0x0
data_161050:
		.string "AIL_map_sequence_channel(0x%X,%d,%d)\n"
		.short  0x0
data_161078:
		.string "AIL_true_sequence_channel(0x%X,%d)\n"
data_16109c:
		.string "AIL_send_channel_voice_message(0x%X,0x%X,0x%X,0x%X,0x%X)\n"
		.short  0x0
data_1610d8:
		.string "AIL_send_sysex_message(0x%X,0x%X)\n"
		.byte	0x0
data_1610fc:
		.string "AIL_create_wave_synthesizer(0x%X,0x%X,0x%X,%d)\n"
data_16112c:
		.string "AIL_destroy_wave_synthesizer(0x%X)\n"



data_161820:
		.string "0123456789ABCDEF"
		.ascii  "\x00\x00\x00"
data_161834:
		.ascii  "\x72\x74\x00\x00"
data_161838:
		.string "DRIVER"
		.byte	0x0
data_161840:
		.string "DEVICE"
		.byte	0x0
data_161848:
		.string "IO_ADDR"
data_161850:
		.ascii  "\x49\x52\x51\x00"
data_161854:
		.string "DMA_8_bit"
		.short  0x0
data_161860:
		.string "DMA_16_bit"
		.byte	0x0
data_16186c:
		.string "Corrupted .INI file\n"
		.ascii  "\x00\x00\x00"
data_161884:
		.string "Insufficient memory for driver descriptor\n"
		.byte	0x0
data_1618b0:
		.string "Insufficient low memory\n"
		.ascii  "\x00\x00\x00"
data_1618cc:
		.string "AIL3DIG"
data_1618d4:
		.string "AIL3MDI"
data_1618dc:
		.string "Invalid driver type\n"
		.ascii  "\x00\x00\x00"
data_1618f4:
		.string "Out of driver handles\n"
		.byte	0x0
data_16190c:
		.string "Out of timer handles\n"
		.short  0x0
data_161924:
		.string "Minimum DMA buffer size too large for VDM\n"
		.byte	0x0
data_161950:
		.string "Could not allocate memory for driver\n"
		.short  0x0
data_161978:
		.string ".DIG driver required\n"
		.short  0x0
data_161990:
		.string "Digital sound hardware not found\n"
		.short  0x0
data_1619b4:
		.string "Could not allocate DMA buffers\n"
data_1619d4:
		.string "Could not allocate build buffer\n"
		.ascii  "\x00\x00\x00"
data_1619f8:
		.string "Could not allocate SAMPLE structures\n"
		.short  0x0
data_161a20:
		.string "Out of timer handles\n"
		.short  0x0
data_161a38:
		.string "%s/%s"
		.short  0x0
data_161a40:
		.string "Driver file not found\n"
		.byte	0x0
data_161a58:
		.string "Unable to open file DIG.INI\n"
		.ascii  "\x00\x00\x00"
data_161a78:
		.string "Out of sample handles\n"
		.byte	0x0
data_161a90:
		.string "fmt "
		.ascii  "\x00\x00\x00"
data_161a98:
		.string "data"
		.ascii  "\x00\x00\x00"
data_161aa0:
		.string "Creative"
		.ascii  "\x00\x00\x00"
data_161aac:
		.string "WAVE"
		.ascii  "\x00\x00\x00"
data_161ab4:
		.string "Unrecognized digital audio file type\n"
		.short  0x0
data_161adc:
		.string "Invalid or missing data block\n"
		.byte	0x0
data_161afc:
		.string "Unrecognized digital audio file type\n"
		.short  0x0
data_161b24:
		.string "Invalid or missing data block\n"
		.byte	0x0
data_161b44:
		.string "FORM"
		.ascii  "\x00\x00\x00"
data_161b4c:
		.string "CAT "
		.ascii  "\x00\x00\x00"
data_161b54:
		.string "XMID"
		.ascii  "\x00\x00\x00"
data_161b5c:
		.string "Internal note queue overflow\n"
		.short  0x0
data_161b7c:
		.string "Could not allocate memory for driver\n"
		.short  0x0
data_161ba4:
		.string ".MDI driver required\n"
		.short  0x0
data_161bbc:
		.string "XMIDI sound hardware not found\n"
data_161bdc:
		.string "Could not initialize instrument manager\n"
		.ascii  "\x00\x00\x00"
data_161c08:
		.string "Could not allocate SEQUENCE structures\n"
data_161c30:
		.string "Out of timer handles\n"
		.short  0x0
data_161c48:
		.string "%s/%s"
		.short  0x0
data_161c50:
		.string "Driver file not found\n"
		.byte	0x0
data_161c68:
		.string "Unable to open file MDI.INI\n"
		.ascii  "\x00\x00\x00"
data_161c88:
		.string "Tandy 3-voice music"
data_161c9c:
		.string "IBM internal speaker music"
		.byte	0x0
data_161cb8:
		.ascii  "\x2e\x41\x44\x00"
data_161cbc:
		.string ".OPL"
		.ascii  "\x00\x00\x00"
data_161cc4:
		.string "Out of sequence handles\n"
		.ascii  "\x00\x00\x00"
data_161ce0:
		.string "Invalid XMIDI sequence\n"
data_161cf8:
		.string "TIMB"
		.ascii  "\x00\x00\x00"
data_161d00:
		.string "RBRN"
		.ascii  "\x00\x00\x00"
data_161d08:
		.string "EVNT"
		.ascii  "\x00\x00\x00"
data_161d10:
		.string "No timbres loaded\n"
		.byte	0x0
data_161d24:
		.string "Driver could not install timbre bank %u, patch %u\n"
		.byte	0x0
data_161d58:
		.string "Driver could not install timbre bank %u, patch %u\n"
		.byte	0x0
data_161d8c:
		.string "Insufficient memory for HWAVE descriptor\n"
		.short  0x0


data_1621e0:
		.ascii  "JFMAMJJASOND"
data_1621ec:
		.ascii  "aeapauuuecoe"
data_1621f8:
		.ascii  "nbrrynlgptvc"
data_162204:
		.ascii  "SMTWTFS"
data_16220b:
		.ascii  "uouehra"
data_162212:
		.string "nneduit"
		.short  0x0


/* FILE * */
ail_debug_file:		/* 1e8fa0 */
		.long	0x0

AIL_debug:
		.long	0x0

/* 32-bit bool */
AIL_sys_debug:		/* 1e8fa8 */
		.long	0x0

data_1e8fac:
		.long	0x0
data_1e8fb0:
		.long	0x0
AIL_indent:
		.long	0x0
data_1e8fb8:
		.long	0x0
data_1e8fbc:
		.long	0x0
data_1e8fc0:
		.long	0x0
data_1e8fc4:
		.fill   0x18
data_1e8fdc:
		.fill   0x110

data_1ed6ac:
		.long	0x0
data_1ed6b0:
		.fill   0x40
data_1ed6f0:
		.fill   0x100
data_1ed7f0:
		.fill   0x18
data_1ed808:
		.long	0x0
data_1ed80c:
		.long	0x0
data_1ed810:
		.long	0x0
data_1ed814:
		.long	0x0
data_1ed818:
		.long	0x0
data_1ed81c:
		.long	0x0
data_1ed820:
		.long	0x0
data_1ed824:
		.long	0x0
data_1ed828:
		.long	0x0
data_1ed82c:
		.long	0x0
data_1ed830:
		.long	0x0
data_1ed834:
		.long	0x0
data_1ed838:
		.long	0x0
data_1ed83c:
		.long	0x0
data_1ed840:
		.long	0x0
data_1ed844:
		.long	0x0
data_1ed848:
		.long	0x0
data_1ed84c:
		.long	0x0
data_1ed850:
		.long	0x0
data_1ed854:
		.long	0x0
data_1ed858:
		.fill   0x18
data_1ed870:
		.fill   0x24
data_1ed894:
		.fill   0x1c
data_1ed8b0:
		.long	0x0
data_1ed8b4:
		.long	0x0
data_1ed8b8:
		.short  0x0
data_1ed8ba:
		.fill   0x6
data_1ed8c0:
		.long	0x0
data_1ed8c4:
		.long	0x0
data_1ed8c8:
		.long	0x0
data_1ed8cc:
		.long	0x0
data_1ed8d0:
		.fill   0x10
data_1ed8e0:
		.long	0x0
data_1ed8e4:
		.long	0x0
data_1ed8e8:
		.long	0x0
data_1ed8ec:
		.long	0x0
data_1ed8f0:
		.long	0x0
data_1ed8f4:
		.long	0x0
data_1ed8f8:
		.long	0x0
data_1ed8fc:
		.long	0x0
data_1ed900:
		.long	0x0
data_1ed904:
		.long	0x0
data_1ed908:
		.long	0x0
data_1ed90c:
		.long	0x0
data_1ed910:
		.long	0x0
data_1ed914:
		.fill   0x218
