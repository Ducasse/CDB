"
To be turned into tests!
"
Class {
	#name : #MyPlayground,
	#superclass : #Object,
	#category : #'CDBFormat-Old'
}

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbEnum2 [
	| em cdbElt |
	em := OldCdbEnumeration new
		initializeWithByteArray: CDBTest decodedCDBFileContents readStream;
		yourself.
	[ em hasMoreElements ]
		whileTrue: [ cdbElt := em nextElement.
			Transcript
				show: cdbElt printString;
				cr ]
]

{ #category : #'as yet unclassified' }
MyPlayground >> myPlaygroundCdbMake [
	"Playground example for use CDB make"

	| maker |
	maker := OldCdbMake new.
	maker start: 'testTwoSimilarKeys.cdb'.
	maker addKey: 'one' asByteArray value: 'Rambo1' asByteArray. 
	maker addKey: 'three' asByteArray value: 'Golden State Warriors' asByteArray.
	maker addKey: 'four' asByteArray value: 'Record of Chicago Bulls' asByteArray. 
	maker addKey: 'one' asByteArray value: 'Rambo2' asByteArray. 
	maker finish.
]
