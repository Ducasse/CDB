Class {
	#name : #CDBEnumTest,
	#superclass : #TestCase,
	#category : #'CDBFormat-Test'
}

{ #category : #helpers }
CDBEnumTest >> randomStr: aSize [
	"self new randomStr: 4"

	| alphabet |
	alphabet := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	^ String streamContents: [ :ws | aSize timesRepeat: [ ws nextPut: (alphabet at: 36 atRandom) ] ]
]

{ #category : #tests }
CDBEnumTest >> testGeneric [
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
	maker := CdbMake new.
	maker start: 'test.cdb'.
	1 to: size do: [ :c | maker addKey: (keys at: c) asByteArray value: (values at: c) asByteArray ].
	maker finish.
	cdbEnum := Cdb elements: 'test.cdb'.
	i := 1.
	[ cdbEnum hasMoreElements ]
		whileTrue: [ result := cdbEnum nextElement.
			self assert: (keys at: i) equals: result getKey asString.
			self assert: (values at: i) equals: result getData asString.
			i := i + 1 ]
]

{ #category : #tests }
CDBEnumTest >> testInsertOneChar [
	"comment stating purpose of message"

	| maker cdbEnum result |
	maker := CdbMake new.
	maker start: 'test.cdb'.
	maker addKey: 'a' value: 'toto'.
	maker finish.
	
	cdbEnum := Cdb elements: 'test.cdb'.
	result := cdbEnum nextElement.
	self assert: 'a' = result getKey asString.
	self assert: 'toto' = result getData asString.
]

{ #category : #tests }
CDBEnumTest >> testOneEnumaration [
	"Playground example for use CDB make"

	|i maker cdbEnum keys values result|
	
	keys := #('three' 'four').
	values := #('Golden State Warriors' 'Record of Chicago Bulls').
	maker := CdbMake new.
	maker start: 'test.cdb'.
	maker addKey: (keys at: 1) value: (values at: 1).
	maker addKey: (keys at: 2) value: (values at: 2).
	maker finish.
	
	cdbEnum := Cdb elements: 'test.cdb'.
 	i := 1.
 	[ cdbEnum hasMoreElements ] 
      whileTrue: [
			  result := cdbEnum nextElement.
			  self assert: (keys at: i) = result getKey asString.
			  self assert: (values at: i) = result getData asString.
			  i := i + 1.
	   ]
]

{ #category : #tests }
CDBEnumTest >> testOneHasMoreElement [
	"Playground example for use CDB make"

	|expectedSize maker cdbEnum keys values|
	
	keys := #('three' 'four').
	values := #('Golden State Warriors' 'Record of Chicago Bulls').
	maker := CdbMake new.
	maker start:'test.cdb'.
	maker addKey: ((keys at: 1) asByteArray) value: ((values at: 1) asByteArray).
	maker addKey: ((keys at: 2) asByteArray) value: ((values at: 2) asByteArray).
	maker finish.
	
	cdbEnum := Cdb elements:'test.cdb'.
  	expectedSize := 0.
 	[ cdbEnum hasMoreElements ] 
      whileTrue: [
	       cdbEnum nextElement.
	       expectedSize := expectedSize + 1.
	   ].

	self assert: (keys size) = expectedSize
]
