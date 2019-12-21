[top]
components : persona

[persona]
type : cell
border : wrapped
delay : inertial
defaultDelayTime : 100
dim : (5, 5, 4)
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

%capas
%0 sueldos personas
%1 switch salarios/impuestos
%2 prox direccion personas
%3 sueldos locales

[persona-rule]
%REGLAS NIVEL DIRECCION
% 1: izq
% 2: arriba
% 3: derecha
% 4: abajo
% no se porq no andan las macros... (reemplazar por las macros de abajo eventualmente)
rule : {1} 100 {cellpos(2) = 1 and ((if((0,-1,2) > 0, 1, 0) + if((0,-2,2) > 0, 1, 0) + if((-1,-1,2) > 0, 1, 0) + if((1,-1,2) > 0, 1, 0)) / 5) >= random } % 5 lo tire por tirar, tiene que ser >4 si o si para que sea una probabilidad, cuanto mas grande, mas random va a ser
rule : {2} 100 {cellpos(2) = 1 and ((if((-2,0,2) > 0, 1, 0) + if((-1,0,2) > 0, 1, 0) + if((-1,-1,2) > 0, 1, 0) + if((-1,1,2) > 0, 1, 0)) / 5) >= random }
rule : {3} 100 {cellpos(2) = 1 and ((if((0,1,2) > 0, 1, 0) + if((0,2,2) > 0, 1, 0) + if((-1,1,2) > 0, 1, 0) + if((1,1,2) > 0, 1, 0)) / 5) >= random }
rule : {4} 100 {cellpos(2) = 1 and ((if((1,0,2) > 0, 1, 0) + if((2,0,2) > 0, 1, 0) + if((1,1,2) > 0, 1, 0) + if((1,-1,2) > 0, 1, 0)) / 5) >= random }
rule : {randInt(3) + 1} 100 {cellpos(2) = 1}


% ACTUALIZO SALARIO PERSONA
rule : {(0,0,0) + 10} 0 { cellpos(2) = 0 and (0,0,0) != 0 and (0,0,2) = 2}

% LOCALES PAGAN IMPUESTOS
rule : {(0,0,0) - 10} 0 { cellpos(2) = 3 and (0,0,0) >= 10 and (0,0,3) = 1}
rule : {0} 0 { cellpos(2) = 3 and (0,0,0) < 10 and (0,0,3) = 1}

% ABRO LOCAL
% si la persona abre un local, para que aparezca un local y la persona pierda plata a la vez, ponemos como "estado intermedio" que el local empieza
% con -1 de plata y en el mismo instante si en la capa de locales esta en -1 la persona se descuenta de su sueldo y el local agrega su ganancia
rule : {-1} 0 { cellpos(2) = 3 and (0,0,1) > 15 and (0,0,0) = 0 and randInt(4) = 0}
rule : {(0,0,0) - 15} 0 { cellpos(2) = 0 and (0,0,3) = -1}
rule : {15} 0 { cellpos(2) = 3 and (0,0,0) = -1}

% REGLAS PARA AVANZAR (CON CONSUMO)
% para hacer que una persona gaste plata cuando entre a un local y el local gane al mismo tiempo, lo que hacemos es tener un "estado intermedio"
% en donde la persona que viene y consume termina con su sueldo en negativo, para que despues en la prox regla un local vea si el sueldo
% de la persona esta en negativo significa que consumio, entonces cobra.
rule : {-1 * ((0,-1,0) - 5)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,-1,0) > 5 and (0,-1,1) = 3 and (0,0,3) > 0 and randInt(3) < 2} 
rule : {-1 * ((-1,0,0) - 5)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (-1,0,0) > 5 and (-1,0,1) = 4 and ((0,-1,0) = 0 or (0,-1,1) != 3) and (0,0,3) > 0 and randInt(3) < 2}
rule : {-1 * ((0,1,0) - 5)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,1,0)  > 5 and (0,1,1) = 1  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and (0,0,3) > 0 and randInt(3) < 2}
rule : {-1 * ((1,0,0) - 5)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (1,0,0) > 5 and (1,0,1) = 2  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and ((0,1,0) = 0 or (0,1,1) != 1) and (0,0,3) > 0 and randInt(3) < 2}

% LOCAL GANA PLATA CUANDO PERSONA CONSUME
rule: {(0,0,0) + 5} 0 { cellpos(2) = 3 and (0,0,0) > 0 and (0,0,1) < 0}
rule: {-1 * (0,0,0)} 0 { cellpos(2) = 0 and (0,0,0) < 0} % volvemos a invertir el sueldo de la persona para que quede normal, despues de consumir.

% REGLAS PARA AVANZAR
rule : {(0,-1,0)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,-1,0) > 0 and (0,-1,1) = 3 } 
rule : {(-1,0,0)} 100 { cellpos(2) = 0 and (0,0,0) = 0 and (-1,0,0) > 0 and (-1,0,1) = 4 and ((0,-1,0) = 0 or (0,-1,1) != 3)}
rule : {(0,1,0)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (0,1,0)  > 0 and (0,1,1) = 1  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4)}
rule : {(1,0,0)}  100 { cellpos(2) = 0 and (0,0,0) = 0 and (1,0,0)  > 0 and (1,0,1) = 2  and ((0,-1,0) = 0 or (0,-1,1) != 3) and ((-1,0,0) = 0 or (-1,0,1) != 4) and ((0,1,0) = 0 or (0,1,1) != 1)}

% REGLAS PARA DECIDIR QUE SOY EL QUE AVANZA
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (0,1,0)  = 0 and (0,0,1) = 3 }
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (1,0,0)  = 0 and (0,0,1) = 4 and ((1,-1,0)  = 0 or (1,-1,1) != 3)}
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (0,-1,0) = 0 and (0,0,1) = 1 and ((0,-2,0)  = 0 or (0,-2,1) != 3) and ((-1,-1,0) = 0 or (-1,-1,1) != 4)} 
rule : 0 100 {cellpos(2) = 0 and (0,0,0) != 0 and (-1,0,0) = 0 and (0,0,1) = 2 and ((-1,-1,0) = 0 or (-1,-1,1) != 3) and ((-2,0,0) = 0 or (-2,0,1) != 4) and ((-1,1,0) = 0 or (-1,1,1) != 1)}

%REGLA DEFAULT
rule : {(0,0,0)} 100 {cellpos(2) = 0}
rule : {(0,0,0)} 100 {cellpos(2) = 3}

%REGLA SWITCH SALARIO/IMPUESTOS
rule : 2 1000 {cellpos(2) = 2 and (0,0,0) = 0}
rule : 1 0 {cellpos(2) = 2 and (0,0,0) = 2}
rule : 0 0 {cellpos(2) = 2 and (0,0,0) = 1}


#BeginMacro(cant_locales_arriba)
if((-2,0,2) > 0, 1, 0) + if((-1,0,2) > 0, 1, 0) + if((-1,-1,2) > 0, 1, 0) + if((-1,1,2) > 0, 1, 0)
#EndMacro

#BeginMacro(cant_locales_derecha)
if((0,1,2) > 0, 1, 0) + if((0,2,2) > 0, 1, 0) + if((-1,1,2) > 0, 1, 0) + if((1,1,2) > 0, 1, 0)
#EndMacro

#BeginMacro(cant_locales_abajo)
if((1,0,2) > 0, 1, 0) + if((2,0,2) > 0, 1, 0) + if((1,1,2) > 0, 1, 0) + if((1,-1,2) > 0, 1, 0)
#EndMacro

#BeginMacro(cant_locales_izq)
if((0,-1,2) > 0, 1, 0) + if((0,-2,2) > 0, 1, 0) + if((-1,-1,2) > 0, 1, 0) + if((1,-1,2) > 0, 1, 0)
#EndMacro