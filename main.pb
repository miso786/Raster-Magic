;==================================
;INITIALIZATION
;==================================

IncludeFile "SOURCES\rm_rm.pbi"
rm::Init()


;==================================
;MAIN LOOP
;=================================

Repeat 
  
  rm::update()
  ;-CODE START HERE
  If input::escape() : End : EndIf
  
  
  
  
  ;-CODE END HERE
ForEver

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; EnableXP
; DPIAware