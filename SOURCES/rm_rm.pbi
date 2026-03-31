DeclareModule rm
  #PB_VERSION     = 640
  #VIRTUAL_WIDTH  = 1366
  #VIRTUAL_HEIGHT = 768
  #TITLE          = "Raster Magic Test"
  Declare Init()
  Declare Update()
EndDeclareModule

IncludeFile "rm_headers.pbi"

;101 - 20260329  - To free rm::events from some graphics And input calls, i modified rm::update To handle the multiwork

Module rm
  #VERSION        = 101
  ;==========================================
  ;Initializes Raster Magic 2d Game Framework
  ;==========================================
  Procedure Init()
    res::init()
    screenshot::init()
    input::init()
    Desktop::Init()
    window::init()
    screen::init()
    pet::init()
    line::init()
    window::show()
  EndProcedure
  
  Procedure update()
    input::update()
    
    events::update()
    
    mouse::draw()
    screenshot::Update()
    FlipBuffers()
    
    
    DesktopMouseX()         ; linux fix
    ClearScreen(RGB(0,0,0)) ; linux fix
    
    
  EndProcedure
EndModule


; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 20
; Folding = -
; EnableXP
; DPIAware