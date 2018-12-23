"
An Enumeration containing a CdbElement for each entry in the constant database.
	parameter:  filepath The CDB file to read.
	Return:  An Enumeration containing a CdbElement for each entry in the constant database.

"
Class {
	#name : #OldCdbEnumeration,
	#superclass : #Object,
	#instVars : [
		'in',
		'eod',
		'pos'
	],
	#category : #'CDBFormat-Old'
}

{ #category : #new }
OldCdbEnumeration class >> new: aFilepath [
	 ^ self new
		initializeWithFilePath: aFilepath;
		yourself
]

{ #category : #'modal control' }
OldCdbEnumeration >> finalize [

	in close
]

{ #category : #inspection }
OldCdbEnumeration >> gtInspectorDetailsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite table
		title: [ 'Details' ];
		display: [ 
					{'self' -> self } ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]

{ #category : #'modal control' }
OldCdbEnumeration >> hasMoreElements [
	"Returns true,if there are more elements in the constant database, false otherwise."

	^ pos < eod.
]

{ #category : #accessing }
OldCdbEnumeration >> in [

	^ in
]

{ #category : #initalize }
OldCdbEnumeration >> initialize: filepath [
	
	self initializeWithByteArray: filepath 
]

{ #category : #initalize }
OldCdbEnumeration >> initializeRawValue [

	| a b c d |
	a := in next bitAnd: 16rFF.
	b := (in next bitAnd: 16rff) << 8.
	c := (in next bitAnd: 16rff) << 16.
	d := (in next bitAnd: 16rff) << 24.
	eod := a bitOr: (b bitOr: (c bitOr: d)).

	"Skip the rest of the hashtable"
	in skip: 2048 - 4.

	"Current data pointer"
	pos := 2048
]

{ #category : #initalize }
OldCdbEnumeration >> initializeWithByteArray: aByteArray [

	in := ZnBufferedReadStream on: aByteArray readStream.
	self initializeRawValue
]

{ #category : #initalize }
OldCdbEnumeration >> initializeWithFilePath: filepath [
	
	in := (File named: filepath asFileReference fullName) readStream.
	self initializeRawValue
]

{ #category : #'modal control' }
OldCdbEnumeration >> nextElement [
	"Returns the next data element in the CDB file"
	
	| klen dlen key off count data |
	
	"Read the key and value lengths"
	klen := self readLeInt. 
	pos := pos + 4.
	dlen := self readLeInt.
	pos := pos + 4.

	"Read the key"
	key := ByteArray new: klen.
	off := 1.
	[ off <= klen ] whileTrue: [ 
		count := in readInto: key startingAt: off count: (klen-off + 1).
		off := off + count.
	].
	pos := pos + klen.
	
	"Read the data"
	
	data  := ByteArray new: dlen.
	off := 1.
	[ off <= dlen ] whileTrue: [ 
		count := in readInto: data startingAt: off count: (dlen-off + 1).
		off := off + count.
	].
	pos := pos + dlen.
	
	^ CdbElement new: key and: data.
]

{ #category : #'modal control' }
OldCdbEnumeration >> readLeInt [
	"Reads a little-endian integer from: in"
	|A B C D|
	A :=  in next bitAnd: 16rFF.
	B := (in next bitAnd: 16rFF) << 8.
	C := (in next bitAnd: 16rFF) << 16.
	D := (in next bitAnd: 16rFF) << 24.
	
	^ A bitOr: (B bitOr: (C bitOr: D)) 
]

{ #category : #initalize }
OldCdbEnumeration >> setPath: filepath [
	
	in := FileStream readOnlyFileNamed: filepath.
	in binary.

]
