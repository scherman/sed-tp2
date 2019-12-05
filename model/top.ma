[top]
components : persona

[persona]
type : cell
border : wrapped
delay : transport
defaultDelayTime : 100
dim : (5, 5, 3)
initialCellsValue : top.val
initialValue : 0
localTransition : persona-rule

neighbors :                                  persona(-2,0,2)
neighbors :                 persona(-1,-1,2) persona(-1,0,2) persona(-1,1,2)
neighbors : persona(0,-2,2) persona(0,-1,2)  persona(0,0,2)  persona(0,1,2) persona(0,2,2)
neighbors :                 persona(1,-1,2)  persona(1,0,2)  persona(1,1,2)
neighbors :                                  persona(2,0,2)

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
% ACTUALIZO MI SALARIO
rule : {(0,0,0) + 10} 0 { cellpos(2) = 0 and (0,0,0) != 0 and (0,0,2) = 1}
% REGLAS PARA AVANZAR
rule : {(0,-1,0)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,-1,0) != 0 and (0,-1,1) = 3 } 
rule : {(-1,0,0)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (-1,0,0) != 0 and (-1,0,1) = 4 and ((0,-1,0) = 0 or (0,-1,1) != 3)}
rule : {(0,1,0)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,1,0)  != 0 and (0,1,1) = 1  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4)}
rule : {(1,0,0)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (1,0,0)  != 0 and (1,0,1) = 2  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and ((0,1,0) = 0 or (0,1,1) != 1)}
% REGLAS PARA DECIDIR QUE SOY EL QUE AVANZA
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (0,1,0)  = 0 and (0,0,1) = 3 }
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (1,0,0)  = 0 and (0,0,1) = 4 and ((1,-1,0)  = 0 or (1,-1,1) != 3)}
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (0,-1,0) = 0 and (0,0,1) = 1 and ((0,-2,0)  = 0 or (0,-2,1) != 3) and ((-1,-1,0) = 0 or (-1,-1,1) != 4)} 
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (-1,0,0) = 0 and (0,0,1) = 2 and ((-1,-1,0) = 0 or (-1,-1,1) != 3) and ((-2,0,0) = 0 or (-2,0,1) != 4) and ((-1,1,0) = 0 or (-1,1,1) != 1)}
%REGLA SALARIO
rule : {(0,0,0)} 100 {cellpos(2) = 0}

%REGLA SWITCH SALARIO
rule : 0 0 {cellpos(2) = 2 and (0,0,0) = 1}
rule : 1 1000 {cellpos(2) = 2}
