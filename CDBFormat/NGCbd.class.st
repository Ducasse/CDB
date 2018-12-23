Class {
	#name : #NGCbd,
	#superclass : #Object,
	#instVars : [
		'file'
	],
	#category : #'CDBFormat-NewCore'
}

{ #category : #utilities }
NGCbd class >> dumpOnTranscript: aFileName [
	"self dumpOnTranscript: 'myFromPythonImplementation.cdb'"
	"self dumpOnTranscript: 'testTwoSimilarKeys.cdb'"

	| em cdbElt |
	em := CdbEnumeration new: aFileName.
	[ em hasMoreElements ]
		whileTrue: [ cdbElt := em nextElement.
			Transcript
				show: cdbElt printString;
				cr ]
]

{ #category : #accessing }
NGCbd >> fileName: aString [
	file := File named: aString asFileReference fullName
]

{ #category : #utils }
NGCbd >> readUnsignedByteModulate [
	"Read an unsigned byte"
	
 	| h a b c d |
	h := 0.
	a := file next.
	b := file next << 8.
	c := file next << 16.
	d := file next << 24.
	h := a bitOr: (b bitOr: (c bitOr: d)). 
	^ h
	
]

{ #category : #utils }
NGCbd >> searchMatching: k and: key [

	1 to: k size do: [ :i | 
		(k at: i) = (key at: i)
			ifFalse: [ ^ false ] ].
	^ true
]
