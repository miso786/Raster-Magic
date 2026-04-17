;=======================================================================
;Font module to load raster magic graphic fonts
;Work in progress, not all safety code had been added yet.
;=======================================================================

;20260417 0202        - miso - Added the first implementation


;=======================================================================
;".fnt" file format specification
;The file is a zip, extension is .fnt
;Contains only png images at the moment, the png filenames is assembled:
;
;unicode number + ".png"
;
; The width dimension of the images are used as character width,
; Height usually should be the same everywhere.
;=======================================================================



DeclareModule fnt
  EnableExplicit
  
  #VERSION                =    001  ;WORK IN PROGRESS
  #COMPRESSION            =    #PB_PackerPlugin_Zip
  #FORMAT                 =    #PB_ImagePlugin_PNG
  #EXTENSION_GRAPHICS     =    ".fnt"
  
  Structure template
    id.i
    valid.i
    charactercount.i
    lastcharacter.i
    *characters
    *characterswidth
    *charactersheight
  EndStructure
  
  Global Dim lst.template(0)         ; temporary array
  Global Dim temp.i(0)               ; data of loaded fonts
  
  Global active          =  -1       ; no active font at start
  
;=======================================================================
  Declare init()
  Declare release()
  Declare load(filename.s)
  Declare draw(x.i,y.i,t$)
  Declare setcurrent(id)
EndDeclareModule

Module fnt
  EnableExplicit
  Global Path$            =    GetCurrentDirectory()  +  "DATA"  +  #PS$
  Global count.i
  
  
  ;*****************************************************************
  ;Initializes fonts module
  ;*****************************************************************
  Procedure init()
    UseZipPacker()
  EndProcedure
    
    
  ;*****************************************************************
  ;Loads a raster magic font file
  ;*****************************************************************
  Procedure load(filename.s)
    Protected packid, ucurrent, umax, *buffer, size, counter
    Protected i
    ReDim lst(count)
    filename.s    =     path$  +  filename.s
    If Right(filename.s,4) <> fnt::#EXTENSION_GRAPHICS : ProcedureReturn(#False) : EndIf
    If Not FileSize(filename.s) : ProcedureReturn(#False) : EndIf
    packid = OpenPack(#PB_Any,filename.s,fnt::#COMPRESSION)
    If Not IsPack(packid) : ProcedureReturn #False : EndIf
    ExaminePack(packid)
    While NextPackEntry(packid)
      counter + 1
      ucurrent = Val(Left(PackEntryName(packid),8))
      If ucurrent>umax
        umax = ucurrent
        ReDim temp(umax)
      EndIf
      size = PackEntrySize(packid,#PB_Packer_UncompressedSize)
      *buffer = AllocateMemory(size,#PB_Memory_NoClear)
      UncompressPackMemory(packid,*buffer,size)
      temp(ucurrent) = CatchSprite(#PB_Any,*buffer,#PB_Sprite_AlphaBlending)
      FreeMemory(*buffer)
    Wend
    ClosePack(packid)
    lst(count)\id               =   count
    lst(count)\charactercount   =   counter
    lst(count)\lastcharacter    =   umax
    lst(count)\valid            =   #True
    lst(count)\characters       =   AllocateMemory(   (umax+1)   *   SizeOf(integer)   )
    lst(count)\characterswidth  =   AllocateMemory(   (umax+1)   *   SizeOf(integer)   )
    lst(count)\charactersheight =   AllocateMemory(   (umax+1)   *   SizeOf(integer)   )

    CopyMemory(@temp(0),lst(count)\characters,   (umax+1)   *   SizeOf(Integer))
    For i = 0 To umax
      If IsSprite(temp(i))
        PokeI(lst(count)\characterswidth+(i*SizeOf(integer)),SpriteWidth(temp(i)))
        PokeI(lst(count)\charactersheight+(i*SizeOf(integer)),SpriteHeight(temp(i)))
      EndIf
    Next i
    ReDim temp(0)
    count + 1
    ProcedureReturn (count - 1)
  EndProcedure
  
  Procedure setcurrent(id)
    fnt::active = id
  EndProcedure
  
  ;==========================================
  ;Draws text on screen with the current font
  ;==========================================
  Procedure draw(x.i,y.i,t$)
    Protected i.i,pos,cc
    Protected clip = ScreenWidth()
    If fnt::active<0 Or fnt::active>count : ProcedureReturn #False : EndIf
    If fnt::lst(fnt::active)\valid <> #True : ProcedureReturn #False : EndIf
    For i = 1 To Len(t$)
      cc=Asc(Mid(t$,i,1))
      If cc>fnt::lst(fnt::active)\lastcharacter Or cc<0 :ProcedureReturn #False: EndIf
      If IsSprite(PeekI(lst(active)\characters+(cc*SizeOf(integer)))) And cc>0 And x+pos-120<clip
        DisplayTransparentSprite(PeekI(lst(active)\characters+(cc*SizeOf(integer))),x+pos,y)
        pos + PeekI(lst(active)\characterswidth+(cc*SizeOf(integer)))+1
      EndIf
    Next i
  EndProcedure
  
  ;*****************************************************************
  ;Frees the resources that had been reserved when initialized
  ;*****************************************************************
  Procedure release()
  EndProcedure
  
EndModule


; IDE Options = PureBasic 6.40 beta 7 (Windows - x64)
; CursorPosition = 24
; Folding = --
; EnableXP
; DPIAware