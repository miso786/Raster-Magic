IncludeFile "SOURCES\rm_rm.pbi"



;main is for tests and prototyping. So its chaos. All the other stuff are well written I hope.


rm::Init()

a = res::SpriteLoad("starfield_256.png")
ZoomSprite(a,400,400)
b = res::SoundLoad("newintro.ogg")
c = res::SpriteLoad("hangar.png")
;d = res::SpriteLoad("cae05.png")
d = res::SpriteLoad("cp3.png")
e = res::SpriteLoad("hangar_main_halo.png")
f = res::SpriteLoad("light_triplet.png")
g = res::SpriteLoad("olight.png")


Global.def::resource newres,small
Global.def::spriteactor myactor,parent,lc


res::Load("cae05.png",@newres)
res::Load("e1_lowres.png",@small)


parent\spr = @small
parent\alpha = 255
With parent\gizmo
  \x= 1366/2
  \y= 100
  \sx = 1
  \sy = 1
  \angle256 = 0
  \angle360 = 0
EndWith




myactOr\spr = @small
myactor\alpha = 255
myactOr\hasparent = #True
myactor\parentgizmo = @parent\gizmo
With myactor\gizmo
  \x= 0
  \y= 100
  \sx = 1
  \sy = 1
  \angle256 = 0
  \angle360 = 0
EndWith



lc\spr = @small
lc\alpha = 255
lc\hasparent = #True
lc\parentgizmo = @myactor\gizmo
With lc\gizmo
  \x= 0
  \y= 100
  \sx = 1
  \sy = 1
  \angle256 = 0
  \angle360 = 0
EndWith






Procedure DrawSpriteActor(*actor.def::spriteactor)

    Define id = *actor\spr\id
    Define.f px, py, pa, sx, sy
    Define.f lx, ly, la, lsx, lsy

    ; Local transform
    lx  = *actor\gizmo\x
    ly  = *actor\gizmo\y
    la  = *actor\gizmo\angle360
    lsx = *actor\gizmo\sx
    lsy = *actor\gizmo\sy

    If *actor\hasparent

        ; Parent world transform
        px = *actor\parentgizmo\px
        py = *actor\parentgizmo\py
        pa = *actor\parentgizmo\pa
        sx = *actor\parentgizmo\sx
        sy = *actor\parentgizmo\sy

        ; --- WORLD ROTATION ---
        Define.f rad = Radian(pa)
        Define.f rx = lx * Cos(rad) - ly * Sin(rad)
        Define.f ry = lx * Sin(rad) + ly * Cos(rad)

        ; --- WORLD SCALE ---
        rx * sx
        ry * sy

        ; --- WORLD POSITION ---
        *actor\gizmo\px = px + rx
        *actor\gizmo\py = py + ry

        ; --- WORLD ROTATION ---
        *actor\gizmo\pa = pa + la

        ; --- WORLD SCALE ---
        *actor\gizmo\sx = sx * lsx
        *actor\gizmo\sy = sy * lsy

    Else
        ; Root actor → world = local
        *actor\gizmo\px = lx
        *actor\gizmo\py = ly
        *actor\gizmo\pa = la
        *actor\gizmo\sx = lsx
        *actor\gizmo\sy = lsy
    EndIf

    ; --- SPRITE DRAWING ---
    ZoomSprite(id, *actor\spr\w * *actor\gizmo\sx, *actor\spr\h * *actor\gizmo\sy)
    RotateSprite(id, *actor\gizmo\pa, #PB_Absolute)

    Define drawX.f = *actor\gizmo\px - *actor\spr\cx * *actor\gizmo\sx
    Define drawY.f = *actor\gizmo\py - *actor\spr\cy * *actor\gizmo\sy

    DisplayTransparentSprite(id, drawX, drawY, *actor\Alpha)

EndProcedure



PlaySound(b)
ctr.a
Repeat 
  ctr.a+3
  ctr2.a+2
  ctr3.a+1
  ctr4.a+8
  events::update()
  
  RotateSprite(a,0.1,#PB_Relative)
  DisplayTransparentSprite(a,ScreenWidth()/2-SpriteWidth(a)/2,ScreenHeight()/2-SpriteHeight(a)/2)
  DisplayTransparentSprite(c,0,0)
  ;ZoomSprite(e,255+math::cos256(ctr)*25,255+math::Cos256(ctr)*25)
  DisplayTransparentSprite(e,678-SpriteWidth(e)/2,248-SpriteHeight(e)/2,128+math::cos256(ctr3)*32)
  
  DisplayTransparentSprite(f,1174-SpriteWidth(f)/2,65-SpriteHeight(f)/2,128+math::Sin256(ctr)*64)
  
  ZoomSprite(g,128,128)
  RotateSprite(g,0,#PB_Absolute)
  DisplayTransparentSprite(g,274,17,128+math::Sin256(ctr)*64)
  DisplayTransparentSprite(g,474,100,128+math::Sin256(ctr)*32)
  ZoomSprite(g,80,80)
  DisplayTransparentSprite(g,500,125,128+math::Sin256(ctr3)*64)
  RotateSprite(g,90,#PB_Absolute)
  ZoomSprite(g,80,80)
  DisplayTransparentSprite(g,200,220,128+math::Sin256(ctr+32)*64)
  DisplayTransparentSprite(g,1260,88,128+math::Sin256(ctr4+64)*64)
  DisplayTransparentSprite(g,1260,110,128+math::Sin256(ctr4)*64)
  
  
  Define cx.f = 700.0
  Define cy.f = Round(math::Sin256(ctr3)*4,#PB_Round_Nearest)
  DisplayTransparentSprite(d,cx.f,cy.f)
  res::draw(@newres,-300,0)
  
  pet::text(10,10,"Raster Magic + Void Squadron test 2: actors + parent - child hierarchy")
  
  parent\gizmo\angle360 = math::sin256(ctr2)*40
  ;parent\gizmo\sx = 1+math::sin256(ctr)*0.5
  ;parent\gizmo\sy = 1+math::sin256(ctr)*0.5
  
  
  
  ;myactor\gizmo\x = 1366/2;+math::sin256(ctr3)*106
  ;myactor\gizmo\y = 768/2;+math::sin256(ctr3)*106
  ;myactor\gizmo\sx = 1+math::sin256(ctr4)*0.5
  ;myactor\gizmo\sy = 1+math::sin256(ctr4)*0.5
  myactor\gizmo\angle360 = math::sin256(ctr2)*30
  lc\gizmo\angle360 = math::sin256(ctr2)*20
  myactor\alpha = 128+math::sin256(ctr3)*32
  drawspriteactor(@parent)
  drawspriteactor(@myactor)
  drawspriteactor(@lc)
  If input::escape() : End : EndIf
  screenshot::Update()
  FlipBuffers()
  
  Delay(0)
ForEver

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 189
; FirstLine = 161
; Folding = -
; EnableXP
; DPIAware