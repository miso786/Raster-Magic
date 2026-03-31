; - SCREENSHOT STANDALONE MODULE
;====================================================================================================
;777 License – Do What You Please
;
;Copyright (c) [2026] [miso]
;
;This software code is released under the “777” terms:
;
; -    Do what you please.
; -    You may Read, modify, copy, distribute, delete, sell, bundle, Or use it in any way you like.
; -    No credit Or attribution is required.
; -    No warranties of any kind. Use at your own risk.
; -    The author is Not liable For any damage, loss, Or consequences resulting from its use.
;
;If you make something cool With it, great. If you Break something, that’s on you.
;
;That's all.
;====================================================================================================
;[100-102] - Base module
;[103]     - Added early out to function "create()" if spritegrab fails.
DeclareModule screenshot
  EnableExplicit
  Declare init()
  Declare update()
  Declare.i version()
  Declare release()
EndDeclareModule

Module screenshot
  EnableExplicit
  #VERSION                 = 103
  #PB_VERSION              = 640
  #SCREENSHOT_ENABLED      = #True           ; this should be a var later on
  #SCREENSHOT_MODIFIER_KEY = #PB_Key_LeftAlt
  #SCREENSHOT_KEY          = #PB_Key_S
  #SCREENSHOT_NAME         = "screenshot.jpg"
  
  
  
  ;*****************************************************************
  ;Initializes the screenshot module
  ;*****************************************************************
  Procedure init()
    UseJPEGImageEncoder() : ;for screenshots
    InitKeyboard()        : ;it is not really it's task, but to be standalone, I put it here too.
                          : ;Won't cause problems by being called twice.
  EndProcedure
  
  
  
  ;*****************************************************************
  ;creates the screenshot in currentdirectory() using choosen fname.
  ;*****************************************************************
  Procedure create(screenshotFileName.s)
    Protected id
    ;FIXME - Does not work with stretched screen...
    id   =   GrabSprite(#PB_Any,  0,  0,  ScreenWidth(),  ScreenHeight())
    If Not id  :  ProcedureReturn #False  :  EndIf                          ;Early out, [change 103]
    SaveSprite(id,   screenshotFileName,  #PB_ImagePlugin_JPEG)
    FreeSprite(id)
  EndProcedure
  
  
  
  
  
  ;*****************************************************************
  ; Checks for keypressed for screenshot, if screenshots are enabled
  ; It can be improved with a timestamp, but I rarely need more than
  ; one screenshot.
  ; Expects that initkeyboard() has been called once, 
  ; and examinekeyboard() called in the loop before calling this.
  ; Place it after the draw calls, and just before flipbuffers()
  ;*****************************************************************
  Procedure update()
    Static justpressed.a
    If Not #SCREENSHOT_ENABLED : ProcedureReturn #False : EndIf
    If Not KeyboardPushed(#SCREENSHOT_MODIFIER_KEY)  
      justpressed = #False
      ProcedureReturn #False ; early out
    EndIf
    
    If Not KeyboardPushed(#SCREENSHOT_KEY)
      justpressed = #False
      ProcedureReturn #False ; early out
    EndIf
   
    If justpressed = #False
      create(GetCurrentDirectory()  +  #SCREENSHOT_NAME)
      justpressed = #True
    EndIf
   
  EndProcedure
  
  
  
  ;========================================
  ;Returns the version number of the module
  ;========================================
  Procedure.i version()
    ProcedureReturn #VERSION
  EndProcedure
   
  
  ;==================================================================
  ;This is emtpy, but straightforward with other modules having this.
  ;if later something would be needed to release, this is the place.
  ;==================================================================
  Procedure release()
  EndProcedure
    
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 112
; FirstLine = 54
; Folding = --
; EnableXP
; DPIAware