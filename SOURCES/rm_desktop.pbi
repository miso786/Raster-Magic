Module Desktop
  #VERSION = 100
  #MAIN    = 0
  ;======================================================
  ;This code gets the parameters of the main desktop ID 0
  ;======================================================
  Procedure Init()
    count                =  ExamineDesktops()
    main\id              =  #MAIN
    main\width           =  DesktopWidth(#MAIN)
    main\height          =  DesktopHeight(#MAIN)
    main\unscaledwidth   =  DesktopUnscaledX(main\width)
    main\unscaledheight  =  DesktopUnscaledY(main\height)
  EndProcedure
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 3
; Folding = -
; EnableXP
; DPIAware