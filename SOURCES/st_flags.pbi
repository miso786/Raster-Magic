;This Module is For storing true/false type data in binary
;It's purpose is small size, fast save possibility
;can be used for gamestates, pathfinding nodes (open/closed)
;It is possible to store a larga set of data with this like:
;Is #npc_A_alive, #has_pc_visited_place_A, has_item_key_A. seen_this_thing_A_before
;Saving would be fast with bitflags, can be compressed too.
;Note: Later it would be good to create a byte/other, longer formats

;Changelog:
;Ver: 100 - Created by miso 20260420 1904

DeclareModule flags
  Declare init()
  Declare.i create(bitsize.i)
  Declare set(index, blockid = 0)
  Declare clear(index, blockid = 0)
  Declare flip(index, blockid = 0)
  Declare get(index,blockid = 0)
  Declare release()
EndDeclareModule

Module flags
  #VERSION        = 100
  #BITSPERBYTE    = 8
  #BITMINIMUM     = 1
  #COUNTMINIMUM   = 1
  Structure flagstype
    *address
    bitsize.i
    size.i
  EndStructure
  
  Global count = 0
  
  Global current.flagstype
  current\address  = 0
  current\bitsize  = 0
  current\size = 0
  
  ;mbk should be used as name for all memory block type later on
  Global Dim mbk.flagstype(count)
  
  ;auto initialized, its just for consistency
  Procedure init()
  EndProcedure
  
  ;=====================================
  ;Creates a set of bitflags, returns ID
  ;=====================================
  Procedure.i create(bitsize.i)
    If bitsize<#BITMINIMUM : ProcedureReturn #False : EndIf
    Protected bytecount.i,remainder.i
    bytecount = bitsize/#BITSPERBYTE
    remainder = bitsize%#BITSPERBYTE
    If remainder<> 0 : bytecount + 1 : EndIf
    count + 1
    ReDim mbk(count)
    mbk(count)\address = AllocateMemory(bytecount)
    If Not mbk(count)\address : ProcedureReturn #False : EndIf
    mbk(count)\size = bytecount
    mbk(count)\bitsize = bitsize
    ProcedureReturn count
  EndProcedure
  
  ;===================================
  ;Sets the default id of the bitflags
  ;===================================
  Procedure choose(id)
    If id<#COUNTMINIMUM Or id>count
      ProcedureReturn #False
    EndIf
    current\address = mbk(count)\address
    current\bitsize = mbk(count)\bitsize
    current\size    = mbk(count)\size
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
    Else
        *address = mbk(blockid)\address
        bitsize  = mbk(blockid)\bitsize
    EndIf

    If index < 0 Or index > bitsize
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
    Else
        *address = mbk(blockid)\address
        bitsize  = mbk(blockid)\bitsize
    EndIf

    If index < 0 Or index > bitsize
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
    If blockid = 0 
      *address = current\address
      bitsize = current\bitsize
    Else
      *address = mbk(blockid)\address
      bitsize = mbk(blockid)\bitsize
    EndIf
    ;note, this might cause problems, if #false is not expected at reading
    If index<0 Or index>bitsize : ProcedureReturn #False : EndIf
    byteindex = index/#BITSPERBYTE
    bitindex  = index%#BITSPERBYTE
    readbyte  = PeekA(*address + byteindex)
    mask      = 1<<bitindex
    ProcedureReturn Bool(readbyte&mask<>0)
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
    Else
        *address = mbk(blockid)\address
        bitsize  = mbk(blockid)\bitsize
    EndIf

    If index < 0 Or index > bitsize
        ProcedureReturn
    EndIf

    byteindex = index / #BITSPERBYTE
    bitindex  = index % #BITSPERBYTE

    byteread  = PeekA(*address + byteindex)
    mask      = 1 << bitindex

    PokeA(*address + byteindex, byteread ! mask)
EndProcedure
  
  Procedure release()
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
; CursorPosition = 9
; Folding = --
; EnableXP
; DPIAware