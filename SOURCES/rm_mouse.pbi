

Module mouse
  #VERSION = 100
  Global msprite.i
  
  Procedure init()
    InitMouse()
  EndProcedure
  
  Procedure update()
    ExamineMouse()
  EndProcedure
  
  Procedure release()
    
  EndProcedure
  
  Procedure draw()
    If Not IsSprite(msprite) : ProcedureReturn #False : EndIf : ; early out if sprite is not valid
    DisplayTransparentSprite(msprite,MouseX(),MouseY())
  EndProcedure
  
  Procedure registersprite(id)
    msprite = id
  EndProcedure
  
  
  
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 5
; Folding = --
; EnableXP
; DPIAware