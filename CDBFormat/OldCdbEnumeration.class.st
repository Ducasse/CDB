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

	^ pos < eod
]

{ #category : #accessing }
OldCdbEnumeration >> in [

	^ in
]

{ #category : #initalize }
OldCdbEnumeration >> initializeRawValue [

	eod := self readNextLittleEndianByte.
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
	
	| klen dlen key data |
	klen := self readNextLittleEndianByte. 
	pos := pos + 4.
	dlen := self readNextLittleEndianByte.
	pos := pos + 4.
	key := self nextFor: klen.
	data  := self nextFor: dlen.
	^ CdbElement new: key and: data.
]

{ #category : #'modal control' }
OldCdbEnumeration >> nextFor: length [

	| off contents count| 
	contents := ByteArray new: length.
	off := 1.
	[ off <= length ] whileTrue: [ 
		count := in readInto: contents startingAt: off count: (length - off + 1).
		off := off + count.
	].
	pos := pos + length.
	^ contents
	
	
]

{ #category : #initalize }
OldCdbEnumeration >> readNextLittleEndianByte [

	| a b c d |
	a := in next bitAnd: 16rFF.
	b := (in next bitAnd: 16rFF) << 8.
	c := (in next bitAnd: 16rFF) << 16.
	d := (in next bitAnd: 16rFF) << 24.
	^ a bitOr: (b bitOr: (c bitOr: d))

]
