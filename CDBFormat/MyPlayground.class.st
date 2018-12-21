"
To be turned into tests!
"
Class {
	#name : #MyPlayground,
	#superclass : #Object,
	#category : #CDBFormat
}

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbEnum [
	"comment stating purpose of message"

	| em cdbElt | 
	em := Cdb elements: 'test.cdb'.
	[ em hasMoreElements ] whileTrue: [ 
		cdbElt := em nextElement.
		Transcript show: 'Loop elements : Value : '; show: (cdbElt getData) asString; show: ' Key : '; show: (cdbElt getKey) asString; cr.
   ].
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbFind [
	"comment stating purpose of message"
	|cdb key r|
	cdb := Cdb new: 'test.cdb'.
	key := 'one' asByteArray.
	r := cdb find: key.
	cdb close.
	r asString 
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbMake [
	"Playground example for use CDB make"

	| maker |
	maker := CdbMake new.
	maker start: 'test.cdb'.
	maker addKey: ('three' asByteArray) value: ('Golden State Warriors' asByteArray).
	maker addKey: ('four' asByteArray) value: ('Record of Chicago Bulls' asByteArray). 
	maker finish.
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundTestFileNext [
	"comment stating purpose of message"

	| fileW fileR |
	fileW := FileStream forceNewFileNamed: 'next.test'.
	fileW binary.
	fileW next: 15.
	fileW close.
	
	fileR := FileStream fileNamed: 'next.test'.
	
	fileR binary.
	fileR next.
	fileR close.
	
]
