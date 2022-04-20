(herald dhca (algebra diffie-hellman))

(defprotocol dhca diffie-hellman
  (defrole init
    (vars (g p x rndx) (a b ca name) (y expt) (n text))
    (trace
     (recv enc ((cat (g p) (enc (g p) (privk b))) pubk a)))
    (uniq-gen x)
    (non-orig (privk a)))
  (defrole resp
    (vars (y rndx) (a b ca name) (x expt) (n text))
    (trace
     (recv (enc (cat (g p) (a) (pubk b))))
     (send enc ((cat (g p) (enc (g p) (privk b))) pubk a)))
    (uniq-gen y)
    (non-orig (privk b)))
  (defrole ca (vars (subject ca name) (x expt))
    (trace
     (send (enc (cat (g p) (a) (pubk b)))))
    (uniq-gen g)
    (uniq-gen p))
  (comment An on the fly diffie-hellman exchange)
)

(defskeleton dhca
  (vars )
  (defstrand init 5 )
(comment Full initiator POV No need to make extra assumptions))

(defskeleton dhca
  (vars (n text))
  (defstrand resp 5 (n n))
  (uniq-orig n)
  (comment Full responder point of view with freshly chosen n)
)

(defskeleton dhca
  (vars (a b ca name) (x y rndx) (n text))
  (defstrand init 5 (x x) (y y) (ca ca) (a a) (b b) (n n))
  (defstrand resp 5 (y y) (x x) (ca ca) (a a) (b b) (n n))
(uniq-orig n)
(comment point of view in which init and resp each complete and
    they agree on the relevant parameters)
)
