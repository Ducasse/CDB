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
