[top]
components : persona gen@generator
link : out@gen in@persona

[gen]
distribution : exponential
mean : 3
initial : 1
increment : 0 
out : out

[persona]
type : cell
border : nowrapped
delay : transport
defaultDelayTime : 100
dim : (3, 10)
initialvalue : 0
in : in
link : in in@persona(1,0)
neighbors : persona(-1,-1) persona(-1,0) persona(-1,1)
neighbors : persona(0,-1) persona(0,0) persona(0,1)
neighbors : persona(1,-1) persona(1,0) persona(1,1)
localtransition: persona-rule
initialrowvalues : 1 1010100000

[persona-rule]
rule : {(0,0) + 1} 100 { (0,-1) = 1 and cellpos(1) = 9 }
rule : {(0,0)} 100 { cellpos(1) = 9 }
rule : 0 100 { (0,0) = 1 and cellpos(1) < 9 }
rule : 1 100 { (0,0) = 0 and (0,-1) = 1 }
rule : 0 100 {t} 
