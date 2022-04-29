;; reg is offline.. no one can listen
(defprotocol xiang_zheng basic
  (defrole init
    (vars (a b name) (rg rc ra text) (t1 t2 text))
    (trace
       (send a)
       (recv (cat (enc b t1 rg (hash a rc)) (hash b t1 rg)))
       (send (cat (enc a t2 ra (hash a b rc)) (hash a t2 ra)))
       )
    )
  (defrole resp
    (vars (a b name) (rg rc ra text) (t1 t2 text))
    (trace
       (recv a)
       (send (cat (enc b t1 rg (hash a rc)) (hash b t1 rg)))
       (recv (cat (enc a t2 ra (hash a b rc)) (hash a t2 ra)))
       ))
)

(defskeleton xiang_zheng
  (vars (a b name) (rg rc ra text) (t1 t2 text))
  (defstrand init 3 (a a) (b b) (ra ra) (t2 t2))
  (uniq-gen ra)
  (uniq-gen t2))

(defskeleton xiang_zheng
  (vars (a b name) (rg rc ra text) (t1 t2 text))
  (defstrand resp 3 (a a) (b b) (rc rc) (rg rg) (t1 t1))
  (uniq-gen rc)
  (uniq-gen rg)
  (uniq-gen t1))

; This skeleton should have a shape, demonstrating that m may be leaked.
; (defskeleton xiang_zheng 
;  (vars (a b name) (rg rc ra text) (t1 t2 text))
;  (defstrand init 3 (a a) (b b) (t1 t1) (t2 t2) (rc rc) (rg rg) (ra ra))
;  (defstrand resp 3 (a a) (b b) (t1 t1) (t2 t2) (rc rc) (rg rg) (ra ra))
;  (uniq-gen ra)
;  (uniq-gen rg)
;  (uniq-gen rc)
 
  ;;(non-orig (ltk a s) (ltk b s))
  ;;(uniq-orig m)
;  )