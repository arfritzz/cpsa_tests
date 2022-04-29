; This version of the protocol is modeled properly, with a generic variable (ticket)
(defprotocol kerb-flawed2 basic
  (defrole init
    (vars (a b s name) (ticket mesg) (m n text) (k skey))
    (trace
       ;; Make the request
       (send (cat a b n))
       ;; Receive the encrypted key and ticket
       (recv (cat (enc k n (ltk a s)) ticket))
       (send (cat (enc m k) ticket)))
    (uniq-orig n))
  (defrole resp
    (vars (a b s name) (m text) (k skey))
    (trace
       (recv (cat (enc m k) (enc k a b (ltk b s))))))
  (defrole keyserv
    (vars (a b s name) (m n text) (k skey))
    (trace
       ;; Receive the request
       (recv (cat a b n))
       ;; Send the encrypted key and ticket
       (send (cat (enc k n (ltk a s)) (enc k a b (ltk b s)))))
    (uniq-orig k))
)

; This skeleton should have a shape, demonstrating that m may be leaked.
(defskeleton kerb-flawed2
  (vars (a b s name) (m text))
  (defstrand init 3 (a a) (b b) (s s) (m m))
  (deflistener m)
  (non-orig (ltk a s) (ltk b s))
  (uniq-orig m))