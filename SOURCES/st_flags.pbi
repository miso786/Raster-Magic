;This Module is For storing true/false type data in binary.
;It's purpose is to be small in size, have fast save possibility.
;can be used for gamestates, pathfinding nodes (open/closed)
;It is possible to store a large set of data with this like:
;Is #npc_A_alive, #has_pc_visited_place_A, has_item_key_A. seen_this_thing_A_before
;Saving would be fast with bitflags, can be compressed too.
;Note: Later it would be good to create a byte/other, longer formats

;Changelog:
;Ver: 100 - Created by miso 20260420 1904
;Ver: 100 - small typo fixes in comments by miso 20260420 1904
;Ver: 101 - added full release (no single flags list delete yet) by miso 20260420 1930
;Ver: 102 - choose() was broken, fixed.
;         - bitsize check fixed
;         - fixed get()
;         - added safety check for address if its null
;         - added safety check for blockid to not be greater than count
;         - safety protocol : redim and count-1 if memory allocation fails with create
;         - Added choose to public declarations
;         - clearing current\ after full release


;====================
;-PUBLIC DECLARATIONS
;====================
DeclareModule flags
  Declare init()
  Declare.i create(bitsize.i)
  Declare set(index   ,   blockid  =  0)
  Declare clear(index ,   blockid  =  0)
  Declare flip(index  ,   blockid  =  0)
  Declare get(index   ,   blockid  =  0)
  Declare release()
  Declare choose(id)
EndDeclareModule

;==================
;-FLAGS MODULE
;==================
Module flags
  #VERSION        = 102
  #BITSPERBYTE    = 8
  #BITMINIMUM     = 1
  #COUNTMINIMUM   = 1
  
  ;==================
  Structure flagstype
    *address
    bitsize.i
    size.i
  EndStructure
  
  ;==================
  Global current.flagstype
  Global count     = 0
  current\address  = 0
  current\bitsize  = 0
  current\size     = 0
  
  ;mbk should be used as name for all memory block type later on
  ;==================
  Global Dim mbk.flagstype(count)
  
  ;==========================================
  ;auto initialized, its just for consistency
  ;==========================================
  Procedure init()
  EndProcedure
  
  ;=====================================
  ;Creates a set of bitflags, returns ID
  ;=====================================
  Procedure.i create(bitsize.i)
    If bitsize<#BITMINIMUM   :   ProcedureReturn #False   :   EndIf
    Protected bytecount.i, remainder.i
    bytecount   =   bitsize / #BITSPERBYTE
    remainder   =   bitsize % #BITSPERBYTE
    If remainder<> 0 :   bytecount + 1   : EndIf
    count + 1
    ReDim mbk(count)
    mbk(count)\address   =   AllocateMemory(bytecount)
    If Not mbk(count)\address   :count - 1 : ReDim mbk(count) :   ProcedureReturn #False   :   EndIf
    mbk(count)\size      =   bytecount
    mbk(count)\bitsize   =   bitsize
    ProcedureReturn count
  EndProcedure
  
  ;===================================
  ;Sets the default id of the bitflags
  ;===================================
  Procedure choose(id)
    If id<#COUNTMINIMUM Or id>count
      ProcedureReturn #False
    EndIf
    current\address = mbk(id)\address
    current\bitsize = mbk(id)\bitsize
    current\size    = mbk(id)\size
  EndProcedure
  
  Procedure delete()
  EndProcedure
  
  ;=====================================
  ;Sets a flag to 1
  ;=====================================
  Procedure set(index, blockid = 0)
    Protected block.i
    Protected *address, bitsize
    Protected byteindex.i, bitindex.i, byteread.a, mask.a

    If blockid = 0
      *address = current\address
      bitsize  = current\bitsize
    ElseIf blockid <= count
      *address = mbk(blockid)\address
      bitsize  = mbk(blockid)\bitsize
    Else
      ProcedureReturn #False
    EndIf
    
    If *address = 0 : ProcedureReturn #False : EndIf
    
    If index < 0 Or index >= bitsize
        ProcedureReturn
    EndIf

    byteindex = index / #BITSPERBYTE
    bitindex  = index % #BITSPERBYTE

    byteread  = PeekA(*address + byteindex)
    mask      = 1 << bitindex

    PokeA(*address + byteindex, byteread | mask)
  EndProcedure
  
  ;=====================================
  ;Sets a flag to 0
  ;=====================================
  Procedure clear(index, blockid = 0)
    Protected block.i
    Protected *address, bitsize
    Protected byteindex.i, bitindex.i, byteread.a, mask.a

    If blockid = 0
        *address = current\address
        bitsize  = current\bitsize
    ElseIf blockid <= count
        *address = mbk(blockid)\address
        bitsize  = mbk(blockid)\bitsize
    Else
        ProcedureReturn #False
    EndIf

    If index < 0 Or index >= bitsize
        ProcedureReturn
    EndIf

    byteindex = index / #BITSPERBYTE
    bitindex  = index % #BITSPERBYTE

    byteread  = PeekA(*address + byteindex)
    mask      = 1 << bitindex

    PokeA(*address + byteindex, byteread & ~mask)
  EndProcedure

  ;===========================================
  ;Returns the value of a flag 0-1, -1 if fail
  ;===========================================
  Procedure get(index,blockid = 0)
    Protected block.i
    Protected *address,bitsize
    Protected byteindex.i,bitindex.i,byteread.a, mask.a
    If blockid   =   0 
      *address   =   current\address
      bitsize    =   current\bitsize
    ElseIf blockid <= count
      *address   =   mbk(blockid)\address
      bitsize    =   mbk(blockid)\bitsize
    Else
      ProcedureReturn #False
    EndIf
    If *address = 0 : ProcedureReturn #False : EndIf
    ;note, this might cause problems, if #false is not expected at reading
    If index<0   Or   index>bitsize   :   ProcedureReturn #False   :   EndIf
    byteindex    =   index / #BITSPERBYTE
    bitindex     =   index % #BITSPERBYTE
    byteread     =   PeekA(*address + byteindex)
    mask         =   1  <<  bitindex
    ProcedureReturn Bool(readbyte & mask <> 0)
  EndProcedure
  
  ;=====================================
  ;Flips the value of a flag
  ;=====================================
  Procedure flip(index, blockid = 0)
    Protected block.i
    Protected *address, bitsize
    Protected byteindex.i, bitindex.i, byteread.a, mask.a

    If blockid = 0
        *address = current\address
        bitsize  = current\bitsize
    ElseIf blockid <= count
        *address = mbk(blockid)\address
        bitsize  = mbk(blockid)\bitsize
    Else
        ProcedureReturn #False
    EndIf
      
    If *address = 0 : ProcedureReturn #False : EndIf
    If index < 0 Or index >= bitsize
        ProcedureReturn
    EndIf

    byteindex = index / #BITSPERBYTE
    bitindex  = index % #BITSPERBYTE

    byteread  = PeekA(*address + byteindex)
    mask      = 1  <<  bitindex

    PokeA(*address + byteindex, byteread ! mask)
  EndProcedure
  
  ;===========================
  ;releases ALL allocated data
  ;===========================
  Procedure release()
    Protected i
    If count<1 : ProcedureReturn #False : EndIf
    For i = count To 1 Step -1
      If mbk(i)\address
        FreeMemory(mbk(i)\address)
      EndIf
    Next i
    count = 0
    ReDim mbk(0)
    current\address = 0
    current\bitsize = 0
    current\size    = 0
  EndProcedure
EndModule

;Usage
;myflags = flags::create(1024)
;flags::set(10,myflags)
;flags::clear(10,myflags)
;flags::flip(10,myflags)
;flags::flip(10,myflags)
;Debug flags::get(10,myflags)



; IDE Options = PureBasic 6.40 beta 7 (Windows - x64)
; CursorPosition = 19
; Folding = --
; EnableXP
; DPIAware