
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

.global EXPORT_SYMBOL(poly_screen);
.global EXPORT_SYMBOL(vec_map);
.global EXPORT_SYMBOL(vec_screen_width);
.global EXPORT_SYMBOL(polyscans);
.global EXPORT_SYMBOL(vec_colour);
.global EXPORT_SYMBOL(vec_mode);
.global EXPORT_SYMBOL(vec_window_height);
.global EXPORT_SYMBOL(vec_window_width);
.global EXPORT_SYMBOL(_fade_table);
.global EXPORT_SYMBOL(_ghost_table);


/*----------------------------------------------------------------*/
/* Behold - core of the Bullfrog engine, triangle rendering function */
GLOBAL_FUNC (original_trig_)
/*----------------------------------------------------------------*/
		pusha
		sub    $0x6c,%esp
		mov    %eax,%esi
		mov    %edx,%edi
		mov    %ebx,%ecx
		mov    0x4(%esi),%eax
		mov    0x4(%edi),%ebx
		mov    0x4(%ecx),%edx
		cmp    %ebx,%eax
		je     jump_120dff
		jg     jump_120dc5
		cmp    %edx,%eax
		je     jump_120dec
		jl     jump_120e3a
		xchg   %esi,%ecx
		xchg   %edi,%ecx
		jmp    jump_120e44
	jump_120dc5:
		cmp    %edx,%eax
		je     jump_1220b4
		jl     jump_12174d
		cmp    %edx,%ebx
		je     jump_122533
		jl     jump_120de6
		xchg   %esi,%ecx
		xchg   %edi,%ecx
		jmp    jump_121751
	jump_120de6:
		xchg   %esi,%edi
		xchg   %edi,%ecx
		jmp    jump_120e44
	jump_120dec:
		mov    (%esi),%eax
		cmp    (%ecx),%eax
		jle    jump_122a92
		xchg   %esi,%ecx
		xchg   %edi,%ecx
		jmp    jump_122541
	jump_120dff:
		cmp    %edx,%eax
		je     jump_122a92
		jl     jump_120e1c
		mov    (%esi),%eax
		cmp    (%edi),%eax
		jle    jump_122a92
		xchg   %esi,%ecx
		xchg   %edi,%ecx
		jmp    jump_1220c2
	jump_120e1c:
		mov    (%edi),%eax
		cmp    (%esi),%eax
		jle    jump_122a92
		jmp    jump_122541
	jump_120e2b:
		mov    (%edi),%eax
		cmp    (%ecx),%eax
		jle    jump_122a92
		jmp    jump_1220c2
	jump_120e3a:
		cmp    %edx,%ebx
		je     jump_120e2b
		jg     jump_121751
	jump_120e44:
		mov    0x4(%esi),%eax
		mov    %eax,0x54(%esp)
		or     %eax,%eax
		jns    jump_120e5f
		mov    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x1,0x66(%esp)
		jmp    jump_120e82
	jump_120e5f:
		cmp    EXPORT_SYMBOL(vec_window_height),%eax
		jge    jump_122a92
		mov    %eax,%ebx
		imul   EXPORT_SYMBOL(vec_screen_width),%ebx
		add    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x0,0x66(%esp)
	jump_120e82:
		mov    0x4(%ecx),%ebx
		cmp    EXPORT_SYMBOL(vec_window_height),%ebx
		setg   0x68(%esp)
		sub    %eax,%ebx
		mov    %ebx,0x10(%esp)
		mov    %ebx,0x20(%esp)
		mov    0x4(%edi),%ebx
		cmp    EXPORT_SYMBOL(vec_window_height),%ebx
		setg   0x67(%esp)
		sub    %eax,%ebx
		mov    %ebx,0x14(%esp)
		mov    (%ecx),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x4(%esp)
		mov    (%edi),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x14(%esp)
		cmp    0x4(%esp),%eax
		jle    jump_122a92
		mov    %eax,0x8(%esp)
		mov    0x4(%ecx),%ebx
		sub    0x4(%edi),%ebx
		mov    (%ecx),%eax
		sub    (%edi),%eax
		shl    $0x10,%eax
		cltd
		idiv   %ebx
		mov    %eax,0xc(%esp)
		mov    %ebx,0x18(%esp)
		mov    (%edi),%eax
		shl    $0x10,%eax
		mov    %eax,0x1c(%esp)
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_120f07(,%eax,4)

vtable_120f07:
		.long   func_121601
		.long   func_12142f
		.long   func_121201
		.long   func_121201
		.long   func_12142f
		.long   func_120f73
		.long   func_120f73
		.long   func_121201
		.long   func_121201
		.long   func_121201
		.long   func_121201
		.long   func_121201
		.long   func_121201
		.long   func_121201
		.long   func_121601
		.long   func_121601
		.long   func_12142f
		.long   func_12142f
		.long   func_121201
		.long   func_121201
		.long   func_120f73
		.long   func_120f73
		.long   func_121201
		.long   func_121201
		.long   func_120f73
		.long   func_120f73
		.long   func_120f73


/*----------------------------------------------------------------*/
func_120f73:
/*----------------------------------------------------------------*/
		mov    0x14(%esp),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x5c(%esp)
		mov    (%esi),%eax
		sub    (%ecx),%eax
		imull  0x5c(%esp)
		sar    $0x10,%eax
		mov    (%edi),%ebx
		sub    (%esi),%ebx
		add    %eax,%ebx
		jl     jump_122a92
		je     jump_120fee
		inc    %ebx
		mov    0x8(%esi),%eax
		sub    0x8(%ecx),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x8(%edi),%eax
		sub    0x8(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%esi),%eax
		sub    0xc(%ecx),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0xc(%edi),%eax
		sub    0xc(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
		mov    0x10(%esi),%eax
		sub    0x10(%ecx),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x10(%edi),%eax
		sub    0x10(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
	jump_120fee:
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x34(%esp)
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x40(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_12114f
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x14(%esp),%edi
		js     jump_1210e7
		mov    0x4(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%eax
		mov    0x28(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%esi
		mov    0x1c(%esp),%ebx
		mov    0x48(%esp),%edi
		sub    0x14(%esp),%edi
		sub    %edi,0x18(%esp)
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x48(%esp),%edi
		imul   0xc(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_1210dc
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_1210dc:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_1211b3
	jump_1210e7:
		mov    0x48(%esp),%edi
		sub    %edi,0x14(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_12117e
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121140
		mov    %edi,0x14(%esp)
		jmp    jump_12114d
	jump_121140:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_12114d:
		jmp    jump_12117e
	jump_12114f:
		cmpb   $0x0,0x68(%esp)
		je     jump_12117e
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121171
		mov    %edi,0x14(%esp)
		jmp    jump_12117e
	jump_121171:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_12117e:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_121184:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x14(%esp)
		jne    jump_121184
		mov    0x1c(%esp),%ebx
	jump_1211b3:
		cmpb   $0x0,0x67(%esp)
		je     jump_1211c8
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_1211c8:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0xc(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_1211c8
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_121201:
/*----------------------------------------------------------------*/
		mov    0x14(%esp),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x5c(%esp)
		mov    (%esi),%eax
		sub    (%ecx),%eax
		imull  0x5c(%esp)
		sar    $0x10,%eax
		mov    (%edi),%ebx
		sub    (%esi),%ebx
		add    %eax,%ebx
		jl     jump_122a92
		je     jump_121261
		inc    %ebx
		mov    0x8(%esi),%eax
		sub    0x8(%ecx),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x8(%edi),%eax
		sub    0x8(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%esi),%eax
		sub    0xc(%ecx),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0xc(%edi),%eax
		sub    0xc(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
	jump_121261:
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x34(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		cmpb   $0x0,0x66(%esp)
		je     jump_12138b
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x14(%esp),%edi
		js     jump_12132e
		mov    0x4(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%eax
		mov    0x28(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%edx
		mov    0x1c(%esp),%ebx
		mov    0x48(%esp),%edi
		sub    0x14(%esp),%edi
		sub    %edi,0x18(%esp)
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x48(%esp),%edi
		imul   0xc(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		cmpb   $0x0,0x68(%esp)
		je     jump_121323
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_121323:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_1213e8
	jump_12132e:
		mov    0x48(%esp),%edi
		sub    %edi,0x14(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		cmpb   $0x0,0x68(%esp)
		je     jump_1213ba
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_12137c
		mov    %edi,0x14(%esp)
		jmp    jump_121389
	jump_12137c:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121389:
		jmp    jump_1213ba
	jump_12138b:
		cmpb   $0x0,0x68(%esp)
		je     jump_1213ba
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_1213ad
		mov    %edi,0x14(%esp)
		jmp    jump_1213ba
	jump_1213ad:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_1213ba:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_1213c0:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		add    $0x14,%edi
		decl   0x14(%esp)
		jne    jump_1213c0
		mov    0x1c(%esp),%ebx
	jump_1213e8:
		cmpb   $0x0,0x67(%esp)
		je     jump_1213fd
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_1213fd:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0xc(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_1213fd
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_12142f:
/*----------------------------------------------------------------*/
		mov    0x14(%esp),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x5c(%esp)
		mov    (%esi),%eax
		sub    (%ecx),%eax
		imull  0x5c(%esp)
		sar    $0x10,%eax
		mov    (%edi),%ebx
		sub    (%esi),%ebx
		add    %eax,%ebx
		jl     jump_122a92
		je     jump_121474
		inc    %ebx
		mov    0x10(%esi),%eax
		sub    0x10(%ecx),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x10(%edi),%eax
		sub    0x10(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
	jump_121474:
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x40(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_12156b
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x14(%esp),%edi
		js     jump_121519
		mov    0x4(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%eax
		mov    0x40(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%esi
		mov    0x1c(%esp),%ebx
		mov    0x48(%esp),%edi
		sub    0x14(%esp),%edi
		sub    %edi,0x18(%esp)
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x48(%esp),%edi
		imul   0xc(%esp),%edi
		add    %edi,%ebx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_12150e
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_12150e:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_1215c1
	jump_121519:
		mov    0x48(%esp),%edi
		sub    %edi,0x14(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_12159a
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_12155c
		mov    %edi,0x14(%esp)
		jmp    jump_121569
	jump_12155c:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121569:
		jmp    jump_12159a
	jump_12156b:
		cmpb   $0x0,0x68(%esp)
		je     jump_12159a
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_12158d
		mov    %edi,0x14(%esp)
		jmp    jump_12159a
	jump_12158d:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_12159a:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_1215a0:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x14(%esp)
		jne    jump_1215a0
		mov    0x1c(%esp),%ebx
	jump_1215c1:
		cmpb   $0x0,0x67(%esp)
		je     jump_1215d6
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_1215d6:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0xc(%esp),%ebx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_1215d6
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_121601:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		cmpb   $0x0,0x66(%esp)
		je     jump_1216c5
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x14(%esp),%edi
		js     jump_12167e
		mov    0x4(%esp),%edi
		imul   0x14(%esp),%edi
		add    %edi,%eax
		mov    0x1c(%esp),%ebx
		mov    0x48(%esp),%edi
		sub    0x14(%esp),%edi
		sub    %edi,0x18(%esp)
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x48(%esp),%edi
		imul   0xc(%esp),%edi
		add    %edi,%ebx
		cmpb   $0x0,0x68(%esp)
		je     jump_121673
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_121673:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_121714
	jump_12167e:
		mov    0x48(%esp),%edi
		sub    %edi,0x14(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		cmpb   $0x0,0x68(%esp)
		je     jump_1216f4
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_1216b6
		mov    %edi,0x14(%esp)
		jmp    jump_1216c3
	jump_1216b6:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_1216c3:
		jmp    jump_1216f4
	jump_1216c5:
		cmpb   $0x0,0x68(%esp)
		je     jump_1216f4
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_1216e7
		mov    %edi,0x14(%esp)
		jmp    jump_1216f4
	jump_1216e7:
		sub    0x14(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_1216f4:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_1216fa:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		add    $0x14,%edi
		decl   0x14(%esp)
		jne    jump_1216fa
		mov    0x1c(%esp),%ebx
	jump_121714:
		cmpb   $0x0,0x67(%esp)
		je     jump_121729
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_121729:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0xc(%esp),%ebx
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_121729
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_12174d:
		xchg   %esi,%edi
		xchg   %edi,%ecx
	jump_121751:
		mov    0x4(%esi),%eax
		mov    %eax,0x54(%esp)
		or     %eax,%eax
		jns    jump_12176c
		mov    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x1,0x66(%esp)
		jmp    jump_12178f
	jump_12176c:
		cmp    EXPORT_SYMBOL(vec_window_height),%eax
		jge    jump_122a92
		mov    %eax,%ebx
		imul   EXPORT_SYMBOL(vec_screen_width),%ebx
		add    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x0,0x66(%esp)
	jump_12178f:
		mov    0x4(%ecx),%ebx
		cmp    EXPORT_SYMBOL(vec_window_height),%ebx
		setg   0x67(%esp)
		sub    %eax,%ebx
		mov    %ebx,0x10(%esp)
		mov    0x4(%edi),%ebx
		cmp    EXPORT_SYMBOL(vec_window_height),%ebx
		setg   0x68(%esp)
		sub    %eax,%ebx
		mov    %ebx,0x14(%esp)
		mov    %ebx,0x20(%esp)
		mov    (%ecx),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x4(%esp)
		mov    (%edi),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x14(%esp)
		cmp    0x4(%esp),%eax
		jle    jump_122a92
		mov    %eax,0x8(%esp)
		mov    0x4(%edi),%ebx
		sub    0x4(%ecx),%ebx
		mov    (%edi),%eax
		sub    (%ecx),%eax
		shl    $0x10,%eax
		cltd
		idiv   %ebx
		mov    %eax,0xc(%esp)
		mov    %ebx,0x18(%esp)
		mov    (%ecx),%eax
		shl    $0x10,%eax
		mov    %eax,0x1c(%esp)
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_121814(,%eax,4)

vtable_121814:
		.long   func_121f68
		.long   func_121d87
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121d87
		.long   func_121880
		.long   func_121880
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121f68
		.long   func_121f68
		.long   func_121d87
		.long   func_121d87
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121880
		.long   func_121880
		.long   func_121b3b
		.long   func_121b3b
		.long   func_121880
		.long   func_121880
		.long   func_121880


/*----------------------------------------------------------------*/
func_121880:
/*----------------------------------------------------------------*/
		mov    0x10(%esp),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x14(%esp)
		mov    %eax,0x5c(%esp)
		mov    (%edi),%eax
		sub    (%esi),%eax
		imull  0x5c(%esp)
		sar    $0x10,%eax
		mov    (%esi),%ebx
		sub    (%ecx),%ebx
		add    %eax,%ebx
		jl     jump_122a92
		je     jump_1218f7
		inc    %ebx
		mov    0x8(%edi),%eax
		sub    0x8(%esi),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x8(%esi),%eax
		sub    0x8(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%esi),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0xc(%esi),%eax
		sub    0xc(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
		mov    0x10(%edi),%eax
		sub    0x10(%esi),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x10(%esi),%eax
		sub    0x10(%ecx),%eax
		cltd
		idiv   %ebx
	jump_1218f7:
		mov    %eax,0x3c(%esp)
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x34(%esp)
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x40(%esp)
		mov    0x8(%edi),%eax
		sub    0x8(%ecx),%eax
		cltd
		idivl  0x18(%esp)
		mov    %eax,0x2c(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%ecx),%eax
		cltd
		idivl  0x18(%esp)
		mov    %eax,0x38(%esp)
		mov    0x10(%edi),%eax
		sub    0x10(%ecx),%eax
		cltd
		idivl  0x18(%esp)
		mov    %eax,0x44(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_121a89
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x10(%esp),%edi
		js     jump_121a21
		mov    0x8(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%esi
		mov    0x1c(%esp),%eax
		mov    0x48(%esp),%edi
		sub    0x10(%esp),%edi
		mov    %edi,0x48(%esp)
		sub    %edi,0x18(%esp)
		imul   0xc(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x2c(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x38(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x44(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_121a16
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_121a16:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_121aed
	jump_121a21:
		mov    0x48(%esp),%edi
		sub    %edi,0x10(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_121ab8
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121a7a
		mov    %edi,0x10(%esp)
		jmp    jump_121a87
	jump_121a7a:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121a87:
		jmp    jump_121ab8
	jump_121a89:
		cmpb   $0x0,0x68(%esp)
		je     jump_121ab8
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121aab
		mov    %edi,0x10(%esp)
		jmp    jump_121ab8
	jump_121aab:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121ab8:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_121abe:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_121abe
		mov    0x1c(%esp),%eax
	jump_121aed:
		cmpb   $0x0,0x67(%esp)
		je     jump_121b02
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_121b02:
		mov    %eax,(%edi)
		add    0xc(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x2c(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x38(%esp),%edx
		mov    %esi,0x10(%edi)
		add    0x44(%esp),%esi
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_121b02
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_121b3b:
/*----------------------------------------------------------------*/
		mov    0x10(%esp),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x14(%esp)
		mov    %eax,0x5c(%esp)
		mov    (%edi),%eax
		sub    (%esi),%eax
		imull  0x5c(%esp)
		sar    $0x10,%eax
		mov    (%esi),%ebx
		sub    (%ecx),%ebx
		add    %eax,%ebx
		jl     jump_122a92
		je     jump_121b9b
		inc    %ebx
		mov    0x8(%edi),%eax
		sub    0x8(%esi),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x8(%esi),%eax
		sub    0x8(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%esi),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0xc(%esi),%eax
		sub    0xc(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
	jump_121b9b:
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x34(%esp)
		mov    0x8(%edi),%eax
		sub    0x8(%ecx),%eax
		cltd
		idivl  0x18(%esp)
		mov    %eax,0x2c(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%ecx),%eax
		cltd
		idivl  0x18(%esp)
		mov    %eax,0x38(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		cmpb   $0x0,0x66(%esp)
		je     jump_121ce3
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x10(%esp),%edi
		js     jump_121c86
		mov    0x8(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%edx
		mov    0x1c(%esp),%eax
		mov    0x48(%esp),%edi
		sub    0x10(%esp),%edi
		mov    %edi,0x48(%esp)
		sub    %edi,0x18(%esp)
		imul   0xc(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x2c(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x38(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		cmpb   $0x0,0x68(%esp)
		je     jump_121c7b
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_121c7b:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_121d40
	jump_121c86:
		mov    0x48(%esp),%edi
		sub    %edi,0x10(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		cmpb   $0x0,0x68(%esp)
		je     jump_121d12
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121cd4
		mov    %edi,0x10(%esp)
		jmp    jump_121ce1
	jump_121cd4:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121ce1:
		jmp    jump_121d12
	jump_121ce3:
		cmpb   $0x0,0x68(%esp)
		je     jump_121d12
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121d05
		mov    %edi,0x10(%esp)
		jmp    jump_121d12
	jump_121d05:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121d12:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_121d18:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_121d18
		mov    0x1c(%esp),%eax
	jump_121d40:
		cmpb   $0x0,0x67(%esp)
		je     jump_121d55
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_121d55:
		mov    %eax,(%edi)
		add    0xc(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x2c(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x38(%esp),%edx
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_121d55
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_121d87:
/*----------------------------------------------------------------*/
		mov    0x10(%esp),%eax
		shl    $0x10,%eax
		cltd
		idivl  0x14(%esp)
		mov    %eax,0x5c(%esp)
		mov    (%edi),%eax
		sub    (%esi),%eax
		imull  0x5c(%esp)
		sar    $0x10,%eax
		mov    (%esi),%ebx
		sub    (%ecx),%ebx
		add    %eax,%ebx
		jl     jump_122a92
		je     jump_121dcc
		inc    %ebx
		mov    0x10(%edi),%eax
		sub    0x10(%esi),%eax
		imull  0x5c(%esp)
		shrd   $0x10,%edx,%eax
		add    0x10(%esi),%eax
		sub    0x10(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
	jump_121dcc:
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x10(%esp)
		mov    %eax,0x40(%esp)
		mov    0x10(%edi),%eax
		sub    0x10(%ecx),%eax
		cltd
		idivl  0x18(%esp)
		mov    %eax,0x44(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_121ed2
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x10(%esp),%edi
		js     jump_121e80
		mov    0x8(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%ebx
		mov    0x40(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%esi
		mov    0x1c(%esp),%eax
		mov    0x48(%esp),%edi
		sub    0x10(%esp),%edi
		mov    %edi,0x48(%esp)
		sub    %edi,0x18(%esp)
		imul   0xc(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x44(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_121e75
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_121e75:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_121f28
	jump_121e80:
		mov    0x48(%esp),%edi
		sub    %edi,0x10(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x68(%esp)
		je     jump_121f01
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121ec3
		mov    %edi,0x10(%esp)
		jmp    jump_121ed0
	jump_121ec3:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121ed0:
		jmp    jump_121f01
	jump_121ed2:
		cmpb   $0x0,0x68(%esp)
		je     jump_121f01
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_121ef4
		mov    %edi,0x10(%esp)
		jmp    jump_121f01
	jump_121ef4:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_121f01:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_121f07:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_121f07
		mov    0x1c(%esp),%eax
	jump_121f28:
		cmpb   $0x0,0x67(%esp)
		je     jump_121f3d
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_121f3d:
		mov    %eax,(%edi)
		add    0xc(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %esi,0x10(%edi)
		add    0x44(%esp),%esi
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_121f3d
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_121f68:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		cmpb   $0x0,0x66(%esp)
		je     jump_12202c
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		cmp    0x10(%esp),%edi
		js     jump_121fe5
		mov    0x8(%esp),%edi
		imul   0x10(%esp),%edi
		add    %edi,%ebx
		mov    0x1c(%esp),%eax
		mov    0x48(%esp),%edi
		sub    0x10(%esp),%edi
		mov    %edi,0x48(%esp)
		sub    %edi,0x18(%esp)
		imul   0xc(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		cmpb   $0x0,0x68(%esp)
		je     jump_121fda
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x18(%esp)
		mov    %edi,0x20(%esp)
	jump_121fda:
		lea    EXPORT_SYMBOL(polyscans),%edi
		jmp    jump_12207b
	jump_121fe5:
		mov    0x48(%esp),%edi
		sub    %edi,0x10(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		cmpb   $0x0,0x68(%esp)
		je     jump_12205b
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_12201d
		mov    %edi,0x10(%esp)
		jmp    jump_12202a
	jump_12201d:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_12202a:
		jmp    jump_12205b
	jump_12202c:
		cmpb   $0x0,0x68(%esp)
		je     jump_12205b
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		cmpb   $0x0,0x67(%esp)
		je     jump_12204e
		mov    %edi,0x10(%esp)
		jmp    jump_12205b
	jump_12204e:
		sub    0x10(%esp),%edi
		setle  0x67(%esp)
		mov    %edi,0x18(%esp)
	jump_12205b:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_122061:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_122061
		mov    0x1c(%esp),%eax
	jump_12207b:
		cmpb   $0x0,0x67(%esp)
		je     jump_122090
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_122090:
		mov    %eax,(%edi)
		add    0xc(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		add    $0x14,%edi
		decl   0x18(%esp)
		jne    jump_122090
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_1220b4:
		mov    (%ecx),%eax
		cmp    (%esi),%eax
		jle    jump_122a92
		xchg   %esi,%edi
		xchg   %edi,%ecx
	jump_1220c2:
		mov    0x4(%esi),%eax
		mov    %eax,0x54(%esp)
		or     %eax,%eax
		jns    jump_1220dd
		mov    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x1,0x66(%esp)
		jmp    jump_122100
	jump_1220dd:
		cmp    EXPORT_SYMBOL(vec_window_height),%eax
		jge    jump_122a92
		mov    %eax,%ebx
		imul   EXPORT_SYMBOL(vec_screen_width),%ebx
		add    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x0,0x66(%esp)
	jump_122100:
		mov    0x4(%ecx),%ebx
		cmp    EXPORT_SYMBOL(vec_window_height),%ebx
		setg   0x67(%esp)
		sub    %eax,%ebx
		mov    %ebx,0x10(%esp)
		mov    %ebx,0x20(%esp)
		mov    (%ecx),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idiv   %ebx
		mov    %eax,0x4(%esp)
		mov    (%edi),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idiv   %ebx
		mov    %eax,0x8(%esp)
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_122142(,%eax,4)

vtable_122142:
		.long   func_1224a1
		.long   func_1223da
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1223da
		.long   func_1221ae
		.long   func_1221ae
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1224a1
		.long   func_1224a1
		.long   func_1223da
		.long   func_1223da
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1221ae
		.long   func_1221ae
		.long   func_1222d7
		.long   func_1222d7
		.long   func_1221ae
		.long   func_1221ae
		.long   func_1221ae


/*----------------------------------------------------------------*/
func_1221ae:
/*----------------------------------------------------------------*/
		mov    (%edi),%ebx
		sub    (%ecx),%ebx
		mov    0x8(%edi),%eax
		sub    0x8(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
		mov    0x10(%edi),%eax
		sub    0x10(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x34(%esp)
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x40(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_12227f
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x67(%esp)
		je     jump_122298
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_122298
	jump_12227f:
		cmpb   $0x0,0x67(%esp)
		je     jump_122298
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_122298:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_12229e:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_12229e
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_1222d7:
/*----------------------------------------------------------------*/
		mov    (%edi),%ebx
		sub    (%ecx),%ebx
		mov    0x8(%edi),%eax
		sub    0x8(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x34(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		cmpb   $0x0,0x66(%esp)
		je     jump_122389
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x67(%esp)
		je     jump_1223a2
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_1223a2
	jump_122389:
		cmpb   $0x0,0x67(%esp)
		je     jump_1223a2
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_1223a2:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_1223a8:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_1223a8
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_1223da:
/*----------------------------------------------------------------*/
		mov    (%edi),%ebx
		sub    (%ecx),%ebx
		mov    0x10(%edi),%eax
		sub    0x10(%ecx),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x40(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_122457
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x67(%esp)
		je     jump_122470
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_122470
	jump_122457:
		cmpb   $0x0,0x67(%esp)
		je     jump_122470
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_122470:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_122476:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_122476
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)



/*----------------------------------------------------------------*/
func_1224a1:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    %eax,%ebx
		cmpb   $0x0,0x66(%esp)
		je     jump_1224f0
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		cmpb   $0x0,0x67(%esp)
		je     jump_122509
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_122509
	jump_1224f0:
		cmpb   $0x0,0x67(%esp)
		je     jump_122509
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_122509:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_12250f:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_12250f
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)
	jump_122533:
		mov    (%ecx),%eax
		cmp    (%edi),%eax
		jle    jump_122a92
		xchg   %esi,%edi
		xchg   %edi,%ecx
	jump_122541:
		mov    0x4(%esi),%eax
		mov    %eax,0x54(%esp)
		or     %eax,%eax
		jns    jump_12255c
		mov    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x1,0x66(%esp)
		jmp    jump_12257f
	jump_12255c:
		cmp    EXPORT_SYMBOL(vec_window_height),%eax
		jge    jump_122a92
		mov    %eax,%ebx
		imul   EXPORT_SYMBOL(vec_screen_width),%ebx
		add    EXPORT_SYMBOL(poly_screen),%ebx
		mov    %ebx,(%esp)
		movb   $0x0,0x66(%esp)
	jump_12257f:
		mov    0x4(%ecx),%ebx
		cmp    EXPORT_SYMBOL(vec_window_height),%ebx
		setg   0x67(%esp)
		sub    %eax,%ebx
		mov    %ebx,0x10(%esp)
		mov    %ebx,0x20(%esp)
		mov    (%ecx),%eax
		sub    (%esi),%eax
		shl    $0x10,%eax
		cltd
		idiv   %ebx
		mov    %eax,0x4(%esp)
		mov    (%ecx),%eax
		sub    (%edi),%eax
		shl    $0x10,%eax
		cltd
		idiv   %ebx
		mov    %eax,0x8(%esp)
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1225c1(,%eax,4)

vtable_1225c1:
		.long   func_12291e
		.long   func_122854
		.long   func_122759
		.long   func_122759
		.long   func_122854
		.long   func_12262d
		.long   func_12262d
		.long   func_122759
		.long   func_122759
		.long   func_122759
		.long   func_122759
		.long   func_122759
		.long   func_122759
		.long   func_122759
		.long   func_12291e
		.long   func_12291e
		.long   func_122854
		.long   func_122854
		.long   func_122759
		.long   func_122759
		.long   func_12262d
		.long   func_12262d
		.long   func_122759
		.long   func_122759
		.long   func_12262d
		.long   func_12262d
		.long   func_12262d


/*----------------------------------------------------------------*/
func_12262d:
/*----------------------------------------------------------------*/
		mov    (%edi),%ebx
		sub    (%esi),%ebx
		mov    0x8(%edi),%eax
		sub    0x8(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
		mov    0x10(%edi),%eax
		sub    0x10(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x34(%esp)
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x40(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    (%edi),%ebx
		shl    $0x10,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_122701
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x67(%esp)
		je     jump_12271a
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_12271a
	jump_122701:
		cmpb   $0x0,0x67(%esp)
		je     jump_12271a
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_12271a:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_122720:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_122720
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_122759:
/*----------------------------------------------------------------*/
		mov    (%edi),%ebx
		sub    (%esi),%ebx
		mov    0x8(%edi),%eax
		sub    0x8(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x24(%esp)
		mov    0xc(%edi),%eax
		sub    0xc(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x30(%esp)
		mov    0x8(%ecx),%eax
		sub    0x8(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x28(%esp)
		mov    0xc(%ecx),%eax
		sub    0xc(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x34(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    (%edi),%ebx
		shl    $0x10,%ebx
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		cmpb   $0x0,0x66(%esp)
		je     jump_122803
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x28(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ecx
		mov    0x34(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%edx
		cmpb   $0x0,0x67(%esp)
		je     jump_12281c
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_12281c
	jump_122803:
		cmpb   $0x0,0x67(%esp)
		je     jump_12281c
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_12281c:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_122822:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %ecx,0x8(%edi)
		add    0x28(%esp),%ecx
		mov    %edx,0xc(%edi)
		add    0x34(%esp),%edx
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_122822
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_122854:
/*----------------------------------------------------------------*/
		mov    (%edi),%ebx
		sub    (%esi),%ebx
		mov    0x10(%edi),%eax
		sub    0x10(%esi),%eax
		cltd
		idiv   %ebx
		mov    %eax,0x3c(%esp)
		mov    0x10(%ecx),%eax
		sub    0x10(%esi),%eax
		cltd
		idivl  0x20(%esp)
		mov    %eax,0x40(%esp)
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    (%edi),%ebx
		shl    $0x10,%ebx
		mov    0x10(%esi),%esi
		cmpb   $0x0,0x66(%esp)
		je     jump_1228d4
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		mov    0x40(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%esi
		cmpb   $0x0,0x67(%esp)
		je     jump_1228ed
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_1228ed
	jump_1228d4:
		cmpb   $0x0,0x67(%esp)
		je     jump_1228ed
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_1228ed:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_1228f3:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		mov    %esi,0x10(%edi)
		add    0x40(%esp),%esi
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_1228f3
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)


/*----------------------------------------------------------------*/
func_12291e:
/*----------------------------------------------------------------*/
		mov    (%esi),%eax
		shl    $0x10,%eax
		mov    (%edi),%ebx
		shl    $0x10,%ebx
		cmpb   $0x0,0x66(%esp)
		je     jump_122970
		mov    0x54(%esp),%edi
		neg    %edi
		sub    %edi,0x10(%esp)
		sub    %edi,0x20(%esp)
		jle    jump_122a92
		mov    %edi,0x48(%esp)
		imul   0x4(%esp),%edi
		add    %edi,%eax
		mov    0x8(%esp),%edi
		imul   0x48(%esp),%edi
		add    %edi,%ebx
		cmpb   $0x0,0x67(%esp)
		je     jump_122989
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
		jmp    jump_122989
	jump_122970:
		cmpb   $0x0,0x67(%esp)
		je     jump_122989
		mov    EXPORT_SYMBOL(vec_window_height),%edi
		sub    0x54(%esp),%edi
		mov    %edi,0x20(%esp)
		mov    %edi,0x10(%esp)
	jump_122989:
		lea    EXPORT_SYMBOL(polyscans),%edi
	jump_12298f:
		mov    %eax,(%edi)
		add    0x4(%esp),%eax
		mov    %ebx,0x4(%edi)
		add    0x8(%esp),%ebx
		add    $0x14,%edi
		decl   0x10(%esp)
		jne    jump_12298f
		movzbl EXPORT_SYMBOL(vec_mode),%eax
		jmp    *vtable_1229b3(,%eax,4)

vtable_1229b3:
		.long   func_122a1f
		.long   func_122a97
		.long   func_122c53
		.long   func_122eef
		.long   func_1231cf
		.long   func_123433
		.long   func_12374a
		.long   func_123b2b
		.long   func_123e3e
		.long   func_124184
		.long   func_1244f7
		.long   func_123b2b
		.long   func_124870
		.long   func_124b75
		.long   func_124e7b
		.long   func_125010
		.long   func_1251a4
		.long   func_12545d
		.long   func_125716
		.long   func_125a45
		.long   func_125d74
		.long   func_1261ed
		.long   func_126666
		.long   func_1269d9
		.long   func_126d4c
		.long   func_127205
		.long   func_1276be


/*----------------------------------------------------------------*/
func_122a1f:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    (%esp),%edx
		mov    EXPORT_SYMBOL(vec_colour),%al
		mov    %al,%ah
		mov    %ax,%bx
		shl    $0x10,%eax
		mov    %bx,%ax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_122a3c:
		mov    0x2(%esi),%bx
		movzwl 0x6(%esi),%ecx
		add    EXPORT_SYMBOL(vec_screen_width),%edx
		or     %bx,%bx
		jns    jump_122a66
		or     %cx,%cx
		jle    jump_122a89
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122a62
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122a62:
		mov    %edx,%edi
		jmp    jump_122a7c
	jump_122a66:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122a74
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122a74:
		sub    %bx,%cx
		jle    jump_122a89
		lea    (%ebx,%edx,1),%edi
	jump_122a7c:
		shr    %ecx
		jae    jump_122a81
		stos   %al,%es:(%edi)
	jump_122a81:
		shr    %ecx
		jae    jump_122a87
		stos   %ax,%es:(%edi)
	jump_122a87:
		rep stos %eax,%es:(%edi)
	jump_122a89:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_122a3c
	jump_122a92:
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_122a97:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_122aa1:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_122af3
		or     %cx,%cx
		jle    jump_122c41
		neg    %ax
		movzwl %ax,%eax
		imul   0x3c(%esp),%eax
		mov    %ax,%bx
		shr    $0x8,%eax
		add    0x10(%esi),%bx
		adc    0x12(%esi),%ah
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122ae9
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122ae9:
		movzwl %ax,%eax
		mov    EXPORT_SYMBOL(vec_colour),%al
		jmp    jump_122b1a
	jump_122af3:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122b01
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122b01:
		sub    %ax,%cx
		jle    jump_122c41
		add    %eax,%edi
		movzbl EXPORT_SYMBOL(vec_colour),%eax
		mov    0x10(%esi),%bx
		mov    0x12(%esi),%ah
	jump_122b1a:
		mov    %ah,(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x1(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x2(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x3(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x4(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x5(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x6(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x7(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x8(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0x9(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0xa(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0xb(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0xc(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0xd(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0xe(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		mov    %ah,0xf(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_122c41
		add    $0x10,%edi
		jmp    jump_122b1a
	jump_122c41:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_122aa1
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_122c53:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_122c6a:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_122cc4
		or     %cx,%cx
		jle    jump_122edd
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122cbf
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122cbf:
		movzwl %ax,%eax
		jmp    jump_122cec
	jump_122cc4:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122cd2
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122cd2:
		sub    %ax,%cx
		jle    jump_122edd
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_122cec:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_122cf6:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x1(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x2(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x3(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x4(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x5(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x6(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x7(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x8(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0x9(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0xa(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0xb(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0xc(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0xd(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0xe(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    %al,0xf(%edi)
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_122ed9
		add    $0x10,%edi
		jmp    jump_122cf6
	jump_122ed9:
		mov    0x5c(%esp),%esi
	jump_122edd:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_122c6a
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_122eef:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_122f06:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_122f60
		or     %cx,%cx
		jle    jump_1231bd
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122f5b
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122f5b:
		movzwl %ax,%eax
		jmp    jump_122f88
	jump_122f60:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_122f6e
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_122f6e:
		sub    %ax,%cx
		jle    jump_1231bd
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_122f88:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_122f92:
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_122f9b
		mov    %al,(%edi)
	jump_122f9b:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_122fbe
		mov    %al,0x1(%edi)
	jump_122fbe:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_122fe1
		mov    %al,0x2(%edi)
	jump_122fe1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_123004
		mov    %al,0x3(%edi)
	jump_123004:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_123027
		mov    %al,0x4(%edi)
	jump_123027:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12304a
		mov    %al,0x5(%edi)
	jump_12304a:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12306d
		mov    %al,0x6(%edi)
	jump_12306d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_123090
		mov    %al,0x7(%edi)
	jump_123090:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1230b3
		mov    %al,0x8(%edi)
	jump_1230b3:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1230d6
		mov    %al,0x9(%edi)
	jump_1230d6:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1230f9
		mov    %al,0xa(%edi)
	jump_1230f9:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12311c
		mov    %al,0xb(%edi)
	jump_12311c:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12313f
		mov    %al,0xc(%edi)
	jump_12313f:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12315e
		mov    %al,0xd(%edi)
	jump_12315e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12317d
		mov    %al,0xe(%edi)
	jump_12317d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12319c
		mov    %al,0xf(%edi)
	jump_12319c:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1231b9
		add    $0x10,%edi
		jmp    jump_122f92
	jump_1231b9:
		mov    0x5c(%esp),%esi
	jump_1231bd:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_122f06
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_1231cf:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_1231d9:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_12322b
		or     %cx,%cx
		jle    jump_1233e1
		neg    %ax
		movzwl %ax,%eax
		imul   0x3c(%esp),%eax
		mov    %ax,%bx
		shr    $0x8,%eax
		add    0x10(%esi),%bx
		adc    0x12(%esi),%ah
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_123221
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_123221:
		movzwl %ax,%eax
		mov    EXPORT_SYMBOL(vec_colour),%al
		jmp    jump_123252
	jump_12322b:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_123239
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_123239:
		sub    %ax,%cx
		jle    jump_1233e1
		add    %eax,%edi
		movzbl EXPORT_SYMBOL(vec_colour),%eax
		mov    0x10(%esi),%bx
		mov    0x12(%esi),%ah
	jump_123252:
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x1(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x2(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x3(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x4(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x5(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x6(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x7(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x8(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0x9(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0xa(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0xb(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0xc(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0xd(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0xe(%edi)
		je     jump_1233e1
		add    0x3c(%esp),%bx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		adc    0x3e(%esp),%ah
		dec    %cx
		mov    %dl,0xf(%edi)
		je     jump_1233e1
		add    $0x10,%edi
		jmp    jump_123252
	jump_1233e1:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_1231d9
		add    $0x6c,%esp
		popa
		ret

.section .rodata
data_1233f3:
                .fill   0x4
                .ascii  "\xf1\xff\xff\xff\xf2\xff\xff\xff"
                .ascii  "\xf3\xff\xff\xff\xf4\xff\xff\xff"
                .ascii  "\xf5\xff\xff\xff\xf6\xff\xff\xff"
                .ascii  "\xf7\xff\xff\xff\xf8\xff\xff\xff"
                .ascii  "\xf9\xff\xff\xff\xfa\xff\xff\xff"
                .ascii  "\xfb\xff\xff\xff\xfc\xff\xff\xff"
                .ascii  "\xfd\xff\xff\xff\xfe\xff\xff\xff"
                .ascii  "\xff\xff\xff\xff"
.text


/*----------------------------------------------------------------*/
func_123433:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    %esi,0x5c(%esp)
		xor    %ebx,%ebx
		mov    0x24(%esp),%ecx
		mov    0x30(%esp),%edx
		mov    0x3c(%esp),%ebp
		cmp    $0x0,%ebp
		jae    jump_123451
		dec    %ecx
	jump_123451:
		rol    $0x10,%ecx
		rol    $0x10,%edx
		shr    $0x8,%ebp
		mov    %dl,%bl
		mov    %cl,%dl
		mov    %bp,%cx
		mov    %ecx,0x4c(%esp)
		mov    %edx,0x50(%esp)
		mov    %bl,0x64(%esp)
	jump_12346d:
		mov    0x5c(%esp),%esi
		addl   $0x14,0x5c(%esp)
		mov    (%esi),%eax
		mov    0x4(%esi),%ebp
		sar    $0x10,%eax
		sar    $0x10,%ebp
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %eax,%eax
		jns    jump_1234db
		or     %ebp,%ebp
		jle    jump_12373b
		neg    %eax
		mov    0x24(%esp),%ecx
		imul   %eax,%ecx
		add    0x8(%esi),%ecx
		mov    0x30(%esp),%edx
		imul   %eax,%edx
		add    0xc(%esi),%edx
		mov    0x3c(%esp),%ebx
		imul   %eax,%ebx
		add    0x10(%esi),%ebx
		rol    $0x10,%ecx
		rol    $0x10,%edx
		shr    $0x8,%ebx
		mov    %dl,%al
		mov    %cl,%dl
		mov    %bx,%cx
		mov    %al,%bh
		cmp    EXPORT_SYMBOL(vec_window_width),%ebp
		jle    jump_1234d9
		mov    EXPORT_SYMBOL(vec_window_width),%ebp
	jump_1234d9:
		jmp    jump_12350e
	jump_1234db:
		cmp    EXPORT_SYMBOL(vec_window_width),%ebp
		jle    jump_1234e9
		mov    EXPORT_SYMBOL(vec_window_width),%ebp
	jump_1234e9:
		sub    %eax,%ebp
		jle    jump_12373b
		add    %eax,%edi
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		mov    0x10(%esi),%ebx
		rol    $0x10,%ecx
		rol    $0x10,%edx
		shr    $0x8,%ebx
		mov    %dl,%al
		mov    %cl,%dl
		mov    %bx,%cx
		mov    %al,%bh
	jump_12350e:
		xor    %dh,%dh
		and    $0xffff,%ebx
		mov    %ebp,%eax
		and    $0xf,%eax
		add    data_1233f3(,%eax,4),%edi
		mov    EXPORT_SYMBOL(vec_map),%esi
		jmp    *vtable_123530(,%eax,4)

vtable_123530:
		.long   func_123570
		.long   func_123713
		.long   func_1236f7
		.long   func_1236db
		.long   func_1236bf
		.long   func_1236a3
		.long   func_123687
		.long   func_12366b
		.long   func_12364f
		.long   func_123633
		.long   func_123617
		.long   func_1235fb
		.long   func_1235df
		.long   func_1235c3
		.long   func_1235a7
		.long   func_12358b


/*----------------------------------------------------------------*/
func_123570:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,(%edi)


/*----------------------------------------------------------------*/
func_12358b:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x1(%edi)


/*----------------------------------------------------------------*/
func_1235a7:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x2(%edi)


/*----------------------------------------------------------------*/
func_1235c3:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x3(%edi)


/*----------------------------------------------------------------*/
func_1235df:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x4(%edi)


/*----------------------------------------------------------------*/
func_1235fb:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x5(%edi)


/*----------------------------------------------------------------*/
func_123617:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x6(%edi)


/*----------------------------------------------------------------*/
func_123633:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x7(%edi)


/*----------------------------------------------------------------*/
func_12364f:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x8(%edi)


/*----------------------------------------------------------------*/
func_12366b:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0x9(%edi)


/*----------------------------------------------------------------*/
func_123687:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0xa(%edi)


/*----------------------------------------------------------------*/
func_1236a3:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0xb(%edi)


/*----------------------------------------------------------------*/
func_1236bf:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0xc(%edi)


/*----------------------------------------------------------------*/
func_1236db:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0xd(%edi)


/*----------------------------------------------------------------*/
func_1236f7:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0xe(%edi)


/*----------------------------------------------------------------*/
func_123713:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		adc    0x64(%esp),%bh
		mov    %al,0xf(%edi)
		add    $0x10,%edi
		sub    $0x10,%ebp
		jg     func_123570
	jump_12373b:
		decl   0x20(%esp)
		jne    jump_12346d
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_12374a:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    %esi,0x5c(%esp)
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		mov    0x3c(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x50(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_123770:
		mov    0x5c(%esp),%esi
		addl   $0x14,0x5c(%esp)
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_1237ea
		or     %cx,%cx
		jle    jump_123b1c
		mov    %cx,%bp
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		mov    %eax,%ecx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		imul   0x3c(%esp),%ecx
		add    0x10(%esi),%ecx
		rol    $0x10,%ecx
		mov    %cl,%ah
		mov    %bp,%cx
		movzwl %ax,%eax
		cmp    EXPORT_SYMBOL(vec_window_width),%cx
		jle    jump_1237e8
		mov    EXPORT_SYMBOL(vec_window_width),%cx
	jump_1237e8:
		jmp    jump_123820
	jump_1237ea:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1237f8
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1237f8:
		sub    %ax,%cx
		jle    jump_123b1c
		add    %eax,%edi
		mov    0xc(%esi),%edx
		mov    0xa(%esi),%bl
		rol    $0x10,%edx
		mov    %cx,%bp
		mov    %dl,%bh
		mov    0x10(%esi),%ecx
		mov    0x8(%esi),%dx
		rol    $0x10,%ecx
		mov    %cl,%ah
		mov    %bp,%cx
	jump_123820:
		mov    %cx,%si
		and    $0xf,%esi
		add    data_1233f3(,%esi,4),%edi
		mov    EXPORT_SYMBOL(vec_map),%ebp
		jmp    *vtable_12383a(,%esi,4)

vtable_12383a:
		.long   func_123880
		.long   func_123ae6
		.long   func_123abd
		.long   func_123a94
		.long   func_123a6b
		.long   func_123a42
		.long   func_123a19
		.long   func_1239f0
		.long   func_1239c7
		.long   func_12399e
		.long   func_123975
		.long   func_12394c
		.long   func_123923
		.long   func_1238fa
		.long   func_1238d1
		.long   func_1238a8


/*----------------------------------------------------------------*/
func_123880:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_12388f
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,(%edi)
	jump_12388f:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_1238a8:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_1238b8
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_1238b8:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_1238d1:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_1238e1
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_1238e1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_1238fa:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_12390a
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_12390a:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123923:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123933
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_123933:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_12394c:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_12395c
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_12395c:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123975:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123985
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_123985:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_12399e:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_1239ae
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_1239ae:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_1239c7:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_1239d7
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_1239d7:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_1239f0:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123a00
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_123a00:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123a19:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123a29
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_123a29:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123a42:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123a52
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_123a52:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123a6b:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123a7b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_123a7b:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123a94:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123aa4
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_123aa4:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123abd:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123acd
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_123acd:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah


/*----------------------------------------------------------------*/
func_123ae6:
/*----------------------------------------------------------------*/
		mov    (%ebx,%ebp,1),%al
		or     %al,%al
		je     jump_123af6
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_123af6:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%ah
		add    $0x10,%edi
		sub    $0x10,%cx
		jg     func_123880
	jump_123b1c:
		decl   0x20(%esp)
		jne    jump_123770
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_123b2b:
/*----------------------------------------------------------------*/
		cmpb   $0x20,EXPORT_SYMBOL(vec_colour)
		je     func_122c53
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_123b4f:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_123ba9
		or     %cx,%cx
		jle    jump_123e2c
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_123ba4
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_123ba4:
		movzwl %ax,%eax
		jmp    jump_123bd1
	jump_123ba9:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_123bb7
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_123bb7:
		sub    %ax,%cx
		jle    jump_123e2c
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_123bd1:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
		mov    EXPORT_SYMBOL(vec_colour),%ah
	jump_123be1:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x1(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x2(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x3(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x4(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x5(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x6(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x7(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x8(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x9(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xa(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xb(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xc(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xd(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xe(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xf(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_123e28
		add    $0x10,%edi
		jmp    jump_123be1
	jump_123e28:
		mov    0x5c(%esp),%esi
	jump_123e2c:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_123b4f
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_123e3e:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_123e55:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_123eaf
		or     %cx,%cx
		jle    jump_124172
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_123eaa
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_123eaa:
		movzwl %ax,%eax
		jmp    jump_123ed7
	jump_123eaf:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_123ebd
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_123ebd:
		sub    %ax,%cx
		jle    jump_124172
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_123ed7:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
		mov    EXPORT_SYMBOL(vec_colour),%ah
	jump_123ee7:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123eff
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,(%edi)
	jump_123eff:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123f28
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_123f28:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123f51
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_123f51:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123f7a
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_123f7a:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123fa3
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_123fa3:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123fcc
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_123fcc:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_123ff5
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_123ff5:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_12401e
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_12401e:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_124047
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_124047:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_124070
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_124070:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_124099
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_124099:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_1240c2
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_1240c2:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_1240eb
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_1240eb:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_124110
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_124110:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_124135
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_124135:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %al,%al
		je     jump_12415a
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_12415a:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12416e
		add    $0x10,%edi
		jmp    jump_123ee7
	jump_12416e:
		mov    0x5c(%esp),%esi
	jump_124172:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_123e55
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_124184:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_12419b:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_1241f5
		or     %cx,%cx
		jle    jump_1244e5
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1241f0
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1241f0:
		movzwl %ax,%eax
		jmp    jump_12421d
	jump_1241f5:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124203
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124203:
		sub    %ax,%cx
		jle    jump_1244e5
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_12421d:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_124227:
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_124241
		mov    (%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,(%edi)
	jump_124241:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_12426d
		mov    0x1(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_12426d:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_124299
		mov    0x2(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_124299:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1242c5
		mov    0x3(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_1242c5:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1242f1
		mov    0x4(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_1242f1:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_12431d
		mov    0x5(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_12431d:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_124349
		mov    0x6(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_124349:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_124375
		mov    0x7(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_124375:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1243a1
		mov    0x8(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_1243a1:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1243cd
		mov    0x9(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_1243cd:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1243f9
		mov    0xa(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_1243f9:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_124425
		mov    0xb(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_124425:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_124451
		mov    0xc(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_124451:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_12447d
		mov    0xd(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_12447d:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1244a5
		mov    0xe(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_1244a5:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		or     %ah,%ah
		je     jump_1244cd
		mov    0xf(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_1244cd:
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1244e1
		add    $0x10,%edi
		jmp    jump_124227
	jump_1244e1:
		mov    0x5c(%esp),%esi
	jump_1244e5:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_12419b
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_1244f7:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_12450e:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_124568
		or     %cx,%cx
		jle    jump_12485e
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124563
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124563:
		movzwl %ax,%eax
		jmp    jump_124590
	jump_124568:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124576
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124576:
		sub    %ax,%cx
		jle    jump_12485e
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_124590:
		mov    EXPORT_SYMBOL(vec_colour),%ah
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_1245a0:
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1245b1
		mov    (%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,(%edi)
	jump_1245b1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1245dd
		mov    0x1(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_1245dd:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124609
		mov    0x2(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_124609:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124635
		mov    0x3(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_124635:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124661
		mov    0x4(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_124661:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12468d
		mov    0x5(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_12468d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1246b9
		mov    0x6(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_1246b9:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1246e5
		mov    0x7(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_1246e5:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124711
		mov    0x8(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_124711:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12473d
		mov    0x9(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_12473d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124769
		mov    0xa(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_124769:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124795
		mov    0xb(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_124795:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1247c1
		mov    0xc(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_1247c1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1247ed
		mov    0xd(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_1247ed:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_124815
		mov    0xe(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_124815:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12483d
		mov    0xf(%edi),%al
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_12483d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_12485a
		add    $0x10,%edi
		jmp    jump_1245a0
	jump_12485a:
		mov    0x5c(%esp),%esi
	jump_12485e:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_12450e
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_124870:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_124887:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_1248e1
		or     %cx,%cx
		jle    jump_124b63
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1248dc
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1248dc:
		movzwl %ax,%eax
		jmp    jump_124909
	jump_1248e1:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1248ef
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1248ef:
		sub    %ax,%cx
		jle    jump_124b63
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_124909:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
		mov    EXPORT_SYMBOL(vec_colour),%al
	jump_124918:
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x1(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x2(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x3(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x4(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x5(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x6(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x7(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x8(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0x9(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0xa(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0xb(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0xc(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0xd(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0xe(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    %ah,0xf(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124b5f
		add    $0x10,%edi
		jmp    jump_124918
	jump_124b5f:
		mov    0x5c(%esp),%esi
	jump_124b63:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_124887
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_124b75:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_124b8c:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_124be6
		or     %cx,%cx
		jle    jump_124e69
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124be1
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124be1:
		movzwl %ax,%eax
		jmp    jump_124c0e
	jump_124be6:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124bf4
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124bf4:
		sub    %ax,%cx
		jle    jump_124e69
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_124c0e:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
		mov    EXPORT_SYMBOL(vec_colour),%ah
	jump_124c1e:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x1(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x2(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x3(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x4(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x5(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x6(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x7(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x8(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x9(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xa(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xb(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xc(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xd(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xe(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xf(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_124e65
		add    $0x10,%edi
		jmp    jump_124c1e
	jump_124e65:
		mov    0x5c(%esp),%esi
	jump_124e69:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_124b8c
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_124e7b:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    (%esp),%edx
		xor    %eax,%eax
		mov    EXPORT_SYMBOL(vec_colour),%ah
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_124e90:
		mov    0x2(%esi),%bx
		movzwl 0x6(%esi),%ecx
		add    EXPORT_SYMBOL(vec_screen_width),%edx
		or     %bx,%bx
		jns    jump_124ebe
		or     %cx,%cx
		jle    jump_124ffe
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124eba
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124eba:
		mov    %edx,%edi
		jmp    jump_124ed8
	jump_124ebe:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_124ecc
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_124ecc:
		sub    %bx,%cx
		jle    jump_124ffe
		lea    (%ebx,%edx,1),%edi
	jump_124ed8:
		mov    (%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x1(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x1(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x2(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x2(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x3(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x3(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x4(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x4(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x5(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x5(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x6(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x6(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x7(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x7(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x8(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x8(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0x9(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x9(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0xa(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xa(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0xb(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xb(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0xc(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xc(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0xd(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xd(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0xe(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xe(%edi)
		dec    %cx
		je     jump_124ffe
		mov    0xf(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xf(%edi)
		dec    %cx
		je     jump_124ffe
		add    $0x10,%edi
		jmp    jump_124ed8
	jump_124ffe:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_124e90
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_125010:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    (%esp),%edx
		movzbl EXPORT_SYMBOL(vec_colour),%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_125024:
		mov    0x2(%esi),%bx
		movzwl 0x6(%esi),%ecx
		add    EXPORT_SYMBOL(vec_screen_width),%edx
		or     %bx,%bx
		jns    jump_125052
		or     %cx,%cx
		jle    jump_125192
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_12504e
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_12504e:
		mov    %edx,%edi
		jmp    jump_12506c
	jump_125052:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125060
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125060:
		sub    %bx,%cx
		jle    jump_125192
		lea    (%ebx,%edx,1),%edi
	jump_12506c:
		mov    (%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,(%edi)
		dec    %cx
		je     jump_125192
		mov    0x1(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x1(%edi)
		dec    %cx
		je     jump_125192
		mov    0x2(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x2(%edi)
		dec    %cx
		je     jump_125192
		mov    0x3(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x3(%edi)
		dec    %cx
		je     jump_125192
		mov    0x4(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x4(%edi)
		dec    %cx
		je     jump_125192
		mov    0x5(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x5(%edi)
		dec    %cx
		je     jump_125192
		mov    0x6(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x6(%edi)
		dec    %cx
		je     jump_125192
		mov    0x7(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x7(%edi)
		dec    %cx
		je     jump_125192
		mov    0x8(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x8(%edi)
		dec    %cx
		je     jump_125192
		mov    0x9(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0x9(%edi)
		dec    %cx
		je     jump_125192
		mov    0xa(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0xa(%edi)
		dec    %cx
		je     jump_125192
		mov    0xb(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0xb(%edi)
		dec    %cx
		je     jump_125192
		mov    0xc(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0xc(%edi)
		dec    %cx
		je     jump_125192
		mov    0xd(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0xd(%edi)
		dec    %cx
		je     jump_125192
		mov    0xe(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0xe(%edi)
		dec    %cx
		je     jump_125192
		mov    0xf(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%ah
		mov    %ah,0xf(%edi)
		dec    %cx
		je     jump_125192
		add    $0x10,%edi
		jmp    jump_12506c
	jump_125192:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_125024
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_1251a4:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		xor    %edx,%edx
	jump_1251ac:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_1251fe
		or     %cx,%cx
		jle    jump_12544b
		neg    %ax
		movzwl %ax,%eax
		imul   0x3c(%esp),%eax
		mov    %ax,%bx
		shr    $0x8,%eax
		add    0x10(%esi),%bx
		adc    0x12(%esi),%ah
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1251f4
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1251f4:
		movzwl %ax,%eax
		mov    EXPORT_SYMBOL(vec_colour),%al
		jmp    jump_125225
	jump_1251fe:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_12520c
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_12520c:
		sub    %ax,%cx
		jle    jump_12544b
		add    %eax,%edi
		movzbl EXPORT_SYMBOL(vec_colour),%eax
		mov    0x10(%esi),%bx
		mov    0x12(%esi),%ah
	jump_125225:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    (%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x1(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x1(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x2(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x2(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x3(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x3(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x4(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x4(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x5(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x5(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x6(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x6(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x7(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x7(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x8(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x8(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0x9(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x9(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0xa(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xa(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0xb(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xb(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0xc(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xc(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0xd(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xd(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0xe(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xe(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dh
		mov    0xf(%edi),%dl
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xf(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_12544b
		add    $0x10,%edi
		jmp    jump_125225
	jump_12544b:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_1251ac
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_12545d:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		xor    %edx,%edx
	jump_125465:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_1254b7
		or     %cx,%cx
		jle    jump_125704
		neg    %ax
		movzwl %ax,%eax
		imul   0x3c(%esp),%eax
		mov    %ax,%bx
		shr    $0x8,%eax
		add    0x10(%esi),%bx
		adc    0x12(%esi),%ah
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1254ad
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1254ad:
		movzwl %ax,%eax
		mov    EXPORT_SYMBOL(vec_colour),%al
		jmp    jump_1254de
	jump_1254b7:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1254c5
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1254c5:
		sub    %ax,%cx
		jle    jump_125704
		add    %eax,%edi
		movzbl EXPORT_SYMBOL(vec_colour),%eax
		mov    0x10(%esi),%bx
		mov    0x12(%esi),%ah
	jump_1254de:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    (%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x1(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x1(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x2(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x2(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x3(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x3(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x4(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x4(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x5(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x5(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x6(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x6(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x7(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x7(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x8(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x8(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0x9(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0x9(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0xa(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xa(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0xb(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xb(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0xc(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xc(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0xd(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xd(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0xe(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xe(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%dl
		mov    0xf(%edi),%dh
		mov    EXPORT_SYMBOL(_ghost_table)(%edx),%dl
		mov    %dl,0xf(%edi)
		add    0x3c(%esp),%bx
		adc    0x3e(%esp),%ah
		dec    %cx
		je     jump_125704
		add    $0x10,%edi
		jmp    jump_1254de
	jump_125704:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_125465
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_125716:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_12572d:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_125787
		or     %cx,%cx
		jle    jump_125a33
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125782
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125782:
		movzwl %ax,%eax
		jmp    jump_1257af
	jump_125787:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125795
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125795:
		sub    %ax,%cx
		jle    jump_125a33
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_1257af:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_1257b9:
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    (%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x1(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x1(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x2(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x2(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x3(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x3(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x4(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x4(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x5(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x5(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x6(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x6(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x7(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x7(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x8(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x8(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0x9(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x9(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0xa(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xa(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0xb(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xb(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0xc(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xc(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0xd(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xd(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0xe(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xe(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		mov    (%ebx,%esi,1),%ah
		add    0x24(%esp),%dx
		mov    0xf(%edi),%al
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xf(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125a2f
		add    $0x10,%edi
		jmp    jump_1257b9
	jump_125a2f:
		mov    0x5c(%esp),%esi
	jump_125a33:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_12572d
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_125a45:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_125a5c:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_125ab6
		or     %cx,%cx
		jle    jump_125d62
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125ab1
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125ab1:
		movzwl %ax,%eax
		jmp    jump_125ade
	jump_125ab6:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125ac4
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125ac4:
		sub    %ax,%cx
		jle    jump_125d62
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_125ade:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_125ae8:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    (%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x1(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x1(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x2(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x2(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x3(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x3(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x4(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x4(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x5(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x5(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x6(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x6(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x7(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x7(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x8(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x8(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0x9(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0x9(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0xa(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xa(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0xb(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xb(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0xc(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xc(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0xd(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xd(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0xe(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xe(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    0xf(%edi),%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    %al,0xf(%edi)
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_125d5e
		add    $0x10,%edi
		jmp    jump_125ae8
	jump_125d5e:
		mov    0x5c(%esp),%esi
	jump_125d62:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_125a5c
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_125d74:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		mov    0x3c(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x50(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_125d96:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_125e01
		or     %cx,%cx
		jle    jump_1261db
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125dc6
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125dc6:
		mov    %ecx,0x58(%esp)
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		mov    %eax,%ecx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		imul   0x3c(%esp),%ecx
		add    0x10(%esi),%ecx
		rol    $0x10,%ecx
		movzwl %ax,%eax
		jmp    jump_125e33
	jump_125e01:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_125e0f
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_125e0f:
		sub    %ax,%cx
		jle    jump_1261db
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
		mov    %ecx,0x58(%esp)
		mov    0x10(%esi),%ecx
		rol    $0x10,%ecx
	jump_125e33:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_125e3d:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    (%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x1(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x1(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x2(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x2(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x3(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x3(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x4(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x4(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x5(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x5(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x6(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x6(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x7(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x7(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x8(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x8(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0x9(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x9(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0xa(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xa(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0xb(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xb(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0xc(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xc(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0xd(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xd(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0xe(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xe(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		add    0x4c(%esp),%edx
		mov    0xf(%edi),%al
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xf(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1261d7
		add    $0x10,%edi
		jmp    jump_125e3d
	jump_1261d7:
		mov    0x5c(%esp),%esi
	jump_1261db:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_125d96
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_1261ed:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		mov    0x3c(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x50(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_12620f:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_12627a
		or     %cx,%cx
		jle    jump_126654
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_12623f
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_12623f:
		mov    %ecx,0x58(%esp)
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		mov    %eax,%ecx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		imul   0x3c(%esp),%ecx
		add    0x10(%esi),%ecx
		rol    $0x10,%ecx
		movzwl %ax,%eax
		jmp    jump_1262ac
	jump_12627a:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_126288
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_126288:
		sub    %ax,%cx
		jle    jump_126654
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
		mov    %ecx,0x58(%esp)
		mov    0x10(%esi),%ecx
		rol    $0x10,%ecx
	jump_1262ac:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_1262b6:
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    (%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x1(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x1(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x2(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x2(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x3(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x3(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x4(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x4(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x5(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x5(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x6(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x6(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x7(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x7(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x8(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x8(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0x9(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0x9(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0xa(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xa(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0xb(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xb(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0xc(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xc(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0xd(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xd(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0xe(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xe(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		mov    (%ebx,%esi,1),%al
		add    0x24(%esp),%dx
		mov    %cl,%ah
		adc    0x26(%esp),%bl
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		add    0x4c(%esp),%edx
		mov    0xf(%edi),%ah
		adc    0x32(%esp),%bh
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		add    0x50(%esp),%ecx
		mov    %al,0xf(%edi)
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_126650
		add    $0x10,%edi
		jmp    jump_1262b6
	jump_126650:
		mov    0x5c(%esp),%esi
	jump_126654:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_12620f
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_126666:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_12667d:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_1266d7
		or     %cx,%cx
		jle    jump_1269c7
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1266d2
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1266d2:
		movzwl %ax,%eax
		jmp    jump_1266ff
	jump_1266d7:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1266e5
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1266e5:
		sub    %ax,%cx
		jle    jump_1269c7
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_1266ff:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_126709:
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_12671a
		mov    (%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,(%edi)
	jump_12671a:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_126746
		mov    0x1(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_126746:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_126772
		mov    0x2(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_126772:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_12679e
		mov    0x3(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_12679e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_1267ca
		mov    0x4(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_1267ca:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_1267f6
		mov    0x5(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_1267f6:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_126822
		mov    0x6(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_126822:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_12684e
		mov    0x7(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_12684e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_12687a
		mov    0x8(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_12687a:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_1268a6
		mov    0x9(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_1268a6:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_1268d2
		mov    0xa(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_1268d2:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_1268fe
		mov    0xb(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_1268fe:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_12692a
		mov    0xc(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_12692a:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_126956
		mov    0xd(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_126956:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_12697e
		mov    0xe(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_12697e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		mov    (%ebx,%esi,1),%ah
		or     %ah,%ah
		je     jump_1269a6
		mov    0xf(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_1269a6:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_1269c3
		add    $0x10,%edi
		jmp    jump_126709
	jump_1269c3:
		mov    0x5c(%esp),%esi
	jump_1269c7:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_12667d
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_1269d9:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_1269f0:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_126a4a
		or     %cx,%cx
		jle    jump_126d3a
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_126a45
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_126a45:
		movzwl %ax,%eax
		jmp    jump_126a72
	jump_126a4a:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_126a58
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_126a58:
		sub    %ax,%cx
		jle    jump_126d3a
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
	jump_126a72:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_126a7c:
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126a8d
		mov    (%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,(%edi)
	jump_126a8d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126ab9
		mov    0x1(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_126ab9:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126ae5
		mov    0x2(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_126ae5:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126b11
		mov    0x3(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_126b11:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126b3d
		mov    0x4(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_126b3d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126b69
		mov    0x5(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_126b69:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126b95
		mov    0x6(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_126b95:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126bc1
		mov    0x7(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_126bc1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126bed
		mov    0x8(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_126bed:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126c19
		mov    0x9(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_126c19:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126c45
		mov    0xa(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_126c45:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126c71
		mov    0xb(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_126c71:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126c9d
		mov    0xc(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_126c9d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126cc9
		mov    0xd(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_126cc9:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126cf1
		mov    0xe(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_126cf1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126d19
		mov    0xf(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_126d19:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		dec    %cx
		je     jump_126d36
		add    $0x10,%edi
		jmp    jump_126a7c
	jump_126d36:
		mov    0x5c(%esp),%esi
	jump_126d3a:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_1269f0
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_126d4c:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		mov    0x3c(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x50(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_126d6e:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_126dd9
		or     %cx,%cx
		jle    jump_1271f3
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_126d9e
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_126d9e:
		mov    %ecx,0x58(%esp)
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		mov    %eax,%ecx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		imul   0x3c(%esp),%ecx
		add    0x10(%esi),%ecx
		rol    $0x10,%ecx
		movzwl %ax,%eax
		jmp    jump_126e0b
	jump_126dd9:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_126de7
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_126de7:
		sub    %ax,%cx
		jle    jump_1271f3
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
		mov    %ecx,0x58(%esp)
		mov    0x10(%esi),%ecx
		rol    $0x10,%ecx
	jump_126e0b:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_126e15:
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126e2e
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    (%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,(%edi)
	jump_126e2e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126e6c
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x1(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_126e6c:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126eaa
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x2(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_126eaa:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126ee8
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x3(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_126ee8:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126f26
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x4(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_126f26:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126f64
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x5(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_126f64:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126fa2
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x6(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_126fa2:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_126fe0
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x7(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_126fe0:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12701e
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x8(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_12701e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12705c
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0x9(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_12705c:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12709a
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0xa(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_12709a:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1270d8
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0xb(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_1270d8:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127116
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0xc(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_127116:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127154
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0xd(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_127154:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12718e
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0xe(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_12718e:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1271c8
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%ah
		mov    0xf(%edi),%al
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_1271c8:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1271ef
		add    $0x10,%edi
		jmp    jump_126e15
	jump_1271ef:
		mov    0x5c(%esp),%esi
	jump_1271f3:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_126d6e
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_127205:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    0x30(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x4c(%esp)
		mov    0x3c(%esp),%eax
		shl    $0x10,%eax
		mov    %eax,0x50(%esp)
		xor    %eax,%eax
		xor    %ebx,%ebx
		xor    %ecx,%ecx
	jump_127227:
		mov    0x2(%esi),%ax
		movzwl 0x6(%esi),%ecx
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %ax,%ax
		jns    jump_127292
		or     %cx,%cx
		jle    jump_1276ac
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_127257
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_127257:
		mov    %ecx,0x58(%esp)
		neg    %ax
		movzwl %ax,%eax
		mov    %eax,%edx
		mov    %eax,%ecx
		imul   0x30(%esp),%edx
		add    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		imul   0x24(%esp),%eax
		add    0x8(%esi),%eax
		mov    %ax,%dx
		shr    $0x8,%eax
		mov    %ah,%bl
		imul   0x3c(%esp),%ecx
		add    0x10(%esi),%ecx
		rol    $0x10,%ecx
		movzwl %ax,%eax
		jmp    jump_1272c4
	jump_127292:
		cmp    EXPORT_SYMBOL(vec_window_width),%ecx
		jle    jump_1272a0
		mov    EXPORT_SYMBOL(vec_window_width),%ecx
	jump_1272a0:
		sub    %ax,%cx
		jle    jump_1276ac
		add    %eax,%edi
		mov    0xc(%esi),%edx
		rol    $0x10,%edx
		mov    %dl,%bh
		mov    0x8(%esi),%dx
		mov    0xa(%esi),%bl
		mov    %ecx,0x58(%esp)
		mov    0x10(%esi),%ecx
		rol    $0x10,%ecx
	jump_1272c4:
		mov    %esi,0x5c(%esp)
		mov    EXPORT_SYMBOL(vec_map),%esi
	jump_1272ce:
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1272e7
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    (%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,(%edi)
	jump_1272e7:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127325
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x1(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x1(%edi)
	jump_127325:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127363
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x2(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x2(%edi)
	jump_127363:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1273a1
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x3(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x3(%edi)
	jump_1273a1:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1273df
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x4(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x4(%edi)
	jump_1273df:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12741d
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x5(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x5(%edi)
	jump_12741d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12745b
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x6(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x6(%edi)
	jump_12745b:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127499
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x7(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x7(%edi)
	jump_127499:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1274d7
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x8(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x8(%edi)
	jump_1274d7:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127515
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x9(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x9(%edi)
	jump_127515:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127553
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xa(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xa(%edi)
	jump_127553:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127591
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xb(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xb(%edi)
	jump_127591:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_1275cf
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xc(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xc(%edi)
	jump_1275cf:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_12760d
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xd(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xd(%edi)
	jump_12760d:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127647
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xe(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xe(%edi)
	jump_127647:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		mov    (%ebx,%esi,1),%al
		or     %al,%al
		je     jump_127681
		mov    %cl,%ah
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xf(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xf(%edi)
	jump_127681:
		add    0x24(%esp),%dx
		adc    0x26(%esp),%bl
		add    0x4c(%esp),%edx
		adc    0x32(%esp),%bh
		add    0x50(%esp),%ecx
		adc    0x3e(%esp),%cl
		decl   0x58(%esp)
		je     jump_1276a8
		add    $0x10,%edi
		jmp    jump_1272ce
	jump_1276a8:
		mov    0x5c(%esp),%esi
	jump_1276ac:
		add    $0x14,%esi
		decl   0x20(%esp)
		jne    jump_127227
		add    $0x6c,%esp
		popa
		ret


/*----------------------------------------------------------------*/
func_1276be:
/*----------------------------------------------------------------*/
		lea    EXPORT_SYMBOL(polyscans),%esi
		mov    %esi,0x5c(%esp)
		xor    %ebx,%ebx
		mov    0x24(%esp),%ecx
		mov    0x30(%esp),%edx
		mov    0x3c(%esp),%ebp
		rol    $0x10,%ecx
		rol    $0x10,%edx
		shr    $0x8,%ebp
		mov    %dl,%bl
		mov    %cl,%dl
		mov    %bp,%cx
		xor    %dh,%dh
		mov    %ecx,0x4c(%esp)
		mov    %edx,0x50(%esp)
		mov    %bl,0x64(%esp)
	jump_1276f4:
		mov    0x5c(%esp),%esi
		addl   $0x14,0x5c(%esp)
		mov    (%esi),%eax
		mov    0x4(%esi),%ebp
		sar    $0x10,%eax
		sar    $0x10,%ebp
		mov    (%esp),%edi
		add    EXPORT_SYMBOL(vec_screen_width),%edi
		mov    %edi,(%esp)
		or     %eax,%eax
		jns    jump_127762
		or     %ebp,%ebp
		jle    jump_127a4b
		neg    %eax
		mov    0x24(%esp),%ecx
		imul   %eax,%ecx
		add    0x8(%esi),%ecx
		mov    0x30(%esp),%edx
		imul   %eax,%edx
		add    0xc(%esi),%edx
		mov    0x3c(%esp),%ebx
		imul   %eax,%ebx
		add    0x10(%esi),%ebx
		rol    $0x10,%ecx
		rol    $0x10,%edx
		shr    $0x8,%ebx
		mov    %dl,%al
		mov    %cl,%dl
		mov    %bx,%cx
		mov    %al,%bh
		cmp    EXPORT_SYMBOL(vec_window_width),%ebp
		jle    jump_127760
		mov    EXPORT_SYMBOL(vec_window_width),%ebp
	jump_127760:
		jmp    jump_127795
	jump_127762:
		cmp    EXPORT_SYMBOL(vec_window_width),%ebp
		jle    jump_127770
		mov    EXPORT_SYMBOL(vec_window_width),%ebp
	jump_127770:
		sub    %eax,%ebp
		jle    jump_127a4b
		add    %eax,%edi
		mov    0x8(%esi),%ecx
		mov    0xc(%esi),%edx
		mov    0x10(%esi),%ebx
		rol    $0x10,%ecx
		rol    $0x10,%edx
		shr    $0x8,%ebx
		mov    %dl,%al
		mov    %cl,%dl
		mov    %bx,%cx
		mov    %al,%bh
	jump_127795:
		xor    %dh,%dh
		and    $0xffff,%ebx
		mov    %ebp,%eax
		and    $0xf,%eax
		add    data_1233f3(,%eax,4),%edi
		mov    EXPORT_SYMBOL(vec_map),%esi
		jmp    *vtable_1277c0(,%eax,4)

vtable_1277c0:
		.long   func_127800
		.long   func_127a1b
		.long   func_1279f7
		.long   func_1279d3
		.long   func_1279af
		.long   func_12798b
		.long   func_127967
		.long   func_127943
		.long   func_12791f
		.long   func_1278fb
		.long   func_1278d7
		.long   func_1278b3
		.long   func_12788f
		.long   func_12786b
		.long   func_127847
		.long   func_127823


/*----------------------------------------------------------------*/
func_127800:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127a75
	jump_12781b:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,(%edi)


/*----------------------------------------------------------------*/
func_127823:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127aa0
	jump_12783e:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x1(%edi)


/*----------------------------------------------------------------*/
func_127847:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127acd
	jump_127862:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x2(%edi)


/*----------------------------------------------------------------*/
func_12786b:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127afa
	jump_127886:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x3(%edi)


/*----------------------------------------------------------------*/
func_12788f:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127b27
	jump_1278aa:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x4(%edi)


/*----------------------------------------------------------------*/
func_1278b3:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127b54
	jump_1278ce:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x5(%edi)


/*----------------------------------------------------------------*/
func_1278d7:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127b81
	jump_1278f2:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x6(%edi)


/*----------------------------------------------------------------*/
func_1278fb:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127bae
	jump_127916:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x7(%edi)


/*----------------------------------------------------------------*/
func_12791f:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127bdb
	jump_12793a:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x8(%edi)


/*----------------------------------------------------------------*/
func_127943:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127c08
	jump_12795e:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0x9(%edi)


/*----------------------------------------------------------------*/
func_127967:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127c35
	jump_127982:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xa(%edi)


/*----------------------------------------------------------------*/
func_12798b:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127c62
	jump_1279a6:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xb(%edi)


/*----------------------------------------------------------------*/
func_1279af:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127c8f
	jump_1279ca:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xc(%edi)


/*----------------------------------------------------------------*/
func_1279d3:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127cbc
	jump_1279ee:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xd(%edi)


/*----------------------------------------------------------------*/
func_1279f7:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127ce9
	jump_127a12:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xe(%edi)


/*----------------------------------------------------------------*/
func_127a1b:
/*----------------------------------------------------------------*/
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		jbe    jump_127d16
	jump_127a36:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    %al,0xf(%edi)
		add    $0x10,%edi
		sub    $0x10,%ebp
		jg     func_127800
	jump_127a4b:
		decl   0x20(%esp)
		jne    jump_1276f4
		add    $0x6c,%esp
		popa
		ret
	jump_127a5a:
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_12781b
	jump_127a75:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    (%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_12783e
	jump_127aa0:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x1(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x1(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_127862
	jump_127acd:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x2(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x2(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_127886
	jump_127afa:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x3(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x3(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_1278aa
	jump_127b27:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x4(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x4(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_1278ce
	jump_127b54:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x5(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x5(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_1278f2
	jump_127b81:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x6(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x6(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_127916
	jump_127bae:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x7(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x7(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_12793a
	jump_127bdb:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x8(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x8(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_12795e
	jump_127c08:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0x9(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0x9(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_127982
	jump_127c35:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xa(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xa(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_1279a6
	jump_127c62:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xb(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xb(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_1279ca
	jump_127c8f:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xc(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xc(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_1279ee
	jump_127cbc:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xd(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xd(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_127a12
	jump_127ce9:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xe(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xe(%edi)
		mov    %ch,%ah
		mov    %dl,%bl
		add    0x4c(%esp),%ecx
		mov    (%ebx,%esi,1),%al
		adc    0x50(%esp),%edx
		adc    0x64(%esp),%bh
		cmp    $0xc,%al
		ja     jump_127a36
	jump_127d16:
		mov    EXPORT_SYMBOL(_fade_table)(%eax),%al
		mov    0xf(%edi),%ah
		mov    EXPORT_SYMBOL(_ghost_table)(%eax),%al
		mov    %al,0xf(%edi)
		add    $0x10,%edi
		sub    $0x10,%ebp
		jg     jump_127a5a
		decl   0x20(%esp)
		jne    jump_1276f4
		add    $0x6c,%esp
		popa
		ret

