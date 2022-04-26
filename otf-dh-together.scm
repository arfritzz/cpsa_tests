(herald dhca (algebra diffie-hellman))

(defprotocol dhca diffie-hellman
  (defrole ca (vars (subject a b ca name) (g rndx) (x expt))
    (trace
     (send (enc g a (pubk b))))
    (uniq-gen g)
    )
  (defrole resp
    (vars (y rndx) (g base) (a b ca name) (x expt) (n text))
    (trace
     (recv (enc g a (pubk b)))
     (send (enc g (enc g (privk b)) (pubk a)))
     (recv (exp g x))
     (send (exp g y))
     (recv (enc n (exp g (mul x y))))
     (send n))
    (uniq-gen y)
    (non-orig (privk b)))
  (defrole init
    (vars (x rndx) (g base) (a b ca name) (y expt) (n text))
    (trace
     (recv (enc g (enc g (privk b)) (pubk a)))
     (send (exp g x))
     (recv (exp g y))
     (send (enc n (exp g (mul x y))))
     (recv n)
     )
    (uniq-gen x)
    (non-orig (privk a)))
  (comment An on the fly diffie-hellman exchange)
)

(defskeleton dhca
  (vars )
  (defstrand init 5 )
(comment Full initiator POV No need to make extra assumptions))

(defskeleton dhca
  (vars )
  (defstrand resp 6 )
  (comment Full responder point of view with freshly chosen n)
)

(defskeleton dhca
  (vars (a b ca name) (x y rndx) (g base))
  (defstrand resp 6 (x x) (y y) (g g) (a a) (b b))
  (defstrand init 5 (y y) (x x) (g g) (a a) (b b))
;;  (uniq-gen x)
;;  (uniq-gen y)
;;  (uniq-gen g)
(comment point of view in which init and resp each complete and they agree on the relevant parameters)
)