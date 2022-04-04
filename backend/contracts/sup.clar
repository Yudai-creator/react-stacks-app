
;; sup
;; <add a description here>

;; constants

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
