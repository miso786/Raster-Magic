
;******************************************************************
;Special thanks for MijiKai and Stargate for the line snippet
;******************************************************************
;--MODULE DECLARATION
DeclareModule line
  Global sprite_ID.i = -1 ;(Sprite used with filledbox:: module also)
  Declare init()
  Declare destroy()
  Declare draw(x1.i , y1.i , x2.i , y2.i , color.i = -1 , width.i=2 , intensity.i = 255)
EndDeclareModule

DeclareModule box
  Declare draw(x1.i , y1.i , x2.i , y2.i , color.i = -1 , width.i=2 , intensity.i = 255)
EndDeclareModule

DeclareModule filledbox
  Declare draw(x1.i , y1.i , x2.i , y2.i , color.i = -1 , intensity.i = 255)
EndDeclareModule




;******************************************************************
;Special thanks for MijiKai and Stargate for the line snippet
;******************************************************************
;--MODULE
Module line
  #VERSION = 100
  ;******************************************************************
  ;This procedure initializes the line functions, creates it's sprite
  ;******************************************************************
  Procedure init()
    If Not IsSprite( sprite_ID )
      sprite_ID = CreateSprite(#PB_Any,1,1,#PB_Sprite_AlphaBlending)
      If Not IsSprite( sprite_ID ) : ProcedureReturn #False : EndIf
      StartDrawing( SpriteOutput( sprite_ID ) )
      DrawingMode( #PB_2DDrawing_AllChannels )
      Box(0 , 0 , OutputWidth() , OutputHeight() , RGBA( 255 , 255 , 255 , 255 ))
      StopDrawing()
      ProcedureReturn #True  
    EndIf
  EndProcedure
  
  ;******************************************************************
  ;This procedure frees the resources (1 sprite) if linedrawing is 
  ;not needed anymore
  ;******************************************************************
  Procedure destroy()
    If IsSprite(sprite_ID) : FreeSprite(sprite_ID) : EndIf 
  EndProcedure
  
  ;******************************************************************
  ;This procedure draws a line to screen either 2d or 3d Ogre screen
  ;******************************************************************
  Procedure draw(x1.i , y1.i , x2.i , y2.i , color.i = -1 , width.i=2 , intensity.i = 255)
    ;MIJIKAI and STARGATE code
    Protected.f length, dx, dy
    length = Sqr((X1-X2)*(X1-X2) + (Y1-Y2)*(Y1-Y2))
    dy = (X2 - X1) * Width / (2 * length)
    dx = (Y1 - Y2) * Width / (2 * length)
    ;ZoomSprite(sprite_ID , length , length)
    TransformSprite(sprite_ID , X1-dx , Y1-dy , X2-dx , Y2-dy , X2+dx , Y2+dy , X1+dx , Y1+dy)
    DisplayTransparentSprite(sprite_ID , 0 , 0 , intensity , color)
  EndProcedure
EndModule



Module box
  #VERSION = 100
  ;******************************************************************
  ;This procedure draws an outlined box
  ;******************************************************************
  Procedure draw(x1.i , y1.i , x2.i , y2.i , color.i = -1 , width.i=2 , intensity.i = 255)
    Protected o.i ;Offset
    o  =  Round( width/2 , #PB_Round_Nearest )
    line::draw(x1   , y1+o , x2      , y1+o    , color.i , width.i , intensity.i)
    line::draw(x1   , y2-o , x2-o    , y2-o    , color.i , width.i , intensity.i)
    line::draw(x2-o , y1   , x2-o    , y2      , color.i , width.i , intensity.i)
    line::draw(x1+o , y1+o , x1+o    , y2-o    , color.i , width.i , intensity.i)
  EndProcedure
EndModule

Module filledbox
  #VERSION = 100
  ;******************************************************************
  ;This procedure draws a line to screen either 2d or 3d Ogre screen
  ;******************************************************************
  Procedure draw(x1.i , y1.i , x2.i , y2.i , color.i = -1 , intensity.i = 255)
    ;MIJIKAI and STARGATE code
    Protected.f length, dx, dy
    length = Sqr( (X1-X2) * (X1-X2) + (Y1-Y2) * (Y1-Y2) )
    TransformSprite(line::sprite_ID , X1 , Y1 , X2 , Y1 , X2 , Y2 , X1 , Y2)
    DisplayTransparentSprite(line::sprite_ID , 0 , 0 , intensity , color)
  EndProcedure
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 85
; FirstLine = 38
; Folding = --
; EnableXP
; DPIAware