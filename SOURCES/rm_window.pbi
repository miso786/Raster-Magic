
Module window
  #VERSION = 100
  #MAIN    = 0
  #FLAGS = #PB_Window_BorderLess|#PB_Window_Invisible  
  Global color.i = RGB(0,0,0)
  
  ;==========================================
  ;Initializes the main window
  ;==========================================
  Procedure init()
    main = OpenWindow(#PB_Any, 0,0,rm::#VIRTUAL_WIDTH, rm::#VIRTUAL_WIDTH, rm::#TITLE, #FLAGS)
    SetWindowColor(main,color)
  EndProcedure
  
  
  ;======================================================
  ;The main window starts as hidden, that will enable it.
  ;======================================================
  Procedure show()
    ResizeWindow(main,0,0,desktop::main\unscaledwidth,desktop::main\unscaledheight)
    HideWindow(main,#False)
  EndProcedure
  
EndModule

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 8
; Folding = -
; EnableXP
; DPIAware