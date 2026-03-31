;==================================
;TEMPLATE GAME FILE
;==================================

;Example game exclusive file, the game manager gm_gm.pbi
;This is a template

;gm headers
;-SND
DeclareModule snd
  Declare init()
  Declare update()
  Global.i intro
EndDeclareModule

;-SPR

DeclareModule spr
  Declare init()
  Declare update()
  Global.i mouse, logo
EndDeclareModule




;-gm module declaration
DeclareModule gm
  #NAME = "TEMPLATE GAME"
  Declare init()
  Declare update()
EndDeclareModule


;-gm includes

IncludeFile "gm_spr.pbi"
IncludeFile "gm_snd.pbi"


;-gm module
; it's now has the main loop tasks, but thats not the final purpose of this module.
; Different scenes will have their own gm_scene.pbi, in the end gm_gm only handles the switching between them
; For now this module is more like a scene.
Module gm
  #VERSION = 100
  ;==================
  ;template procedure
  ;==================
  Global lw.i,sw.i,dist.f,sh,lh
  Procedure init()
    rm::Init()
    ;preloading sprites
    spr::mouse = res::SpriteLoad("cursor.png")
    ZoomSprite(spr::mouse,SpriteWidth(spr::mouse)/4,SpriteHeight(spr::mouse)/4)
    mouse::registersprite(spr::mouse)
    ;preloading sounds
    snd::intro = res::SoundLoad("intro.ogg")
    ;==================================
    ;LOADING RASTER MAGIC LOGO ASSETS 
    ;==================================
    spr::logo   =  res::SpriteLoad("rm.png")
    ZoomSprite(spr::logo,SpriteWidth(spr::logo)/4,SpriteHeight(spr::logo)/4)
    lw = SpriteWidth(spr::logo)/2 : lh = SpriteHeight(spr::logo)/2
    sw = ScreenWidth()/2 : sh = 50
    
    ;==================================
    ;PLAYING AN INTRO SOUND
    ;==================================
    PlaySound(snd::intro)
  EndProcedure
  
  ;==================
  ;template procedure
  ;==================
  Procedure update()
    rm::Update()
    ;-CODE START HERE
    dist.f = phases::n_sin() * 10
    ;spritedraws
    DisplayTransparentSprite(spr::logo,  (sw - lw),  (sh - lh + dist))
    rm::drawversion()
    ;controls
    If input::escape() : End : EndIf
    ;-CODE END HERE
  EndProcedure
  
EndModule



; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 45
; FirstLine = 1
; Folding = --
; EnableXP
; DPIAware