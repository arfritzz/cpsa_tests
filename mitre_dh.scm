(herald "Plain diffie-hellman protocol with challenge-response" (algebra diffie-hellman)
; (limit 1)
)

(defprotocol plaindh diffie-hellman
  (defrole init
    (vars (x rndx) (y expt) (n text))
    (trace (send (exp (gen) x))
           (recv (exp (gen) y))
           (send (enc n (exp (gen) (mul x y))))
           (recv n))
    (uniq-orig n)
    (uniq-gen x))
  (defrole resp
    (vars (y rndx) (x expt) (n text))
    (trace (recv (exp (gen) x))
           (send (exp (gen) y))
           (recv (enc n (exp (gen) (mul x y))))
           (send n))
    (uniq-gen y))
  (comment "Diffie-hellman key exchange followed by an encryption"))

(defskeleton plaindh
  (vars )
  (defstrand init 4))

(defskeleton plaindh
  (vars )
  (defstrand resp 4))

(defskeleton plaindh
  (vars (x y rndx) )
  (defstrand resp 4 (x x) (y y))
  (defstrand init 4 (x x) (y y))
;;  (uniq-gen x)
;;  (uniq-gen y)
;;  (uniq-gen g)
(comment point of view in which init and resp each complete and they agree on the relevant parameters)
)