DeclareModule rm
  #PB_VERSION     = 640
  #VIRTUAL_WIDTH  = 1366
  #VIRTUAL_HEIGHT = 768
  #TITLE          = "Raster Magic Test"
  Declare Init()
  Declare Update()
  Declare drawversion()
EndDeclareModule

IncludeFile "rm_headers.pbi"

;101 - 20260329  - To free rm::events from some graphics And input calls, i modified rm::update To handle the multiwork
;103 - 20260331  - Added phases module

Module rm
  #VERSION        = 103
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
    phases::init()
    window::show()
  EndProcedure
  
  ;==========================================
  ;Initializes Raster Magic 2d Game Framework
  ;==========================================
  Procedure update()
    FlipBuffers()
    ClearScreen(RGB(0,0,0)) ; linux fix
    input::update()
    events::update()
    screenshot::Update()
    phases::update()
    mouse::draw()
    DesktopMouseX()         ; linux fix
  EndProcedure
  
  ;==========================================
  ;Returns version as string
  ;==========================================
  Procedure.s getversion_s()
    ProcedureReturn Str(#VERSION)
  EndProcedure
  
  ;==========================================
  ;Displays the frameworks version text
  ;==========================================
  Procedure drawversion()
    pet::text(0,ScreenHeight()-30,"Raster Magic framework v"+getversion_s())
  EndProcedure
  
  
EndModule


; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 13
; FirstLine = 3
; Folding = --
; EnableXP
; DPIAware