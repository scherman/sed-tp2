[top]
components : persona

[persona]
type : cell
border : wrapped
delay : transport
defaultDelayTime : 100
dim : (5, 5, 2)
initialCellsValue : top.val
initialValue : -1
localTransition : persona-rule

neighbors :                                  persona(-2,0,1)
neighbors :                 persona(-1,-1,1) persona(-1,0,1) persona(-1,1,1)
neighbors : persona(0,-2,1) persona(0,-1,1)  persona(0,0,1)  persona(0,1,1) persona(0,2,1)
neighbors :                 persona(1,-1,1)  persona(1,0,1)  persona(1,1,1)
neighbors :                                  persona(2,0,1)

neighbors :                                  persona(-2,0,0)
neighbors :                 persona(-1,-1,0) persona(-1,0,0) persona(-1,1,0)
neighbors : persona(0,-2,0) persona(0,-1,0)  persona(0,0,0)  persona(0,1,0) persona(0,2,0)
neighbors :                 persona(1,-1,0)  persona(1,0,0)  persona(1,1,0)
neighbors :                                  persona(2,0,0)

[persona-rule]
%REGLAS NIVEL DIRECCION
rule : {randInt(3) + 1} 100 {cellpos(2) = 1} 
% REGLAS PARA AVANZAR
rule : {(0,1,0)}  100 { cellpos(2) = 0 and (0,0,0) = -1 and (0,1,0)  != -1 and (0,1,1) = 1 }
rule : {(1,0,0)}  100 { cellpos(2) = 0 and (0,0,0) = -1 and (1,0,0)  != -1 and (1,0,1) = 2 }
rule : {(0,-1,0)} 100 { cellpos(2) = 0 and (0,0,0) = -1 and (0,-1,0) != -1 and (0,-1,1) = 3 } 
rule : {(-1,0,0)} 100 { cellpos(2) = 0 and (0,0,0) = -1 and (-1,0,0) != -1 and (-1,0,1) = 4 }
% REGLAS PARA DECIDIR QUE SOY EL QUE AVANZA
rule : -1 100 {cellpos(2) = 0 and (0,0,0) != -1 and (0,1,0)  = -1 and (0,0,1) = 3 }
rule : -1 100 {cellpos(2) = 0 and (0,0,0) != -1 and (1,0,0)  = -1 and (0,0,1) = 4 and ((1,-1,0)  = -1 or (1,-1,1) != 3)}
rule : -1 100 {cellpos(2) = 0 and (0,0,0) != -1 and (0,-1,0) = -1 and (0,0,1) = 1 and ((0,-2,0)  = -1 or (0,-2,1) != 3) and ((-1,-1,0) = -1 or (-1,-1,1) != 4)} 
rule : -1 100 {cellpos(2) = 0 and (0,0,0) != -1 and (-1,0,0) = -1 and (0,0,1) = 2 and ((-1,-1,0) = -1 or (-1,-1,1) != 3) and ((-2,0,0) = -1 or (-2,0,1) != 4) and ((-1,1,0) = -1 or (-1,1,1) != 1)}

rule : {(0,0,0)} 100 {cellpos(2) = 0}
