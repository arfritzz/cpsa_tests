(herald dhca (algebra diffie-hellman))

(defprotocol dhca diffie-hellman
  (defrole ca (vars (subject a b ca name) (g rndx) (x expt))
    (trace
     (send (enc g a (pubk b))))
    (uniq-gen g))
  (defrole resp
    (vars (g y rndx) (a b ca name) (x expt) (n text))
    (trace
     (recv (enc g a (pubk b)))
     (send (enc g (enc g (privk b)) (pubk a))))
    (uniq-gen y)
    (non-orig (privk b)))
  (defrole init
    (vars (g x rndx) (a b ca name) (y expt) (n text))
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

;;(defskeleton dhca
;;  (vars (a b ca name) (x y g rndx) (n text))
;;  (defstrand init 1 (x x) (y y) (g g) (a a) (b b) (n n))
;;  (defstrand resp 2 (y y) (x x) (g g) (a a) (b b) (n n))
;;(uniq-orig n)
;;(comment point of view in which init and resp each complete and
;;    they agree on the relevant parameters)
;;)
