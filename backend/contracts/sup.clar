
;; sup
;; Smart contract to handle writing a message to the blockchain
;; in exchange for a small fee in STX

;; constants

;; my wallet SP2SSXVE9VR65TZ8EWC5BRBYHTCXENZ5Y8S0P3WWJ
(define-constant receiver-address 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM)

;;

;; data maps and vars

(define-data-var total-sups uint u0)
(define-map messages principal (string-utf8 500))

;;

;; private functions
;;

;; public functions

(define-read-only (get-sups)
  (var-get total-sups)
)

(define-read-only (get-message (who principal))
    (map-get? messages who)
)


(define-public (write-sup (message (string-utf8 500)) (price uint))
    (begin
        (try! (stx-transfer? price tx-sender receiver-address))
        ;; #[allow(unchecked_data)]
        (map-set messages tx-sender message )

        (var-set total-sups (+ (var-get total-sups) u1))

        (ok "Sup written successfully")
    )
)

;;
