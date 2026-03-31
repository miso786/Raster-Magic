

Module mouse
  #VERSION = 100
  Global msprite.i
  
  ;==================================
  ;Mouse Init
  ;==================================  
  Procedure init()
    InitMouse()
  EndProcedure
  
  ;==================================
  ;Mouse Update
  ;==================================
  Procedure update()
    ExamineMouse()
  EndProcedure
  
  ;==================================
  ;Mouse Release
  ;==================================
  Procedure release()
    
  EndProcedure
  
  ;==================================
  ;Mouse Draw
  ;==================================
  Procedure draw()
    If Not IsSprite(msprite) : ProcedureReturn #False : EndIf : ; early out if sprite is not valid
    DisplayTransparentSprite(msprite,MouseX(),MouseY())
  EndProcedure
  
  ;==================================
  ;Mouse setcursorsprite
  ;==================================
  Procedure registersprite(id)
    msprite = id
  EndProcedure
  
  
  
EndModule

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 36
; Folding = --
; EnableXP
; DPIAware