"
An Enumeration containing a CdbElement for each entry in the constant database.
	parameter:  filepath The CDB file to read.
	Return:  An Enumeration containing a CdbElement for each entry in the constant database.

"
Class {
	#name : #CDBDumper,
	#superclass : #Object,
	#instVars : [
		'in',
		'eod',
		'pos'
	],
	#category : #'CDBFormat-CDB'
}

{ #category : #iterate }
CDBDumper >> do: aBlock [

	[ self hasMoreElements ]
		whileTrue: [ 
			| cdbElt | 
			cdbElt := self nextElement.
			aBlock value: cdbElt ]
]

{ #category : #iterate }
CDBDumper >> dump [ 

	self do: [ :cdbElt | 
			Transcript
				show: cdbElt printString;
				cr ]
]

{ #category : #reading }
CDBDumper >> finalize [

	in close
]

{ #category : #inspection }
CDBDumper >> gtInspectorDetailsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite table
		title: [ 'Details' ];
		display: [ 
					{'self' -> self } ];
		column: 'Key' evaluated: #key;
		column: 'Value' evaluated: #value;
		send: #value
]

{ #category : #reading }
CDBDumper >> hasMoreElements [
	"Returns true,if there are more elements in the constant database, false otherwise."

	^ pos < eod
]

{ #category : #accessing }
CDBDumper >> in [

	^ in
]

{ #category : #initalize }
CDBDumper >> initializeRawValue [

	eod := self readNextLittleEndianByte.
	"Skip the rest of the hashtable"
	in skip: 2048 - 4.
	"Current data pointer"
	pos := 2048
]

{ #category : #initalize }
CDBDumper >> initializeWithByteArray: aByteArray [

	in := ZnBufferedReadStream on: aByteArray readStream.
	self initializeRawValue
]

{ #category : #initalize }
CDBDumper >> initializeWithFilePath: filepath [
	
	in := (File named: filepath asFileReference fullName) readStream.
	self initializeRawValue
]

{ #category : #reading }
CDBDumper >> nextElement [
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

{ #category : #reading }
CDBDumper >> nextFor: length [

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

{ #category : #reading }
CDBDumper >> readNextLittleEndianByte [

	| a b c d |
	a := in next bitAnd: 16rFF.
	b := (in next bitAnd: 16rFF) << 8.
	c := (in next bitAnd: 16rFF) << 16.
	d := (in next bitAnd: 16rFF) << 24.
	^ a bitOr: (b bitOr: (c bitOr: d))

]
