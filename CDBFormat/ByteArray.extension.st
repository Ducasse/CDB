Extension { #name : #ByteArray }

{ #category : #'*CDBFormat' }
ByteArray >> cdbHash [
	"Computes and returns the hash value for the given key."

	| h l k |
	h := 5381.
	1 to: self size do: [ :i | 
		l := h << 5.
		h := h + (l bitAnd: 16r00000000ffffffff).
		h := h bitAnd: 16r00000000ffffffff.
		k := self at: i.
		k := k + 16r100 bitAnd: 16rff.
		h := h bitXor: k ].
	^ h bitAnd: 16r00000000ffffffff
]

{ #category : #'*CDBFormat' }
ByteArray >> cdbHash2 [
	"Computes and returns the hash value for the given key."
	| h l k |
	h := 5381.
	1 to: self size do: [ :i | 
			l := h << 5.
			h := h + ( l bitAnd: 16r00000000ffffffff).
			h := h bitAnd: 16r00000000ffffffff.			
			k := self at: i.
			k := (k + 16r100) bitAnd: 16rff.
			
			h := h bitXor: k.
	].
	^ h bitAnd: 16r00000000ffffffff.
]
