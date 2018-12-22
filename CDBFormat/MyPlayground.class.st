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

	| em cdbElt | 
	em := Cdb elements: 'testTwoSimilarKeys.cdb'.
	[ em hasMoreElements ] whileTrue: [ 
		cdbElt := em nextElement.
		Transcript show: 'Value : '; show: cdbElt data asString; show: ' Key : '; show: cdbElt key asString; cr.
   ].
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbEnum2 [

	| em cdbElt | 
	em := CdbEnumeration new 
				initializeWithByteArray: NewCDBTest decodedCDBFileContents readStream; yourself.
	[ em hasMoreElements ] whileTrue: [ 
		cdbElt := em nextElement.
		Transcript show: 'Value : '; show: cdbElt data asString; show: ' Key : '; show: cdbElt key asString; cr.
   ].
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbFind [
	
	|cdb key r|
	cdb := Cdb fileName: 'test.cdb'.
	key := 'one' asByteArray.
	r := cdb find: key.
	cdb close.
	self assert: r asString equals: 'rambo'
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbMake [
	"Playground example for use CDB make"

	| maker |
	maker := CdbMake new.
	maker start: 'testTwoSimilarKeys.cdb'.
	maker addKey: 'one' asByteArray value: 'Rambo1' asByteArray. 
	maker addKey: 'three' asByteArray value: 'Golden State Warriors' asByteArray.
	maker addKey: 'four' asByteArray value: 'Record of Chicago Bulls' asByteArray. 
	maker addKey: 'one' asByteArray value: 'Rambo2' asByteArray. 
	maker finish.
]
