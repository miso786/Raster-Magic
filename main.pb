;TEST USAGE OF RASTER MAGIC FRAMEWORK

;==================================
;INITIALIZATION
;==================================
IncludeFile "SOURCES"+#PS$+"rm_rm.pbi"
IncludeFile "SOURCES"+#PS$+"gm_gm.pbi"
gm::Init()



;==================================
;MAIN LOOP
;=================================
Repeat 
  
  gm::update()
  
ForEver

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 8
; EnableXP
; DPIAware