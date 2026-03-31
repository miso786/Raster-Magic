
Module Input
  #VERSION = 103
  Procedure init()
    InitKeyboard()
    mouse::init()
    InitJoystick()
  EndProcedure
  
  Procedure update()
    ExamineKeyboard()
    ExamineMouse()
  EndProcedure
  
  ;==================================
  ;Returns true, if Escape is pressed
  ;==================================
  Procedure.i escape()
    ProcedureReturn KeyboardPushed(#PB_Key_Escape)
  EndProcedure
  
  ;==================================
  ;Returns true, if Space  is pressed
  ;==================================
  Procedure.i Spacekey()
    ProcedureReturn KeyboardPushed(#PB_Key_Space)
  EndProcedure
  
  ;==================================
  ;Returns true, if Left  is pressed
  ;==================================
  Procedure.i leftkey()
    ProcedureReturn KeyboardPushed(#PB_Key_Left)
  EndProcedure
  
  ;==================================
  ;Returns true, if Right  is pressed
  ;==================================
  Procedure.i rightkey()
    ProcedureReturn KeyboardPushed(#PB_Key_Right)
  EndProcedure
  
  ;==================================
  ;Returns true, if Up  is pressed
  ;==================================
  Procedure.i upkey()
    ProcedureReturn KeyboardPushed(#PB_Key_Up)
  EndProcedure
  
  ;==================================
  ;Returns true, if Down  is pressed
  ;==================================
  Procedure.i downkey()
    ProcedureReturn KeyboardPushed(#PB_Key_Down)
  EndProcedure

  
  
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; Folding = --
; EnableXP
; DPIAware