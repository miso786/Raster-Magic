
Module phases
  EnableExplicit
  #VERSION = 100
  Global.a fast, normal, slow
  Global.a fast_increment, normal_increment, slow_increment
  
  
  ;================================
  ;Init
  ;================================
  Procedure init()
    fast_increment     =   5
    normal_increment   =   3
    slow_increment     =   1
  EndProcedure
  
  ;================================
  ;Update
  ;================================
  Procedure update()
    fast   +   fast_increment
    normal +   normal_increment
    slow   +   slow_increment
  EndProcedure
  
  ;================================
  ;sinus with Normal speed + offset
  ;================================
  Procedure.f n_sin(offset.a = 0)
    ProcedureReturn math::sin256(normal + offset)
  EndProcedure
  
  
EndModule

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 32
; Folding = -
; EnableXP
; DPIAware