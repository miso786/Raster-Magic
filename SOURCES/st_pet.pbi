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


;====================================================================================================
;
; Simple Graphic Texts using Sprites without external data
;
;====================================================================================================
DeclareModule pet
#VERSION = 100
EnableExplicit
;=======================================================================
;petscii font for debug messages on screen
;=======================================================================
  Declare init()
  Declare text(x,y,text.s,color.i=$FFFFFF,intensity.i=255)
  Declare centertext(x,y,text.s,color.i,intensity.i=255)
  Declare releasefont()
EndDeclareModule

Module pet
;======================================================
;System fonts  for displaying system messages on screen
;======================================================
  EnableExplicit
  #USED_CHARACTERS="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[{]};:',<.>/?"+Chr(34)
  Global Dim font(370):Global Dim fontimport.i(370)
  
  ;*****************************************************************
  ;Initializes the pet font module
  ;*****************************************************************
  Procedure init()
    Protected x.i,i.i,j.i,sprline.a
    For i = 1 To Len(#USED_CHARACTERS):fontImport(Asc(Mid(#USED_CHARACTERS,i,1)))=1 : Next i 
    Restore sysfont
      For x= 1 To 370
        If fontimport(x)=1
          font(x)=CreateSprite(#PB_Any,8,12,#PB_Sprite_AlphaBlending)
          StartDrawing(SpriteOutput(font(x)))
          DrawingMode(#PB_2DDrawing_AllChannels)
          For j=0 To 11  
            Read.a sprline 
            For i=0 To 7
              If sprline&%1 :Plot(i,j,RGBA(255,255,255,255)): Else : Plot(i,j,RGBA(0,0,0,0)) : EndIf
              sprline>>1 
            Next i
          Next j
          StopDrawing()
          ZoomSprite(font(x),16,24)
        EndIf
      Next x
  EndProcedure
  
  ;*****************************************************************
  ;draws some text to screen
  ;*****************************************************************
  Procedure text(x,y,text.s,color.i=$FFFFFF,intensity.i=255) : Protected.i textlength,i,character
    textlength.i = Len(text.s)
    For i = 1 To textlength.i
      character.i = Asc(Mid(text.s,i,1))
      If character.i>ArraySize(font()) : ProcedureReturn #Null : EndIf
      If IsSprite(font(character))
        DisplayTransparentSprite(font(character),(x+((i-1) * 16)),(y),intensity,color.i)
      EndIf
    Next i
  EndProcedure
  
  ;*****************************************************************
  ;Draws centered text to screen
  ;*****************************************************************
  Procedure centertext(x,y,text.s,color.i,intensity=255)
    Protected textlength.i
    textlength.i = Len(text.s)
    x=x-(textlength*8) : y=y-8
    text(x,y,text.s,color,intensity)
  EndProcedure
  
  ;*****************************************************************
  ;Frees the resources that had been reserved when initialized
  ;*****************************************************************
  Procedure releasefont()
    Protected i.i
    For i = 1 To Len(#USED_CHARACTERS)
      If IsSprite(font(i)) : FreeSprite(font(i)) : EndIf
    Next i
  EndProcedure
  
 ;*****************************************************************
 ;Font data
 ;***************************************************************** 
 DataSection
    sysfont:
    Data.q $3838383838380000,$EEEE000000003800,$00000000000000EE,$FFEEFFEEEEEE0000,$383800000000EEEE,$0000387EE07C0EFC,$1C3870EECECE0000,$7C7C00000000E6EE,$0000FCEEEE3C7CEE
    Data.q $00003870E0E00000,$7070000000000000,$000070381C1C1C38,$707070381C1C0000,$0000000000001C38,$000000EE7CFF7CEE,$38FE383800000000,$0000000000000038,$001C383800000000
    Data.q $00FE000000000000,$0000000000000000,$0000383800000000,$3870E0C000000000,$7C7C000000000E1C,$00007CEEEEFEFEEE,$38383C3838380000,$7C7C00000000FE38,$0000FE0E1C70E0EE
    Data.q $E078E0EE7C7C0000,$E0E0000000007CEE,$0000E0E0FEEEF8F0,$E0E07E0EFEFE0000,$7C7C000000007CEE,$00007CEEEE7E0EEE,$383870EEFEFE0000,$7C7C000000003838,$00007CEEEE7CEEEE
    Data.q $E0FCEEEE7C7C0000,$3838000000007CEE,$0000383800000038,$0000003838380000,$F0F00000001C3838,$0000F0381C0E1C38,$FE00FE0000000000,$1E1E000000000000,$00001E3870E07038
    Data.q $3870E0EE7C7C0000,$7C7C000000003800,$00007CCE0EFEFEEE,$EEFEEE7C38380000,$7E7E00000000EEEE,$00007EEEEE7EEEEE,$0E0E0EEE7C7C0000,$3E3E000000007CEE,$00003E7EEEEEEE7E
    Data.q $0E3E0E0EFEFE0000,$FEFE00000000FE0E,$00000E0E0E3E0E0E,$EEFE0EEE7C7C0000,$EEEE000000007CEE,$0000EEEEEEFEEEEE,$383838387C7C0000,$F8F8000000007C38,$00003C7E70707070
    Data.q $3E1E3E7EEEEE0000,$0E0E00000000EE7E,$0000FE0E0E0E0E0E,$CEFEFEFECECE0000,$EEEE00000000CECE,$0000EEEEFEFEFEFE,$EEEEEEEE7C7C0000,$7E7E000000007CEE,$00000E0E0E7EEEEE
    Data.q $EEEEEEEE7C7C0000,$7E7E00000000F07C,$0000EE7E3E7EEEEE,$E07C0EEE7C7C0000,$FEFE000000007CEE,$0000383838383838,$EEEEEEEEEEEE0000,$EEEE000000007CEE,$0000387CEEEEEEEE
    Data.q $FEFECECECECE0000,$EEEE00000000CEFE,$0000EEEE7C387CEE,$387CEEEEEEEE0000,$FEFE000000003838,$0000FE0E1C3870E0,$1C1C1C1C7C7C0000,$7C7C000000007C1C,$00007C7070707070
    Data.q $3838FE7C38380000,$0000000000003838,$0000FF0000000000,$FCE07C0000000000,$000000000000FCEE,$00007EEEEE7E0E0E,$0E0E7C0000000000,$0000000000007C0E,$0000FCEEEEFCE0E0
    Data.q $FEEE7C0000000000,$0000000000007C0E,$0000383838FC38F0,$EEEEFC0000000000,$0E0E0000007EE0FC,$0000EEEEEEEE7E0E,$38383C0038380000,$0000000000007C38,$003C707070700070
    Data.q $3E7E0E0E0E0E0000,$3C3C00000000EE7E,$00007C3838383838,$FEFEEE0000000000,$000000000000CEFE,$0000EEEEEEEE7E00,$EEEE7C0000000000,$0000000000007CEE,$000E0E7EEEEE7E00
    Data.q $EEEEFC0000000000,$0000000000E0E0FC,$00000E0E0EEE7E00,$7C0EFC0000000000,$0000000000007EE0,$0000F0383838FE38,$EEEEEE0000000000,$000000000000FCEE,$0000387CEEEEEE00
    Data.q $FEFECE0000000000,$000000000000FCFC,$0000EE7C387CEE00,$EEEEEE0000000000,$00000000003E70FC,$0000FE1C3870FE00,$381E3838F0F00000,$1E1E00000000F038,$00001E3838F03838
  EndDataSection
EndModule 

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 104
; Folding = --
; EnableXP
; DPIAware