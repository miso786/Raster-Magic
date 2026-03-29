DeclareModule rm
  #PB_VERSION     = 610
  #VERSION        = 100   ; 1.00, not finished yet
  #VIRTUAL_WIDTH  = 1366
  #VIRTUAL_HEIGHT = 768
  #TITLE          = "Raster Magic Test"
  Declare Init()
EndDeclareModule

IncludeFile "rm_headers.pbi"

Module rm
  ;==========================================
  ;Initializes Raster Magic 2d Game Framework
  ;==========================================
  Procedure Init()
    res::init()
    input::init()
    Desktop::Init()
    window::init()
    screen::init()
    pet::init()
    window::show()
  EndProcedure
  
  Procedure update()
    
    
    
  EndProcedure
EndModule


; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 21
; Folding = -
; EnableXP
; DPIAware