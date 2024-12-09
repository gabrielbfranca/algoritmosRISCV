.data

stringA: .string "digite o a:"
stringB: .string "digite o b:"
stringC: .string "digite o c:"
stringX: .string "digite o x:"
newline: .string "\n"
raiz1: .string "R(1) = "
raiz2: .string "R(2) = "
soma: .string " + "
subs: .string " - "
i: .string " i"
.text

.macro scanFloat %string, %registertoMove
      la a0, %string
      li a7, 4
      ecall
      
      li a7, 6
      ecall
      
      fmv.s %registertoMove, fa0
.end_macro

.macro printFloat %x
	li a7, 2
	fmv.s fa0, %x
	ecall
.end_macro

.macro print_str %str
	la a0, %str
	li a7, 4
	ecall
.end_macro

MAIN: 
	scanFloat stringA, fa1
	printFloat fa1
	print_str newline
	
	scanFloat stringB, fa2
	printFloat fa2
	print_str newline
	
	scanFloat stringC, fa3
	printFloat fa3
	print_str newline
	
BHASKARA:fmul.s ft0, fa2, fa2 # delta b^2
	fmul.s ft1, fa1, fa3 # ac
	li t2, 4
	fcvt.s.w ft2, t2
	fmul.s ft1, ft1, ft2 #4ac		
	fsub.s ft0, ft0, ft1 # b^2 - 4ac
	
	fsgnjn.s fa2,fa2, fa2    # -b
	
	li t2, 2
	fcvt.s.w ft2, t2
	fmul.s ft5, ft2, fa1 # 2a
	
	li t4, 0           # Load integer 0 into t0
	fmv.s.x ft4, t4    # Convert integer 0 to floating-point 0.0 in ft1
	flt.s t3, ft0, ft4
	li t6, 1
	beq t3, t6, negativeDELTA
	
	fsqrt.s ft0, ft0     # sqrt (delta)
	fadd.s ft1, fa2, ft0 # -b + sqrt(delta)
	fdiv.s fs0, ft1, ft5
	
	fsub.s ft1, fa2, ft0 # -b - sqrt(delta)
	fdiv.s fs1, ft1, ft5
	j SHOW
negativeDELTA:	fsgnjn.s ft0, ft0, ft0
		fsqrt.s ft0, ft0     # sqrt (delta)
		fdiv.s  fs1, fa2, ft5
		fdiv.s  fs2, ft0, ft5

SHOW:	beq t3, t6, printDeltaNegativo
printDELTAPOSITIVO:	print_str raiz1 
			printFloat fs0
			print_str newline
			print_str raiz2
			printFloat fs1
			print_str newline
			j EXIT
	
printDeltaNegativo:	print_str raiz1 
			printFloat fs1
			print_str soma
			printFloat fs2
			print_str i
			print_str newline
	
			print_str raiz2 
			printFloat fs1
			print_str subs
			printFloat fs2
			print_str i
			print_str newline
EXIT:	li a7, 10
	ecall

# 3.5) a) R-type 11, i-type 8, j-type 1   156 ns
# 3.5) b) R-type 11, i-type 8, j-type 1	156 ns
# 3.5) c) R-type 10, i-type 8, j-type 1 146 ns
# 3.5) d) R-type 10, i-type 8, j-type 1 146 ns
# 3.5) e) R-type 11, i-type 8, j-type 1 156 ns