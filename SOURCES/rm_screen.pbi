

Module screen
  #VERSION       = 101
  #FRAMERATE     = 60     ;important, as phases and timings will be based on frames - must reach this at a steady pace on older hardware for the gameloop
  #AUTOSTRETCH   = 1
  ;[101] - moved setframerate() from rm_rm::init() to screen::init
  
  ;==========================================
  ;Initializes the main screen
  ;==========================================
  Procedure init()
    If Not OpenWindowedScreen(WindowID(window::main), 0, 0, rm::#VIRTUAL_WIDTH , rm::#VIRTUAL_HEIGHT,#AUTOSTRETCH,0,0,#PB_Screen_SmartSynchronization) : End : EndIf
    SetFrameRate(#FRAMERATE)
  EndProcedure
  
  
  
EndModule

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 8
; Folding = -
; EnableXP
; DPIAware