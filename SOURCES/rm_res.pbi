;=========================
;RESOURCES MODULE
;Handles all asset loading
;=========================
Module res
  EnableExplicit
  #VERSION = 101
  Global soundcount
  Global spritecount
  
  Global Path$ = ".\Data\"
  
  ;==========================================
  ;Initializes the res module
  ;==========================================
  Procedure init()
    UseZipPacker()
    UsePNGImageDecoder()
    UseJPEGImageDecoder()
    UsePNGImageEncoder()            ;For creating screenshots/sprite assets in editors
    UseJPEGImageEncoder()           ;For creating screenshots
    UseOGGSoundDecoder()
    InitSprite()
    InitSound()
  EndProcedure
  
  ;========================================================
  ;Loads an asset by its extension, uses the resource type!
  ;========================================================
  Procedure.i Load(assetname.s , *asset.def::resource)
    Protected extension.s
    Protected length.i = Len(assetname)
    extension.s = Right(assetname.s, 4)
    With *asset
      If extension.s = ".png" Or extension.s = ".jpg"
        \id=res::spriteload(assetname.s)
        If Not IsSprite(\id) : ProcedureReturn #False : EndIf
        \type = def::#SPRITE
        \w = SpriteWidth(\id)
        \h = SpriteHeight(\id)
        \cx = \w/2
        \cy = \h/2
        ProcedureReturn #True
      ElseIf extension.s = ".wav" Or extension.s = ".ogg"
        \id=res::SoundLoad(assetname.s)
        If Not IsSound(\id) : ProcedureReturn #False : EndIf
        \type = def::#SOUND
        ProcedureReturn #True
      EndIf
    EndWith
  EndProcedure
  
  
  ;==============================================
  ;Draws a sprite asset of resource sprite at x,y
  ;==============================================
  Procedure Draw(*asset.def::resource, x.f, y.f)
    With *asset
      If \Type = def::#SPRITE
        If Not IsSprite(\id):End:EndIf
        DisplayTransparentSprite(\id, x.f, y.f)
      EndIf
    EndWith
  EndProcedure
  
  Procedure Iload()
  EndProcedure
  
  
  
  ;==========================================
  ;Loads a sound from a specific zip
  ;Returns it's ID
  ;==========================================
  Procedure.i SoundLoad(name.s)
    Protected Archive, Size, *Buffer, ID,result.i
    Protected ArchiveName.s = Path$ + "sounds.zip"
    If FileSize(ArchiveName.s) = 0 : ProcedureReturn -1 : EndIf
    Archive = OpenPack(#PB_Any, ArchiveName.s, #PB_PackerPlugin_Zip)
    If Not Archive : ProcedureReturn -1: EndIf
    If Not ExaminePack(Archive) : ClosePack(archive) : ProcedureReturn - 1 : EndIf
    
    While NextPackEntry(Archive)
      If PackEntryName(Archive) = name.s
        Size = PackEntrySize(Archive, #PB_Packer_UncompressedSize)
        *Buffer = AllocateMemory(Size)
        If *Buffer = 0 : ProcedureReturn -1 : EndIf
        Result.i = UncompressPackMemory(Archive, *Buffer, Size, name.s)
        If Result <> Size : FreeMemory(*Buffer) : ProcedureReturn -1 : EndIf
        ID = CatchSound(#PB_Any, *Buffer, Size)
        ClosePack(Archive)
        FreeMemory(*Buffer)
        If Not IsSound(ID) : ProcedureReturn -1 : EndIf
        soundcount + 1
        ProcedureReturn ID
      EndIf 
    Wend
    ClosePack(Archive)
    ProcedureReturn ID
  EndProcedure
  
  
  
  ;==========================================
  ;Loads a sprite from a specific zip
  ;Returns it's ID
  ;==========================================
  Procedure.i SpriteLoad(name.s)
    #SpriteFlags = #PB_Sprite_AlphaBlending
    Protected Archive, Size, *Buffer, ID,result.i
    Protected ArchiveName.s = Path$ + "sprites.zip"
    If FileSize(ArchiveName.s) = 0 : ProcedureReturn -1 : EndIf
    Archive = OpenPack(#PB_Any, ArchiveName.s, #PB_PackerPlugin_Zip)
    If Not Archive : ProcedureReturn -1: EndIf
    If Not ExaminePack(Archive) : ClosePack(archive) : ProcedureReturn - 1 : EndIf
    
    While NextPackEntry(Archive)
      If PackEntryName(Archive) = name.s
        Size = PackEntrySize(Archive, #PB_Packer_UncompressedSize)
        *Buffer = AllocateMemory(Size)
        If *Buffer = 0 : ProcedureReturn -1 : EndIf
        Result.i = UncompressPackMemory(Archive, *Buffer, Size, name.s)
        If Result <> Size : FreeMemory(*Buffer) : ProcedureReturn -1 : EndIf
        ID = CatchSprite(#PB_Any, *Buffer, #SpriteFlags)
        ClosePack(Archive)
        FreeMemory(*Buffer)
        If Not IsSprite(ID) : ProcedureReturn -1 : EndIf
        spritecount + 1
        ProcedureReturn ID
      EndIf 
    Wend
    ClosePack(Archive)
    ProcedureReturn ID
  EndProcedure
  
EndModule

; IDE Options = PureBasic 6.40 beta 6 (Windows - x64)
; CursorPosition = 6
; Folding = --
; EnableXP
; DPIAware