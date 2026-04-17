;============================
;- STANDALONE MODULE INCLUDES
;============================
IncludeFile "st_def.pbi"
IncludeFile "st_pet.pbi"
IncludeFile "st_math.pbi"
IncludeFile "st_screenshot.pbi"
IncludeFile "st_line.pbi"
IncludeFile "st_font.pbi"


;============================
;-HEADER DECLARATIONS GO HERE
;============================

;-DESKTOP
DeclareModule desktop
  Global count.i, main.def::desktop
  Declare Init()
EndDeclareModule

;-WINDOW
DeclareModule window
  Global main.i
  Declare init()
  Declare Show()
EndDeclareModule

;-SCREEN
DeclareModule screen
  Declare init()
EndDeclareModule

;-EVENTS
DeclareModule events
  Declare init()
  Declare update()
EndDeclareModule

;-INPUT
DeclareModule Input
  Declare   init()
  Declare   update()
  Declare.i escape()
  Declare.i spacekey()
  Declare.i upkey()
  Declare.i downkey()
  Declare.i leftkey()
  Declare.i rightkey()
EndDeclareModule

;-RESOURCES
DeclareModule res
  Declare   init()
  Declare.i Load(assetname.s , *asset.def::resource)
  Declare   Draw(*asset.def::resource, x.f, y.f)
  Declare.i SoundLoad(name.s)
  Declare.i SpriteLoad(name.s)
EndDeclareModule

;-MOUSE
DeclareModule mouse
  Declare init()
  Declare update()
  Declare release()
  Declare draw()
  Declare registersprite(id)
EndDeclareModule

;-PHASES
DeclareModule phases
  EnableExplicit
  Declare init()
  Declare update()
  Declare.f n_sin(offset.a = 0)
EndDeclareModule



;========================
;-INCLUDE MODULES GO HERE
;========================

IncludeFile "rm_desktop.pbi"
IncludeFile "rm_window.pbi"
IncludeFile "rm_screen.pbi"
IncludeFile "rm_events.pbi"
IncludeFile "rm_input.pbi"
IncludeFile "rm_res.pbi"
IncludeFile "rm_mouse.pbi"
IncludeFile "rm_phases.pbi"












; IDE Options = PureBasic 6.40 beta 7 (Windows - x64)
; CursorPosition = 8
; Folding = --
; EnableXP
; DPIAware