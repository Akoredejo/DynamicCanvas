;; Generative Art NFT Customization Suite
;; A comprehensive smart contract for creating, customizing, and trading generative art NFTs
;; with dynamic trait modification, rarity scoring, and collaborative customization features.
;; Users can mint base NFTs and apply various artistic transformations, filters, and traits
;; to create unique personalized artworks with provable ownership and modification history.

;; constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u100))
(define-constant ERR-NOT-FOUND (err u101))
(define-constant ERR-ALREADY-EXISTS (err u102))
(define-constant ERR-INSUFFICIENT-PAYMENT (err u103))
(define-constant ERR-INVALID-TRAIT (err u104))
(define-constant ERR-CUSTOMIZATION-LOCKED (err u105))
(define-constant ERR-MAX-TRAITS-EXCEEDED (err u106))

(define-constant BASE-MINT-PRICE u1000000) ;; 1 STX base price
(define-constant CUSTOMIZATION-FEE u100000) ;; 0.1 STX per customization
(define-constant MAX-TRAITS-PER-NFT u12)
(define-constant RARITY-MULTIPLIER u150) ;; 1.5x price multiplier for rare traits
(define-constant COLLABORATION-REWARD u50000) ;; 0.05 STX reward for collaborations

;; data maps and vars
(define-data-var next-token-id uint u1)
(define-data-var total-customizations uint u0)
(define-data-var contract-balance uint u0)

(define-map nft-data
  uint ;; token-id
  {
    owner: principal,
    base-template: (string-ascii 50),
    trait-count: uint,
    rarity-score: uint,
    customization-locked: bool,
    creation-block: uint,
    last-modified: uint
  })

(define-map nft-traits
  { token-id: uint, trait-index: uint }
  {
    trait-type: (string-ascii 30),
    trait-value: (string-ascii 50),
    rarity-tier: uint,
    applied-by: principal,
    application-block: uint
  })

(define-map trait-definitions
  (string-ascii 30) ;; trait-type
  {
    base-rarity: uint,
    customization-cost: uint,
    max-applications: uint,
    current-applications: uint,
    creator: principal
  })

(define-map user-stats
  principal
  {
    nfts-owned: uint,
    customizations-applied: uint,
    traits-created: uint,
    collaboration-earnings: uint
  })

;; private functions
(define-private (calculate-rarity-score (token-id uint))
  (let ((trait-count (get trait-count (unwrap-panic (map-get? nft-data token-id))))
        (base-score u100))
    (fold + (map get-trait-rarity (generate-trait-indices token-id trait-count)) base-score)))

(define-private (get-trait-rarity (trait-index uint))
  (let ((trait-data (map-get? nft-traits { token-id: u1, trait-index: trait-index })))
    (match trait-data
      trait (get rarity-tier trait)
      u0)))

(define-private (generate-trait-indices (token-id uint) (count uint))
  (list u0 u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11)) ;; Simplified for max 12 traits

(define-private (update-user-stats (user principal) (stat-type (string-ascii 20)))
  (let ((current-stats (default-to 
                         { nfts-owned: u0, customizations-applied: u0, traits-created: u0, collaboration-earnings: u0 }
                         (map-get? user-stats user))))
    (if (is-eq stat-type "mint")
      (map-set user-stats user (merge current-stats { nfts-owned: (+ (get nfts-owned current-stats) u1) }))
      (if (is-eq stat-type "customize")
        (map-set user-stats user (merge current-stats { customizations-applied: (+ (get customizations-applied current-stats) u1) }))
        true))))

;; public functions
(define-public (mint-base-nft (template (string-ascii 50)))
  (let ((token-id (var-get next-token-id)))
    (asserts! (>= (stx-get-balance tx-sender) BASE-MINT-PRICE) ERR-INSUFFICIENT-PAYMENT)
    
    (try! (stx-transfer? BASE-MINT-PRICE tx-sender CONTRACT-OWNER))
    
    (map-set nft-data token-id {
      owner: tx-sender,
      base-template: template,
      trait-count: u0,
      rarity-score: u100,
      customization-locked: false,
      creation-block: block-height,
      last-modified: block-height
    })
    
    (var-set next-token-id (+ token-id u1))
    (update-user-stats tx-sender "mint")
    
    (ok token-id)))

(define-public (create-trait-definition (trait-type (string-ascii 30)) (rarity uint) (cost uint))
  (begin
    (asserts! (is-none (map-get? trait-definitions trait-type)) ERR-ALREADY-EXISTS)
    (asserts! (<= rarity u100) ERR-INVALID-TRAIT)
    
    (map-set trait-definitions trait-type {
      base-rarity: rarity,
      customization-cost: cost,
      max-applications: u1000,
      current-applications: u0,
      creator: tx-sender
    })
    
    (update-user-stats tx-sender "create-trait")
    (ok true)))

(define-public (apply-customization (token-id uint) (trait-type (string-ascii 30)) (trait-value (string-ascii 50)))
  (let ((nft (unwrap! (map-get? nft-data token-id) ERR-NOT-FOUND))
        (trait-def (unwrap! (map-get? trait-definitions trait-type) ERR-NOT-FOUND))
        (current-trait-count (get trait-count nft))
        (customization-cost (+ CUSTOMIZATION-FEE (get customization-cost trait-def))))
    
    (asserts! (is-eq (get owner nft) tx-sender) ERR-UNAUTHORIZED)
    (asserts! (not (get customization-locked nft)) ERR-CUSTOMIZATION-LOCKED)
    (asserts! (< current-trait-count MAX-TRAITS-PER-NFT) ERR-MAX-TRAITS-EXCEEDED)
    (asserts! (>= (stx-get-balance tx-sender) customization-cost) ERR-INSUFFICIENT-PAYMENT)
    
    (try! (stx-transfer? customization-cost tx-sender CONTRACT-OWNER))
    
    ;; Add trait to NFT
    (map-set nft-traits 
      { token-id: token-id, trait-index: current-trait-count }
      {
        trait-type: trait-type,
        trait-value: trait-value,
        rarity-tier: (get base-rarity trait-def),
        applied-by: tx-sender,
        application-block: block-height
      })
    
    ;; Update NFT data
    (map-set nft-data token-id
      (merge nft {
        trait-count: (+ current-trait-count u1),
        rarity-score: (calculate-rarity-score token-id),
        last-modified: block-height
      }))
    
    ;; Update trait usage
    (map-set trait-definitions trait-type
      (merge trait-def {
        current-applications: (+ (get current-applications trait-def) u1)
      }))
    
    (var-set total-customizations (+ (var-get total-customizations) u1))
    (update-user-stats tx-sender "customize")
    
    (ok { trait-applied: true, new-rarity-score: (calculate-rarity-score token-id) })))


