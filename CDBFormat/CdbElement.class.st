"
CdbElement represents a single element in a constant database.
"
Class {
	#name : #CdbElement,
	#superclass : #Object,
	#instVars : [
		'data',
		'key'
	],
	#category : #'CDBFormat-NewCore'
}

{ #category : #new }
CdbElement class >> new: aKey and: aData [
	 ^ self new
		setKey: aKey data: aData;
		yourself
]

{ #category : #getter }
CdbElement >> data [

	^ data
]

{ #category : #getter }
CdbElement >> key [

	^ key
]

{ #category : #printing }
CdbElement >> printOn: aStream [
	aStream
		nextPutAll: 'k: ';
		nextPutAll: key asString;
		nextPutAll: ' v: ';
		nextPutAll: data asString
]

{ #category : #initalize }
CdbElement >> setKey: k data: d [
	"Creates an instance of the CdbElement class and initializes it with the given key and data values."

	key := k.
	data := d
]
