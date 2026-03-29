DeclareModule def
  Structure desktop
    id.i
    width.i
    height.i
    unscaledwidth.i
    unscaledheight.i
  EndStructure
  
  ;RESOURCE TYPES, fix values, no changing enumerations allowed here.
  #DATA   = 1
  #IMAGE  = 2
  #SPRITE = 3
  #SOUND  = 4
  Structure Resource
    type.i      ; #DATA #IMAGE or #SPRITE
    id.i        ; spriteID ImageID or soundID or textureID etc.
    w.i         ; base width
    h.i         ; base height
    cx.i        ; base center point, saves some divides
    cy.i
  EndStructure
  
  Structure gizmo
    x.f
    y.f
    sx.f
    sy.f
    angle256.a
    angle360.f
    px.f
    py.f
    pa.f
  EndStructure
  
  Structure spriteactor
    *spr.resource
    gizmo.gizmo
    alpha.a
    hasparent.a
    *parentgizmo.gizmo
  EndStructure

EndDeclareModule


Module def
  #VERSION = 102
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 32
; FirstLine = 7
; Folding = -
; EnableXP
; DPIAware