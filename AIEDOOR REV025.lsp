
(defun c:doorauto ( )
  
  (setq dcl_id (load_dialog "D:\\AutoLisp projects\\AIE final door project\\DCL\\AIEDOOR rev01.dcl"))
  
  (if (not (new_dialog "aied" dcl_id)
      )
    (exit)
  )
  
  (setq tof '("90 deg" "45 deg"))
  (setq tofi  '("90" "45"))
  
  (setq frameth '("105 MM" "50 MM" ))
  (setq framethi '("105" "50"))
  
  (setq pt (list 10 -10 0))
  (setq txt (ssget "_x" (list (cons 10 pt))))


  (if txt 
    
    (progn 
      (setq txtname (ssname txt 0))
      (setq txtdata (entget txtname))
      (setq txtcont (cdr (assoc 1 txtdata)))
      (setq n (atof txtcont))
      (setq n1 (+ 1 n))
      (setq n2 (rtos n1))
      (setq txtnew1 (subst (cons 1 n2) (assoc 1 txtdata) txtdata))
      (entmod txtnew1)
    )
    
    (progn 
      (entmake 
        (list (cons 0 "text") 
              (cons 10 (list 10 -10 0))
              (cons 40 10)
              (cons 50 0)
              (cons 1 "1")
              
        )
      )
      (setq n1 1)
    )
    
  )
  
  (setq x1 (* (- n1 1) 15000))
  (setq x x1)
  (setq y 0)
    
  
  ;start of Template Creation
  
  ; Template Layer
 (entmake (list (cons 0 "layer")
       (cons 100 "AcDbSymbolTableRecord")
       (cons 100 "AcDbLayerTableRecord")
       (cons 2 "template")
       (cons 70 0)
       (cons 62 7)
 ))
  
  ;Dimensions Layer
  (entmake (list (cons 0 "layer")
       (cons 100 "AcDbSymbolTableRecord")
       (cons 100 "AcDbLayerTableRecord")
       (cons 2 "Dimensions")
       (cons 70 0)
       (cons 62 7)
 ))
  
  ;Doors Layer
  (entmake (list (cons 0 "layer")
       (cons 100 "AcDbSymbolTableRecord")
       (cons 100 "AcDbLayerTableRecord")
       (cons 2 "Doors")
       (cons 70 0)
       (cons 62 3)
 ))
  ;End of Template Creation
  
  

  (start_list "framesel")
  (mapcar 'add_list frameth)
  (end_list)
  
  (start_list "tof")
  (mapcar 'add_list tof)
  (end_list)
  
  
  (setq lx (dimx_tile "logo"))
  (setq ly (dimy_tile "logo"))
  (setq sld (findfile "D:\\AutoLisp projects\\AIE final door project\\DCL\\logo.sld"))
  
  (start_image "logo")
  (fill_image 0 0 lx ly 0)
  (slide_image 0 0 lx ly (strcat sld))  
  (end_image)
  
  
  (action_tile "rbsd" "(setq doortype \"1\")")  
  (action_tile "rbde" "(setq doortype \"2\")")
  (action_tile "rbdu" "(setq doortype \"3\")")
  (action_tile "rblp" "(setq doororie \"1\")")
  (action_tile "rbrp" "(setq doororie \"2\")")
  
  ;(set_tile "warning" "!!!  Invalid Door Dimensions !!!")

    
    
  (action_tile "accept" 
      
    (strcat
      "(progn
       (setq siz (atof (get_tile \"framesel\")))"
       "(setq tofsiz (atof (get_tile \"tof\")))"
      "(setq width (atof (get_tile \"width\")))"
      "(setq height (atof (get_tile \"height\")))"
      "(setq eqd (atoi (get_tile \"eqd\")))"
      "(done_dialog)(setq userclick t))"
       )
  )

  (action_tile "cancel" "(done_dialog)(setq userclick nil)")
  (start_dialog)
  (unload_dialog dcl_id) 
  
  
  (if userclick
    (progn 
      (setq siz (fix siz))
      (setq frth (nth siz framethi))
      (setq tofsiz (fix tofsiz))
      (setq tofn (nth tofsiz tofi))
      
    (c:mainc)

    )
  )
  
  
  
)
  (princ)
  ; setting co-ordinates 

  


;end of dialog box initialization 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Start of Drawings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(defun c:mainc ( )
(princ)
  
  (setq curos (getvar "osmode"))
  (setvar "osmode" 0 )
  
  (setvar "cmdecho" 0)
  
  ;;; start of Dimensions
 (if (not (tblsearch "dimstyle"  "50"))
    (progn
   (command "-dimstyle"
    "annotative"
    "yes"
    "50"
    "restore"
    "50"
   )
   
  (setvar "dimasz" 50)
  (setvar  "dimclre" 1)
  (setvar  "dimclrd" 1)
  (setvar  "dimtxt" 50)
   
   (command "-dimstyle"
    "save"
    "50"
    "yes" 
   )
    )
  
 )
 ;;;;

(if (not (tblsearch "dimstyle"  "80"))
    (progn
   (command "-dimstyle"
    "annotative"
    "yes"
    "80"
    "restore"
    "80"
   )
   
  (setvar "dimasz" 80)
  (setvar  "dimclre" 1)
  (setvar  "dimclrd" 1)
  (setvar  "dimtxt" 80)
   
   (command "-dimstyle"
    "save"
    "80"
    "yes" 
   )
    )
  
 )
;;;;
(if (not (tblsearch "dimstyle"  "100"))
    (progn
   (command "-dimstyle"
    "annotative"
    "yes"
    "100"
    "restore"
    "100"
   )
   
  (setvar "dimasz" 100)
  (setvar  "dimclre" 1)
  (setvar  "dimclrd" 1)
  (setvar  "dimtxt" 100)
   
   (command "-dimstyle"
    "save"
    "100"
    "yes" 
   )
    )
  
 )  
 
 ;;;End of Dimensions
 
  
  ;start of Single Door
  (if (= (atoi doortype) 1)
  (progn
    
        ;initializing Door origin
      
    (setq xsl (+ x 4000))
    (setq ysl 7000)
    (setq xsp (+ x 4000))
    (setq ysp 5200 )
    ;;; End of initializing Door Origin ;;;
    
    ;start of template of single door
      (setvar "clayer" "template")
      (command "rectangle" (list x  y 0 ) (list (+ 8245 x ) (+ y 9906) 0)(cons 62 "7"))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 955  ) 0)) (cons 11 (list (+ x 8245 ) (+ y 955 )  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 1910 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 1910)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 2865 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 2865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 3865 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 3865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 4865 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 4865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 6665 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 6665)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 8456 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 8456)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 9106 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 9106)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 9906 ) 0)) (cons 11 (list (+ x 8245 ) (+ y 9906)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list (+ x 4510) y  0)) (cons 11 (list (+ x 4510 ) (+ y 9906) 0))))
    ;start of text
    
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 5100 )  (+ y 3515 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Bottom C 0.8MM SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 5100 )  (+ y 4515 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Top C 0.8MM SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 5100 )  (+ y 5865 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Panel SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 5100 )  (+ y 7665 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Lid SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 5100 )  (+ y 8790) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat "Qty" (rtos eqd))) ))
    ;end of text
    ;end of template of single door
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Start of Right Push Single Door ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
 
    
    ;start of right push
    (if (= (atoi doororie) 2 )
    (progn 
    ;(alert (strcat "Single Door Right Push"))
    ;text start
      (setvar "clayer" "template")
      (entmake (list (cons 0 "text")(cons 10 (list (+ x 1300 )  (+ y 8790) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat "Right Active Shutter") )))
    ;;;text end;;;
       
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start frame drawing and text
    (if (= (atoi frth ) 105);;fraem thickness if 105mm
    (progn
    (setvar "clayer" "template") 
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 )(+ y 9515) 0)) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm " "x" " " (rtos  height) "mm " "" "x" frth"mm"))))
      
  
      ;;;;;;Start of 90 degrees frame

      
      (if (= (atoi tofn) 90)
      (progn 
      
        
        
      ;;;start of top frame
      (setvar "clayer" "doors")
      
      (setq tfx (+ 4000 x))
      (setq tfy 2200)
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 231.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 231.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 231.2) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 231.2) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 230) )
      (list (+ (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 230) )
      (list (- (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (+ (- tfx (- width 76))210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 226.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (- (+ (- tfx (- width 76)) 210) 20 )(+ tfy 233) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

         (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 127.8 ) 0)) (cons 40 8)))    
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;
      
      ;;; start of right  frame 
      (setq rfx (+ 4000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 70.2) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 28) (+ rfy 140.3) 0)) (cons 40 8)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 77.4) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 291) (+ rfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1075) (+ rfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1859) (+ rfy 127.8) 0)) (cons 40 8)))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) rfy 0) (list (+ (- rfx height) 270) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) rfy 0) (list (+ (- rfx height) 315) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) rfy 0) (list (+ (- rfx height) 1054) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) rfy 0) (list (+ (- rfx height) 1099) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) rfy 0) (list (+ (- rfx height) 1838) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) rfy 0) (list (+ (- rfx height) 1883) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 270) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 315) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1054) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1099) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1838) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1883) (+ rfy 227.2) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 2) 0) 
        (list (+ (- rfx height) 268) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 2) 0) 
        (list (+ (- rfx height) 313) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1052) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1097) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1836) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1881) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 268) (+ rfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 313) (+ rfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1052) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1097) (+ rfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1836) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1881) (+ rfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      
      
      
      ;;; end of right frame;;;;
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      ;;; start of left  frame 
      (setq lfx (+ 4000 x))
      (setq lfy (+ 200 y))
      
      (command "rectang" (list lfx lfy 0) (list (- lfx height) (+ lfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 28) (+ lfy 90.2) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 161.2) 0)) (cons 40 8)))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 291)  (+ lfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1075) (+ lfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1859) (+ lfy 103.4) 0)) (cons 40 8)))
         
      (command "rectang" (list (+ (- lfx height) 266) lfy 0) (list (+ (- lfx height) 270) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 311) lfy 0) (list (+ (- lfx height) 315) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1050) lfy 0) (list (+ (- lfx height) 1054) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1095) lfy 0) (list (+ (- lfx height) 1099) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1834) lfy 0) (list (+ (- lfx height) 1838) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1879) lfy 0) (list (+ (- lfx height) 1883) (+ lfy 4) 0 ))  
      
      
      (command "rectang" (list (+ (- lfx height) 266) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 270) (+ lfy 227.2) 0 ))
      (command "rectang" (list (+ (- lfx height) 311) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 315) (+ lfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1050) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1054) (+ lfy 227.2) 0 ))
      (command "rectang" (list (+ (- lfx height) 1095) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1099) (+ lfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1834) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1838) (+ lfy 227.2) 0 ))
      (command "rectang" (list (+ (- lfx height) 1879) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1883) (+ lfy 227.2) 0 ))   
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- lfx height) 268) (+ lfy 2) 0) 
        (list (+ (- lfx height) 268) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 313) (+ lfy 2) 0) 
        (list (+ (- lfx height) 313) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1052) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1052) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1097) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1097) (- lfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1836) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1836) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1881) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1881) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- lfx height) 268) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 268) (+ lfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 313) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 313) (+ lfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1052) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1052) (+ lfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1097) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1097) (+ lfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1836) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1836) (+ lfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1881) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1881) (+ lfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    ;;lock cutout 
      
    (command "rectang" (list (- lfx 1016.25) (+ lfy 149.2) 0)(list (- lfx 895.25)  (+ lfy 172.2) 0))
    
      
    ;;;lock cutout;;;
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list lfx lfy 0)(list (- lfx height) lfy 0)
      (list (- lfx (/ height 2)) (- lfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      
      ;;; end of left frame;;;;
      
      
      ))
      
    ;;;;;;end of 90 degrees frame;;;;;;  
      
      
       ;;;;;;Start of 45 degrees frame
    (if (= (atoi tofn) 45 )
    (progn
    
    
    
    ))
  ;;;;;;;;end of 45 degrees frame;;;;;;
      
     
    ))
      
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
      
     (if (= (atoi frth ) 50);;Frame thuckness if 50mm
    (progn
      
      
     (setvar "clayer" "template")
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 4610 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 )(+ y 9515) 0 )) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm" "x" (rtos height) "mm" "x"  frth"mm"))))
    
      
      ;;; start of 90 degrees frame
      (if (= (atoi tofn) 90)

      (progn
        
        ;;;start of top frame
      (setvar "clayer" "doors")
      
      (setq tfx (+ 4000 x ))
      (setq tfy 2200)
        
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 173.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 173.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 173.2 ) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 94.2) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 173.2 ) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 67.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 173.2 ) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
        
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 172) )
      (list (+ (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 172) )
      (list (- (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 67.8) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 67.8 ) 0)) (cons 40 8)))    
          
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list(+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
      
      ;;; start of right  frame 
        
      (setq rfx (+ 4000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 81.2) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 56.2) 0)) (cons 40 5)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 77.4) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 140) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 924) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1708) (+ rfy 67.8) 0)) (cons 40 8)))
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- rfx height) 115) rfy 0) (list (+ (- rfx height) 119) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) rfy 0) (list (+ (- rfx height) 164) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) rfy 0) (list (+ (- rfx height) 904) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) rfy 0) (list (+ (- rfx height) 949) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) rfy 0) (list (+ (- rfx height) 1688) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) rfy 0) (list (+ (- rfx height) 1733) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 115) ( + rfy  173.2 ) 0) (list (+ (- rfx height) 119) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 164) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 904) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 949) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1688) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1733) (+ rfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 2) 0) 
        (list (+ (- rfx height) 117) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 2) 0) 
        (list (+ (- rfx height) 162) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 2) 0) 
        (list (+ (- rfx height) 902) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 2) 0) 
        (list (+ (- rfx height) 947) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1686) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1731) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 174) 0) 
        (list (+ (- rfx height) 117) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 174) 0) 
        (list (+ (- rfx height) 162) (+ rfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 174) 0) 
        (list (+ (- rfx height) 902) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 174) 0) 
        (list (+ (- rfx height) 947) (+ rfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1686) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1731) (+ rfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      ;;; end of right frame;;;;
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
      ;;; start of left  frame 
        
      (setq lfx (+ 4000 x))
      (setq lfy (+ 200 y))
      
      (command "rectang" (list lfx lfy 0) (list (- lfx height) (+ lfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 117) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 92) 0)) (cons 40 5)))
      
      
   
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 140) (+ lfy 105.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 924) (+ lfy 105.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1708) (+ lfy 105.4) 0)) (cons 40 8)))
        
      ;; lock cutout
        
        (command "rectang" (list (- lfx 895.25) (+ lfy 94.5) 0) (list  (- lfx 1016.25) (+ lfy 118.7) 0))
        
      ;; lock cutout ;;
        
      
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- lfx height) 115) lfy 0) (list (+ (- lfx height) 119) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) lfy 0) (list (+ (- lfx height) 164) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) lfy 0) (list (+ (- lfx height) 904) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) lfy 0) (list (+ (- lfx height) 949) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) lfy 0) (list (+ (- lfx height) 1688) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) lfy 0) (list (+ (- lfx height) 1733) (+ lfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- lfx height) 115) ( + lfy  173.2 ) 0) (list (+ (- lfx height) 119) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 164) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 904) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 949) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1688) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1733) (+ lfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 2) 0) 
        (list (+ (- lfx height) 117) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 2) 0) 
        (list (+ (- lfx height) 162) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 2) 0) 
        (list (+ (- lfx height) 902) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 2) 0) 
        (list (+ (- lfx height) 947) (- lfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1686) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1731) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 174) 0) 
        (list (+ (- lfx height) 117) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 174) 0) 
        (list (+ (- lfx height) 162) (+ lfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 174) 0) 
        (list (+ (- lfx height) 902) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 174) 0) 
        (list (+ (- lfx height) 947) (+ lfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1686) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1731) (+ lfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list lfx lfy 0)(list (- lfx height) lfy 0)
      (list (- lfx (/ height 2)) (- lfy 100) 0)
      )
    (setvar "clayer" "doors")
      
        
        
      ;;; end of left frame;;;;
      ))
      
      ;;;;;;;end of 90 degrees frame;;;;;;
      
      
      ;;; start of 45 degrees frame
      (if (= (atoi tofn) 45)
      (progn
      
      
      ))
      
    ;;;;;end of 45 degrees frame;;;;;;
    )  
    )
    
    
    ;end of frame drawing and text
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    

      
 
    ;; Start of Right push lid
      (setvar "clayer" "doors")
      (command "rectang"  (list xsl ysl 0) (list (- xsl (- height 47)) (+ ysl (- width 55)) 0));;lid cutout
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      (command "dimlinear" (list xsl (+ ysl (- width 47)) 0) (list (- xsl (- height 47)) (+ ysl (- width 55)) 0)  (list (/(- xsl (- height 47))2) (+ ysl(- width 55)100)0))
      (command "dimlinear" (list (- xsl (- height 47)) ysl ) (list (- xsl (-  height 47)) (+ ysl (- width 55)) 0) (list (- (- xsl (- height 47 )) 100) (/ (+ ysl (- width 55)) 2) 0))
      (setvar "clayer" "doors")
      (command "rectang"  (list (- xsl 1150)  (+ ysl (- (/ (- width 55) 2) 175))  0 ) (list (- xsl 1900) (+ ysl (+ (/ (- width 55) 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- xsl 1150) (+ ysl (/ (-  width 55) 2) 175) 0) (list (- xsl 1900 ) (+ ysl (/ (-  width 55) 2) 175) 0)
      (list (- xsl 1525 ) (+ ysl (/ (-  width 55) 2) 225) 0)
      )
      
      (command "dimlinear"
      (list  (- xsl 1900) (+ ysl (/ (-  width 55) 2) 175) 0 )(list  (- xsl 1900) (- (+ ysl (/ (-  width 55) 2)) 175) 0 )
      (list  (- xsl 1950) (+ ysl (/ (-  width 55) 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      (entmake (list (cons 0 "circle")  (cons  10 (list (- xsl 1095) (+ ysl 83.5 ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- xsl 1395) (+ ysl 83.5) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- xsl 1095) (+ ysl 83.5) 0)(list (- xsl 1395) (+ ysl 83.5)0)
      (list (- xsl 12450) (+ ysl 103.5) 0)
      )
      
      (command "clayer" "doors")
      
    ;; lock cutout
      (command "rectang" (list (- xsl 902.5) (+ ysl 53.5) 0) (list (- xsl 937.5) ( + ysl 73.5) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (- xsl 920) (+ ysl 46.75) 0)) (cons 40 1.5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- xsl 920) (+ ysl 80.25) 0)) (cons 40 1.5)))
     
    ;; End of Right Push lid ;;
      
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 


    ;;Start of Right Push Panel
    (command "rectang" (list xsp ysp 0) (list (- xsp (- height 47)) (+ ysp (+ width 62.8)) 0 )); panel cutout
    (command "rectang" (list (- xsp 1150) (+ ysp (- (/ (+ width 62.8) 2) 175))0) (list (- xsp 1900) (+ ysp (+ (/ (+ width 62.8) 2) 175))0));; window cutout
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
    (command "dimlinear" (list (- xsp (- height 47)) (+ ysp (+  width 62.8)) 0) (list (- xsp (- height 47)) ysp 0) 
    (list (- (- xsp (- height 47))100) (/ (+ ysp (+ width 62.8))2 )0)) ;; panel width dimensions
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list (-  xsp 1150) (- (+ ysp (/ (+  width 62.8) 2)) -175) 0) (list xsp (- (+ ysp (/ (+  width 62.8) 2)) -175) 0)
    (list (- xsp (/ 1150)) (- (+ ysp (/ (+  width 62.8) 2)) -175) 0 )
    )
    (setvar "clayer" "doors")
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- xsp 1095 ) (+ ysp (-(+ width 62.8) 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- xsp  1393) (+ ysp (-(+ width 62.8) 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- xsp  1397) (+ ysp (-(+ width 62.8) 142.4) 0))) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- xsp 1393) (+ ysp (-(+ width 62.8) 142.4 4)) 0)) (cons 11 (list (- xsp 1397) (+ ysp (-(+ width 62.8) 142.4 4) 0)))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- xsp 1393) (+ ysp (-(+ width 62.8) 138.4)) 0)) (cons 11 (list (- xsp 1397) (+ ysp (-(+ width 62.8) 138.4) 0)))))
    (command "trim" "" "fence"  
    (list (- xsp 1392) (+ ysp (- (+ width 62.8) 138.7)) 0) (list (- xsp 1398) (+ ysp (- (+ width 62.8) 138.65)) 0)
    (list (- xsp 1392) (+ ysp (- (+ width 62.8) 142.4)) 0) (list (- xsp 1398) (+ ysp (- (+ width 62.8) 142.4)) 0)
    (list (- xsp 1392) (+ ysp (- (+ width 62.8) 146.15)) 0) (list (- xsp  1398) (+ ysp (- (+ width 62.8) 146.15)) 0) ""  "")
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list (- xsp 1095) (- (+ ysp width 62.8) 142.4) 0) (list xsp (+ ysp width 62.8) 0)
      (list (- xsp (/ 1095 2)) (+  ysp width 62.8 250))
      )
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout 
      (command "rectang" (list (- xsp 868.75) (+ ysp (- (+ width 62.8) 39.6)0))  (list (- xsp 1030.75) (+ ysp (- (+ width 62.8) 61.8))0))
      (command "rectang" (list (- xsp 902.5)  (+ ysp (- (+ width 62.8) 112.4)0)) (list (- xsp 937.5)  (+ ysp (- (+ width 62.8 ) 132.4))))
      (entmake (list (cons  0 "circle") (cons 10 (list (- xsp 920) (+ ysp (- (+ width 62.8) 139.15)) 0 )) (cons 40 1.5)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- xsp 920) (+ ysp (- (+ width 62.8) 105.65)) 0 )) (cons 40 1.5)))
       (command "clayer" "dimensions")
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - xsp 949.75) (- (+ ysp (+ width 62.8)) 50.7) 0 ) (list xsp (+ ysp (+ width 62.8)) 0 )
      (list ( - (/ 949. 5)) (+ ysp width 62.8 150))
      )
      
      (command "dimlinear";;; lock cutout dimensions
      (list xsp (+ ysp (+ width 62.8)) 0 ) (list (- xsp 920) (- (+ ysp width 62.8) 122.4) 0)
       (list (- xsp (/ 920 2 )) (+ (+ ysp width 62.8) 75) 0)   
      )
      (command "clayer" "doors")

    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- xsp (- height 47)) 199) (+ ysp 42.16) 0)  (list (+ (- xsp (- height 47)) 301) (+ ysp 76.2)0)   )
      (command "rectang" (list (+ (- xsp (- height 47)) 983) (+ ysp 42.16) 0)  (list (+ (- xsp (- height 47)) 1085) (+ ysp 76.2)0)   )
      (command "rectang" (list (+ (- xsp (- height 47)) 1767) (+ ysp 42.16) 0)  (list (+ (- xsp (- height 47)) 1869) (+ ysp 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- xsp 18) (+ ysp 43.5) 0) (list (- xsp 33) (+ ysp 58.5) 0) )
      
      
  ;;;;
   (command "rectang" (list (+ (- xsp (- height 47)) 10) ysp 0)  (list (+ (- xsp (- height 47)) 30) (+ ysp 15 ) 0))
   (command "rectang" (list (+ (- xsp (- height 47)) 220) ysp 0)  (list (+ (- xsp (- height 47)) 240) (+ ysp 15 ) 0))
   (command "rectang" (list ( - xsp  10) ysp 0)  (list (- xsp  30) (+ ysp 15 ) 0))
   (command "rectang" (list ( - xsp  220) ysp 0)  (list (- xsp 240) (+ ysp 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 12) (+  ysp 2) 0 )
        (list (+ (- xsp (-  height 47)) 12) (-  ysp 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 222) (+  ysp 2) 0 )
        (list (+ (- xsp (-  height 47)) 222) (-  ysp 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- xsp  12) (+  ysp 2) 0 )
        (list (- xsp  12) (-  ysp 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- xsp  222) (+  ysp 2) 0 )
        (list (- xsp  222) (-  ysp 2) 0 )
        "" ""
      )
   (command "rectang" (list (+ (- xsp (- height 47)) 10) (+ ysp (+ width 62.8)) 0)  (list (+ (- xsp (- height 47)) 30) (- (+ ysp (+ width 62.8)) 15) 0))
   (command "rectang" (list (+ (- xsp (- height 47)) 220) (+ ysp (+ width 62.8)) 0)  (list (+ (- xsp (- height 47)) 240) (- (+ ysp (+ width 62.8)) 15) 0))
   (command "rectang" (list ( - xsp  10) (+ ysp (+ width 62.8)) 0)  (list (- xsp  30) (- (+ ysp (+ width 62.8)) 15) 0))
   (command "rectang" (list ( - xsp  220) (+ ysp (+ width 62.8)) 0)  (list (- xsp 240) (- (+ ysp (+ width 62.8)) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 12) (+  ysp (+ width 62.8) 2) 0 )
        (list (+ (- xsp (-  height 47)) 12) ( - (+ ysp  (+ width 62.8)) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 222) (+  ysp  (+ width 62.8) 2) 0 )
        (list (+ (- xsp (-  height 47)) 222) ( - (+ ysp  (+ width 62.8)) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- xsp  12) (+  ysp  (+ width 62.8) 2) 0 )
        (list (- xsp  12) ( - (+ ysp  (+ width 62.8)) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- xsp  222) (+  ysp (+ width 62.8) 2) 0 )
        (list (- xsp  222) ( - (+ ysp  (+ width 62.8)) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
      
    ;; End of Right push panel ;;
                
    )
    )
    ;end of right push
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Start of Bottom c and top c ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
    
    ;;start of bottom and top c 
    
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 3000))
    (setq tpcy 4200)
    (setq bpcx (+ x 3000))
    (setq bpcy 3100)
    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx (- width 85.5)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx (- width 85.5)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx (- width 85.5))  22) tpcy 0)) (cons 11(list (+ (- tpcx (- width 85.5)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx (- width 85.5))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx (- width 85.5))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx (- width 85.5))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx (- width 85.5))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx (- width 85.5))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx (- width 85.5)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx (- width 85.5))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx (- width 85.5))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx (- width 85.5)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ (- width 85.5) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx (- width 93)) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx(- width 93)) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - width 93)) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - width 93)) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - width 93)) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - width 93)) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - width 93))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - width 93)) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - width 93)) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - width 93)) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - width 93)) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - width 93)) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx (- width 93)) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ (- width 93) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx (- width 93)) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ (- width 93) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - width 93)) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ (- width 93) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
    
    
    ;;end of bottom and top c 
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Start of Single Left push door ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    
    ;;;;;start of left push 
    
    
    (if (= (atoi doororie) 1 )
    (progn 
      (alert (strcat "Single Door Left Push"))
    ;text start
      (setvar "clayer" "template")
      (entmake (list (cons 0 "text")(cons 10 (list (+ x 1300 )  (+ y 8790) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat "Left Active Shutter") )))
    ;text end
      
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
    ;start frame drawing and text
    (if (= (atoi frth ) 105);;fraem thickness if 105mm
    (progn
    (setvar "clayer" "template") 
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 )(+ y 9515) 0)) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm " "x" " " (rtos  height) "mm " "" "x" frth"mm"))))
      
      
      
      
      ;;;;;;;;;start of 90 degrees frame
      
      (if (= (atoi tofn) 90)
      
      (progn 
      
          ;;;start of top frame
      (setvar "clayer" "doors")
      
      (setq tfx (+ 4000 x ) )
      (setq tfy 2200)
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 231.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 231.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 231.2) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 231.2) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 230) )
      (list (+ (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 230) )
      (list (- (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (+ (- tfx (- width 76))210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 226.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (- (+ (- tfx (- width 76)) 210) 20 )(+ tfy 233) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

         (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 127.8 ) 0)) (cons 40 8)))    
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;
      
      ;;; start of right  frame 
      (setq rfx (+ 4000 x) )
      (setq rfy 1200 )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 161) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 28) (+ rfy 90.9) 0)) (cons 40 5)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 186.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 153.8) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 186.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 153.8) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy  186.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 153.8) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 291) (+ rfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1075) (+ rfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1859) (+ rfy 103.4) 0)) (cons 40 8)))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) rfy 0) (list (+ (- rfx height) 270) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) rfy 0) (list (+ (- rfx height) 315) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) rfy 0) (list (+ (- rfx height) 1054) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) rfy 0) (list (+ (- rfx height) 1099) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) rfy 0) (list (+ (- rfx height) 1838) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) rfy 0) (list (+ (- rfx height) 1883) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 270) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 315) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1054) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1099) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1838) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1883) (+ rfy 227.2) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 2) 0) 
        (list (+ (- rfx height) 268) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 2) 0) 
        (list (+ (- rfx height) 313) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1052) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1097) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1836) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1881) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 268) (+ rfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 313) (+ rfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1052) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1097) (+ rfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1836) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1881) (+ rfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      
      
      
      ;;; end of right frame;;;;
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      ;;; start of left  frame 
      (setq lfx (+ 4000 x))
      (setq lfy 200)
      
      (command "rectang" (list lfx lfy 0) (list (- lfx height) (+ lfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 70.2) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 28) (+ lfy 140.3) 0)) (cons 40 5)))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 291)  (+ lfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1075) (+ lfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1859) (+ lfy 127.8) 0)) (cons 40 8)))
         
      (command "rectang" (list (+ (- lfx height) 266) lfy 0) (list (+ (- lfx height) 270) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 311) lfy 0) (list (+ (- lfx height) 315) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1050) lfy 0) (list (+ (- lfx height) 1054) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1095) lfy 0) (list (+ (- lfx height) 1099) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1834) lfy 0) (list (+ (- lfx height) 1838) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1879) lfy 0) (list (+ (- lfx height) 1883) (+ lfy 4) 0 ))  
      
      
      (command "rectang" (list (+ (- lfx height) 266) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 270) (+ lfy 227.2) 0 ))
      (command "rectang" (list (+ (- lfx height) 311) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 315) (+ lfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1050) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1054) (+ lfy 227.2) 0 ))
      (command "rectang" (list (+ (- lfx height) 1095) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1099) (+ lfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1834) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1838) (+ lfy 227.2) 0 ))
      (command "rectang" (list (+ (- lfx height) 1879) ( + lfy 231.2 ) 0) (list (+ (- lfx height) 1883) (+ lfy 227.2) 0 ))   
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- lfx height) 268) (+ lfy 2) 0) 
        (list (+ (- lfx height) 268) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 313) (+ lfy 2) 0) 
        (list (+ (- lfx height) 313) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1052) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1052) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1097) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1097) (- lfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1836) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1836) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1881) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1881) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- lfx height) 268) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 268) (+ lfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 313) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 313) (+ lfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1052) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1052) (+ lfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1097) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1097) (+ lfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1836) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1836) (+ lfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1881) (+ lfy 229.2) 0) 
        (list (+ (- lfx height) 1881) (+ lfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    ;;lock cutout 
      
    (command "rectang" (list (- lfx 1016.25) (+ lfy 82) 0)(list (- lfx 895.25)  (+ lfy 59) 0))
    
      
    ;;;lock cutout;;;
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list lfx lfy 0)(list (- lfx height) lfy 0)
      (list (- lfx (/ height 2)) (- lfy 100) 0)
      )
    (setvar "clayer" "doors")
      ;;; end of left frame;;;;
        
    
      ))
      
      ;;;;; end of 90 degrees frame ;;;;;;;;;;;
      
      
      ;;;;;;start of 45 degrees fraem
      (if (= (atoi tofn) 45)
      
      (progn
      
      
      ))
      
      ;;;;;;;;;;;end of 45 degrees frame ;;;;;;;
      
    
    ))
      
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
      
     (if (= (atoi frth ) 50);;Frame thuckness if 50mm
    (progn
     (setvar "clayer" "template")
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 4610 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 4610 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 )(+ y 9515) 0 )) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm" "x" (rtos height) "mm" "x"  frth"mm"))))
     
      
      ;;start of 90 degrees frame 
      (if (= (atoi tofn) 90)
      
      (progn
      
         ;;;start of top frame
      (setvar "clayer" "doors")
      
      (setq tfx (+ 4000 x))
      (setq tfy 2200)
        
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 173.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 173.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 173.2 ) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 94.2) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 173.2 ) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 67.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 173.2 ) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
        
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 172) )
      (list (+ (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 172) )
      (list (- (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 67.8) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 67.8 ) 0)) (cons 40 8)))    
          
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list(+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"

        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
      
      ;;; start of right  frame
        
      (setq rfx (+ 4000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 81.2) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 56.2) 0)) (cons 40 5)))
      
      
      
      
      
      ;; lock cutout
        
        (command "rectang" (list (- rfx 895.25) (+ rfy 54.5) 0) (list  (- rfx 1016.25) (+ rfy 77.5) 0))
        
      ;; lock cutout ;;
        
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 140) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 924) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1708) (+ rfy 67.8) 0)) (cons 40 8)))
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- rfx height) 115) rfy 0) (list (+ (- rfx height) 119) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) rfy 0) (list (+ (- rfx height) 164) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) rfy 0) (list (+ (- rfx height) 904) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) rfy 0) (list (+ (- rfx height) 949) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) rfy 0) (list (+ (- rfx height) 1688) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) rfy 0) (list (+ (- rfx height) 1733) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 115) ( + rfy  173.2 ) 0) (list (+ (- rfx height) 119) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 164) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 904) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 949) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1688) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1733) (+ rfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 2) 0) 
        (list (+ (- rfx height) 117) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 2) 0) 
        (list (+ (- rfx height) 162) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 2) 0) 
        (list (+ (- rfx height) 902) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 2) 0) 
        (list (+ (- rfx height) 947) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1686) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1731) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 174) 0) 
        (list (+ (- rfx height) 117) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 174) 0) 
        (list (+ (- rfx height) 162) (+ rfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 174) 0) 
        (list (+ (- rfx height) 902) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 174) 0) 
        (list (+ (- rfx height) 947) (+ rfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1686) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1731) (+ rfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      ;;; end of right frame;;;;
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
      ;;; start of left  frame 
        
      (setq lfx (+ 4000 x))
      (setq lfy (+ 200 y))
      
      (command "rectang" (list lfx lfy 0) (list (- lfx height) (+ lfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 117) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 92) 0)) (cons 40 5)))
      
      
   
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 140) (+ lfy 105.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 924) (+ lfy 105.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1708) (+ lfy 105.4) 0)) (cons 40 8)))
        
        ;;;hinge
      
      (command "rectang" (list (+ (- lfx height) 240)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 342 )  (+ lfy 130.6) 0 ))
      (command "rectang" (list (+ (- lfx height) 1024)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 1126 )  (+ lfy 130.6) 0 ))
      (command "rectang" (list (+ (- lfx height) 1808)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 1910 )  (+ lfy 130.6) 0 ))
      
      ;;;hinges;;;  
        
        
    
      
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- lfx height) 115) lfy 0) (list (+ (- lfx height) 119) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) lfy 0) (list (+ (- lfx height) 164) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) lfy 0) (list (+ (- lfx height) 904) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) lfy 0) (list (+ (- lfx height) 949) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) lfy 0) (list (+ (- lfx height) 1688) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) lfy 0) (list (+ (- lfx height) 1733) (+ lfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- lfx height) 115) ( + lfy  173.2 ) 0) (list (+ (- lfx height) 119) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 164) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 904) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 949) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1688) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1733) (+ lfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 2) 0) 
        (list (+ (- lfx height) 117) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 2) 0) 
        (list (+ (- lfx height) 162) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 2) 0) 
        (list (+ (- lfx height) 902) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 2) 0) 
        (list (+ (- lfx height) 947) (- lfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1686) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1731) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 174) 0) 
        (list (+ (- lfx height) 117) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 174) 0) 
        (list (+ (- lfx height) 162) (+ lfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 174) 0) 
        (list (+ (- lfx height) 902) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 174) 0) 
        (list (+ (- lfx height) 947) (+ lfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1686) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1731) (+ lfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list lfx lfy 0)(list (- lfx height) lfy 0)
      (list (- lfx (/ height 2)) (- lfy 100) 0)
      )
    (setvar "clayer" "doors")
      
        
        
      ;;; end of left frame;;;;
      
      ))
      
      ;;;;;;end of 90 degrees frame;;;;;;;;;
      

      ;;start of 45 degrees frame      
      
      (if (= (atoi tofn) 45)
      
      (progn
      
      
      ))
      
      ;;;end of 45 degrees frame;;;;;;;;;;;;;;
      
      
      
    )
       

       
       
    )
    
    
    ;end of frame drawing and text
      
      
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
      
      ;; Start of Right push lid
      
      (setvar "clayer" "doors")
      (command "rectang"  (list xsl ysl 0) (list (- xsl (- height 47)) (+ ysl (- width 55)) 0));;lid cutout
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      (command "dimlinear" (list xsl (+ ysl (- width 47)) 0) (list (- xsl (- height 47)) (+ ysl (- width 55)) 0)  (list (/(- xsl (- height 47))2) (+ ysl(- width 55)100)0))
      (command "dimlinear" (list (- xsl (- height 47)) ysl ) (list (- xsl (-  height 47)) (+ ysl (- width 55)) 0) (list (- (- xsl (- height 47 )) 100) (/ (+ ysl (- width 55)) 2) 0))
      (setvar "clayer" "doors")
      (command "rectang"  (list (- xsl 1150)  (+ ysl (- (/ (- width 55) 2) 175))  0 ) (list (- xsl 1900) (+ ysl (+ (/ (- width 55) 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- xsl 1150) (+ ysl (/ (-  width 55) 2) 175) 0) (list (- xsl 1900 ) (+ ysl (/ (-  width 55) 2) 175) 0)
      (list (- xsl 1525 ) (+ ysl (/ (-  width 55) 2) 225) 0)
      )
      
      
      (command "dimlinear"
      (list  (- xsl 1900) (+ ysl (/ (-  width 55) 2) 175) 0 )(list  (- xsl 1900) (- (+ ysl (/ (-  width 55) 2)) 175) 0 )
      (list  (- xsl 1950) (+ ysl (/ (-  width 55) 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      (entmake (list (cons 0 "circle")  (cons  10 (list (- xsl 1095) (- (+ ysl (- width 47)) 91.5 ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- xsl 1395) (- (+ ysl (- width 47)) 91.5 ) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- xsl 1095) (- (+ ysl (- width 47)) 91.5 ) 0)(list (- xsl 1395) (- (+ ysl (- width 47)) 91.5 )0)
      (list (- xsl 12450) (- (+ ysl (- width 47)) 103.5 ) 0)
      )
      
      (command "clayer" "doors")
      
    ;; lock cutout
      (command "rectang" (list (- xsl 902.5) (- (+ ysl (- width 47)) 61.5) 0) (list (- xsl 937.5) ( - (+ ysl (- width 47)) 81.5) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (- xsl 920) (- (+ ysl (- width 47)) 54.75) 0)) (cons 40 1.5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- xsl 920) (- (+ ysl (- width 47)) 88.25) 0)) (cons 40 1.5)))
     
    ;; End of Right Push lid ;;
      
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
     ;;Start of Right Push Panel
      
      
    (command "rectang" (list xsp ysp 0) (list (- xsp (- height 47)) (+ ysp (+ width 62.8)) 0 )); panel cutout
    (command "rectang" (list (- xsp 1150) (+ ysp (- (/ (+ width 62.8) 2) 175))0) (list (- xsp 1900) (+ ysp (+ (/ (+ width 62.8) 2) 175))0));; window cutout
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
    (command "dimlinear" (list (- xsp (- height 47)) (+ ysp (+  width 62.8)) 0) (list (- xsp (- height 47)) ysp 0) 
    (list (- (- xsp (- height 47))100) (/ (+ ysp (+ width 62.8))2 )0)) ;; panel width dimensions
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list (-  xsp 1150) (- (+ ysp (/ (+  width 62.8) 2)) -175) 0) (list xsp (- (+ ysp (/ (+  width 62.8) 2)) -175) 0)
    (list (- xsp (/ 1150)) (- (+ ysp (/ (+  width 62.8) 2)) -175) 0 )
    )
    (setvar "clayer" "doors")
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- xsp 1095 ) (+  ysp 142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- xsp  1393) (+ ysp  142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- xsp  1397) (+ ysp  142.4) 0)) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- xsp 1393) (+ ysp  142.4 4) 0)) (cons 11 (list (- xsp 1397) (+ ysp 142.4 4) 0))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- xsp 1393) (+ ysp  138.4) 0)) (cons 11 (list (- xsp 1397) (+ ysp  138.4) 0))))
   
    (command "trim" "" "fence"  
    (list (- xsp 1392) (+ ysp  138.7) 0) (list (- xsp 1398) (+ ysp 138.65) 0)
    (list (- xsp 1392) (+ ysp  142.4) 0) (list (- xsp 1398) (+ ysp  142.4) 0)
    (list (- xsp 1392) (+ ysp  146.15) 0) (list (- xsp  1398) (+ ysp  146.15) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list (- xsp 1095) (+ ysp 142.4) 0) (list xsp ysp 0)
      (list (- xsp (/ 1095 2)) (-  ysp 250))
      )
      
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout  
      
      (command "rectang" (list (- xsp 868.75) (+ ysp  39.6)0)  (list (- xsp 1030.75) (+ ysp  61.8)0))
      (command "rectang" (list (- xsp 902.5)  (+ ysp  112.40)) (list (- xsp 937.5)  (+ ysp 132.4)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- xsp 920) (+ ysp 139.15) 0 )) (cons 40 1.5)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- xsp 920) (+ ysp 105.65) 0 )) (cons 40 1.5)))
      
       (command "clayer" "dimensions")
      
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - xsp 949.75)  (+ ysp  50.7) 0 ) (list xsp  ysp  0 )
      (list ( - (/ 949. 5)) (- ysp  150))
      )
      
      (command "dimlinear";;; lock cutout dimensions
      (list xsp ysp  0 ) (list (- xsp 920) (+ ysp  122.4)0 )
       (list (- xsp (/ 920 2 )) (- ysp  75) 0)   
      
      (command "clayer" "doors")

    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- xsp (- height 47)) 199) (- (+ ysp width 62.8) 42.16) 0)  (list (+ (- xsp (- height 47)) 301) (- (+ ysp width 62.8) 76.2)0)   )
      (command "rectang" (list (+ (- xsp (- height 47)) 983) (- (+ ysp width 62.8) 42.16) 0)  (list (+ (- xsp (- height 47)) 1085) (- (+ ysp width 62.8) 76.2)0)   )
      (command "rectang" (list (+ (- xsp (- height 47)) 1767) (- (+ ysp width 62.8)42.16) 0)  (list (+ (- xsp (- height 47)) 1869) (- (+ ysp width 62.8) 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- xsp 18) (- (+ ysp width 62.8) 43.5) 0) (list (- xsp 33) (- (+ ysp width 62.8)58.5) 0) )
      
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (command "rectang" (list (+ (- xsp (- height 47)) 10) ysp 0)  (list (+ (- xsp (- height 47)) 30) (+ ysp 15 ) 0))
   (command "rectang" (list (+ (- xsp (- height 47)) 220) ysp 0)  (list (+ (- xsp (- height 47)) 240) (+ ysp 15 ) 0))
   (command "rectang" (list ( - xsp  10) ysp 0)  (list (- xsp  30) (+ ysp 15 ) 0))
   (command "rectang" (list ( - xsp  220) ysp 0)  (list (- xsp 240) (+ ysp 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 12) (+  ysp 2) 0 )
        (list (+ (- xsp (-  height 47)) 12) (-  ysp 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 222) (+  ysp 2) 0 )
        (list (+ (- xsp (-  height 47)) 222) (-  ysp 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- xsp  12) (+  ysp 2) 0 )
        (list (- xsp  12) (-  ysp 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- xsp  222) (+  ysp 2) 0 )
        (list (- xsp  222) (-  ysp 2) 0 )
        "" ""
      )
   (command "rectang" (list (+ (- xsp (- height 47)) 10) (+ ysp (+ width 62.8)) 0)  (list (+ (- xsp (- height 47)) 30) (- (+ ysp (+ width 62.8)) 15) 0))
   (command "rectang" (list (+ (- xsp (- height 47)) 220) (+ ysp (+ width 62.8)) 0)  (list (+ (- xsp (- height 47)) 240) (- (+ ysp (+ width 62.8)) 15) 0))
   (command "rectang" (list ( - xsp  10) (+ ysp (+ width 62.8)) 0)  (list (- xsp  30) (- (+ ysp (+ width 62.8)) 15) 0))
   (command "rectang" (list ( - xsp  220) (+ ysp (+ width 62.8)) 0)  (list (- xsp 240) (- (+ ysp (+ width 62.8)) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 12) (+  ysp (+ width 62.8) 2) 0 )
        (list (+ (- xsp (-  height 47)) 12) ( - (+ ysp  (+ width 62.8)) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- xsp (-  height 47)) 222) (+  ysp  (+ width 62.8) 2) 0 )
        (list (+ (- xsp (-  height 47)) 222) ( - (+ ysp  (+ width 62.8)) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- xsp  12) (+  ysp  (+ width 62.8) 2) 0 )
        (list (- xsp  12) ( - (+ ysp  (+ width 62.8)) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- xsp  222) (+  ysp (+ width 62.8) 2) 0 )
        (list (- xsp  222) ( - (+ ysp  (+ width 62.8)) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
      
    ;; End of Right push panel ;;
      
      

      
    )
    
    ;end of left push
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  
  )
  ;end of Single door
  )))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
 
  
  
  
  
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Euqal shutter  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  
  
  ;;;;;;;;;;;start of Double door Euqal Door
  
  
  (if (= (atoi doortype) 2)
  (progn
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start template 
    
    (setvar "clayer" "template")
    
    (command "rectangle" (list (+ x 0 ) (+ y 0) 0) (list (+ x 11755) (+ y 9915)0) )
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 955  ) 0)) (cons 11 (list (+ x 11755) (+ y 955 )  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 1910 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 1910)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 2865 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 2865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 3865 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 3865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 4865 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 4865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 6665 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 6665)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 8456 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 8456)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 9106 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 9106)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 9906 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 9906)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list (+ x 7520) y  0)) (cons 11 (list (+ x 7520 )   (+ y 9915) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (+ x 3760) (+ y 2865) 0)) (cons 11 (list (+ x 3760 ) (+ y 9106) 0))))
    
    ;end of template
     ;start of text
   
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 3515 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Bottom C 0.8MM SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 4515 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Top C 0.8MM SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 5865 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Panel SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 7665 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Lid SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 8790) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat "Qty" (rtos eqd)) )))
    
    ;end of text
    
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start frame drawing and text
    
    (if (= (atoi frth ) 105);;;frame thickness
    (progn
        
    (setvar "clayer" "template")
      
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 8020 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 8020 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 8020 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 )(+ y 9515) 0)) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm " "x" (rtos height) "mm " "x" frth"mm" " " "Equal Shutter"))))
    
     
      
      ;;;;;; start of 90 degrees frames
      (if (= (atoi tofn ) 90)
      (progn 
        
        (setvar "clayer" "doors")
      
      (setq tfx ( + 6000 x))
      (setq tfy 2200)
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 231.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 231.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 231.2) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 231.2) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 230) )
      (list (+ (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 230) )
      (list (- (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (+ (- tfx (- width 76))210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 226.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (- (+ (- tfx (- width 76)) 210) 20 )(+ tfy 233) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

         (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 127.8 ) 0)) (cons 40 8)))    
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;
        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        ;;; start of right  frame 
      (setq rfx (+ 6000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 70.2) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 28) (+ rfy 140.3) 0)) (cons 40 8)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 77.4) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 291) (+ rfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1075) (+ rfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1859) (+ rfy 127.8) 0)) (cons 40 8)))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) rfy 0) (list (+ (- rfx height) 270) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) rfy 0) (list (+ (- rfx height) 315) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) rfy 0) (list (+ (- rfx height) 1054) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) rfy 0) (list (+ (- rfx height) 1099) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) rfy 0) (list (+ (- rfx height) 1838) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) rfy 0) (list (+ (- rfx height) 1883) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 270) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 315) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1054) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1099) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1838) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1883) (+ rfy 227.2) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 2) 0) 
        (list (+ (- rfx height) 268) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 2) 0) 
        (list (+ (- rfx height) 313) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1052) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1097) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1836) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1881) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 268) (+ rfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 313) (+ rfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1052) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1097) (+ rfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1836) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1881) (+ rfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
       ;;; end of right frame;;;;
        
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
        
   ;;; start of left  frame 
      (setq rfx (+ 6000 x) )
      (setq rfy 200 )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 161) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 28) (+ rfy 90.9) 0)) (cons 40 5)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 186.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 153.8) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 186.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 153.8) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy  186.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 153.8) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 291) (+ rfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1075) (+ rfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1859) (+ rfy 103.4) 0)) (cons 40 8)))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) rfy 0) (list (+ (- rfx height) 270) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) rfy 0) (list (+ (- rfx height) 315) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) rfy 0) (list (+ (- rfx height) 1054) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) rfy 0) (list (+ (- rfx height) 1099) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) rfy 0) (list (+ (- rfx height) 1838) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) rfy 0) (list (+ (- rfx height) 1883) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 270) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 315) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1054) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1099) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1838) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1883) (+ rfy 227.2) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 2) 0) 
        (list (+ (- rfx height) 268) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 2) 0) 
        (list (+ (- rfx height) 313) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1052) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1097) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1836) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1881) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 268) (+ rfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 313) (+ rfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1052) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1097) (+ rfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1836) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1881) (+ rfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      
      
      
      ;;; end of LEFT frame;;;;
      
    
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
        
       
        
        

      ))
      ;; End of 90 degrees frames

          
      ;;;;;; start of 45 degrees frames
      (if (= (atoi tofn ) 45)
      (progn 
      
        
      
      ))
      ;; End of 45 degrees frames
    
    
    )
    )
    
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (if (= (atoi frth ) 50);;;frame thickness
    (progn
      
      
      (setvar "clayer" "template" )
      
    (entmake (list (cons 0   "text") (cons 10 (list (+ x 8020 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0   "text") (cons 10 (list (+ x 8020 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0   "text") (cons 10 (list (+ x 8020 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 ) (+ y 9515) 0 )) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm" "x" (rtos height) "mm" "x"  frth"mm" " " "Equal Shutter"  ))))
       
      ;;;;;; start of 90 degrees frames
      (if (= (atoi tofn ) 90)
      (progn 
        
        ;;;start of top frame
      (setvar "clayer" "doors")
      
      (setq tfx ( + 6000 x ))
      (setq tfy 2200)
        
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 173.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 173.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 173.2 ) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 94.2) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 173.2 ) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 67.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 173.2 ) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
        
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 172) )
      (list (+ (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 172) )
      (list (- (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 67.8) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 67.8 ) 0)) (cons 40 8)))    
          
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list(+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"

        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        

    ;;; start of right  frame 
      (setq rfx (+ 6000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 81.2) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 56.2) 0)) (cons 40 5)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 77.4) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 140) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 924) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1708) (+ rfy 67.8) 0)) (cons 40 8)))
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- rfx height) 115) rfy 0) (list (+ (- rfx height) 119) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) rfy 0) (list (+ (- rfx height) 164) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) rfy 0) (list (+ (- rfx height) 904) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) rfy 0) (list (+ (- rfx height) 949) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) rfy 0) (list (+ (- rfx height) 1688) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) rfy 0) (list (+ (- rfx height) 1733) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 115) ( + rfy  173.2 ) 0) (list (+ (- rfx height) 119) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 164) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 904) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 949) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1688) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1733) (+ rfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 2) 0) 
        (list (+ (- rfx height) 117) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 2) 0) 
        (list (+ (- rfx height) 162) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 2) 0) 
        (list (+ (- rfx height) 902) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 2) 0) 
        (list (+ (- rfx height) 947) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1686) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1731) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 174) 0) 
        (list (+ (- rfx height) 117) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 174) 0) 
        (list (+ (- rfx height) 162) (+ rfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 174) 0) 
        (list (+ (- rfx height) 902) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 174) 0) 
        (list (+ (- rfx height) 947) (+ rfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1686) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1731) (+ rfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
    
    ;;; end of right frame;;;;
        
    ;;; start of left  frame 
        
      (setq lfx (+ 6000 x))
      (setq lfy (+ 200 y))
      
      (command "rectang" (list lfx lfy 0) (list (- lfx height) (+ lfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 117) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 92) 0)) (cons 40 5)))
      
      
   
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 140) (+ lfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 924) (+ lfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1708) (+ lfy 127.8) 0)) (cons 40 8)))
        
        ;;;hinge
      
      (command "rectang" (list (+ (- lfx height) 240)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 342 )  (+ lfy 130.6) 0 ))
      (command "rectang" (list (+ (- lfx height) 1024)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 1126 )  (+ lfy 130.6) 0 ))
      (command "rectang" (list (+ (- lfx height) 1808)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 1910 )  (+ lfy 130.6) 0 ))
      
      ;;;hinges;;;  
        
        
    
      
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- lfx height) 115) lfy 0) (list (+ (- lfx height) 119) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) lfy 0) (list (+ (- lfx height) 164) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) lfy 0) (list (+ (- lfx height) 904) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) lfy 0) (list (+ (- lfx height) 949) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) lfy 0) (list (+ (- lfx height) 1688) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) lfy 0) (list (+ (- lfx height) 1733) (+ lfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- lfx height) 115) ( + lfy  173.2 ) 0) (list (+ (- lfx height) 119) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 164) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 904) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 949) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1688) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1733) (+ lfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 2) 0) 
        (list (+ (- lfx height) 117) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 2) 0) 
        (list (+ (- lfx height) 162) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 2) 0) 
        (list (+ (- lfx height) 902) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 2) 0) 
        (list (+ (- lfx height) 947) (- lfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1686) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1731) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 174) 0) 
        (list (+ (- lfx height) 117) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 174) 0) 
        (list (+ (- lfx height) 162) (+ lfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 174) 0) 
        (list (+ (- lfx height) 902) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 174) 0) 
        (list (+ (- lfx height) 947) (+ lfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1686) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1731) (+ lfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list lfx lfy 0)(list (- lfx height) lfy 0)
      (list (- lfx (/ height 2)) (- lfy 100) 0)
      )
    (setvar "clayer" "doors")
      
        
        
      ;;; end of left frame;;;;
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
      
        
      
      ))
      ;; End of 90 degrees frames

          
      ;;;;;; start of 45 degrees frames
      (if (= (atoi tofn ) 45)
      (progn 
        
      
      
      ))
      ;; End of 45 degrees frames
    


    )
    )
    
    
    ;end of frame drawing and text
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Euqal Door RIGHT push  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start of right push
    (if (= (atoi doororie) 2 )
    (progn 
      
        (setvar "clayer" "template")
      
    (alert (strcat "Double Door Euqal Right Push"))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 100) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Right Active Push Shutter"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 3860) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Left Inactive Push Shutter"))))
       
       (setq rlx (+ x 3500) 
            rly (+ y 7000)
            rpx (+ x 3500)
            rpy (+ y 5200)
            llx (+ x 7200)
            lly (+ y 7000)
            lpx (+ x 7200)
            lpy (+ y 5200))
      
      
      (setq shutter (/ (- width 90) 2))
      (setq widthl (+ shutter 29.5 ))
      (setq widthp (+ shutter 147.3 ))
      
      (setq height1 (- height 47))
      
      
      
 
    ;; Start of Right push lid
      (setvar "clayer" "doors")
      (command "rectang"  (list rlx rly 0) (list (- rlx height1) (+ rly widthl) 0));;lid cutout
      
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      
      (command "dimlinear" (list rlx (+ rly widthl )  0) (list (- rlx height1) (+ rly widthl) 0)
      (list (/(- rlx height1)2) (+ rly widthl 100)0))
      
      (command "dimlinear" (list (- rlx height1) rly ) (list (- rlx (-  height 47)) (+ rly widthl) 0)
      (list (- (- rlx height1) 100) (/ (+ rly widthl) 2) 0))
      
      (setvar "clayer" "doors")
      
      (command "rectang"  (list (- rlx 1150)  (+ rly (- (/ widthl 2) 175))  0 ) (list (- rlx 1900) (+ rly (+ (/ widthl 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- rlx 1150) (+ rly (/ widthl 2) 175) 0) (list (- rlx 1900 ) (+ rly (/ widthl 2) 175) 0)
      (list (- rlx 1525 ) (+ rly (/ widthl 2) 225) 0)
      )
      
      (command "dimlinear"
      (list  (- rlx 1900) (+ rly (/ widthl 2) 175) 0 )(list  (- rlx 1900) (- (+ rly (/ widthl 2)) 175) 0 )
      (list  (- rlx 1950) (+ rly (/ widthl 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      
      (entmake (list (cons 0 "circle")  (cons  10 (list (- rlx 1095) (+ rly 83.5 ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- rlx 1395) (+ rly 83.5) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- rlx 1095) (+ rly 83.5) 0)(list (- rlx 1395) (+ rly 83.5)0)
      (list (- rlx 12450) (+ rly 103.5) 0)
      )
      
      (command "clayer" "doors")
      
    ;; lock cutout
      (command "rectang" (list (- rlx 902.5) (+ rly 53.5) 0) (list (- rlx 937.5) ( + rly 73.5) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 920) (+ rly 46.75) 0)) (cons 40 1.5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 920) (+ rly 80.25) 0)) (cons 40 1.5)))
     
    ;; End of Right Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      ;;Start of Right Push Panel
    (command "rectang" (list rpx rpy 0) (list (- rpx height1) (+ rpy widthp) 0 )); panel cutout
    (command "rectang" (list (- rpx 1150) (+ rpy (- (/ widthp 2) 175))0) (list (- rpx 1900) (+ rpy (+ (/ widthp 2) 175))0));; window cutout
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear"
    (list (- rpx height1) (+ rpy widthp ) 0) (list (- rpx height1) rpy 0) 
    (list (- (- rpx height1) 100)  ( + rpy widthp )  0)
    ) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
   
    (command "dimlinear"
    (list (-  rpx 1150)    (- (+ rpy (/ widthp  2)) -175) 0 ) (list rpx (- (+ rpy (/ widthp  2)) -175) 0)
    (list (- rpx (/ 1150)) (- (+ rpy (/ widthp  2)) -175) 0 )
    )
      
    (setvar "clayer" "doors" )
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx 1095 ) (+ rpy (- widthp 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1393) (+ rpy (- widthp 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1397) (+ rpy (- widthp 142.4) 0))) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- widthp 142.4 4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- widthp 142.4 4) 0)))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- widthp 138.4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- widthp 138.4) 0)))))
   
    (command "trim" "" "fence"  
    (list (- rpx 1392) (+ rpy (- widthp 138.7)) 0) (list (- rpx 1398) (+ rpy (- widthp 138.65)) 0)
    (list (- rpx 1392) (+ rpy (- widthp 142.4)) 0) (list (- rpx 1398) (+ rpy (- widthp 142.4)) 0)
    (list (- rpx 1392) (+ rpy (- widthp 146.15)) 0) (list (- rpx  1398) (+ rpy (- widthp 146.15)) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      
      (command "-dimstyle" "restore" "50")
      
      (command "dimlinear"
      (list (- rpx 1095) (- (+ rpy widthp ) 142.4) 0) (list rpx (+ rpy widthp) 0)
      (list (- rpx (/ 1095 2)) (+ rpy widthp  250) 0)
      )
    (command "clayer" "doors")
      
      ;;;;;
      
     ;;lock cutout 
      (command "rectang" (list (- rpx 868.75) (+ rpy (- widthp 39.6)0))  (list (- rpx 1030.75) (+ rpy (- widthp 61.8))0))
      (command "rectang" (list (- rpx 902.5)  (+ rpy (- widthp 112.4)0)) (list (- rpx 937.5)  (+ rpy (- widthp  132.4))))
      (entmake (list (cons  0 "circle") (cons 10 (list (- rpx 920) (+ rpy (- widthp 139.15)) 0 )) (cons 40 1.5)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- rpx 920) (+ rpy (- widthp 105.65)) 0 )) (cons 40 1.5)))
       (command "clayer" "dimensions")
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - rpx 949.75) (- (+ rpy widthp) 50.7) 0 ) (list rpx (+ rpy widthp) 0 )
      (list ( - (/ 949. 5)) (+ rpy widthp  150))
      )
      
      (command "dimlinear";;; lock cutout dimensions
      (list rpx (+ rpy widthp) 0 ) (list (- rpx 920) (- (+ rpy widthp ) 122.4) 0)
       (list (- rpx (/ 920 2 )) (+ (+ rpy widthp ) 75) 0)   
      )
      (command "clayer" "doors")

    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- rpx height1) 199) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 301) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 983) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1085) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 1767) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1869) (+ rpy 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- rpx 18) (+ rpy 43.5) 0) (list (- rpx 33) (+ rpy 58.5) 0) )
      
      
 
      (entmake (list (cons 0 "circle") (cons 10 (list (- rpx 25) (-  (+ rpy widthp ) 87.4) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (-  rpx height1) 25) (-  (+ rpy widthp ) 87.4) 0)) (cons 40 3)))
      
      (setq n1 (- height1 108))
      (while (< 120 n1)
      (progn
        (entmake (list (cons 0 "circle") (cons 10 (list (+ ( - rpx height1 ) n1) (- (+ rpy widthp) 87.4) 0 )) (cons 40 3)))
        (setq n1 (- n1 120))
      );;progn
      );;While
      
      
  ;;;;
   (command "rectang" (list (+ (- rpx height1) 10) rpy 0)  (list (+ (- rpx height1) 30) (+ rpy 15 ) 0))
   (command "rectang" (list (+ (- rpx height1) 220) rpy 0)  (list (+ (- rpx height1) 240) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  10) rpy 0)  (list (- rpx  30) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  220) rpy 0)  (list (- rpx 240) (+ rpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy 2) 0 )
        (list (- rpx  12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy 2) 0 )
        (list (- rpx  222) (-  rpy 2) 0 )
        "" ""
      )
      
   (command "rectang" (list (+ (- rpx height1) 10) (+ rpy widthp) 0)  (list (+ (- rpx height1) 30) (- (+ rpy widthp) 15) 0))
   (command "rectang" (list (+ (- rpx height1) 220) (+ rpy widthp) 0)  (list (+ (- rpx height1) 240) (- (+ rpy widthp) 15) 0))
   (command "rectang" (list ( - rpx  10) (+ rpy widthp) 0)  (list (- rpx  30) (- (+ rpy widthp) 15) 0))
   (command "rectang" (list ( - rpx  220) (+ rpy widthp) 0)  (list (- rpx 240) (- (+ rpy widthp) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy widthp 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) ( - (+ rpy  widthp) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy  widthp 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) ( - (+ rpy  widthp) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy  widthp 2) 0 )
        (list (- rpx  12) ( - (+ rpy  widthp) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy widthp 2) 0 )
        (list (- rpx  222) ( - (+ rpy  widthp) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
      
  ;; End of Right push panel ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
  ;; Start of left push lid
      
      (setvar "clayer" "doors")
      (command "rectang"  (list llx lly 0) (list (- llx height1) (+ lly widthl) 0));;lid cutout
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      (command "dimlinear" (list llx (+ lly widthl) 0) (list (- llx height1) (+ lly widthl) 0)  (list (/(- llx height1)2) (+ lly widthl 100)0))
      (command "dimlinear" (list (- llx height1) lly ) (list (- llx height1 ) (+ lly widthl) 0) (list (- (- llx height1) 100) (/ (+ lly widthl) 2) 0))
      (setvar "clayer" "doors")
      (command "rectang"  (list (- llx 1150)  (+ lly (- (/ widthl 2) 175))  0 ) (list (- llx 1900) (+ lly (+ (/ widthl 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      
      (command "dimlinear"
      (list  (- llx 1150) (+ lly (/ widthl 2) 175) 0) (list (- llx 1900 ) (+ lly (/ widthl 2) 175) 0)
      (list (- llx 1525 ) (+ lly (/ widthl 2) 225) 0)
      )
      
      
      (command "dimlinear"
      (list  (- llx 1900) (+ lly (/ widthl 2) 175) 0 )(list  (- llx 1900) (- (+ lly (/ widthl 2)) 175) 0 )
      (list  (- llx 1950) (+ lly (/ widthl 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      (entmake (list (cons 0 "circle")  (cons  10 (list (- llx 1095) (- (+ lly widthl) 83.5  ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- llx 1395) (- (+ lly widthl) 83.5  ) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- llx 1095) (- (+ lly widthl) 83.5 ) 0)(list (- llx 1395) (- (+ lly widthl) 83.5 )0)
      (list (- llx 12450) (- (+ lly widthl) 103.5 ) 0)
      )
      
      (command "clayer" "doors")
      
      (setq n2 (- height1 108) )
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 18) (- (+ lly widthl) 32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 18) (+ lly widthl)  0)) (cons 40 8)))
      (command "trim" "" "fence" 
      (list (- llx 18) (+ lly widthl 9)  0)
      (list (- llx 18) (- (+ lly widthl ) 2) 0)
      "" "")
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1 ) 18) (- (+ lly widthl ) 32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1 ) 18) (+ lly widthl )  0)) (cons 40 8)))
        (command "trim" "" "fence" 
      (list (+ (- llx height1 ) 18)  (+ lly widthl 9)  0)
      (list (+ (- llx height1 ) 18)  (- (+ lly widthl) 2) 0)
      "" "")
      
      (while (< 110 n2)
      (progn
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1) n2) (- (+ lly widthl) 32) 0)) (cons 40 3)))
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1) n2) (+ widthl lly) 0)) (cons 40 8)))
          (command "trim" "" "fence" 
          (list (+ (- llx height1 ) n2)  (+ lly widthl 9)  0)
          (list (+ (- llx height1 ) n2)  (- (+ lly widthl ) 2) 0)
          "" "")
      
        
        (setq n2 (- n2 120))
      );;progn
      );;while
     
    ;; End of left Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
      
     
        
    ;;Start of left Push Panel
      
      
    (command "rectang" (list lpx lpy 0) (list (- lpx height1) (+ lpy widthp) 0 )); panel cutout
    (command "rectang" (list (- lpx 1150) (+ lpy (- (/ widthp 2) 175))0) (list (- lpx 1900) (+ lpy (+ (/ widthp 2) 175))0));; window cutout
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear" (list (- lpx height1) (+ lpy widthp) 0) (list (- lpx height1) lpy 0) 
    (list (- (- lpx height1)100) (/ (+ lpy widthp )2 )0)) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list (-  lpx 1150) (- (+ lpy (/ widthp 2)) -175) 0) (list lpx (- (+ lpy (/ widthp 2)) -175) 0)
    (list (- lpx (/ 1150)) (- (+ lpy (/ widthp 2)) -175) 0 )
    )
    (setvar "clayer" "doors")
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx 1095 ) (+  lpy 142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1393) (+ lpy  142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1397) (+ lpy  142.4) 0)) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  142.4 4) 0)) (cons 11 (list (- lpx 1397) (+ lpy 142.4 4) 0))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  138.4) 0)) (cons 11 (list (- lpx 1397) (+ lpy  138.4) 0))))
   
    (command "trim" "" "fence"  
    (list (- lpx 1392) (+ lpy  138.7) 0) (list (- lpx 1398) (+ lpy 138.65) 0)
    (list (- lpx 1392) (+ lpy  142.4) 0) (list (- lpx 1398) (+ lpy  142.4) 0)
    (list (- lpx 1392) (+ lpy  146.15) 0) (list (- lpx  1398) (+ lpy  146.15) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list (- lpx 1095) (+ lpy 142.4) 0) (list lpx lpy 0)
      (list (- lpx (/ 1095 2)) (-  lpy 250))
      )
      
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout  
      
      (command "rectang" (list (- lpx 868.75) (+ lpy  39.6)0)  (list (- lpx 1030.75) (+ lpy  61.8)0))
     
      
       (command "clayer" "dimensions")
      
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - lpx 949.75)  (+ lpy  50.7) 0 ) (list lpx  lpy  0 )
      (list ( - (/ 949. 5)) (- lpy  150))
      )
      
      
      (command "clayer" "doors")

    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- lpx height1) 199) (- (+ lpy widthp ) 42.16) 0)  (list (+ (- lpx height1) 301) (- (+ lpy widthp) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 983) (- (+ lpy widthp) 42.16) 0)  (list (+ (- lpx height1) 1085) (- (+ lpy widthp ) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 1767) (- (+ lpy widthp)42.16) 0)  (list (+ (- lpx height1) 1869) (- (+ lpy widthp ) 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- lpx 18) (- (+ lpy widthp) 43.5) 0) (list (- lpx 33) (- (+ lpy widthp )58.5) 0) )
      (command "rectang" (list (+ (- lpx height1) 199.25) (+ lpy 38.25) 0) (list (+ (- lpx height1 ) 369.75) (+ lpy 63.75)  0))
       
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (command "rectang" (list (+ (- lpx height1) 10) lpy 0)  (list (+ (- lpx height1) 30) (+ lpy 15 ) 0))
   (command "rectang" (list (+ (- lpx height1) 220) lpy 0)  (list (+ (- lpx height1) 240) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  10) lpy 0)  (list (- lpx  30) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  220) lpy 0)  (list (- lpx 240) (+ lpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy 2) 0 )
        (list (- lpx  12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy 2) 0 )
        (list (- lpx  222) (-  lpy 2) 0 )
        "" ""
      )
   (command "rectang" (list (+ (- lpx height1) 10) (+ lpy widthp) 0)  (list (+ (- lpx height1) 30) (- (+ lpy widthp) 15) 0))
   (command "rectang" (list (+ (- lpx height1) 220) (+ lpy widthp) 0)  (list (+ (- lpx height1) 240) (- (+ lpy widthp) 15) 0))
   (command "rectang" (list ( - lpx  10) (+ lpy widthp) 0)  (list (- lpx  30) (- (+ lpy widthp) 15) 0))
   (command "rectang" (list ( - lpx  220) (+ lpy widthp) 0)  (list (- lpx 240) (- (+ lpy widthp) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy widthp 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) ( - (+ lpy  widthp) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy  widthp 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) ( - (+ lpy  widthp) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy  widthp 2) 0 )
        (list (- lpx  12) ( - (+ lpy  widthp) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy widthp 2) 0 )
        (list (- lpx  222) ( - (+ lpy  widthp) 2) 0 )
        "" ""
      )
      
  ;;;;      

    ;; End of left push panel ;;
      

    )
    )
    ;end of right push
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Top C and Bottom C ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
 
     ;;start of bottom and top c 
  
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 3000))
    (setq tpcy 4200)
    (setq bpcx (+ x 3000))
    (setq bpcy 3100)

    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter 1)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter 1)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter 1))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter 1)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter 1))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter 1))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter 1))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter 1))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter 1))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter 1)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter 1))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter 1))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter 1)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter 1) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter  8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter  8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter  8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter  8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter  8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter  8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter  8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter  8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter  8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter  8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter  8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter  8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
    
    
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    

    ;;start of bottom and top c 
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 7000))
    (setq tpcy 4200)
    (setq bpcx (+ x 7000))
    (setq bpcy 3100)
    
      ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter 1)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter 1)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter 1))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter 1)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter 1))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter 1))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter 1))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter 1))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter 1))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter 1)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter 1))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter 1))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter 1)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter 1) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc

   
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter 8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter 8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter 8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter 8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter 8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter 8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter 8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter 8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter 8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter 8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter 8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter 8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c    
    
    
    

    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Euqal Door LEFT push ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;start of left push 
    
    (if (= (atoi doororie) 1 )
    (progn 
      
    (setvar "clayer" "template")
      
      (alert (strcat "Double Door equal Left Push"))
      
      (entmake (list (cons 0 "text") (cons 10 (list (+ x 100) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Right Inactive Push Shutter"))))
      (entmake (list (cons 0 "text") (cons 10 (list (+ x 3860) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Left Active Push Shutter"))))
      (setvar "clayer" "doors")
      
      (setq rlx (+ x 3500) 
            rly (+ y 7000)
            rpx (+ x 3500)
            rpy (+ y 5200)
            llx (+ x 7200)
            lly (+ y 7000)
            lpx (+ x 7200)
            lpy (+ y 5200))
      
      
      (setq shutter (/ (- width 90) 2))
      (setq widthl (+ shutter 29.5 ))
      (setq widthp (+ shutter 147.3 ))
      
      (setq height1 (- height 47))
      
    ;; Start of Right push lid
      (setvar "clayer" "doors")
      (command "rectang"  (list rlx rly 0) (list (- rlx height1) (+ rly widthl) 0));;lid cutout
      
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      
      (command "dimlinear" (list rlx (+ rly widthl )  0) (list (- rlx height1) (+ rly widthl) 0)
      (list (/(- rlx height1) 2) (+ rly widthl 100) 0 ))
      
      (command "dimlinear" (list (- rlx height1) rly ) (list (- rlx (-  height 47)) (+ rly widthl) 0)
      (list (- (- rlx height1) 100) (/ (+ rly widthl) 2) 0 ))
      
      (setvar "clayer" "doors")
      
      (command "rectang"  (list (- rlx 1150)  (+ rly (- (/ widthl 2) 175))  0 ) (list (- rlx 1900) (+ rly (+ (/ widthl 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- rlx 1150) (+ rly (/ widthl 2) 175) 0) (list (- rlx 1900 ) (+ rly (/ widthl 2) 175) 0)
      (list (- rlx 1525 ) (+ rly (/ widthl 2) 225) 0)
      )
      
      (command "dimlinear"
      (list  (- rlx 1900) (+ rly (/ widthl 2) 175) 0 )(list  (- rlx 1900) (- (+ rly (/ widthl 2)) 175) 0 )
      (list  (- rlx 1950) (+ rly (/ widthl 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      
      (entmake (list (cons 0 "circle")  (cons  10 (list (- rlx 1095) (+ rly 83.5 ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- rlx 1395) (+ rly 83.5) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- rlx 1095) (+ rly 83.5) 0)(list (- rlx 1395) (+ rly 83.5)0)
      (list (- rlx 12450) (+ rly 103.5) 0)
      )
      
      (command "clayer" "doors")
      
      
      (setq n2 (- height1 108) )
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 18)  (+ rly 32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 18)  rly  0)) (cons 40 8)))
      (command "trim" "" "fence" 
      (list (- rlx 18) (- rly  9)  0)
      (list (- rlx 18)(+ rly  2) 0)
      "" "")
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1 ) 18) (+ rly  32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1 ) 18)  rly 0)) (cons 40 8)))
        (command "trim" "" "fence" 
      (list (+ (- rlx height1 ) 18)  (- rly 9)  0)
      (list (+ (- rlx height1 ) 18)  (+ rly 2) 0)
      "" "")
      
      (while (< 110 n2)
      (progn
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1) n2)  (+ rly 32) 0)) (cons 40 3)))
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1) n2)  rly 0)) (cons 40 8)))
          (command "trim" "" "fence" 
          (list (+ (- rlx height1 ) n2)  (- rly 9)  0)
          (list (+ (- rlx height1 ) n2) (+ rly 2) 0)
          "" "")
      
        
        (setq n2 (- n2 120))
      );;progn
      );;while
    
    ;; End of Right Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      ;;Start of Right Push Panel
    (command "rectang" (list rpx rpy 0) (list (- rpx height1) (+ rpy widthp) 0 )); panel cutout
    (command "rectang" (list (- rpx 1150) (+ rpy (- (/ widthp 2) 175))0) (list (- rpx 1900) (+ rpy (+ (/ widthp 2) 175))0));; window cutout
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear"
    (list (- rpx height1) (+ rpy widthp ) 0) (list (- rpx height1) rpy 0) 
    (list (- (- rpx height1)100)  ( + rpy widthp )  0)
    ) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
   
    (command "dimlinear"
    (list (-  rpx 1150)    (- (+ rpy (/ widthp  2)) -175) 0 ) (list rpx (- (+ rpy (/ widthp  2)) -175) 0)
    (list (- rpx (/ 1150)) (- (+ rpy (/ widthp  2)) -175) 0 )
    )
      
    (setvar "clayer" "doors" )
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx 1095 ) (+ rpy (- widthp 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1393) (+ rpy (- widthp 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1397) (+ rpy (- widthp 142.4) 0))) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- widthp 142.4 4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- widthp 142.4 4) 0)))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- widthp 138.4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- widthp 138.4) 0)))))
   
    (command "trim" "" "fence"  
    (list (- rpx 1392) (+ rpy (- widthp 138.7)) 0) (list (- rpx 1398) (+ rpy (- widthp 138.65)) 0)
    (list (- rpx 1392) (+ rpy (- widthp 142.4)) 0) (list (- rpx 1398) (+ rpy (- widthp 142.4)) 0)
    (list (- rpx 1392) (+ rpy (- widthp 146.15)) 0) (list (- rpx  1398) (+ rpy (- widthp 146.15)) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      
      (command "dimlinear"
      (list (- rpx 1095) (- (+ rpy widthp ) 142.4) 0) (list rpx (+ rpy widthp) 0)
      (list (- rpx (/ 1095 2)) (+ rpy widthp  250) 0)
      )
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout 
      (command "rectang" (list (- rpx 868.75) (+ rpy (- widthp 39.6)0))  (list (- rpx 1030.75) (+ rpy (- widthp 61.8))0))

       (command "clayer" "dimensions")
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - rpx 949.75) (- (+ rpy widthp) 50.7) 0 ) (list rpx (+ rpy widthp) 0 )
      (list ( - (/ 949. 5)) (+ rpy widthp  150))
      )
   (command "clayer" "doors")
    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- rpx height1) 199) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 301) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 983) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1085) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 1767) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1869) (+ rpy 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- rpx 18) (+ rpy 43.5) 0) (list (- rpx 33) (+ rpy 58.5) 0) )
      
      
  ;;;;
   (command "rectang" (list (+ (- rpx height1) 10) rpy 0)  (list (+ (- rpx height1) 30) (+ rpy 15 ) 0))
   (command "rectang" (list (+ (- rpx height1) 220) rpy 0)  (list (+ (- rpx height1) 240) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  10) rpy 0)  (list (- rpx  30) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  220) rpy 0)  (list (- rpx 240) (+ rpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy 2) 0 )
        (list (- rpx  12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy 2) 0 )
        (list (- rpx  222) (-  rpy 2) 0 )
        "" ""
      )
   (command "rectang" (list (+ (- rpx height1) 10) (+ rpy widthp) 0)  (list (+ (- rpx height1) 30) (- (+ rpy widthp) 15) 0))
   (command "rectang" (list (+ (- rpx height1) 220) (+ rpy widthp) 0)  (list (+ (- rpx height1) 240) (- (+ rpy widthp) 15) 0))
   (command "rectang" (list ( - rpx  10) (+ rpy widthp) 0)  (list (- rpx  30) (- (+ rpy widthp) 15) 0))
   (command "rectang" (list ( - rpx  220) (+ rpy widthp) 0)  (list (- rpx 240) (- (+ rpy widthp) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy widthp 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) ( - (+ rpy  widthp) 2)  0 )
        "" "" )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy  widthp 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) ( - (+ rpy  widthp) 2) 0 )
        "" "")
      
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy  widthp 2) 0 )
        (list (- rpx  12) ( - (+ rpy  widthp) 2) 0 )
        "" "")
      
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy widthp 2) 0 )
        (list (- rpx  222) ( - (+ rpy  widthp) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
      
  ;; End of Right push panel ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
  ;; Start of left push lid
      
      (setvar "clayer" "doors")
      (command "rectang"  (list llx lly 0) (list (- llx height1) (+ lly widthl) 0));;lid cutout
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      (command "dimlinear" (list llx (+ lly widthl) 0) (list (- llx height1) (+ lly widthl) 0)  (list (/(- llx height1)2) (+ lly widthl 100)0))
      (command "dimlinear" (list (- llx height1) lly ) (list (- llx height1 ) (+ lly widthl) 0) (list (- (- llx height1) 100) (/ (+ lly widthl) 2) 0))
      (setvar "clayer" "doors")
      (command "rectang"  (list (- llx 1150)  (+ lly (- (/ widthl 2) 175))  0 ) (list (- llx 1900) (+ lly (+ (/ widthl 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- llx 1150) (+ lly (/ widthl 2) 175) 0) (list (- llx 1900 ) (+ lly (/ widthl 2) 175) 0)
      (list (- llx 1525 ) (+ lly (/ widthl 2) 225) 0)
      )
      
      
      (command "dimlinear"
      (list  (- llx 1900) (+ lly (/ widthl 2) 175) 0 )(list  (- llx 1900) (- (+ lly (/ widthl 2)) 175) 0 )
      (list  (- llx 1950) (+ lly (/ widthl 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      
      (entmake (list (cons 0 "circle")  (cons  10 (list (- llx 1095) (- (+ lly widthl) 83.5  ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- llx 1395) (- (+ lly widthl) 83.5  ) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- llx 1095) (- (+ lly widthl) 83.5 ) 0)(list (- llx 1395) (- (+ lly widthl) 83.5 )0)
      (list (- llx 12450) (- (+ lly widthl) 103.5 ) 0)
      )
      
      (command "clayer" "doors")
      
    ;; lock cutout
      
      (command "rectang" (list (- llx 902.5) (- (+ lly widthl) 53.5) 0) (list (- llx 937.5) ( - (+ lly widthl ) 73.5 ) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 920) (- (+ lly widthl ) 46.75) 0)) (cons 40 1.5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 920) (- (+ lly widthl ) 80.25) 0)) (cons 40 1.5)))
      
      
      
     
    ;; End of left Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
      
     
        
    ;;Start of left Push Panel
      
      
    (command "rectang" (list lpx lpy 0) (list (- lpx height1) (+ lpy widthp) 0 )); panel cutout
    (command "rectang" (list (- lpx 1150) (+ lpy (- (/ widthp 2) 175))0) (list (- lpx 1900) (+ lpy (+ (/ widthp 2) 175))0));; window cutout
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear" (list (- lpx height1) (+ lpy widthp) 0) (list (- lpx height1) lpy 0) 
    (list (- (- lpx height1)100) (/ (+ lpy widthp )2 )0)) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list (-  lpx 1150) (- (+ lpy (/ widthp 2)) -175) 0) (list lpx (- (+ lpy (/ widthp 2)) -175) 0)
    (list (- lpx (/ 1150)) (- (+ lpy (/ widthp 2)) -175) 0 )
    )
    (setvar "clayer" "doors")
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx 1095 ) (+  lpy 142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1393) (+ lpy  142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1397) (+ lpy  142.4) 0)) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  142.4 4) 0)) (cons 11 (list (- lpx 1397) (+ lpy 142.4 4) 0))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  138.4) 0)) (cons 11 (list (- lpx 1397) (+ lpy  138.4) 0))))
   
    (command "trim" "" "fence"  
    (list (- lpx 1392) (+ lpy  138.7) 0) (list (- lpx 1398) (+ lpy 138.65) 0)
    (list (- lpx 1392) (+ lpy  142.4) 0) (list (- lpx 1398) (+ lpy  142.4) 0)
    (list (- lpx 1392) (+ lpy  146.15) 0) (list (- lpx  1398) (+ lpy  146.15) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list (- lpx 1095) (+ lpy 142.4) 0) (list lpx lpy 0)
      (list (- lpx (/ 1095 2)) (-  lpy 250))
      )
      
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout  
      
      (command "rectang" (list (- lpx 868.75) (+ lpy  39.6)0)  (list (- lpx 1030.75) (+ lpy  61.8)0))
      (command "rectang" (list (- lpx 902.5)  (+ lpy  112.40)) (list (- lpx 937.5)  (+ lpy 132.4)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- lpx 920) (+ lpy 139.15) 0 )) (cons 40 1.5)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- lpx 920) (+ lpy 105.65) 0 )) (cons 40 1.5)))
      
       (command "clayer" "dimensions")
      
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - lpx 949.75)  (+ lpy  50.7) 0 ) (list lpx  lpy  0 )
      (list ( - (/ 949. 5)) (- lpy  150))
      )
      
      (command "dimlinear";;; lock cutout dimensions
      (list lpx lpy  0 ) (list (- lpx 920) (+ lpy  122.4)0 )
       (list (- lpx (/ 920 2 )) (- lpy  75) 0)   
      
      (command "clayer" "doors")
 )
    ;;;;
               
      
      
 

   ;;; hinges 
      (command "rectang" (list (+ (- lpx height1) 199) (- (+ lpy widthp ) 42.16) 0)  (list (+ (- lpx height1) 301) (- (+ lpy widthp) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 983) (- (+ lpy widthp) 42.16) 0)  (list (+ (- lpx height1) 1085) (- (+ lpy widthp ) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 1767) (- (+ lpy widthp)42.16) 0)  (list (+ (- lpx height1) 1869) (- (+ lpy widthp ) 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- lpx 18) (- (+ lpy widthp) 43.5) 0) (list (- lpx 33) (- (+ lpy widthp )58.5) 0) )
      
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (command "rectang" (list (+ (- lpx height1) 10) lpy 0)  (list (+ (- lpx height1) 30) (+ lpy 15 ) 0))
   (command "rectang" (list (+ (- lpx height1) 220) lpy 0)  (list (+ (- lpx height1) 240) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  10) lpy 0)  (list (- lpx  30) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  220) lpy 0)  (list (- lpx 240) (+ lpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy 2) 0 )
        (list (- lpx  12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy 2) 0 )
        (list (- lpx  222) (-  lpy 2) 0 )
        "" ""
      )
               
   (command "rectang" (list (+ (- lpx height1) 10) (+ lpy widthp) 0)  (list (+ (- lpx height1) 30) (- (+ lpy widthp) 15) 0))
   (command "rectang" (list (+ (- lpx height1) 220) (+ lpy widthp) 0)  (list (+ (- lpx height1) 240) (- (+ lpy widthp) 15) 0))
   (command "rectang" (list ( - lpx  10) (+ lpy widthp) 0)  (list (- lpx  30) (- (+ lpy widthp) 15) 0))
   (command "rectang" (list ( - lpx  220) (+ lpy widthp) 0)  (list (- lpx 240) (- (+ lpy widthp) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy widthp 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) ( - (+ lpy  widthp) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy  widthp 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) ( - (+ lpy  widthp) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy  widthp 2) 0 )
        (list (- lpx  12) ( - (+ lpy  widthp) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy widthp 2) 0 )
        (list (- lpx  222) ( - (+ lpy  widthp) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
               
      (entmake (list (cons 0 "circle") (cons 10 (list (- lpx 25) (+  lpy 87.4) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lpx height1) 25) (+  lpy 87.4) 0)) (cons 40 3)))
               
               
      (setq n4 0)
      (setq n4 (- height1 108))
               
      (while (< 120 n4)
      (progn
       (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lpx height1) n4) (+  lpy 87.4) 0)) (cons 40 3))) 
        (setq n4 (- n4 120))
      );;progn
      );;while
      
     
    
      
    ;; End of left push panel ;;
      
      
    
    
   
    
      
      
    )
    )
    ;end of left push
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    )  
  )
   ;end of Double door Euqal Door
  
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door UNequal Door ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  
  
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
   ;start of Double door uneuqal Door
  (if (= (atoi doortype) 3)
  (progn
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start of template
    (setvar "clayer" "template")
      (command "rectangle" (list (+ x 0 ) (+ y 0) 0) (list (+ x 11755) (+ y 9915)0) )
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 955  ) 0)) (cons 11 (list (+ x 11755) (+ y 955 )  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 1910 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 1910)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 2865 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 2865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 3865 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 3865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 4865 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 4865)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 6665 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 6665)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 8456 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 8456)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 9106 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 9106)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list x (+ y 9906 ) 0)) (cons 11 (list (+ x 11755 ) (+ y 9906)  0))))
      (entmake (list (cons 0 "line") (cons 10 (list (+ x 7520) y  0)) (cons 11 (list (+ x 7520 )   (+ y 9915) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (+ x 3760) (+ y 2865) 0)) (cons 11 (list (+ x 3760 ) (+ y 9106) 0))))
    ;start of text
     
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 3515 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Bottom C 0.8MM SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 4515 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Top C 0.8MM SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 5865 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Panel SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 7665 ) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat " Lid SS") )))
    (entmake (list (cons 0 "text")(cons 10 (list (+ x 8020 )  (+ y 8790) 0)) (cons 40 220 ) (cons 50 0 ) (cons 1 (strcat "Qty" (rtos eqd)) )))
    ;end of text
    ;end of template
    
    
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start frame drawing and text
    
   (if (= (atoi frth ) 105);;;frame thickness
    (progn
        
    (setvar "clayer" "template")
      
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 8020 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 8020 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list (+ x 8020 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "105MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 )(+ y 9515) 0)) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm " "x" (rtos height) "mm " "x" frth"mm" " " "UNequal Shutter"))))
    
     
      
      ;;;;;; start of 90 degrees frames
      (if (= (atoi tofn ) 90)
      (progn 
        
        (setvar "clayer" "doors")
      
      (setq tfx (+ 6000 x))
      (setq tfy 2200)
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 231.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 231.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 95.7) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 95.7) 0)) (cons 11 (list (- tfx 18) (+ tfy 231.2) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 95.7) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 231.2) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 226.7)0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 230) )
      (list (+ (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 230) )
      (list (- (- tfx 210) 20) (+ tfy 233) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 127.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 231.2) 0 ) (list (+ (+ (- tfx (- width 76))210) 22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) (+ tfy 231.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 226.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 233) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 230) )
      (list (- (+ (- tfx (- width 76)) 210) 20 )(+ tfy 233) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

         (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 127.8 ) 0)) (cons 40 8)))    
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 231.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 226.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 230) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 233) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;
        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
        ;;; start of right  frame 
      (setq rfx (+ 6000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 70.2) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 28) (+ rfy 140.3) 0)) (cons 40 8)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 77.4) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 291) (+ rfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1075) (+ rfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1859) (+ rfy 127.8) 0)) (cons 40 8)))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) rfy 0) (list (+ (- rfx height) 270) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) rfy 0) (list (+ (- rfx height) 315) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) rfy 0) (list (+ (- rfx height) 1054) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) rfy 0) (list (+ (- rfx height) 1099) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) rfy 0) (list (+ (- rfx height) 1838) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) rfy 0) (list (+ (- rfx height) 1883) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 270) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 315) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1054) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1099) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1838) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1883) (+ rfy 227.2) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 2) 0) 
        (list (+ (- rfx height) 268) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 2) 0) 
        (list (+ (- rfx height) 313) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1052) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1097) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1836) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1881) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 268) (+ rfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 313) (+ rfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1052) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1097) (+ rfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1836) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1881) (+ rfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
       ;;; end of right frame;;;;
        
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;     
        
   ;;; start of left  frame 
      (setq rfx (+ 6000 x) )
      (setq rfy 200 )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 231.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 161) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 28) (+ rfy 90.9) 0)) (cons 40 5)))
      
      
      
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 186.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 153.8) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 186.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 153.8) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy  186.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 153.8) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 291) (+ rfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1075) (+ rfy 103.4) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1859) (+ rfy 103.4) 0)) (cons 40 8)))
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) rfy 0) (list (+ (- rfx height) 270) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) rfy 0) (list (+ (- rfx height) 315) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) rfy 0) (list (+ (- rfx height) 1054) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) rfy 0) (list (+ (- rfx height) 1099) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) rfy 0) (list (+ (- rfx height) 1838) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) rfy 0) (list (+ (- rfx height) 1883) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 266) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 270) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 311) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 315) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1050) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1054) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1095) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1099) (+ rfy 227.2) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1834) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1838) (+ rfy 227.2) 0 ))
      (command "rectang" (list (+ (- rfx height) 1879) ( + rfy 231.2 ) 0) (list (+ (- rfx height) 1883) (+ rfy 227.2) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 2) 0) 
        (list (+ (- rfx height) 268) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 2) 0) 
        (list (+ (- rfx height) 313) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1052) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1097) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1836) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1881) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      
       (command "trim" "" "fence"
        (list (+ (- rfx height) 268) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 268) (+ rfy 232.2) 0)
      "" "" ""
      ) 
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 313) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 313) (+ rfy 232.2) 0)
      "" ""
      ) 
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1052) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1052) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1097) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1097) (+ rfy 232.2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1836) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1836) (+ rfy 232.2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1881) (+ rfy 229.2) 0) 
        (list (+ (- rfx height) 1881) (+ rfy 232.2) 0)
      "" ""
      ) 
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
      
      
      
      
      
      ;;; end of LEFT frame;;;;
      
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
        
       
        
        

      ))
      ;; End of 90 degrees frames

          
      ;;;;;; start of 45 degrees frames
      (if (= (atoi tofn ) 45)
      (progn 
      
        
      
      ))
      ;; End of 45 degrees frames
    
    
    )
    )
    
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    (if (= (atoi frth ) 50);;;frame thickness
    (progn
      
      
      (setvar "clayer" "template" )
      
    (entmake (list (cons 0   "text") (cons 10 (list (+ x 8020 ) (+ y 650 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Left Frame 1.2mm SS"))))
    (entmake (list (cons 0   "text") (cons 10 (list (+ x 8020 ) (+ y 1605 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Right Frame 1.2mm SS"))))
    (entmake (list (cons 0   "text") (cons 10 (list (+ x 8020 ) (+ y 2560 ) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "50MM Top Frame 1.2mm SS"))))
    (entmake (list (cons 0 "text") (cons 10 (list ( + x 200 ) (+ y 9515) 0 )) (cons 40 200) (cons 50 0) (cons 1 (strcat (rtos width) "mm" "x" (rtos height) "mm" "x"  frth"mm" " " "Equal Shutter"  ))))
       
      ;;;;;; start of 90 degrees frames
      (if (= (atoi tofn ) 90)
      (progn 
        
        ;;;start of top frame
      (setvar "clayer" "doors")
      
      (setq tfx (+ 6000 x))
      (setq tfy 2200)
        
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy 0)) (cons 11 (list (- tfx (- width 76)) tfy 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ 173.2 tfy) 0)) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ 173.2 tfy) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list tfx tfy  0)) (cons 11 (list tfx (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list tfx (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 94.2) 0))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx 18) (+ tfy 94.2) 0)) (cons 11 (list (- tfx 18) (+ tfy 173.2 ) 0 ))))
      
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) tfy 0)) (cons 11 (list (- tfx (- width 76)) (+ tfy 94.2) 0 ))))
      (entmake (list (cons 0 "line") (cons 10 (list (- tfx (- width 76)) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 ))))
      (entmake (list (cons 0 "line")(cons 10 (list (+ (- tfx (- width 76)) 18) (+ tfy 94.2 ) 0 )) (cons 11 (list (+ (- tfx (- width 76)) 18) (+ tfy 173.2 ) 0 )) ))
      
      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx 210) (+ tfy 67.8 ) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) tfy 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) tfy 0 )(list (- (- tfx 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (- tfx 210) 18.5 ) (+ tfy 173.2 ) 0 ) (list (+ (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      (command "rectang" (list (- (- tfx 210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx 210) 22.5 )(+ tfy 168.7 )0 ))
      
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (- tfy 2) )
      (list (+ (- tfx 210) 20) (+ tfy 2) )
      "" ""
      )
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (- tfy 2) )
      (list (- (- tfx 210) 20) (+ tfy 2) )
      "" "")
        
      (command "trim" "" "fence"
      (list (+ (- tfx 210) 20) (+ tfy 172) )
      (list (+ (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (- tfx 210) 20) (+ tfy 172) )
      (list (- (- tfx 210) 20) (+ tfy 174) )
      "" "")
      
      
      
     
      (entmake (list (cons 0 "circle") (cons 10 (list ( + (- tfx (- width 76)) 210) (+ tfy 67.8) 0)) (cons 40 8)))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76)) 210) 18.5 ) tfy 0 )(list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 4.5)0 ))
      
      (command "rectang" (list (+ (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (+ (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list (- (+ (- tfx (- width 76))210) 18.5 ) (+ tfy 173.2) 0 ) (list (- (+ (- tfx (- width 76)) 210) 22.5 )(+ tfy 168.7)0 ))
        
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
        
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (- tfy 2))
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 2))
      "" "")
     
      
      (command "trim" "" "fence"
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (+ (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      (command "trim" "" "fence"
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 172) )
      (list (- (+ (- tfx (- width 76)) 210) 20 ) (+ tfy 174) )
      "" "")
      
      
      
      (if (> width 990) 
        (progn

      (entmake (list (cons 0 "circle") (cons 10 (list (- tfx (/ (- width 76) 2))  (+ tfy 67.8 ) 0)) (cons 40 8)))    
          
      (command "rectang" (list (+ (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (+ (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))
      (command "rectang" (list (- (- tfx (/(- width 76) 2))  18.5 ) tfy 0 ) (list (- (- tfx (/(- width 76) 2)) 22.5 ) (+ tfy 4.5)0 ))

      (command "rectang" (list(+ (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (+ (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
      (command "rectang" (list(- (- tfx (/(- width 76) 2))  18.5 ) (+ tfy 173.2) 0 ) (list (- (- tfx (/(- width 76) 2))  22.5 )(+ tfy 168.7)0 ))
        
          (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 2) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (- tfy 2) 0 )       
          "" "") 

            (command "trim" "" "fence"
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (+ (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "")
          (command "trim" "" "fence"
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 172) 0 )
          (list (- (- tfx (/(- width 76) 2))  20 ) (+ tfy 174) 0 )       
          "" "") 
        )
      )
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"

        (list tfx tfy 0) (list (- tfx (- width 76)) tfy 0)
        (list (- tfy (/ (-  width 76) 2))(- tfy 100) 0)
      )
      (setvar "clayer" "doors")

      ;;;end of top frame;;;

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;        

    ;;; start of right  frame 
      (setq rfx (+ 6000 x) )
      (setq rfy (+ 1200 y) )
      
      (command "rectang" (list rfx rfy 0) (list (- rfx height) (+ rfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 81.2) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 19) (+ rfy 56.2) 0)) (cons 40 5)))
      
      ;;;hinge
      
      (command "rectang" (list (+ (- rfx height) 240)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 342 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1024)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1126 )  (+ rfy 77.4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1808)  (+ rfy 45.1) 0 ) (list (+ (- rfx height) 1910 )  (+ rfy 77.4) 0 ))
      
      ;;;hinges;;;
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 140) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 924) (+ rfy 67.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rfx height) 1708) (+ rfy 67.8) 0)) (cons 40 8)))
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- rfx height) 115) rfy 0) (list (+ (- rfx height) 119) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) rfy 0) (list (+ (- rfx height) 164) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) rfy 0) (list (+ (- rfx height) 904) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) rfy 0) (list (+ (- rfx height) 949) (+ rfy 4) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) rfy 0) (list (+ (- rfx height) 1688) (+ rfy 4) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) rfy 0) (list (+ (- rfx height) 1733) (+ rfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- rfx height) 115) ( + rfy  173.2 ) 0) (list (+ (- rfx height) 119) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 160) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 164) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 900) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 904) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 945) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 949) (+ rfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- rfx height) 1684) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1688) (+ rfy 168.7) 0 ))
      (command "rectang" (list (+ (- rfx height) 1729) ( + rfy 173.2 ) 0) (list (+ (- rfx height) 1733) (+ rfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 2) 0) 
        (list (+ (- rfx height) 117) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 2) 0) 
        (list (+ (- rfx height) 162) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 2) 0) 
        (list (+ (- rfx height) 902) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 2) 0) 
        (list (+ (- rfx height) 947) (- rfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1686) (- rfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 2) 0) 
        (list (+ (- rfx height) 1731) (- rfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- rfx height) 117) (+ rfy 174) 0) 
        (list (+ (- rfx height) 117) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 162) (+ rfy 174) 0) 
        (list (+ (- rfx height) 162) (+ rfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 902) (+ rfy 174) 0) 
        (list (+ (- rfx height) 902) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 947) (+ rfy 174) 0) 
        (list (+ (- rfx height) 947) (+ rfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1686) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1686) (+ rfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- rfx height) 1731) (+ rfy 174) 0) 
        (list (+ (- rfx height) 1731) (+ rfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list rfx rfy 0)(list (- rfx height) rfy 0)
      (list (- rfx (/ height 2)) (- rfy 100) 0)
      )
    (setvar "clayer" "doors")
    
    ;;; end of right frame;;;;
        
    ;;; start of left  frame 
        
      (setq lfx (+ 6000 x))
      (setq lfy (+ 200 y))
      
      (command "rectang" (list lfx lfy 0) (list (- lfx height) (+ lfy 173.2) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 117) 0)) (cons 40 5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 19) (+ lfy 92) 0)) (cons 40 5)))
      
      
   
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 140) (+ lfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 924) (+ lfy 127.8) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lfx height) 1708) (+ lfy 127.8) 0)) (cons 40 8)))
        
        ;;;hinge
      
      (command "rectang" (list (+ (- lfx height) 240)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 342 )  (+ lfy 130.6) 0 ))
      (command "rectang" (list (+ (- lfx height) 1024)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 1126 )  (+ lfy 130.6) 0 ))
      (command "rectang" (list (+ (- lfx height) 1808)  (+ lfy 98.3) 0 ) (list (+ (- lfx height) 1910 )  (+ lfy 130.6) 0 ))
      
      ;;;hinges;;;  
        
        
    
      
        
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        
      (command "rectang" (list (+ (- lfx height) 115) lfy 0) (list (+ (- lfx height) 119) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) lfy 0) (list (+ (- lfx height) 164) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) lfy 0) (list (+ (- lfx height) 904) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) lfy 0) (list (+ (- lfx height) 949) (+ lfy 4) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) lfy 0) (list (+ (- lfx height) 1688) (+ lfy 4) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) lfy 0) (list (+ (- lfx height) 1733) (+ lfy 4) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "rectang" (list (+ (- lfx height) 115) ( + lfy  173.2 ) 0) (list (+ (- lfx height) 119) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 160) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 164) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 900) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 904) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 945) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 949) (+ lfy 168.7) 0 ))
      
      (command "rectang" (list (+ (- lfx height) 1684) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1688) (+ lfy 168.7) 0 ))
      (command "rectang" (list (+ (- lfx height) 1729) ( + lfy 173.2 ) 0) (list (+ (- lfx height) 1733) (+ lfy 168.7) 0 ))
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 2) 0) 
        (list (+ (- lfx height) 117) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 2) 0) 
        (list (+ (- lfx height) 162) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 2) 0) 
        (list (+ (- lfx height) 902) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 2) 0) 
        (list (+ (- lfx height) 947) (- lfy 2) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1686) (- lfy 2) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 2) 0) 
        (list (+ (- lfx height) 1731) (- lfy 2) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
     (command "trim" "" "fence"
        (list (+ (- lfx height) 117) (+ lfy 174) 0) 
        (list (+ (- lfx height) 117) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 162) (+ lfy 174) 0) 
        (list (+ (- lfx height) 162) (+ lfy 172) 0)
      "" ""
      ) 
      
      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 902) (+ lfy 174) 0) 
        (list (+ (- lfx height) 902) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 947) (+ lfy 174) 0) 
        (list (+ (- lfx height) 947) (+ lfy 172) 0)
      "" ""
      ) 

      ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1686) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1686) (+ lfy 172) 0)
      "" ""
      ) 
      (command "trim" "" "fence"
        (list (+ (- lfx height) 1731) (+ lfy 174) 0) 
        (list (+ (- lfx height) 1731) (+ lfy 172) 0)
      "" ""
      ) 
        
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
      
    (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list lfx lfy 0)(list (- lfx height) lfy 0)
      (list (- lfx (/ height 2)) (- lfy 100) 0)
      )
    (setvar "clayer" "doors")
      
        
        
      ;;; end of left frame;;;;
      
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
      
        
      
      ))
      ;; End of 90 degrees frames

          
      ;;;;;; start of 45 degrees frames
      (if (= (atoi tofn ) 45)
      (progn 
        
      
      
      ))
      ;; End of 45 degrees frames
    


    )
    )
     ;end of frame drawing and text
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    
    
    
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door UNequal Door RIGHT push ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
    
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;start of right push
    (if (= (atoi doororie) 2 )
      
    (progn 
      
         (setvar "clayer" "template")
      (alert (strcat "Double Door Uneuqal Right Push"))
      (entmake (list (cons 0 "text") (cons 10 (list (+ x 100) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Right Active Push Shutter"))))
      (entmake (list (cons 0 "text") (cons 10 (list (+ x 3860) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Left Inactive Push Shutter"))))
      
      (setvar "clayer" "doors")
      
      (setq rlx (+ x 3500) 
            rly (+ y 7000)
            rpx (+ x 3500)
            rpy (+ y 5200)
            llx (+ x 7200)
            lly (+ y 7000)
            lpx (+ x 7200)
            lpy (+ y 5200))
      
      
      (setq shutter1 (* (- width 90) 0.75))
      (setq shutter2 (* (- width 90) 0.25))
      
      (setq width1l (+ shutter1 30.25 ))
      (setq width1p (+ shutter1 148.05 ))
      
      (setq width2l (+ shutter2 28.75))
      (setq width2p (+ shutter2 146.55 ))
      
      (setq height1 (- height 47))
      
      ;; Start of Right push lid
      (setvar "clayer" "doors")
      (command "rectang"  (list rlx rly 0) (list (- rlx height1) (+ rly width1l) 0));;lid cutout
      
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      
      (command "dimlinear" (list rlx (+ rly width1l )  0) (list (- rlx height1) (+ rly width1l) 0)
      (list (/(- rlx height1)2) (+ rly width1l 100)0))
      
      (command "dimlinear" (list (- rlx height1) rly ) (list (- rlx (-  height 47)) (+ rly width1l) 0)
      (list (- (- rlx height1) 100) (/ (+ rly width1l) 2) 0))
      
      (setvar "clayer" "doors")
      
      (command "rectang"  (list (- rlx 1150)  (+ rly (- (/ width1l 2) 175))  0 ) (list (- rlx 1900) (+ rly (+ (/ width1l 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- rlx 1150) (+ rly (/ width1l 2) 175) 0) (list (- rlx 1900 ) (+ rly (/ width1l 2) 175) 0)
      (list (- rlx 1525 ) (+ rly (/ width1l 2) 225) 0)
      )
      
      (command "dimlinear"
      (list  (- rlx 1900) (+ rly (/ width1l 2) 175) 0 )(list  (- rlx 1900) (- (+ rly (/ width1l 2)) 175) 0 )
      (list  (- rlx 1950) (+ rly (/ width1l 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      
      (entmake (list (cons 0 "circle")  (cons  10 (list (- rlx 1095) (+ rly 83.5 ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- rlx 1395) (+ rly 83.5) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- rlx 1095) (+ rly 83.5) 0)(list (- rlx 1395) (+ rly 83.5)0)
      (list (- rlx 12450) (+ rly 103.5) 0)
      )
      
      (command "clayer" "doors")
      
    ;; lock cutout
      (command "rectang" (list (- rlx 902.5) (+ rly 53.5) 0) (list (- rlx 937.5) ( + rly 73.5) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 920) (+ rly 46.75) 0)) (cons 40 1.5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 920) (+ rly 80.25) 0)) (cons 40 1.5)))
     
    ;; End of Right Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      ;;Start of Right Push Panel
    (command "rectang" (list rpx rpy 0) (list (- rpx height1) (+ rpy width1p) 0 )); panel cutout
    (command "rectang" (list (- rpx 1150) (+ rpy (- (/ width1p 2) 175))0) (list (- rpx 1900) (+ rpy (+ (/ width1p 2) 175))0));; window cutout
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear"
    (list (- rpx height1) (+ rpy width1p ) 0) (list (- rpx height1) rpy 0) 
    (list (- (- rpx height1) 100)  ( + rpy width1p )  0)
    ) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
   
    (command "dimlinear"
    (list (-  rpx 1150)    (- (+ rpy (/ width1p  2)) -175) 0 ) (list rpx (- (+ rpy (/ width1p  2)) -175) 0)
    (list (- rpx (/ 1150)) (- (+ rpy (/ width1p  2)) -175) 0 )
    )
      
    (setvar "clayer" "doors" )
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx 1095 ) (+ rpy (- width1p 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1393) (+ rpy (- width1p 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1397) (+ rpy (- width1p 142.4) 0))) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- width1p 142.4 4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- width1p 142.4 4) 0)))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- width1p 138.4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- width1p 138.4) 0)))))
   
    (command "trim" "" "fence"  
    (list (- rpx 1392) (+ rpy (- width1p 138.7)) 0) (list (- rpx 1398) (+ rpy (- width1p 138.65)) 0)
    (list (- rpx 1392) (+ rpy (- width1p 142.4)) 0) (list (- rpx 1398) (+ rpy (- width1p 142.4)) 0)
    (list (- rpx 1392) (+ rpy (- width1p 146.15)) 0) (list (- rpx  1398) (+ rpy (- width1p 146.15)) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      
      (command "-dimstyle" "restore" "50")
      
      (command "dimlinear"
      (list (- rpx 1095) (- (+ rpy width1p ) 142.4) 0) (list rpx (+ rpy width1p) 0)
      (list (- rpx (/ 1095 2)) (+ rpy width1p  250) 0)
      )
    (command "clayer" "doors")
      
      ;;;;;
      
     ;;lock cutout 
      (command "rectang" (list (- rpx 868.75) (+ rpy (- width1p 39.6)0))  (list (- rpx 1030.75) (+ rpy (- width1p 61.8))0))
      (command "rectang" (list (- rpx 902.5)  (+ rpy (- width1p 112.4)0)) (list (- rpx 937.5)  (+ rpy (- width1p  132.4))))
      (entmake (list (cons  0 "circle") (cons 10 (list (- rpx 920) (+ rpy (- width1p 139.15)) 0 )) (cons 40 1.5)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- rpx 920) (+ rpy (- width1p 105.65)) 0 )) (cons 40 1.5)))
       (command "clayer" "dimensions")
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - rpx 949.75) (- (+ rpy width1p) 50.7) 0 ) (list rpx (+ rpy width1p) 0 )
      (list ( - (/ 949. 5)) (+ rpy width1p  150))
      )
      
      (command "dimlinear";;; lock cutout dimensions
      (list rpx (+ rpy width1p) 0 ) (list (- rpx 920) (- (+ rpy width1p ) 122.4) 0)
       (list (- rpx (/ 920 2 )) (+ (+ rpy width1p ) 75) 0)   
      )
      (command "clayer" "doors")

    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- rpx height1) 199) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 301) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 983) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1085) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 1767) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1869) (+ rpy 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- rpx 18) (+ rpy 43.5) 0) (list (- rpx 33) (+ rpy 58.5) 0) )
      
      
 
      (entmake (list (cons 0 "circle") (cons 10 (list (- rpx 25) (-  (+ rpy width1p ) 87.4) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (-  rpx height1) 25) (-  (+ rpy width1p ) 87.4) 0)) (cons 40 3)))
      
      (setq n1 (- height1 108))
      (while (< 120 n1)
      (progn
        (entmake (list (cons 0 "circle") (cons 10 (list (+ ( - rpx height1 ) n1) (- (+ rpy width1p) 87.4) 0 )) (cons 40 3)))
        (setq n1 (- n1 120))
      );;progn
      );;While
      
      
  ;;;;
   (command "rectang" (list (+ (- rpx height1) 10) rpy 0)  (list (+ (- rpx height1) 30) (+ rpy 15 ) 0))
   (command "rectang" (list (+ (- rpx height1) 220) rpy 0)  (list (+ (- rpx height1) 240) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  10) rpy 0)  (list (- rpx  30) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  220) rpy 0)  (list (- rpx 240) (+ rpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy 2) 0 )
        (list (- rpx  12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy 2) 0 )
        (list (- rpx  222) (-  rpy 2) 0 )
        "" ""
      )
      
   (command "rectang" (list (+ (- rpx height1) 10) (+ rpy width1p) 0)  (list (+ (- rpx height1) 30) (- (+ rpy width1p) 15) 0))
   (command "rectang" (list (+ (- rpx height1) 220) (+ rpy width1p) 0)  (list (+ (- rpx height1) 240) (- (+ rpy width1p) 15) 0))
   (command "rectang" (list ( - rpx  10) (+ rpy width1p) 0)  (list (- rpx  30) (- (+ rpy width1p) 15) 0))
   (command "rectang" (list ( - rpx  220) (+ rpy width1p) 0)  (list (- rpx 240) (- (+ rpy width1p) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy width1p 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) ( - (+ rpy  width1p) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy  width1p 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) ( - (+ rpy  width1p) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy  width1p 2) 0 )
        (list (- rpx  12) ( - (+ rpy  width1p) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy width1p 2) 0 )
        (list (- rpx  222) ( - (+ rpy  width1p) 2) 0 )
        "" ""
      )
      
  ;;;;  
      
      
      
  ;; End of Right push panel ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
  ;; Start of left push lid
      
      (setvar "clayer" "doors")
      (command "rectang"  (list llx lly 0) (list (- llx height1) (+ lly width2l) 0));;lid cutout
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      (command "dimlinear" (list llx (+ lly width2l) 0) (list (- llx height1) (+ lly width2l) 0)  (list (/(- llx height1)2) (+ lly width2l 100)0))
      (command "dimlinear" (list (- llx height1) lly ) (list (- llx height1 ) (+ lly width2l) 0) (list (- (- llx height1) 100) (/ (+ lly width2l) 2) 0))
      (setvar "clayer" "doors")
      
      
      
      
      (command "clayer" "doors")
      
    ;;door handle holes
      (entmake (list (cons 0 "circle")  (cons  10 (list (- llx 1095) (- (+ lly width2l) 83.5  ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- llx 1395) (- (+ lly width2l) 83.5  ) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- llx 1095) (- (+ lly width2l) 83.5 ) 0)(list (- llx 1395) (- (+ lly width2l) 83.5 )0)
      (list (- llx 12450) (- (+ lly width2l) 103.5 ) 0)
      )
      
      (command "clayer" "doors")
      
      (setq n2 (- height1 108) )
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 18) (- (+ lly width2l) 32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 18) (+ lly width2l)  0)) (cons 40 8)))
      (command "trim" "" "fence" 
      (list (- llx 18) (+ lly width2l 9)  0)
      (list (- llx 18) (- (+ lly width2l ) 2) 0)
      "" "")
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1 ) 18) (- (+ lly width2l ) 32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1 ) 18) (+ lly width2l )  0)) (cons 40 8)))
        (command "trim" "" "fence" 
      (list (+ (- llx height1 ) 18)  (+ lly width2l 9)  0)
      (list (+ (- llx height1 ) 18)  (- (+ lly width2l) 2) 0)
      "" "")
      
      (while (< 110 n2)
      (progn
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1) n2) (- (+ lly width2l) 32) 0)) (cons 40 3)))
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- llx height1) n2) (+ width2l lly) 0)) (cons 40 8)))
          (command "trim" "" "fence" 
          (list (+ (- llx height1 ) n2)  (+ lly width2l 9)  0)
          (list (+ (- llx height1 ) n2)  (- (+ lly width2l ) 2) 0)
          "" "")
      
        
        (setq n2 (- n2 120))
      );;progn
      );;while
     
    ;; End of left Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
      
     
        
    ;;Start of left Push Panel
      
      
    (command "rectang" (list lpx lpy 0) (list (- lpx height1) (+ lpy width2p) 0 )); panel cutout
   
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear" (list (- lpx height1) (+ lpy width2p) 0) (list (- lpx height1) lpy 0) 
    (list (- (- lpx height1)100) (/ (+ lpy width2p )2 )0)) ;; panel width dimensions
      
   
    (setvar "clayer" "doors")
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx 1095 ) (+  lpy 142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1393) (+ lpy  142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1397) (+ lpy  142.4) 0)) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  142.4 4) 0)) (cons 11 (list (- lpx 1397) (+ lpy 142.4 4) 0))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  138.4) 0)) (cons 11 (list (- lpx 1397) (+ lpy  138.4) 0))))
   
    (command "trim" "" "fence"  
    (list (- lpx 1392) (+ lpy  138.7) 0) (list (- lpx 1398) (+ lpy 138.65) 0)
    (list (- lpx 1392) (+ lpy  142.4) 0) (list (- lpx 1398) (+ lpy  142.4) 0)
    (list (- lpx 1392) (+ lpy  146.15) 0) (list (- lpx  1398) (+ lpy  146.15) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list (- lpx 1095) (+ lpy 142.4) 0) (list lpx lpy 0)
      (list (- lpx (/ 1095 2)) (-  lpy 250))
      )
      
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout  
      
      (command "rectang" (list (- lpx 868.75) (+ lpy  39.6)0)  (list (- lpx 1030.75) (+ lpy  61.8)0))
     
      
       (command "clayer" "dimensions")
      
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - lpx 949.75)  (+ lpy  50.7) 0 ) (list lpx  lpy  0 )
      (list ( - (/ 949. 5)) (- lpy  150))
      )
      
      
      (command "clayer" "doors")

    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- lpx height1) 199) (- (+ lpy width2p ) 42.16) 0)  (list (+ (- lpx height1) 301) (- (+ lpy width2p) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 983) (- (+ lpy width2p) 42.16) 0)  (list (+ (- lpx height1) 1085) (- (+ lpy width2p ) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 1767) (- (+ lpy width2p)42.16) 0)  (list (+ (- lpx height1) 1869) (- (+ lpy width2p ) 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- lpx 18) (- (+ lpy width2p) 43.5) 0) (list (- lpx 33) (- (+ lpy width2p )58.5) 0) )
      (command "rectang" (list (+ (- lpx height1) 199.25) (+ lpy 38.25) 0) (list (+ (- lpx height1 ) 369.75) (+ lpy 63.75)  0))
       
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (command "rectang" (list (+ (- lpx height1) 10) lpy 0)  (list (+ (- lpx height1) 30) (+ lpy 15 ) 0))
   (command "rectang" (list (+ (- lpx height1) 220) lpy 0)  (list (+ (- lpx height1) 240) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  10) lpy 0)  (list (- lpx  30) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  220) lpy 0)  (list (- lpx 240) (+ lpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy 2) 0 )
        (list (- lpx  12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy 2) 0 )
        (list (- lpx  222) (-  lpy 2) 0 )
        "" ""
      )
   (command "rectang" (list (+ (- lpx height1) 10) (+ lpy width2p) 0)  (list (+ (- lpx height1) 30) (- (+ lpy width2p) 15) 0))
   (command "rectang" (list (+ (- lpx height1) 220) (+ lpy width2p) 0)  (list (+ (- lpx height1) 240) (- (+ lpy width2p) 15) 0))
   (command "rectang" (list ( - lpx  10) (+ lpy width2p) 0)  (list (- lpx  30) (- (+ lpy width2p) 15) 0))
   (command "rectang" (list ( - lpx  220) (+ lpy width2p) 0)  (list (- lpx 240) (- (+ lpy width2p) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy width2p 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) ( - (+ lpy  width2p) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy  width2p 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) ( - (+ lpy  width2p) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy  width2p 2) 0 )
        (list (- lpx  12) ( - (+ lpy  width2p) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy width2p 2) 0 )
        (list (- lpx  222) ( - (+ lpy  width2p) 2) 0 )
        "" ""
      )
      
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Top C and Bottom C ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;start of bottom and top c 
  
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 3000))
    (setq tpcy 4200)
    (setq bpcx (+ x 3000))
    (setq bpcy 3100)

    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter1 0.25)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 0.25)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 0.25))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter1 0.25)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 0.25))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter1 0.25))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter1 0.25))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter1 0.25))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter1 0.25))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 0.25)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 0.25))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 0.25))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter1 0.25)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter1 0.25) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter1  8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter1  8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter1  8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter1  8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter1  8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter1  8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter1  8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
      
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  
      
  (setvar "clayer" "doors")
      
      (setq tpcx (+ x 7000))
    (setq tpcy 4200)
    (setq bpcx (+ x 7000))
    (setq bpcy 3100)

    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter2 1.75)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter2 1.75)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter2 1.75))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter2 1.75)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter2 1.75))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter2 1.75))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter2 1.75))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter2 1.75))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter2 1.75))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter2 1.75)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter2 1.75))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter2 1.75))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter2 1.75)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter2 1.75) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
      
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter2  8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter2  8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter2  8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter2  8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter2  8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter2  8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter2  8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
      
  
      
    ;; End of left push panel ;;  
    )
    )
    
    (setvar "clayer" "template")
  
    ;end of right push
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door UNequal Door LEFT Push;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
  
    
    ;start of left push 
    (if (= (atoi doororie) 1 )
    (progn 
      (alert (strcat "Double Door Unequal Left Push"))
      (entmake (list (cons 0 "text") (cons 10 (list (+ x 100) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Right Inactive Push Shutter"))))
      (entmake (list (cons 0 "text") (cons 10 (list (+ x 3860) (+ y 8790) 0)) (cons 40 180) (cons 50 0) (cons 1 (strcat "Left Active Push Shutter"))))
      
      (setvar "clayer" "doors")
      
       (setq rlx (+ x 3500) 
            rly (+ y 7000)
            rpx (+ x 3500)
            rpy (+ y 5200)
            llx (+ x 7200)
            lly (+ y 7000)
            lpx (+ x 7200)
            lpy (+ y 5200))
      
      
      (setq shutter1 (* (- width 90) 0.25))
      (setq shutter2 (* (- width 90) 0.75))
      
      (setq width1l (+ shutter1 30.25 ))
      (setq width1p (+ shutter1 148.05 ))
      
      (setq width2l (+ shutter2 28.75))
      (setq width2p (+ shutter2 146.55 ))
      
      (setq height1 (- height 47))
      
      
        ;; Start of Right push lid
      (setvar "clayer" "doors")
      (command "rectang"  (list rlx rly 0) (list (- rlx height1) (+ rly width1l) 0));;lid cutout
      
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      
      (command "dimlinear" (list rlx (+ rly width1l )  0) (list (- rlx height1) (+ rly width1l) 0)
      (list (/(- rlx height1) 2) (+ rly width1l 100) 0 ))
      
      (command "dimlinear" (list (- rlx height1) rly ) (list (- rlx (-  height 47)) (+ rly width1l) 0)
      (list (- (- rlx height1) 100) (/ (+ rly width1l) 2) 0 ))
      
      (setvar "clayer" "doors")
      
    
      
      (command "clayer" "doors")
      
    ;;door handle holes
      
      (entmake (list (cons 0 "circle")  (cons  10 (list (- rlx 1095) (+ rly 83.5 ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- rlx 1395) (+ rly 83.5) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- rlx 1095) (+ rly 83.5) 0)(list (- rlx 1395) (+ rly 83.5)0)
      (list (- rlx 12450) (+ rly 103.5) 0)
      )
      
      (command "clayer" "doors")
      
      
      (setq n2 (- height1 108) )
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 18)  (+ rly 32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- rlx 18)  rly  0)) (cons 40 8)))
      (command "trim" "" "fence" 
      (list (- rlx 18) (- rly  9)  0)
      (list (- rlx 18)(+ rly  2) 0)
      "" "")
      
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1 ) 18) (+ rly  32) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1 ) 18)  rly 0)) (cons 40 8)))
        (command "trim" "" "fence" 
      (list (+ (- rlx height1 ) 18)  (- rly 9)  0)
      (list (+ (- rlx height1 ) 18)  (+ rly 2) 0)
      "" "")
      
      (while (< 110 n2)
      (progn
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1) n2)  (+ rly 32) 0)) (cons 40 3)))
        (entmake (list (cons 0 "circle") (cons 10 (list (+ (- rlx height1) n2)  rly 0)) (cons 40 8)))
          (command "trim" "" "fence" 
          (list (+ (- rlx height1 ) n2)  (- rly 9)  0)
          (list (+ (- rlx height1 ) n2) (+ rly 2) 0)
          "" "")
      
        
        (setq n2 (- n2 120))
      );;progn
      );;while
    
    ;; End of Right Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      
      ;;Start of Right Push Panel
    (command "rectang" (list rpx rpy 0) (list (- rpx height1) (+ rpy width1p) 0 )); panel cutout
   
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear"
    (list (- rpx height1) (+ rpy width1p ) 0) (list (- rpx height1) rpy 0) 
    (list (- (- rpx height1)100)  ( + rpy width1p )  0)
    ) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
   
   
      
    (setvar "clayer" "doors" )
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx 1095 ) (+ rpy (- width1p 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1393) (+ rpy (- width1p 142.4) 0))) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- rpx  1397) (+ rpy (- width1p 142.4) 0))) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- width1p 142.4 4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- width1p 142.4 4) 0)))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- rpx 1393) (+ rpy (- width1p 138.4)) 0)) (cons 11 (list (- rpx 1397) (+ rpy (- width1p 138.4) 0)))))
   
    (command "trim" "" "fence"  
    (list (- rpx 1392) (+ rpy (- width1p 138.7)) 0) (list (- rpx 1398) (+ rpy (- width1p 138.65)) 0)
    (list (- rpx 1392) (+ rpy (- width1p 142.4)) 0) (list (- rpx 1398) (+ rpy (- width1p 142.4)) 0)
    (list (- rpx 1392) (+ rpy (- width1p 146.15)) 0) (list (- rpx  1398) (+ rpy (- width1p 146.15)) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      
      (command "dimlinear"
      (list (- rpx 1095) (- (+ rpy width1p ) 142.4) 0) (list rpx (+ rpy width1p) 0)
      (list (- rpx (/ 1095 2)) (+ rpy width1p  250) 0)
      )
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout 
      (command "rectang" (list (- rpx 868.75) (+ rpy (- width1p 39.6)0))  (list (- rpx 1030.75) (+ rpy (- width1p 61.8))0))

       (command "clayer" "dimensions")
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - rpx 949.75) (- (+ rpy width1p) 50.7) 0 ) (list rpx (+ rpy width1p) 0 )
      (list ( - (/ 949. 5)) (+ rpy width1p  150))
      )
   (command "clayer" "doors")
    ;;;;

   ;;; hinges 
      (command "rectang" (list (+ (- rpx height1) 199) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 301) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 983) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1085) (+ rpy 76.2)0)   )
      (command "rectang" (list (+ (- rpx height1) 1767) (+ rpy 42.16) 0)  (list (+ (- rpx height1) 1869) (+ rpy 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- rpx 18) (+ rpy 43.5) 0) (list (- rpx 33) (+ rpy 58.5) 0) )
      
      
  ;;;;
   (command "rectang" (list (+ (- rpx height1) 10) rpy 0)  (list (+ (- rpx height1) 30) (+ rpy 15 ) 0))
   (command "rectang" (list (+ (- rpx height1) 220) rpy 0)  (list (+ (- rpx height1) 240) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  10) rpy 0)  (list (- rpx  30) (+ rpy 15 ) 0))
   (command "rectang" (list ( - rpx  220) rpy 0)  (list (- rpx 240) (+ rpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy 2) 0 )
        (list (- rpx  12) (-  rpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy 2) 0 )
        (list (- rpx  222) (-  rpy 2) 0 )
        "" ""
      )
   (command "rectang" (list (+ (- rpx height1) 10) (+ rpy width1p) 0)  (list (+ (- rpx height1) 30) (- (+ rpy width1p) 15) 0))
   (command "rectang" (list (+ (- rpx height1) 220) (+ rpy width1p) 0)  (list (+ (- rpx height1) 240) (- (+ rpy width1p) 15) 0))
   (command "rectang" (list ( - rpx  10) (+ rpy width1p) 0)  (list (- rpx  30) (- (+ rpy width1p) 15) 0))
   (command "rectang" (list ( - rpx  220) (+ rpy width1p) 0)  (list (- rpx 240) (- (+ rpy width1p) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 12) (+  rpy width1p 2) 0 )
        (list (+ (- rpx (-  height 47)) 12) ( - (+ rpy  width1p) 2)  0 )
        "" "" )
      
      (command "trim" "" "fence"  
        (list (+ (- rpx (-  height 47)) 222) (+  rpy  width1p 2) 0 )
        (list (+ (- rpx (-  height 47)) 222) ( - (+ rpy  width1p) 2) 0 )
        "" "")
      
      
      (command "trim" "" "fence"  
        (list (- rpx  12) (+  rpy  width1p 2) 0 )
        (list (- rpx  12) ( - (+ rpy  width1p) 2) 0 )
        "" "")
      
      
      (command "trim" "" "fence"  
        (list  (- rpx  222) (+  rpy width1p 2) 0 )
        (list (- rpx  222) ( - (+ rpy  width1p) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
      
  ;; End of Right push panel ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; Start of left push lid
      
      (setvar "clayer" "doors")
      (command "rectang"  (list llx lly 0) (list (- llx height1) (+ lly width2l) 0));;lid cutout
      (command "-dimstyle" "restore" "100")
      (setvar "clayer" "dimensions")
      (command "dimlinear" (list llx (+ lly width2l) 0) (list (- llx height1) (+ lly width2l) 0)  (list (/(- llx height1)2) (+ lly width2l 100)0))
      (command "dimlinear" (list (- llx height1) lly ) (list (- llx height1 ) (+ lly width2l) 0) (list (- (- llx height1) 100) (/ (+ lly width2l) 2) 0))
      (setvar "clayer" "doors")
      (command "rectang"  (list (- llx 1150)  (+ lly (- (/ width2l 2) 175))  0 ) (list (- llx 1900) (+ lly (+ (/ width2l 2) 175)) 0 )) ;window cutout 
      (command "-dimstyle" "restore" "50")
      (command "clayer" "dimensions")
      (command "dimlinear"
      (list  (- llx 1150) (+ lly (/ width2l 2) 175) 0) (list (- llx 1900 ) (+ lly (/ width2l 2) 175) 0)
      (list (- llx 1525 ) (+ lly (/ width2l 2) 225) 0)
      )
      
      
      (command "dimlinear"
      (list  (- llx 1900) (+ lly (/ width2l 2) 175) 0 )(list  (- llx 1900) (- (+ lly (/ width2l 2)) 175) 0 )
      (list  (- llx 1950) (+ lly (/ width2l 2) ) 0 )       
      )
      
      (command "clayer" "doors")
      
    ;;door handle holes
      
      (entmake (list (cons 0 "circle")  (cons  10 (list (- llx 1095) (- (+ lly width2l) 83.5  ) 0)) (cons 40 8)))
      (entmake (list (cons 0 "circle")  (cons  10  (list (- llx 1395) (- (+ lly width2l) 83.5  ) 0)) (cons 40 8)))
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear" ;;; door handle dimensions
      (list (- llx 1095) (- (+ lly width2l) 83.5 ) 0)(list (- llx 1395) (- (+ lly width2l) 83.5 )0)
      (list (- llx 12450) (- (+ lly width2l) 103.5 ) 0)
      )
      
      (command "clayer" "doors")
      
    ;; lock cutout
      
      (command "rectang" (list (- llx 902.5) (- (+ lly width2l) 53.5) 0) (list (- llx 937.5) ( - (+ lly width2l ) 73.5 ) 0))
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 920) (- (+ lly width2l ) 46.75) 0)) (cons 40 1.5)))
      (entmake (list (cons 0 "circle") (cons 10 (list (- llx 920) (- (+ lly width2l ) 80.25) 0)) (cons 40 1.5)))
      
      
      
     
    ;; End of left Push lid ;;
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
      
     
        
    ;;Start of left Push Panel
      
      
    (command "rectang" (list lpx lpy 0) (list (- lpx height1) (+ lpy width2p) 0 )); panel cutout
    (command "rectang" (list (- lpx 1150) (+ lpy (- (/ width2p 2) 175))0) (list (- lpx 1900) (+ lpy (+ (/ width2p 2) 175))0));; window cutout
    
    (command "-dimstyle" "restore" "100")
    (setvar "clayer" "dimensions")
      
    (command "dimlinear" (list (- lpx height1) (+ lpy width2p) 0) (list (- lpx height1) lpy 0) 
    (list (- (- lpx height1)100) (/ (+ lpy width2p )2 )0)) ;; panel width dimensions
      
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list (-  lpx 1150) (- (+ lpy (/ width2p 2)) -175) 0) (list lpx (- (+ lpy (/ width2p 2)) -175) 0)
    (list (- lpx (/ 1150)) (- (+ lpy (/ width2p 2)) -175) 0 )
    )
    (setvar "clayer" "doors")
      
      ;; door handle cutout
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx 1095 ) (+  lpy 142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1393) (+ lpy  142.4) 0)) (cons 40 4 )))
    (entmake (list (cons 0 "circle") (cons 10 (list (- lpx  1397) (+ lpy  142.4) 0)) (cons 40 4 ))) 
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  142.4 4) 0)) (cons 11 (list (- lpx 1397) (+ lpy 142.4 4) 0))))
    (entmake (list (cons 0 "line" )  (cons 10 (list (- lpx 1393) (+ lpy  138.4) 0)) (cons 11 (list (- lpx 1397) (+ lpy  138.4) 0))))
   
    (command "trim" "" "fence"  
    (list (- lpx 1392) (+ lpy  138.7) 0) (list (- lpx 1398) (+ lpy 138.65) 0)
    (list (- lpx 1392) (+ lpy  142.4) 0) (list (- lpx 1398) (+ lpy  142.4) 0)
    (list (- lpx 1392) (+ lpy  146.15) 0) (list (- lpx  1398) (+ lpy  146.15) 0) ""  "")
      
      (setvar "clayer" "dimensions")
      (command "-dimstyle" "restore" "50")
      (command "dimlinear"
      (list (- lpx 1095) (+ lpy 142.4) 0) (list lpx lpy 0)
      (list (- lpx (/ 1095 2)) (-  lpy 250))
      )
      
    (command "clayer" "doors")
      
      ;;;;;
      
   ;;lock cutout  
      
      (command "rectang" (list (- lpx 868.75) (+ lpy  39.6)0)  (list (- lpx 1030.75) (+ lpy  61.8)0))
      (command "rectang" (list (- lpx 902.5)  (+ lpy  112.40)) (list (- lpx 937.5)  (+ lpy 132.4)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- lpx 920) (+ lpy 139.15) 0 )) (cons 40 1.5)))
      (entmake (list (cons  0 "circle") (cons 10 (list (- lpx 920) (+ lpy 105.65) 0 )) (cons 40 1.5)))
      
       (command "clayer" "dimensions")
      
      (command "dimlinear" ;;; lock cutout dimensions
      (list ( - lpx 949.75)  (+ lpy  50.7) 0 ) (list lpx  lpy  0 )
      (list ( - (/ 949. 5)) (- lpy  150))
      )
      
      (command "dimlinear";;; lock cutout dimensions
      (list lpx lpy  0 ) (list (- lpx 920) (+ lpy  122.4)0 )
       (list (- lpx (/ 920 2 )) (- lpy  75) 0)   
      
      (command "clayer" "doors")
 )
    ;;;;
               
      
      
 

   ;;; hinges 
      (command "rectang" (list (+ (- lpx height1) 199) (- (+ lpy width2p ) 42.16) 0)  (list (+ (- lpx height1) 301) (- (+ lpy width2p) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 983) (- (+ lpy width2p) 42.16) 0)  (list (+ (- lpx height1) 1085) (- (+ lpy width2p ) 76.2)0)   )
      (command "rectang" (list (+ (- lpx height1) 1767) (- (+ lpy width2p)42.16) 0)  (list (+ (- lpx height1) 1869) (- (+ lpy width2p ) 76.2)0)   )   
  ;;;
      
      (command "rectang" (list (- lpx 18) (- (+ lpy width2p) 43.5) 0) (list (- lpx 33) (- (+ lpy width2p )58.5) 0) )
      
      
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   (command "rectang" (list (+ (- lpx height1) 10) lpy 0)  (list (+ (- lpx height1) 30) (+ lpy 15 ) 0))
   (command "rectang" (list (+ (- lpx height1) 220) lpy 0)  (list (+ (- lpx height1) 240) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  10) lpy 0)  (list (- lpx  30) (+ lpy 15 ) 0))
   (command "rectang" (list ( - lpx  220) lpy 0)  (list (- lpx 240) (+ lpy 15 ) 0))
      
  (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy 2) 0 )
        (list (- lpx  12) (-  lpy 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy 2) 0 )
        (list (- lpx  222) (-  lpy 2) 0 )
        "" ""
      )
               
   (command "rectang" (list (+ (- lpx height1) 10) (+ lpy width2p) 0)  (list (+ (- lpx height1) 30) (- (+ lpy width2p) 15) 0))
   (command "rectang" (list (+ (- lpx height1) 220) (+ lpy width2p) 0)  (list (+ (- lpx height1) 240) (- (+ lpy width2p) 15) 0))
   (command "rectang" (list ( - lpx  10) (+ lpy width2p) 0)  (list (- lpx  30) (- (+ lpy width2p) 15) 0))
   (command "rectang" (list ( - lpx  220) (+ lpy width2p) 0)  (list (- lpx 240) (- (+ lpy width2p) 15) 0))
       (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 12) (+  lpy width2p 2) 0 )
        (list (+ (- lpx (-  height 47)) 12) ( - (+ lpy  width2p) 2)  0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (+ (- lpx (-  height 47)) 222) (+  lpy  width2p 2) 0 )
        (list (+ (- lpx (-  height 47)) 222) ( - (+ lpy  width2p) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list (- lpx  12) (+  lpy  width2p 2) 0 )
        (list (- lpx  12) ( - (+ lpy  width2p) 2) 0 )
        "" ""
      )
      
      (command "trim" "" "fence"  
        (list  (- lpx  222) (+  lpy width2p 2) 0 )
        (list (- lpx  222) ( - (+ lpy  width2p) 2) 0 )
        "" ""
      )
      
  ;;;;      
      
               
      (entmake (list (cons 0 "circle") (cons 10 (list (- lpx 25) (+  lpy 87.4) 0)) (cons 40 3)))
      (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lpx height1) 25) (+  lpy 87.4) 0)) (cons 40 3)))
               
               
      (setq n4 0)
      (setq n4 (- height1 108))
               
      (while (< 120 n4)
      (progn
       (entmake (list (cons 0 "circle") (cons 10 (list (+ (- lpx height1) n4) (+  lpy 87.4) 0)) (cons 40 3))) 
        (setq n4 (- n4 120))
        
      );;progn
      );;while
  
;; End of left push panel ;;
    )
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Top C and Bottom C ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;start of bottom and top c 
  
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 3000))
    (setq tpcy 4200)
    (setq bpcx (+ x 3000))
    (setq bpcy 3100)

    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 1.75))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter1 1.75)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 1.75))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 1.75))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter1 1.75)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter1 1.75) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter1  8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter1  8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter1  8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter1  8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter1  8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter1  8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter1  8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  Start of Double door Top C and Bottom C ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;;start of bottom and top c 
  
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 3000))
    (setq tpcy 4200)
    (setq bpcx (+ x 3000))
    (setq bpcy 3100)

    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 1.75))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter1 1.75)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 1.75))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter1 1.75))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter1 1.75))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter1 1.75))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter1 1.75)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter1 1.75) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter1  8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter1  8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter1  8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter1  8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter1  8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter1  8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter1  8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter1  8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter1  8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;start of bottom and top c 
  
    (setvar "clayer" "doors")
    
    (setq tpcx (+ x 7000))
    (setq tpcy 4200)
    (setq bpcx (+ x 7000))
    (setq bpcy 3100)

    ;; start of topc 
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11 (list (+ (- tpcx ( - shutter2 0.25)) 22) tpcy 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy  80) 0)) (cons 11 (list (+ (- tpcx ( - shutter2 0.25)) 22) (+ tpcy 80) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) tpcy 0)) (cons 11(list (- tpcx 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 20.5) 0)) (cons 11 (list tpcx (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list tpcx (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx 22) (+ tpcy 59.5) 0)) (cons 11 (list (- tpcx 22) (+ tpcy 80) 0))))
             
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter2 0.25))  22) tpcy 0)) (cons 11(list (+ (- tpcx ( - shutter2 0.25)) 22) (+ tpcy 20.5) 0)  )))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter2 0.25))  22) (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter2 0.25))  (+ tpcy 20.5) 0)) ))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter2 0.25))  (+ tpcy 20.5) 0)) (cons 11 (list (- tpcx ( - shutter2 0.25))  (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- tpcx ( - shutter2 0.25))  (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter2 0.25)) 22) (+ tpcy 59.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- tpcx ( - shutter2 0.25))  22) (+ tpcy 59.5) 0)) (cons 11 (list (+ (- tpcx ( - shutter2 0.25))  22) (+ tpcy 80) 0))))
    
    (setvar "clayer" "dimensions")
    (command "-dimstyle" "restore" "50")
    (command "dimlinear" 
    (list tpcx (+ tpcy 20.5) 0) (list (- tpcx ( - shutter2 0.25)) (+ tpcy 20.5) 0)
    (list (- tpcx (/ ( - shutter2 0.25) 2)) (- tpcy 100) 0)
    )
    
    (command "clayer" "doors")
    ;;end of topc
    
    ;; start of bottom c
    
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) bpcy 0)) (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) bpcy  0))))
    (entmake (list (cons 0 "line") ( cons 10 (list (- bpcx 23.75) (+ bpcy 106.5) 0)) (cons 11 (list (+ (- bpcx( - shutter2  8.5 )) 23.75)(+  bpcy 106.5 ) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) bpcy 0))  (cons 11 (list (- bpcx 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 33.5) 0)) (cons 11 (list bpcx (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list bpcx (+ bpcy 73) 0))   (cons 11 (list (- bpcx 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx 23.75) (+ bpcy 73) 0)) (cons 11 (list (- bpcx 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) bpcy 0))  (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 33.5) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter2  8.5 ))(+ bpcy 33.5) 0)) (cons 11 (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 73) 0))   (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 73) 0))))
    (entmake (list (cons 0 "line") (cons 10 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 73) 0)) (cons 11 (list (+ (- bpcx ( - shutter2  8.5 )) 23.75) (+ bpcy 106.5) 0))))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter2  8.5 )) 95.75) (+ bpcy 98.5) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter2  8.5 ) 2)) (+ bpcy 98.5) 0))  (cons 40 4)))
    
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (+(- bpcx ( - shutter2  8.5 )) 95.75) (+ bpcy 8) 0)) (cons 40 4)))
    (entmake (list (cons 0 "circle") (cons 10 (list (- bpcx (/ ( - shutter2  8.5 ) 2)) (+ bpcy 8) 0))  (cons 40 4)))
    
    (setvar "clayer" "dimensions")
    (command "dimlinear" 
    (list bpcx (+ bpcy 33.5) 0 ) (list (- bpcx ( - shutter2  8.5 )) (+ bpcy 33.5) 0)
    (list ( - bpcx (/ ( - shutter2  8.5 ) 2)) (- bpcy 100) 0)
    )    
    ;;end of bottom c
      
    ;end of left push doos
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    )  
  )
  
  ;end of Double door uneuqal Door
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  
  (setvar "osmode" curos)
  (setvar "cmdecho" 1)

)