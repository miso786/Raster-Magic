;TEST USAGE OF RASTER MAGIC FRAMEWORK

;==================================
;INITIALIZATION
;==================================
IncludeFile "SOURCES\rm_rm.pbi"
IncludeFile "SOURCES\gm_gm.pbi"
gm::Init()



;==================================
;MAIN LOOP
;=================================
Repeat 
  
  gm::update()
  
ForEver

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; EnableXP
; DPIAware