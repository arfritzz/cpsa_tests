(herald shome (algebra diffie-hellman))

(defprotocol shome diffie-hellman
  (defrole ca 
    (vars (subject a b name) (g t rndx) )
    (trace
     (send (cat a b t g))
     (send (cat a b t g)))
    (uniq-gen g)
    )
  (defrole resp
  ; the responder is hg 
    (vars (r s t y rndx) (g base) (a b name) (x expt) )
    (trace
     (recv (cat a b t g))
     (send (exp g y))
     (recv (exp g x))
     (send (cat (hash t a b r) (enc r (exp g (mul x y)))))
     (recv (cat (hash t a b s r) (enc s (exp g (mul x y))) ))
     (send (enc (hash a b s t) s (exp g (mul x y)))))
    (uniq-gen y)
    (uniq-orig r)
    )
  (defrole init
    (vars (r s t x rndx) (g base) (a b name) (y expt))
    (trace
     (recv (cat a b t g))
     (recv (exp g y))
     (send (exp g x))
     (recv (cat (hash t a b r) (enc r (exp g (mul x y)))))
     (send (cat (hash t a b s r) (enc s (exp g (mul x y)))))
     (recv (enc (hash a b s t) s (exp g (mul x y)))))
    (uniq-gen x)
    (uniq-orig s)
    )
  (comment From "Session-Key Establishment and Authentication in a Smart Home Network Using Public Key Cryptography" )
)

(defskeleton shome
  (vars )
  (defstrand init 6 )
(comment Full initiator POV No need to make extra assumptions))

(defskeleton shome
  (vars )
  (defstrand resp 6 )
  (comment Full responder point of view with freshly chosen n)
)

(defskeleton shome
  (vars (a b name) (x y s r t rndx) (g base))
  (defstrand resp 6 (x x) (y y) (g g) (a a) (b b) (t t) (s s) (r r))
  (defstrand init 6 (y y) (x x) (g g) (a a) (b b) (t t) (s s) (r r))
;;  (uniq-gen x)
;;  (uniq-gen y)
;;  (uniq-gen g)
(comment point of view in which init and resp each complete and they agree on the relevant parameters)
)