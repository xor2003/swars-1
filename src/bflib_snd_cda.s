
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

.global EXPORT_SYMBOL(SoundProgressMessage);

/*
 * This function allocates some DOS memory.  The variables where the results
 * are saved are never referred to directly.
 */
/*----------------------------------------------------------------*/
EAL_init_realmode_mem:
/*----------------------------------------------------------------*/
		/* XXX: bail out */
		mov    $0x1,%eax
		ret

		push   %ebx
		push   %ecx
		push   %edx
		cmpw   $0x0,data_1edb7a
		je     jump_118476
		mov    $0x1,%eax
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret
	jump_118476:
		mov    $0x1000,%edx
		mov    $0x100,%ebx
		mov    $0x31,%eax
		mov    %ebx,data_1edb2c
		mov    $data_1edb2c,%ebx
		mov    %edx,data_1edb30
		mov    %ebx,%edx
		call   ac_dos_int386
		mov    data_1edb2c,%ax
		mov    %ax,data_1edb7a
		mov    data_1edb38,%ax
		mov    data_1edb44,%ecx
		mov    %ax,data_1edb7c
		test   %ecx,%ecx
		sete   %al
		xor    %ah,%ah
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*
 * uint16_t EAL_alloc_dos_mem (uint16_t paragraph_count)
 * Returns the real-mode segment of the allocated block.
 */
/*----------------------------------------------------------------*/
EAL_alloc_dos_mem:	/* 1184d0 */
/*----------------------------------------------------------------*/
		/* XXX: bail out */
		xor    %eax,%eax
		ret

		push   %ebx
		push   %edx
		mov    $0x100,%edx
		mov    $data_1edb2c,%ebx
		mov    %ax,data_1edb30
		mov    $0x31,%eax
		mov    %dx,data_1edb2c
		mov    %ebx,%edx
		call   ac_dos_int386
		cmpl   $0x0,data_1edb44
		je     jump_118503
		xor    %eax,%eax
		pop    %edx
		pop    %ebx
		ret
	jump_118503:
		mov    data_1edb2c,%ax
		pop    %edx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
EAL_free_dos_mem:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %edx
		mov    $0x100,%edx
		mov    $data_1edb2c,%ebx
		mov    %ax,data_1edb38
		mov    $0x31,%eax
		mov    %dx,data_1edb2c
		mov    %ebx,%edx
		call   ac_dos_int386
		cmpl   $0x0,data_1edb44
		sete   %al
		xor    %ah,%ah
		pop    %edx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (GetCDTrackLength_)
/*----------------------------------------------------------------*/
		mov    track_lengths(,%eax,4),%eax
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (GetCDTrackStartSector_)
/*----------------------------------------------------------------*/
		mov    track_start_sector(,%eax,4),%eax
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (is_daudio_track_)
/*----------------------------------------------------------------*/
		and    $0xffff,%eax
		mov    is_da_track(%eax),%al
		ret


/*----------------------------------------------------------------*/
mmssff_to_sector:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		mov    %eax,%edx
		mov    %eax,%ebx
		shr    $0x10,%edx
		xor    %ah,%ah
		shr    $0x8,%ebx
		mov    %eax,%esi
		xor    %dh,%dh
		xor    %bh,%bh
		and    $0xffff,%edx
		mov    %edx,%eax
		shl    $0x5,%eax
		sub    %edx,%eax
		lea    0x0(,%eax,4),%eax
		add    %edx,%eax
		lea    0x0(,%eax,4),%eax
		mov    %eax,%edx
		lea    0x0(,%eax,8),%ecx
		xor    %eax,%edx
		mov    %bx,%dx
		add    %eax,%ecx
		lea    0x0(,%edx,4),%eax
		add    %edx,%eax
		mov    %eax,%edx
		shl    $0x4,%eax
		sub    %edx,%eax
		add    %eax,%ecx
		xor    %eax,%eax
		mov    %si,%ax
		add    %ecx,%eax
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
cd_mem_init:
/*----------------------------------------------------------------*/
		push   %edx
		mov    $0x2,%eax
		call   EAL_alloc_dos_mem
		cwtl
		mov    %eax,cd_ioctli_low_mem
		mov    $0x100,%eax
		call   EAL_alloc_dos_mem
		cwtl
		mov    cd_ioctli_low_mem,%edx
		mov    %eax,cd_data_low_mem
		test   %edx,%edx
		je     jump_1079f6
		test   %eax,%eax
		je     jump_1079f6
		mov    $0x1,%eax
		pop    %edx
		ret
	jump_1079f6:
		xor    %eax,%eax
		pop    %edx
		ret


/*----------------------------------------------------------------*/
cd_check:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %ebp
		mov    $0x1500,%ebx
		mov    $0x300,%ecx
		mov    $0x2f,%esi
		mov    $data_1edb48,%ebp
		xor    %edx,%edx
		mov    $0x31,%eax
		mov    %edx,data_1edb58
		mov    %ebx,data_1edb64
		mov    %ecx,data_1edb2c
		mov    %esi,data_1edb30
		mov    $data_1edb2c,%ebx
		mov    %edx,data_1edb34
		mov    %ebx,%edx
		mov    %ebp,data_1edb40
		call   ac_dos_int386
		mov    data_1edb58,%ax
		mov    %ax,data_1e948c
		mov    data_1edb60,%ax
		mov    %ax,cd_first
		mov    data_1edb58,%eax
		pop    %ebp
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
cd_getaudiodiscinfo:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		mov    %eax,%edx
		mov    cd_ioctli_low_mem,%ebx
		test   %ebx,%ebx
		je     jump_107c7c
		mov    cd_data_low_mem,%ecx
		test   %ecx,%ecx
		jne    jump_107c83
	jump_107c7c:
		xor    %eax,%eax
		jmp    jump_107d50
	jump_107c83:
		mov    %ebx,%esi
		shl    $0x4,%esi
		movb   $0x1a,(%esi)
		movb   $0x0,0x1(%esi)
		movb   $0x3,0x2(%esi)
		mov    %ecx,%ebp
		movw   $0x0,0x3(%esi)
		mov    %ecx,%eax
		movb   $0x0,0xd(%esi)
		xor    %edi,%edi
		movw   $0x7,0x12(%esi)
		mov    $0x6,%ecx
		movw   $0x0,0x14(%esi)
		shl    $0x10,%eax
		movl   $0x0,0x16(%esi)
		shl    $0x4,%ebp
		mov    %eax,0xe(%esi)
		xor    %ebx,%ebx
		movb   $0xa,0x0(%ebp)
		mov    cd_ioctli_low_mem,%ax
		mov    %bx,data_1edb78
		mov    %bx,data_1edb76
		mov    %ax,data_1edb6a
		mov    %edi,data_1edb58
		mov    %edi,data_1edb34
		mov    $0x2f,%ebx
		xor    %eax,%eax
		mov    $data_1edb48,%edi
		mov    %dx,%ax
		mov    %ebx,data_1edb30
		mov    %edi,data_1edb40
		mov    $0x300,%edx
		mov    $data_1edb2c,%ebx
		mov    %eax,data_1edb60
		mov    $0x1510,%eax
		mov    %edx,data_1edb2c
		mov    %eax,data_1edb64
		mov    %ebx,%edx
		mov    $0x31,%eax
		mov    $data_1e94c8,%edi
		call   ac_dos_int386
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    $data_1e94a0,%edi
		mov    %ebp,%esi
		mov    data_1e94cb,%ax
		movsl  %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
	jump_107d50:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
cd_getaudiotrackinfo:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %esi
		push   %edi
		push   %ebp
		mov    %eax,%ebx
		mov    cd_ioctli_low_mem,%ecx
		test   %ecx,%ecx
		je     jump_107d7a
		cmpl   $0x0,cd_data_low_mem
		jne    jump_107d81
	jump_107d7a:
		xor    %eax,%eax
		jmp    jump_107e48
	jump_107d81:
		mov    %ecx,%esi
		shl    $0x4,%esi
		movb   $0x1a,(%esi)
		movb   $0x0,0x1(%esi)
		movb   $0x3,0x2(%esi)
		movw   $0x0,0x3(%esi)
		mov    cd_data_low_mem,%ebp
		movb   $0x0,0xd(%esi)
		mov    cd_data_low_mem,%eax
		movw   $0x7,0x12(%esi)
		xor    %edi,%edi
		movw   $0x0,0x14(%esi)
		shl    $0x10,%eax
		movl   $0x0,0x16(%esi)
		shl    $0x4,%ebp
		mov    %eax,0xe(%esi)
		mov    $0x6,%ecx
		movb   $0xb,0x0(%ebp)
		mov    cd_ioctli_low_mem,%ax
		mov    %dl,0x1(%ebp)
		mov    $0x300,%edx
		mov    %ax,data_1edb6a
		mov    %edi,data_1edb58
		mov    %edi,data_1edb34
		mov    $data_1edb48,%edi
		xor    %eax,%eax
		mov    %edx,data_1edb2c
		mov    %bx,%ax
		mov    %edi,data_1edb40
		mov    $0x2f,%ebx
		mov    %eax,data_1edb60
		mov    $0x1510,%eax
		mov    %ebx,data_1edb30
		mov    $data_1edb2c,%ebx
		mov    %eax,data_1edb64
		mov    $0x31,%eax
		mov    %ebx,%edx
		mov    $data_1e94c8,%edi
		call   ac_dos_int386
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    $data_1e94a8,%edi
		mov    %ebp,%esi
		mov    data_1e94cb,%ax
		movsl  %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
	jump_107e48:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
cd_getqchannelinfo:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		mov    %eax,%edx
		mov    cd_ioctli_low_mem,%ebx
		test   %ebx,%ebx
		je     jump_107e6c
		mov    cd_data_low_mem,%ecx
		test   %ecx,%ecx
		jne    jump_107e73
	jump_107e6c:
		xor    %eax,%eax
		jmp    jump_107f31
	jump_107e73:
		mov    %ebx,%esi
		shl    $0x4,%esi
		movb   $0x1a,(%esi)
		movb   $0x0,0x1(%esi)
		movb   $0x3,0x2(%esi)
		mov    %ecx,%ebp
		movw   $0x0,0x3(%esi)
		mov    %ecx,%eax
		movb   $0x0,0xd(%esi)
		xor    %edi,%edi
		movw   $0xb,0x12(%esi)
		mov    $0x2f,%ebx
		movw   $0x0,0x14(%esi)
		shl    $0x10,%eax
		movl   $0x0,0x16(%esi)
		shl    $0x4,%ebp
		mov    %eax,0xe(%esi)
		mov    cd_ioctli_low_mem,%ax
		movb   $0xc,0x0(%ebp)
		mov    $0x6,%ecx
		mov    %ax,data_1edb6a
		mov    %edi,data_1edb58
		mov    %ebx,data_1edb30
		mov    %edi,data_1edb34
		mov    $data_1edb48,%edi
		xor    %eax,%eax
		mov    $data_1edb2c,%ebx
		mov    %dx,%ax
		mov    %edi,data_1edb40
		mov    $0x300,%edx
		mov    %eax,data_1edb60
		mov    $0x1510,%eax
		mov    %edx,data_1edb2c
		mov    %eax,data_1edb64
		mov    %ebx,%edx
		mov    $0x31,%eax
		mov    $data_1e94c8,%edi
		call   ac_dos_int386
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    $data_1e94b0,%edi
		mov    %ebp,%esi
		mov    data_1e94cb,%ax
		movsl  %ds:(%esi),%es:(%edi)
		movsl  %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
	jump_107f31:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
mscdex_version:
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %ebp
		mov    $0x150c,%ebx
		mov    $0x300,%ecx
		mov    $0x2f,%esi
		mov    $data_1edb48,%ebp
		xor    %edx,%edx
		mov    $0x31,%eax
		mov    %edx,data_1edb58
		mov    %ebx,data_1edb64
		mov    %ecx,data_1edb2c
		mov    %esi,data_1edb30
		mov    $data_1edb2c,%ebx
		mov    %edx,data_1edb34
		mov    %ebx,%edx
		mov    %ebp,data_1edb40
		call   ac_dos_int386
		mov    data_1edb58,%eax
		pop    %ebp
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (cd_play_)
/*----------------------------------------------------------------*/
		push   %ecx
		push   %esi
		push   %edi
		push   %ebp
		cmpl   $0x0,cd_ioctli_low_mem
		je     jump_108177
		mov    cd_data_low_mem,%esi
		test   %esi,%esi
		jne    jump_10817e
	jump_108177:
		xor    %eax,%eax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ecx
		ret
	jump_10817e:
		shl    $0x4,%esi
		movb   $0x16,(%esi)
		movb   $0x0,0x1(%esi)
		movb   $0x84,0x2(%esi)
		movw   $0x0,0x3(%esi)
		movb   $0x0,0xd(%esi)
		mov    %edx,0xe(%esi)
		xor    %edi,%edi
		mov    %ebx,0x12(%esi)
		mov    cd_data_low_mem,%dx
		mov    %edi,data_1edb58
		mov    %dx,data_1edb6a
		mov    $0x1510,%ebp
		mov    $0x2f,%edx
		mov    $data_1edb48,%ecx
		mov    $data_1edb2c,%ebx
		and    $0xffff,%eax
		mov    %edi,data_1edb34
		mov    $data_1e94fc,%edi
		mov    %eax,data_1edb60
		mov    %edx,data_1edb30
		mov    %ecx,data_1edb40
		mov    $0x300,%eax
		mov    $0x5,%ecx
		mov    %ebx,%edx
		mov    %eax,data_1edb2c
		mov    $0x31,%eax
		mov    %ebp,data_1edb64
		call   ac_dos_int386
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		mov    $0x1,%ah
		mov    data_1e94ff,%dl
		mov    %ah,CD_Audio_Playing
		test   %ah,%dl
		je     jump_10823a
		push   $data_161150
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0x8,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
	jump_10823a:
		mov    data_1e94ff,%ax
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %ecx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (cd_stop_)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		cmpl   $0x0,cd_ioctli_low_mem
		je     jump_108269
		mov    cd_data_low_mem,%ebx
		test   %ebx,%ebx
		jne    jump_108270
	jump_108269:
		xor    %eax,%eax
		jmp    jump_1082ff
	jump_108270:
		mov    %ebx,%esi
		shl    $0x4,%esi
		movb   $0xd,(%esi)
		movb   $0x0,0x1(%esi)
		movb   $0x85,0x2(%esi)
		mov    cd_data_low_mem,%dx
		movw   $0x0,0x3(%esi)
		xor    %ecx,%ecx
		mov    %dx,data_1edb6a
		mov    %ecx,data_1edb58
		mov    $0x1510,%edi
		mov    $0x300,%ebp
		mov    $data_1edb48,%ebx
		and    $0xffff,%eax
		mov    %ecx,data_1edb34
		mov    %eax,data_1edb60
		mov    %edi,data_1edb64
		mov    %ebp,data_1edb2c
		mov    %ebx,data_1edb40
		mov    $0x2f,%eax
		mov    $data_1edb2c,%ebx
		mov    %eax,data_1edb30
		mov    %ebx,%edx
		mov    $0x31,%eax
		mov    $data_1e9514,%edi
		call   ac_dos_int386
		xor    %ah,%ah
		movsl  %ds:(%esi),%es:(%edi)
		movsl  %ds:(%esi),%es:(%edi)
		movsl  %ds:(%esi),%es:(%edi)
		movsb  %ds:(%esi),%es:(%edi)
		mov    %ah,CD_Audio_Playing
		mov    data_1e9517,%ax
	jump_1082ff:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (cd_init_)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		call   EAL_init_realmode_mem
		call   cd_mem_init
		test   %ax,%ax
		jne    jump_108408
		push   $data_16115c
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0x8,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
		xor    %al,%al
		jmp    jump_108658
	jump_108408:
		call   cd_check
		test   %eax,%eax
		jne    jump_108436
		push   $data_161178
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0x8,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
		xor    %al,%al
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret
	jump_108436:
		call   mscdex_version
		xor    %ebx,%ebx
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%edx
		mov    $0x3e8,%ecx
	jump_108447:
		xor    %eax,%eax
		mov    cd_first,%ax
		call   cd_getaudiodiscinfo
		test   $0x80,%ah
		je     jump_10849a
		xor    %ah,%ah
		and    $0xf,%al
		and    $0xffff,%eax
		mov    cd_errors(,%eax,4),%esi
		push   %esi
		push   $data_16119d
		push   %edx
		call   ac_sprintf
		add    $0xc,%esp
		mov    %edx,%eax
		call   SoundProgressLog_
		mov    %ecx,%eax
		call   delay_
		xor    %eax,%eax
		mov    %bx,%ax
		inc    %ebx
		cmp    $0x3,%eax
		jne    jump_108447
		xor    %al,%al
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret
	jump_10849a:
		push   $control_selector
		push   $control_real
		push   $control_prot
		push   $0x1
		call   MEM_alloc_DOS
		add    $0x10,%esp
		test   %eax,%eax
		jne    jump_1084dc
		push   $data_1611ab
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0x8,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
		xor    %al,%al
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret
	jump_1084dc:
		push   $data_1611d1
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0x8,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
		mov    data_1e94a1,%al
		xor    %bh,%bh
		mov    %al,data_1e947f
		mov    data_1e94a2,%al
		mov    data_1e94a1,%bl
		mov    %al,data_1e9480
		jmp    jump_10854f
	jump_108516:
		xor    %eax,%eax
		mov    cd_first,%ax
		call   cd_getaudiotrackinfo
		testb  $0x40,data_1e94ae
		sete   %al
		xor    %edx,%edx
		mov    %bx,%dx
		and    $0xff,%eax
		mov    %al,is_da_track(%edx)
		mov    data_1e94aa,%eax
		inc    %ebx
		call   mmssff_to_sector
		mov    %eax,track_start_sector(,%edx,4)
	jump_10854f:
		xor    %eax,%eax
		xor    %edx,%edx
		mov    data_1e94a2,%al
		mov    %bx,%dx
		cmp    %eax,%edx
		jle    jump_108516
		xor    %ah,%ah
		xor    %esi,%esi
		mov    data_1e94a1,%al
		jmp    jump_10856b
	jump_10856a:
		inc    %eax
	jump_10856b:
		xor    %ebx,%ebx
		xor    %edx,%edx
		mov    data_1e94a2,%bl
		mov    %ax,%dx
		cmp    %ebx,%edx
		jg     jump_10858c
		cmpb   $0x0,is_da_track(%edx)
		je     jump_10856a
		mov    $0x1,%esi
		jmp    jump_10856a
	jump_10858c:
		test   %si,%si
		jne    jump_1085b6
		push   $data_1611d8
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0x8,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
		xor    %al,%al
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret
	jump_1085b6:
		xor    %ah,%dh
		mov    data_1e9108,%esi
		mov    data_1e94a1,%dl
		jmp    jump_1085d7
	jump_1085c6:
		mov    track_start_sector(,%eax,4),%edi
		sub    %esi,%edi
		inc    %edx
		mov    %edi,track_start_sector(,%eax,4)
	jump_1085d7:
		xor    %ebx,%ebx
		xor    %eax,%eax
		mov    data_1e94a2,%bl
		mov    %dx,%ax
		cmp    %ebx,%eax
		jle    jump_1085c6
		xor    %dh,%dh
		mov    data_1e94a1,%dl
		jmp    jump_10861b
	jump_1085f2:
		mov    data_1e9108(%ebx),%eax
		mov    %eax,track_lengths(%ebx)
	jump_1085fe:
		xor    %eax,%eax
		mov    %dx,%ax
		mov    track_start_sector(,%eax,4),%ebx
		mov    track_lengths(,%eax,4),%ebp
		sub    %ebx,%ebp
		inc    %edx
		mov    %ebp,track_lengths(,%eax,4)
	jump_10861b:
		xor    %ecx,%ecx
		xor    %eax,%eax
		mov    data_1e94a2,%cl
		mov    %dx,%ax
		cmp    %ecx,%eax
		jg     jump_108649
		lea    0x0(,%eax,4),%ebx
		jne    jump_1085f2
		mov    data_1e94a3,%eax
		call   mmssff_to_sector
		sub    %esi,%eax
		mov    %eax,track_lengths(%ebx)
		jmp    jump_1085fe
	jump_108649:
		xor    %eax,%eax
		mov    cd_first,%ax
		call   cd_getqchannelinfo
		mov    $0x1,%al
	jump_108658:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		mov    %eax,%eax
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (GetCDFirst_)
/*----------------------------------------------------------------*/
		mov    cd_first,%ax
		ret

/*----------------------------------------------------------------*/
GLOBAL_FUNC (FreeCDAudio_)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		cmpb   $0x0,CD_Audio_Playing
		je     jump_1088a9
		xor    %eax,%eax
		mov    cd_first,%ax
		call   cd_stop_
	jump_1088a9:
		mov    control_selector,%edx
		push   %edx
		mov    control_real,%ebx
		push   %ebx
		push   $control_prot
		call   MEM_free_DOS
		xor    %eax,%eax
		add    $0xc,%esp
		mov    cd_ioctli_low_mem,%ax
		call   EAL_free_dos_mem
		xor    %eax,%eax
		mov    cd_data_low_mem,%ax
		call   EAL_free_dos_mem
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


/*----------------------------------------------------------------*/
GLOBAL_FUNC (SetCDAudioVolume_)
/*----------------------------------------------------------------*/
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		mov    cd_ioctli_low_mem,%edx
		test   %edx,%edx
		je     jump_108a37
		cmpl   $0x0,cd_data_low_mem
		je     jump_108a37
		mov    control_prot,%ecx
		test   %ecx,%ecx
		je     jump_108a37
		movb   $0x3,(%ecx)
		movb   $0x0,0x1(%ecx)
		movb   $0x1,0x3(%ecx)
		movb   $0x2,0x5(%ecx)
		movb   $0x0,0x6(%ecx)
		movb   $0x3,0x7(%ecx)
		movb   $0x0,0x8(%ecx)
		mov    %edx,%edi
		mov    %al,0x2(%ecx)
		mov    %ecx,%esi
		mov    %al,0x4(%ecx)
		mov    $0x9,%ecx
		shl    $0x4,%edi
		push   %edi
		mov    %ecx,%eax
		shr    $0x2,%ecx
		repnz movsl %ds:(%esi),%es:(%edi)
		mov    %al,%cl
		and    $0x3,%cl
		repnz movsb %ds:(%esi),%es:(%edi)
		pop    %edi
		mov    cd_data_low_mem,%esi
		shl    $0x4,%esi
		movb   $0x1a,(%esi)
		movb   $0x0,0x1(%esi)
		mov    $0x1510,%ebp
		movb   $0xc,0x2(%esi)
		mov    $data_1edb2c,%ebx
		movw   $0x0,0x3(%esi)
		mov    $0x2f,%edx
		movb   $0x0,0xd(%esi)
		mov    $data_1edb48,%ecx
		movw   $0x9,0x12(%esi)
		mov    cd_ioctli_low_mem,%eax
		movw   $0x0,0x14(%esi)
		shl    $0x10,%eax
		movl   $0x0,0x16(%esi)
		xor    %edi,%edi
		mov    %eax,0xe(%esi)
		mov    cd_data_low_mem,%ax
		mov    %edi,data_1edb58
		mov    %edx,data_1edb30
		mov    %edi,data_1edb34
		mov    %ecx,data_1edb40
		mov    %ax,data_1edb6a
		xor    %eax,%eax
		mov    $0x6,%ecx
		mov    cd_first,%ax
		mov    $data_1e9534,%edi
		mov    %eax,data_1edb60
		mov    $0x300,%eax
		mov    %ebx,%edx
		mov    %eax,data_1edb2c
		mov    $0x31,%eax
		mov    %ebp,data_1edb64
		call   ac_dos_int386
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		testb  $0x1,data_1e9537
		je     jump_108a37
		xor    %eax,%eax
		mov    data_1e9537,%ax
		push   %eax
		push   $data_16121d
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0xc,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
	jump_108a37:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret

GLOBAL_FUNC (GetCDAudioVolume_)
		push   %ebx
		push   %ecx
		push   %edx
		push   %esi
		push   %edi
		push   %ebp
		mov    cd_ioctli_low_mem,%edx
		test   %edx,%edx
		je     jump_108a63
		cmpl   $0x0,cd_data_low_mem
		je     jump_108a63
		mov    control_prot,%ecx
		test   %ecx,%ecx
		jne    jump_108a6a
	jump_108a63:
		xor    %al,%al
		jmp    jump_108ba5
	jump_108a6a:
		movb   $0x4,(%ecx)
		movb   $0x0,0x1(%ecx)
		movb   $0x0,0x2(%ecx)
		movb   $0x1,0x3(%ecx)
		movb   $0x0,0x4(%ecx)
		movb   $0x2,0x5(%ecx)
		movb   $0x0,0x6(%ecx)
		mov    %ecx,%esi
		movb   $0x3,0x7(%ecx)
		mov    %edx,%edi
		movb   $0x0,0x8(%ecx)
		mov    $0x9,%ecx
		shl    $0x4,%edi
		push   %edi
		mov    %ecx,%eax
		shr    $0x2,%ecx
		repnz movsl %ds:(%esi),%es:(%edi)
		mov    %al,%cl
		and    $0x3,%cl
		repnz movsb %ds:(%esi),%es:(%edi)
		pop    %edi
		mov    cd_data_low_mem,%esi
		shl    $0x4,%esi
		movb   $0x1a,(%esi)
		movb   $0x0,0x1(%esi)
		movb   $0x3,0x2(%esi)
		mov    $0x1510,%ebp
		movw   $0x0,0x3(%esi)
		mov    $data_1edb2c,%ebx
		movb   $0x0,0xd(%esi)
		mov    $0x2f,%edx
		movw   $0x9,0x12(%esi)
		mov    $data_1edb48,%ecx
		movw   $0x0,0x14(%esi)
		mov    control_real,%eax
		movl   $0x0,0x16(%esi)
		xor    %edi,%edi
		mov    %eax,0xe(%esi)
		mov    cd_data_low_mem,%ax
		mov    %edi,data_1edb58
		mov    %edx,data_1edb30
		mov    %edi,data_1edb34
		mov    %ecx,data_1edb40
		mov    %ax,data_1edb6a
		xor    %eax,%eax
		mov    $0x6,%ecx
		mov    cd_first,%ax
		mov    $data_1e9534,%edi
		mov    %eax,data_1edb60
		mov    $0x300,%eax
		mov    %ebx,%edx
		mov    %eax,data_1edb2c
		mov    $0x31,%eax
		mov    %ebp,data_1edb64
		call   ac_dos_int386
		rep movsl %ds:(%esi),%es:(%edi)
		movsw  %ds:(%esi),%es:(%edi)
		testb  $0x1,data_1e9537
		je     jump_108b81
		xor    %eax,%eax
		mov    data_1e9537,%ax
		push   %eax
		push   $data_16122b
		push   $EXPORT_SYMBOL(SoundProgressMessage)
		call   ac_sprintf
		add    $0xc,%esp
		mov    $EXPORT_SYMBOL(SoundProgressMessage),%eax
		call   SoundProgressLog_
	jump_108b81:
		mov    control_prot,%eax
		xor    %edx,%edx
		mov    0x2(%eax),%dl
		mov    0x4(%eax),%al
		and    $0xff,%eax
		add    %eax,%edx
		mov    %edx,%eax
		sar    $0x1f,%edx
		sub    %edx,%eax
		sar    %eax
		and    $0xff,%eax
		sar    %eax
	jump_108ba5:
		pop    %ebp
		pop    %edi
		pop    %esi
		pop    %edx
		pop    %ecx
		pop    %ebx
		ret


.data

cd_errors:
		.long   data_161239
		.long   data_161251
		.long   data_16125e
		.long   data_16126e
		.long   data_16127e
		.long   data_161288
		.long   data_1612ab
		.long   data_1612b6
		.long   data_1612c4
		.long   data_1612d5
		.long   data_1612ea
		.long   data_1612f6
		.long   data_161301
		.long   data_161311
		.long   data_16131a
		.long   data_161323


data_161239:
		.string "Write-protect violation"
data_161251:
		.string "Unknown unit"
data_16125e:
		.string "Drive not ready"
data_16126e:
		.string "Unknown command"
data_16127e:
		.string "CRC error"
data_161288:
		.string "Bad drive request structure length"
data_1612ab:
		.string "Seek error"
data_1612b6:
		.string "Unknown media"
data_1612c4:
		.string "Sector not found"
data_1612d5:
		.string "Printer out of paper"
data_1612ea:
		.string "Write fault"
data_1612f6:
		.string "Read fault"
data_161301:
		.string "General failure"
data_161311:
		.string "Reserved"
data_16131a:
		.string "Reserved"
data_161323:
		.string "Invalid disk change"
		.byte	0x0


data_161150:
		.string "cd error--\n"
data_16115c:
		.string "cannot allocate low memory\n"
data_161178:
		.string "no cd drive or mscdex not installed\n"
data_16119d:
		.string "cd error--%s\n"
data_1611ab:
		.string "could not allocate low memory for cd\n"
data_1611d1:
		.string "cd ok\n"
data_1611d8:
		.string "no da tracks to play\n"
data_1611ee:
		.string "\rCD Head at %02dm:%02ds:%02df, enter option: $"
data_16121d:
		.string "cd error--%d\n"
data_16122b:
		.string "cd error--%d\n"

current_da_track:
		.fill   0x18
track_start_sector:
		.long	0x0
data_1e9108:
		.fill   0x188
track_lengths:
		.fill   0x18c
is_da_track:
		.fill   0x63
data_1e947f:
		.byte	0x0
data_1e9480:
		.byte	0x0
CD_Audio_Playing:
		.ascii  "\x00\x00\x00"
cd_ioctli_low_mem:
		.long	0x0
cd_data_low_mem:
		.long	0x0
data_1e948c:
		.short  0x0
cd_first:
		.short  0x0
data_1e9490:
		.fill   0x8
data_1e9498:
		.fill   0x8
data_1e94a0:
		.byte	0x0
data_1e94a1:
		.byte	0x0
data_1e94a2:
		.byte	0x0
data_1e94a3:
		.fill   0x5
data_1e94a8:
		.short  0x0
data_1e94aa:
		.long	0x0
data_1e94ae:
		.short  0x0
data_1e94b0:
		.fill   0x8
data_1e94b8:
		.byte	0x0
data_1e94b9:
		.byte	0x0
data_1e94ba:
		.short  0x0
data_1e94bc:
		.fill   0xc
data_1e94c8:
		.ascii  "\x00\x00\x00"
data_1e94cb:
		.fill   0x19
data_1e94e4:
		.ascii  "\x00\x00\x00"
data_1e94e7:
		.fill   0x15
data_1e94fc:
		.ascii  "\x00\x00\x00"
data_1e94ff:
		.fill   0x15
data_1e9514:
		.ascii  "\x00\x00\x00"
data_1e9517:
		.fill   0xd
data_1e9524:
		.ascii  "\x00\x00\x00"
data_1e9527:
		.fill   0xd
data_1e9534:
		.ascii  "\x00\x00\x00"
data_1e9537:
		.fill   0x19
control_real:
		.long	0x0
control_selector:
		.long	0x0
control_prot:
		.long	0x0

data_1edb2c:
		.long	0x0
data_1edb30:
		.long	0x0
data_1edb34:
		.long	0x0
data_1edb38:
		.fill   0x8
data_1edb40:
		.long	0x0
data_1edb44:
		.long	0x0
data_1edb48:
		.fill   0x10
data_1edb58:
		.long	0x0
data_1edb5c:
		.long	0x0
data_1edb60:
		.long	0x0
data_1edb64:
		.fill   0x6
data_1edb6a:
		.short  0x0
data_1edb6c:
		.fill   0xa
data_1edb76:
		.short  0x0
data_1edb78:
		.short  0x0
data_1edb7a:
		.short  0x0
data_1edb7c:
		.long	0x0
