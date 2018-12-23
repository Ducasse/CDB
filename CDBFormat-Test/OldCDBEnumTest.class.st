Class {
	#name : #OldCDBEnumTest,
	#superclass : #TestCase,
	#category : #'CDBFormat-Test-New'
}

{ #category : #helpers }
OldCDBEnumTest >> randomStr: aSize [
	"self new randomStr: 4"

	| alphabet |
	alphabet := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	^ String streamContents: [ :ws | aSize timesRepeat: [ ws nextPut: (alphabet at: 36 atRandom) ] ]
]

{ #category : #tests }
OldCDBEnumTest >> testGeneric [
	"Playground example for use CDB make"

	| i maker cdbEnum keys values result size rdm |
	rdm := Random new.
	size := 100.
	keys := Array new: size.
	values := Array new: size.
	1 to: size do: [ :c | 
		| lenKey lenVal |
		lenKey := rdm nextInt: 1000.
		lenVal := rdm nextInt: 10000.
		keys at: c put: (self randomStr: lenKey).
		values at: c put: (self randomStr: lenVal) ].
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	1 to: size do: [ :c | maker addKey: (keys at: c) asByteArray value: (values at: c) asByteArray ].
	maker finish.
	cdbEnum := OldCdbEnumeration new: 'test.cdb'.
	i := 1.
	[ cdbEnum hasMoreElements ]
		whileTrue: [ result := cdbEnum nextElement.
			self assert: (keys at: i) equals: result key asString.
			self assert: (values at: i) equals: result data asString.
			i := i + 1 ]
]

{ #category : #tests }
OldCDBEnumTest >> testInsertOneChar [
	"comment stating purpose of message"

	| maker cdbEnum result |
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	maker addKey: 'a' value: 'toto'.
	maker finish.
	
	cdbEnum := OldCdbEnumeration new: 'test.cdb'.
	result := cdbEnum nextElement.
	self assert: 'a' = result key asString.
	self assert: 'toto' = result data asString.
]

{ #category : #tests }
OldCDBEnumTest >> testOneEnumaration [
	"Playground example for use CDB make"

	|i maker cdbEnum keys values result|
	
	keys := #('three' 'four').
	values := #('Golden State Warriors' 'Record of Chicago Bulls').
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	maker addKey: (keys at: 1) value: (values at: 1).
	maker addKey: (keys at: 2) value: (values at: 2).
	maker finish.
	
	cdbEnum := OldCdbEnumeration new: 'test.cdb'.
 	i := 1.
 	[ cdbEnum hasMoreElements ] 
      whileTrue: [
			  result := cdbEnum nextElement.
			  self assert: (keys at: i) equals: result key asString.
			  self assert: (values at: i) equals: result data asString.
			  i := i + 1.
	   ]
]

{ #category : #tests }
OldCDBEnumTest >> testOneHasMoreElement [
	"Playground example for use CDB make"

	|expectedSize maker cdbEnum keys values|
	
	keys := #('three' 'four').
	values := #('Golden State Warriors' 'Record of Chicago Bulls').
	maker := CDBCreator new.
	maker start:'test.cdb'.
	maker addKey: (keys at: 1) value: (values at: 1).
	maker addKey: (keys at: 2) value: (values at: 2).
	maker finish.
	
	cdbEnum := OldCdbEnumeration new: 'test.cdb'.
  	expectedSize := 0.
 	[ cdbEnum hasMoreElements ] 
      whileTrue: [
	       cdbEnum nextElement.
	       expectedSize := expectedSize + 1.
	   ].

	self assert: keys size equals: expectedSize
]
