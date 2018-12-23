"
CDB is a constant database invented by D. J. Bernstein in 96.

Positions, lengths, and hash values are 32-bit quantities, stored in
little-endian form in 4 bytes. Thus a cdb must fit into 4 gigabytes.

CDB is a constant database, that is, it cannot be updated at a runtime, only rebuilt. Rebuilding is an atomic operation and is very fast. Once created, CDB may be queried, and a query takes very little time to complete.

A cdb is an associative array: it maps strings (``keys'') to strings (``data'').

More information at: http://www.unixuser.org/~euske/doc/cdbinternals/index.html (if the site continues to exist in the future). Thanks the author for the documentation!

!! General information (as described by the author)

A cdb contains 256 pointers to linearly probed open hash tables. The
hash tables contain pointers to (key,data) pairs. A cdb is stored in
a single file on disk:

    +----------------+---------+-------+-------+-----+---------+
    | p0 p1 ... p255 | records | hash0 | hash1 | ... | hash255 |
    +----------------+---------+-------+-------+-----+---------+

Each of the 256 initial pointers states a position and a length. The
position is the starting byte position of the hash table. The length
is the number of slots in the hash table.

Each hash table slot states a hash value and a byte position. If the
byte position is 0, the slot is empty. Otherwise, the slot points to
a record whose key has that hash value.

A record is located as follows. Compute the hash value of the key in
the record. The hash value modulo 256 is the number of a hash table.
The hash value divided by 256, modulo the length of that table, is a
slot number. Probe that slot, the next higher slot, and so on, until
you find the record or run into an empty slot.

The cdb hash function is ``h = ((h << 5) + h) ^ c'', with a starting
hash of 5381.


!! A Two level lookup table 
CDB has 2-level hierarchical tables to lookup data.

!!! Structure of a file
A cdb file consists of roughly three parts.
- A first lookup table of fixed size of 2048 bytes.
- An arbritary number of records.
- A second lookup table of variable size divided into at most 256 subtables (each of which has a variable number of entries and is accessed from a pointer stored in the first lookup table)

!! Main lookup table 

The main first lookup table [ 2048 bytes ]
An entry in the first main table is composed of: 
- a pointer [ 4bytes ] to the ith subtable
- number of entries [ 4 bytes ] (zero if not existing)

Each of the 256 (* 8 = 2048 bytes) initial pointers states a position and a length. The
position is the starting byte position of the hash table. The length
is the number of slots in the hash table.


!! About Records
A cdb has a number of records which has a key and a datum, each of which can be in variable length (up to 4GBytes). Records are stored sequentially, without special alignment. A record
states a key length, a data length, the key, and the data.

Record 
| key length on 4 bytes               |
| data length on 4 bytes              |
| key of variable size                |
| data of variable size (you to 4 GB) | 


!! Subtables and HashPairs
 
A subtable contains hashpairs. 
A hashpair is composed of 
- a hash of a key (4 bytes) and 
- a pointer to a record (4 bytes) (zero if empty)

!! Lookup 

Each key/value pair (called record above) is referred to by a small data structure which is stored in the second table (subtable). Here we call it a ""hashpair"" for convenience.

1 - Given a key, a 32-bit hash value h is calculated.

2 - A hashpair which has the hash value h is located. This step is composed of two phases:
-- The (h % 256) [the least 8 significant bits of h] th subtable is located from the first lookup table. ith subtable contains Ei hashpairs. The first lookup table has 256 pairs of the pointer pi and the number of entries Ei for each subtable. Ei can be zero if the subtable is not existent.
-- The subtable entries are scanned to find the hashpair. The search starts from ((h >> 8) % Ei) th hashpair. If it reaches the end of the subtables, the search goes back at the beginning of the table. To facilitate searching, exactly Ei/2 entries are kept empty (where the pointer is NULL) to detect nonexistent keys. If it reaches an empty slot, that means there is no corresponding data in this file.

3 - The actual key/datum pair is accessed through the pointer in the hashpair.

4 - If the key is correct, the corresponding datum is retrieved. Otherwise, the next hashpair is tried. This process continues until either all hashpairs in the subtable are tried or an empty hashpair is found.
 






"
Class {
	#name : #CDB,
	#superclass : #Object,
	#instVars : [
		'file',
		'slotTable',
		'table',
		'offset',
		'loop',
		'hslots',
		'hpos',
		'khash',
		'kpos'
	],
	#category : #'CDBFormat-CDB'
}

{ #category : #utilities }
CDB class >> dumpByteArrayOnTranscript: aByteArray [
	"self dumpByteArrayOnTranscript: 'bXlGcm9tUHl0aG9uSW1wbGVtZW50YXRpb24uY2Ri' base64Decoded"

	| em |
	em := CDBDumper new.
	em initializeWithByteArray: aByteArray.
	em dump
]

{ #category : #utilities }
CDB class >> dumpFileOnTranscript: aFileName [
	"self dumpFileOnTranscript: 'myFromPythonImplementation.cdb'"
	"self dumpFileOnTranscript: 'testTwoSimilarKeys.cdb'"

	| em |
	em := CDBDumper new.
	em initializeWithFilePath: aFileName.
	em dump
]

{ #category : #utils }
CDB >> close [ 

	file close
]

{ #category : #'utils to merge' }
CDB >> computePosition [

	| a b c d |
	a := (table at: offset) bitAnd: 16rff.
	offset := offset + 1.
	b := ((table at: offset) bitAnd: 16rff) << 8.
	offset := offset + 1.
	c := ((table at: offset) bitAnd: 16rff) << 16.
	offset := offset + 1.
	d := ((table at: offset) bitAnd: 16rff) << 24.
	offset := offset + 1.
	^  a bitOr: (b bitOr: (c bitOr: d)).
]

{ #category : #utils }
CDB >> createFromFile: aFileName [

	file := (File named: aFileName asFileReference fullName) readStream.
	table := ByteArray new: 2048.
	file readInto: table startingAt: 1 count: 2048.
	self createFromTable: table. 
]

{ #category : #utils }
CDB >> createFromTable: a2048ByteArray [

	| pos len iecart ia ib |
	slotTable := IntegerArray new: 256 * 2.
	offset := 1. 
	iecart := 0.
	1 to: 256 do: [ :i | 
		pos := self computePosition.
		len := self computePosition.
		ia := i + iecart.
		ib := ia + 1.
		iecart := iecart + 1.
		slotTable at: ia put: pos.
		slotTable at: ib put: len
		]
]

{ #category : #accessing }
CDB >> fileName: aString [
	file := File named: aString asFileReference fullName
]

{ #category : #finding }
CDB >> find: keyOne [
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

{ #category : #utils }
CDB >> ifActionForLoopEqualZero: key [

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

{ #category : #'old code' }
CDB >> initialize: filepath [
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

{ #category : #'utils to merge' }
CDB >> readUnsignedByteModulate [
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

{ #category : #utils }
CDB >> searchMatching: k and: key [

	1 to: k size do: [ :i | 
		(k at: i) = (key at: i)
			ifFalse: [ ^ false ] ].
	^ true
]
