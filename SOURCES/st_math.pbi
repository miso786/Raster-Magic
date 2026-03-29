DeclareModule math
  Declare.f sin256(a.a)
  Declare.f cos256(a.a)
  Declare.f LERP(  a.f , b.f , t.f  )
  Declare.f INVLERP(  a.f , b.f, v.f  )
  Declare.f remap(  iMin.f , iMAX.f , oMin.f , oMax.f , v.f)    
  Declare.f approach(current.f, target.f, delta.f = 0.1)  
  Declare.f Dist2D(x1.f, y1.f, x2.f, y2.f)
  Declare.f AngleTo(x1.f, y1.f, x2.f, y2.f)

EndDeclareModule

Module math
  #VERSION = 100
  ;==============================================
  ;Precreating sin256 Lookup Table
  ;This one is correct mathematically
  ;Automatically created if module is included
  ;==============================================
  Define i.i
  Global Dim sin256LUT.f(255)
  For i = 0 To 255
    sin256LUT(i) = Sin(2 * #PI * i / 256)
  Next i
  
  
  Procedure.f Sin256(a.a)
    ProcedureReturn sin256LUT(a)
  EndProcedure
  
  ;=================================================
  ;CoSinus, angle/time/phase based, resolution 0-255
  ;sintable+64
  ;=================================================
  Procedure.f Cos256(a.a)
    a + 64
    ProcedureReturn sin256LUT(a)
  EndProcedure  
  
  ;************************************
  ;Lerp
  ;************************************
  Procedure.f LERP(a.f,b.f,t.f)
    ProcedureReturn(((1.0-t.f)*a) + (b*t))
  EndProcedure
  
  ;************************************
  ;InvLerp
  ;************************************
  Procedure.f INVLERP(a.f,b.f,v.f)
    If a=b : ProcedureReturn(1) : EndIf
    ProcedureReturn((v-a) / (b-a))
  EndProcedure
  
  ;************************************
  ;Remap
  ;************************************
  Procedure.f remap(iMin.f,iMAX.f, oMin.f, oMax.f, v.f)  
    Protected t.f
    t.f = INVLERP(iMin,iMAX,v)
    ProcedureReturn(LERP(oMin,oMax,t))
  EndProcedure
  
  ;************************************
  ;Smooth eased approach
  ;************************************
  Procedure.f approach(current.f, target.f, delta.f = 0.1)  
    ProcedureReturn((current * (1-delta)) + target * delta)
  EndProcedure
  
  ;************************************
  ;Distance of two points
  ;************************************
  Procedure.f Dist2D(x1.f, y1.f, x2.f, y2.f)
    Protected dx.f = x2 - x1
    Protected dy.f = y2 - y1
    ProcedureReturn Sqr(dx * dx + dy * dy)
  EndProcedure

  Procedure.f AngleTo(x1.f, y1.f, x2.f, y2.f)
    Protected dx.f = x2 - x1
    Protected dy.f = y2 - y1
    ; atan2 normally gives 0° = East, CCW positive.
    Protected angle.f = Degree(ATan2(dy, dx))
    ; Convert: East‑0° CCW → North‑0° CW
    angle = 90 - angle
    ; Normalize to 0–360
    If angle < 0
        angle + 360
    EndIf
    ProcedureReturn angle
EndProcedure  
  
  
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 8
; Folding = --
; EnableXP
; DPIAware