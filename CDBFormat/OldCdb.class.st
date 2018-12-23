"
Cdb implements a Pharo interface
"
Class {
	#name : #OldCdb,
	#superclass : #Object,
	#instVars : [
		'file',
		'slotTable',
		'loop',
		'khash',
		'hslots',
		'hpos',
		'kpos'
	],
	#category : #'CDBFormat-Old'
}

{ #category : #'instance creation' }
OldCdb class >> fileName: aString [
	^ self new
		initialize: aString;
		yourself
]

{ #category : #'modal control' }
OldCdb >> close [
	"Closes the CDB database"
	
	file close.
	file := nil.
]

{ #category : #accessing }
OldCdb >> fileName: aString [
	file := File named: aString asFileReference fullName
]

{ #category : #'modal control' }
OldCdb >> find: keyOne [
	"Finds the first record stored under the given key"
	
	| h pos klen dlen k d key |
	loop := 0.
	key := keyOne asByteArray.
	"There are no keys if we cannot read the slot table"
	(slotTable == nil) ifTrue: [ ^ nil ].
	
	"Locate the hash entry if we have not yet done so"
	(self ifActionForLoopEqualZero: key) ifFalse: [	^ nil ].

	"Search all of the hash slots for this key"
	[loop < hslots] whileTrue: [
		file position: kpos.
		h := self readUnsignedByteModulate. 
		pos := self readUnsignedByteModulate.
		(pos = 0) ifTrue: [ ^ nil ]. 
		
		"Advance the loop count and key position"
		loop := loop + 1.
		kpos := kpos + 8.
		(kpos = (hpos + (hslots << 3))) ifTrue: [ kpos := hpos ].
		
		"Ignore this entry if the hash values do not match"
		(h = khash ) ifTrue: [
			"Get the length of the key and data in this hash slot entry."
			file position: pos.
			
			klen := self readUnsignedByteModulate.
			
			(klen = key size) ifTrue: [ 
				dlen := self readUnsignedByteModulate.
				
				k := ByteArray new: klen.
				file readInto: k startingAt: 1 count: klen.
				
				(self searchMatching: k and: key) ifTrue: [ 
					d := ByteArray new: dlen.
					file readInto: d startingAt: 1 count: dlen.
					^ d.
				].
			].
		].
	].  
	^ nil.
]

{ #category : #'modal control' }
OldCdb >> ifActionForLoopEqualZero: key [


	| u slot |
	loop = 0
		ifTrue: [ "Get the hash value for the key."
			u := key cdbHash.
			"Unpack the information for this record."
			slot := u bitAnd: 255.
			hslots := slotTable at: (slot << 1) + 2.
			hslots = 0
				ifTrue: [ ^ false ].
			hpos := slotTable at: (slot << 1) + 1.

			"Store the hash value."
			khash := u.

			"Locate the slot containing this key."
			u := u >> 8.
			u := u % hslots.
			u := u << 3.
			kpos := hpos + u ].
	^ true
]

{ #category : #initialize }
OldCdb >> initialize: filepath [
	| table offset pos len A B C D ia ib iecart |
	"Creates an instance of the Cdb class and loads the given CDB file."

	"Open the CDB file"
	file := FileStream readOnlyFileNamed: filepath.
	file binary.

	"Read and parse the slot table"
	table := ByteArray new: 2048.
	file readInto: table startingAt: 1 count: 2048.
	
	slotTable := IntegerArray new: 256 * 2.
	offset := 1.
	iecart := 0.
	1 to: 256 do: [ :i | 
		A := (table at: offset) bitAnd: 16rff.
		offset := offset + 1.
		B := ((table at: offset) bitAnd: 16rff) << 8.
		offset := offset + 1.
		C := ((table at: offset) bitAnd: 16rff) << 16.
		offset := offset + 1.
		D := ((table at: offset) bitAnd: 16rff) << 24.
		offset := offset + 1.
		pos := A bitOr: (B bitOr: (C bitOr: D)).

		"Second step"
		A := (table at: offset) bitAnd: 16rff.
		offset := offset + 1.
		B := ((table at: offset) bitAnd: 16rff) << 8.
		offset := offset + 1.
		C := ((table at: offset) bitAnd: 16rff) << 16.
		offset := offset + 1.
		D := ((table at: offset) bitAnd: 16rff) << 24.
		offset := offset + 1.
		len := A bitOr: (B bitOr: (C bitOr: D)).

		"Third step"
		ia := i + iecart.
		ib := ia + 1.
		iecart := iecart + 1.
		slotTable at: ia put: pos.
		slotTable at: ib put: len
		]
]

{ #category : #'modal control' }
OldCdb >> readUnsignedByteModulate [
	"Read an unsigned byte"
	
 	| h a b c d |
	h := 0.
	a := file next.
	b := file next << 8.
	c := file next << 16.
	d := file next << 24.
	h := a bitOr: (b bitOr: (c bitOr: d)). 
	^ h
	
]

{ #category : #'modal control' }
OldCdb >> searchMatching: k and: key [

	1 to: k size do: [ :i | 
		(k at: i) = (key at: i)
			ifFalse: [ ^ false ] ].
	^ true
]
