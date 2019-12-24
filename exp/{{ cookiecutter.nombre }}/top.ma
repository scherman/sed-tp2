[top]
components : persona

[persona]
type : cell
border : wrapped
delay : inertial
defaultDelayTime : 100
dim : (10, 10, 4)
initialCellsValue : top.val
initialValue : 0
localTransition : persona-rule


neighbors :                                  persona(-2,0,3)
neighbors :                 persona(-1,-1,3) persona(-1,0,3) persona(-1,1,3)
neighbors : persona(0,-2,3) persona(0,-1,3)  persona(0,0,3)  persona(0,1,3) persona(0,2,3)
neighbors :                 persona(1,-1,3)  persona(1,0,3)  persona(1,1,3)
neighbors :                                  persona(2,0,3)

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

% ------- CAPAS ------- 
% 0 plata personas
% 1 switch salarios/impuestos
% 2 prox direccion personas
% 3 plata locales

% ------- DIRECCIONES ------- 
% 1: izq
% 2: arriba
% 3: derecha
% 4: abajo


[persona-rule]
% ------- GENERACION PROX DIRECCION ------- 
rule : {1} 100 {cellpos(2) = 1 and ({{ cookiecutter.cant_locales_izquierda }} / 4) >= random }
rule : {2} 100 {cellpos(2) = 1 and ({{ cookiecutter.cant_locales_arriba }} / 4) >= random }
rule : {3} 100 {cellpos(2) = 1 and ({{ cookiecutter.cant_locales_derecha }} / 4) >= random }
rule : {4} 100 {cellpos(2) = 1 and ({{ cookiecutter.cant_locales_abajo }} / 4) >= random }
rule : {randInt(3) + 1} 100 {cellpos(2) = 1}

% ------- PERSONAS COBRAN SALARIO CUANDO SWITCH SE ACTIVA ------- 
rule : {(0,0,0) + {{ cookiecutter.salario_personas }}} 0 { cellpos(2) = 0 and (0,0,0) != 0 and (0,0,2) = 2}

% ------- LOCALES PAGAN IMPUESTOS CUANDO SWITCH SE ACTIVA------- 
rule : {(0,0,0) - {{ cookiecutter.impuestos_local }}} 0 { cellpos(2) = 3 and (0,0,0) >= {{ cookiecutter.impuestos_local }} and (0,0,3) = 1}
rule : {0} 0 { cellpos(2) = 3 and (0,0,0) < {{ cookiecutter.impuestos_local }} and (0,0,3) = 1}

% ------- ABRIR LOCAL ------- 
% si la persona abre un local, para que aparezca un local y la persona pierda plata a la vez, ponemos como "estado intermedio" que el local empieza con -1 de plata y en el mismo instante si en la capa de locales esta en -1 la persona se descuenta de su sueldo y el local agrega su ganancia
rule : {-1} 0 { cellpos(2) = 3 and (0,0,1) > {{ cookiecutter.costo_poner_local }} and (0,0,0) = 0 and random < {{ cookiecutter.proba_poner_local }}}
rule : {(0,0,0) - {{ cookiecutter.costo_poner_local }}} 0 { cellpos(2) = 0 and (0,0,3) = -1}
rule : { {{ cookiecutter.costo_poner_local }} } 0 { cellpos(2) = 3 and (0,0,0) = -1}

% ------- MOVIMIENTO: PERSONA CONTIGUA SE MUEVE A CELDA ACTUAL (CONSUMIENDO SI HAY LOCAL) ------- 
% para hacer que una persona gaste plata cuando entre a un local y el local gane al mismo tiempo, lo que hacemos es tener un "estado intermedio" en donde la persona que viene y consume termina con su sueldo en negativo, para que despues en la prox regla un local vea si el sueldo de la persona esta en negativo significa que consumio, entonces cobra.
rule : {-1 * ((0,-1,0) - {{ cookiecutter.costo_consumicion }})} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,-1,0) > {{ cookiecutter.costo_consumicion }} and (0,-1,1) = 3 and (0,0,3) > 0 and random < {{ cookiecutter.proba_consumir }}} 
rule : {-1 * ((-1,0,0) - {{ cookiecutter.costo_consumicion }})} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (-1,0,0) > {{ cookiecutter.costo_consumicion }} and (-1,0,1) = 4 and ((0,-1,0) = 0 or (0,-1,1) != 3) and (0,0,3) > 0 and random < {{ cookiecutter.proba_consumir }}}
rule : {-1 * ((0,1,0) - {{ cookiecutter.costo_consumicion }})}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,1,0)  > {{ cookiecutter.costo_consumicion }} and (0,1,1) = 1  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and (0,0,3) > 0 and random < {{ cookiecutter.proba_consumir }}}
rule : {-1 * ((1,0,0) - {{ cookiecutter.costo_consumicion }})}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (1,0,0) > {{ cookiecutter.costo_consumicion }} and (1,0,1) = 2  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and ((0,1,0) = 0 or (0,1,1) != 1) and (0,0,3) > 0 and random < {{ cookiecutter.proba_consumir }}}

% ------- LOCAL GANA PLATA CUANDO PERSONA CONSUME ------- 
rule: {(0,0,0) + {{ cookiecutter.costo_consumicion }}} 0 { cellpos(2) = 3 and (0,0,0) > 0 and (0,0,1) < 0}
rule: {-1 * (0,0,0)} 0 { cellpos(2) = 0 and (0,0,0) < 0} % volvemos a invertir el sueldo de la persona para que quede normal, despues de consumir.

% ------- MOVIMIENTO: PERSONA CONTIGUA SE MUEVE A CELDA ACTUAL (SIN CONSUMIR)------- 
rule : {(0,-1,0)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,-1,0) > 0 and (0,-1,1) = 3 } 
rule : {(-1,0,0)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (-1,0,0) > 0 and (-1,0,1) = 4 and ((0,-1,0) = 0 or (0,-1,1) != 3)}
rule : {(0,1,0)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,1,0)  > 0 and (0,1,1) = 1  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4)}
rule : {(1,0,0)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (1,0,0)  > 0 and (1,0,1) = 2  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and ((0,1,0) = 0 or (0,1,1) != 1)}

% ------- MOVIMIENTO: PERSONA EN CELDA ACTUAL SE MUEVE A CELDA CONTIGUA ------- 
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (0,1,0)  = 0 and (0,0,1) = 3 }
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (1,0,0)  = 0 and (0,0,1) = 4 and ((1,-1,0)  = 0 or (1,-1,1) != 3)}
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (0,-1,0) = 0 and (0,0,1) = 1 and ((0,-2,0)  = 0 or (0,-2,1) != 3) and ((-1,-1,0) = 0 or (-1,-1,1) != 4)} 
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (-1,0,0) = 0 and (0,0,1) = 2 and ((-1,-1,0) = 0 or (-1,-1,1) != 3) and ((-2,0,0) = 0 or (-2,0,1) != 4) and ((-1,1,0) = 0 or (-1,1,1) != 1)}

% ------- SWITCH SALARIO/IMPUESTOS ------- 
rule : 2 1000 {cellpos(2) = 2 and (0,0,0) = 0}
rule : 1 0 {cellpos(2) = 2 and (0,0,0) = 2}
rule : 0 0 {cellpos(2) = 2 and (0,0,0) = 1}

% ------- DEFAULT ------- 
rule : {(0,0,0)} 100 {t}