"
An Enumeration containing a CdbElement for each entry in the constant database.
	parameter:  filepath The CDB file to read.
	Return:  An Enumeration containing a CdbElement for each entry in the constant database.

"
Class {
	#name : #CdbEnumeration,
	#superclass : #Object,
	#instVars : [
		'in',
		'eod',
		'pos'
	],
	#category : #CDBFormat
}

{ #category : #new }
CdbEnumeration class >> new: aFilepath [
	 ^ self new
		initialize: aFilepath;
		yourself
]

{ #category : #'modal control' }
CdbEnumeration >> finalize [

	in close
]

{ #category : #inspection }
CdbEnumeration >> gtInspectorDetailsIn: composite [
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
CdbEnumeration >> hasMoreElements [
	"Returns true,if there are more elements in the constant database, false otherwise."

	^ pos < eod.
]

{ #category : #accessing }
CdbEnumeration >> in [

	^ in
]

{ #category : #initalize }
CdbEnumeration >> initialize: filepath [
	| A B C D |
	"Open the data file"
	in := FileStream readOnlyFileNamed: filepath.
	in binary.
	"Read the end-of-data value"
	A := in next bitAnd: 16rFF.
	B := (in next bitAnd: 16rff) << 8.
	C := (in next bitAnd: 16rff) << 16.
	D := (in next bitAnd: 16rff) << 24.
	eod := A bitOr: (B bitOr: (C bitOr: D)).

	"Skip the rest of the hashtable"
	in skip: 2048 - 4.

	"Current data pointer"
	pos := 2048
]

{ #category : #initalize }
CdbEnumeration >> initializeWithByteArray: aByteArray [
	| A B C D |
	in := ZnBufferedReadStream on: aByteArray.
	"Read the end-of-data value"
	A := in next bitAnd: 16rFF.
	B := (in next bitAnd: 16rff) << 8.
	C := (in next bitAnd: 16rff) << 16.
	D := (in next bitAnd: 16rff) << 24.
	eod := A bitOr: (B bitOr: (C bitOr: D)).

	"Skip the rest of the hashtable"
	in skip: 2048 - 4.

	"Current data pointer"
	pos := 2048
]

{ #category : #'modal control' }
CdbEnumeration >> nextElement [
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
CdbEnumeration >> readLeInt [
	"Reads a little-endian integer from: in"
	|A B C D|
	A :=  in next bitAnd: 16rFF.
	B := (in next bitAnd: 16rFF) << 8.
	C := (in next bitAnd: 16rFF) << 16.
	D := (in next bitAnd: 16rFF) << 24.
	
	^ A bitOr: (B bitOr: (C bitOr: D)) 
]
