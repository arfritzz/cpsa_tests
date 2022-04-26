(herald dhca (algebra diffie-hellman))
;;(herald "dhca" (comment "flaw"))

(defprotocol dhca diffie-hellman
  (defrole ca (vars (subject a b ca name) (g rndx) (x expt))
    (trace
     (send (enc g a (pubk b))))
    (uniq-gen g))
  (defrole resp
    (vars (y g rndx) (a b ca name) (x expt))
    (trace
     (recv (enc g a (pubk b)))
     (send (enc g (enc g (privk b)) (pubk a))))
    (uniq-gen y)
    (non-orig (privk b)))
  (defrole init
    (vars (x g rndx) (a b ca name) (y expt))
    (trace
     (recv (enc g (enc g (privk b)) (pubk a))))
    (uniq-gen x)
    (non-orig (privk a)))
  (comment An on the fly diffie-hellman exchange)
)

(defskeleton dhca
  (vars )
  (defstrand init 1 )
(comment Full initiator POV No need to make extra assumptions))

(defskeleton dhca
  (vars )
  (defstrand resp 2 )
  (comment Full responder point of view with freshly chosen n)
)

(defskeleton dhca
  (vars (a b ca name) (x y g rndx))
  (defstrand resp 2 (g g) (a a) (b b))
  (defstrand init 1 (g g) (a a) (b b))
;;  (uniq-gen x)
;;  (uniq-gen y)
;;  (uniq-gen g)
(comment point of view in which init and resp each complete and
    they agree on the relevant parameters)
)
