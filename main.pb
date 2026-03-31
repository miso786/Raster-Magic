;TEST USAGE OF RASTER MAGIC FRAMEWORK

;==================================
;INITIALIZATION
;==================================
IncludeFile "SOURCES\rm_rm.pbi"
rm::Init()

;==================================
;SETTING UP MOUSE GRAPHICS FOR USE
;==================================
spr_mouse = res::SpriteLoad("cursor.png")
ZoomSprite(spr_mouse,SpriteWidth(spr_mouse)/4,SpriteHeight(spr_mouse)/4)
mouse::registersprite(spr_mouse)

;==================================
;LOADING RASTER MAGIC LOGO ASSETS 
;==================================
logo   =  res::SpriteLoad("rm.png")
ZoomSprite(logo,SpriteWidth(logo)/4,SpriteHeight(logo)/4)
lw = SpriteWidth(logo)/2 : lh = SpriteHeight(logo)/2
sw = ScreenWidth()/2 : sh = 50
;==================================
;LOADING AN INTRO SOUND
;==================================
snd_intro = res::SoundLoad("intro.ogg")
PlaySound(snd_intro)
;==================================
;MAIN LOOP
;=================================

Define counter.a = 0, dist.f = 0

Repeat 
  rm::update()
  
  ;-CODE START HERE
  a+3 : dist.f = math::sin256(a)*10
  
  ;spritedraws
  DisplayTransparentSprite(logo,  (sw - lw),  (sh - lh + dist))
  rm::drawversion()
  
  ;controls
  If input::escape() : End : EndIf
  
  ;-CODE END HERE
ForEver

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 38
; EnableXP
; DPIAware