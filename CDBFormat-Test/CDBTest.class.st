Class {
	#name : #CDBTest,
	#superclass : #TestCase,
	#category : #'CDBFormat-Test'
}

{ #category : #find }
CDBTest >> testFind [

	|cdb i maker  keys values result|
	
	keys := #('three' 'four').
	values := #('Golden State Warriors' 'Record of Chicago Bulls').
	maker := CdbMake new.
	maker start:'test.cdb'.
	
	maker addKey: (keys at: 1) value: (values at: 1).
	maker addKey: (keys at: 2) value: (values at: 2).
	maker finish.
	cdb := Cdb fileName: 'test.cdb'.
	i := 1.
	[ i<= 2 ]
        whileTrue: [  
	          result := (cdb find: (keys at: i)) asString.
	          self assert: (values at: i) equals: result .
	          i := i + 1.
	     ].
	cdb close.
]
