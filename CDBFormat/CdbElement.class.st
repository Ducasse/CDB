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
	#category : #CDBFormat
}

{ #category : #new }
CdbElement class >> new: aKey and: aData [
	 ^ self new
		initialize: aKey and: aData;
		yourself
]

{ #category : #getter }
CdbElement >> getData [

	^ data
]

{ #category : #getter }
CdbElement >> getKey [

	^ key
]

{ #category : #initalize }
CdbElement >> initialize: k and: d [
	"Creates an instance of the CdbElement class and initializes it with the given key and data values."

	key := k.
	data := d
]
