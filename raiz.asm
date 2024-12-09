.data
NUM: .float 1.0e-5
STRING: .string "sqrt="
.text
MAIN:
	li a7,6 # le teclado
	ecall # a = fa0
	
	la a0, STRING #imprime sqrt=
	li a7,4
	ecall
	
	li  t0, 1
	fcvt.s.w fa1, t0
	
	jal RAIZ
	
	la a7, 2 
	ecall
	
	la a7, 10
	ecall
	
RAIZ:
	fadd.s ft0, fa0, fa1 #ft0 = n/p
	fdiv.s ft0, ft0, fa1 #ft0 = p +n/p
	
	li t1, 2
	fcvt.s.w ft3, t1     #ft3=2.0
	fdiv.s ft0, ft0, ft3 # ft0 = m = ((p+n)/p)/2.0
	
	fsub.s ft1, ft0, fa1 #ft1 = m-p
	fabs.s ft1, ft1      #fabs(m-p)
	
	la t0, num
	flw ft2,0(t0)	     # ft2 = 1e-5
	fmul.s ft5, ft0, ft3 # ft5 = 1e-5*m
	
	flt.s t1, ft1, ft5 #fabs(m-p)< 1e-5*m ?

	
	beq t1,zero, RAIZ # fa1 = m
	
	fmv.s fa0, ft0 fa0 = m
	ret
	
	
	