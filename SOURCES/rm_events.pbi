



Module events
  #VERSION = 100
  ;===================================
  ;internally called by update()
  ;===================================
  Procedure isQuitWindow(w_event)
    If w_event = #PB_Event_CloseWindow : End : EndIf
  EndProcedure
  
  ;===================================================
  ;Called internally by update(), 
  ;Checks and resolves if mainwindow loses focus.
  ;Outsourced to reduce the number of indentations.
  ;===================================================
  Procedure isActiveWindow(w_event.i)
    If w_event = #PB_Event_DeactivateWindow
      ReleaseMouse(#True)
      Repeat :  w_event  =  WaitWindowEvent(1)  :  isQuitWindow(w_event)
      Until     w_event  =  #PB_Event_ActivateWindow
      ReleaseMouse(#False)
      
    EndIf
  EndProcedure
   
  Procedure init()
  EndProcedure
  
  
  ;==========================================
  ;swipes through all the window event queue
  ;closes  app  if  closewindow  event
  ;enables alt+tab, gives back the mouse and
  ;the program goes sleep until reactivation.
  ;Calls the controls::update()
  ;==========================================
  Procedure Update()
    Protected w_event.i
    Delay(0)
    ReleaseMouse(#False)
    Repeat 
      w_event = WindowEvent()
      isQuitWindow(w_event)
      isActiveWindow(w_event)
    Until Not w_event

  EndProcedure
   
EndModule

; IDE Options = PureBasic 6.40 beta 2 (Windows - x64)
; CursorPosition = 2
; Folding = -
; EnableXP
; DPIAware