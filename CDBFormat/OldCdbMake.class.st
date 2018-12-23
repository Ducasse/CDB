"
CdbMake implements the database-creation side of
"
Class {
	#name : #OldCdbMake,
	#superclass : #Object,
	#instVars : [
		'file',
		'hashPointers',
		'tableCount',
		'tableStart',
		'pos'
	],
	#category : #CDBFormat
}

{ #category : #'modal control' }
OldCdbMake >> addKey: keyOne value: dataOne [
	"Adds a key to the constant database"
	
	| hash itc key data |
	key := keyOne asByteArray.
	data := dataOne asByteArray.
	
	"Write out the key length."
	self writeLeInt: (key size).
	
	"Write out the data length"
	self writeLeInt: (data size).
	
	"Write out the key"
	file  nextBytesPutAll: key.
	
	"Write out the data."
	file  nextBytesPutAll: data.
	
	"Add the hash pointer to our list"
	hash := key cdbHash.
	hashPointers add: (hash -> pos).
	
	"Add this item to the count"
	itc := (hash bitAnd: 16rff) + 1.
	tableCount at: itc put: ((tableCount at: itc) +1).
	
	"Update the file position pointer"
	self posplus: 8.
	self posplus: (key size).
	self posplus: (data size).
]

{ #category : #'modal control' }
OldCdbMake >> finish [
	"Finalizes the constant database."
	| curEntry slotPointers slotTable |
	
	"Find the start of each hash table"
	curEntry := 0.
	1 to: 256 do: [ :i| 
		curEntry := curEntry + (tableCount at: i).
		tableStart at: i put: curEntry.
	].
	
	"Create a new hash pointer list in order by hash table"
	slotPointers := Array new: (hashPointers size).
	hashPointers do: [ :elm | | its isp | 
		its := ((elm key) bitAnd: 16rff) +1.
		tableStart at: its put: (tableStart at: its) -1.
		isp := (tableStart at: its) +1.
		slotPointers at: isp put: elm.
	].

	"Write out each of the hash tables, building the slot table in the process."
	slotTable := ByteArray new: 2048.
	1 to: 256 do: [ :i | | len curSlotPointer hashTable im1|
		"Get the length of the hashtable"
		len := (tableCount at: i) *2.
		
		"Store the position of this table in the slot table"
		im1 := i - 1.
		slotTable at: ((im1 * 8) + 1)		put: (pos 			bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 2)		put: ((pos >>  8) 	bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 3) 	   put: ((pos >> 16) 	bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 4) 		put: ((pos >> 24) 	bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 5 + 0) put: (len 			bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 5 + 1) put: ((len >>  8) 	bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 5 + 2) put: ((len >> 16) 	bitAnd: 16rff).
		slotTable at: ((im1 * 8) + 5 + 3) put: ((len >> 24)	bitAnd: 16rff).
		
		"Build the hash table"	
		curSlotPointer := tableStart at: i.
		hashTable := Array new: len.
		1 to: (tableCount at: i) do: [ :u | | hp where |
			"Get the hash pointer"
			hp := slotPointers at: (curSlotPointer +1).
			curSlotPointer := curSlotPointer + 1.
			
			"Locate a free space in the hash table"
			where := ((hp key >> 8) % len) +1.
			[(hashTable at: where) = nil ] 
				whileFalse: [
					where := where + 1.
					(where == (len+1)) ifTrue: [ where := 1. ].
				].
			
			"Store the hash pointer"
			hashTable at: where put: hp.
		].
	
		"Write out the hash table."
		1 to: len do: [ :u | | hp |
			hp := hashTable at: u.
			( hp = nil )
				ifFalse: [ 
					self writeLeInt: ((hashTable at: u) key).
					self writeLeInt: ((hashTable at: u) value).
				] ifTrue: [ 
					self writeLeInt: 0.
					self writeLeInt: 0.
				].
			self posplus: 8.
		].
	].

	"Seek back to the beginning of the file and write out the slot table."
	file position: 0.
	file nextPutAll: slotTable.
	
	"Close the file"
	file close.
]

{ #category : #'modal control' }
OldCdbMake >> posplus: count [
	"Advances the file pointer by count bytes, throwing an exception if doing so would cause the file to grow beyond 4 GB."

	| newpos |
	newpos := pos + count.
	newpos < count
		ifTrue: [ Error signal: 'CDB file is too big.' ]
		ifFalse: [ pos := newpos ]
]

{ #category : #starting }
OldCdbMake >> start: filepath [
	"Begins the constant database creation process."
	hashPointers  := LinkedList new.
	tableCount := IntegerArray new: 256.
	tableStart := IntegerArray new: 256.
	
	"Clear the table counts."
	1 to: 256 do: [ :x | tableCount at: x put: 0].
	
	"Open the file"
	file  := FileStream forceNewFileNamed: filepath.
	
	"Seek to the end of the header."
	pos  := 2048.
	file position: pos.
]

{ #category : #'modal control' }
OldCdbMake >> writeLeInt: v [
	"Writes an integer in little-endian format to the constant database at the current file offset."
	
	| a b c d |
	a := v bitAnd: 16rff.
	b := v >> 8 bitAnd: 16rff.
	c := v >> 16 bitAnd: 16rff.
	d := v >> 24 bitAnd: 16rff.
	
	file nextBytesPutAll: a asByteArray.
	file nextBytesPutAll: b asByteArray.
	file nextBytesPutAll: c asByteArray.
	file nextBytesPutAll: d asByteArray.
]
