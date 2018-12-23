Class {
	#name : #CDBDumperTest,
	#superclass : #TestCase,
	#category : #'CDBFormat-Test-New'
}

{ #category : #tests }
CDBDumperTest >> data [

	^  {  ('Sun' -> '1 392 000, 1.9889x10^30') . ('Jupiter' -> '142 984, 1.8986x10^27') . ('Neptune' -> '49 528, 1.0243x10^26') . 
	('Mars' -> '6 780, 6.4185x10^23')}.
	
]

{ #category : #helpers }
CDBDumperTest >> randomStr: aSize [
	"self new randomStr: 4"

	| alphabet |
	alphabet := '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
	^ String streamContents: [ :ws | aSize timesRepeat: [ ws nextPut: (alphabet at: 36 atRandom) ] ]
]

{ #category : #tests }
CDBDumperTest >> testFromFile [

	| em element testingWorkingDirectory |
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / CDBTest cdbFile)
		writeStreamDo: [ :stream | 
			stream nextPutAll: CDBTest encodedCDBFileContentsPlanets ].
		
	em := CDBDumper new.
	em initializeWithByteArray: (testingWorkingDirectory / CDBTest cdbFile) contents base64Decoded.
	
	element := em nextElement.
	self assert: element key asString equals: 'Sun'.
	self assert: element data asString equals: '1 392 000, 1.9889x10^30'.
	
	element := em nextElement.
	self assert: element key asString equals: 'Jupiter'.
	self assert: element data asString equals: '142 984, 1.8986x10^27'.

]

{ #category : #tests }
CDBDumperTest >> testGeneric [
	"generate 100 random entries and contents and verify that all the entries are there. "
	
	| i maker cdbEnum keys values size rdm |
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
	1 to: size do: [ :c | maker addKey: (keys at: c) value: (values at: c) ].
	maker finish.
	
	cdbEnum := CDBDumper new initializeWithFilePath: 'test.cdb'.
	i := 1.
	cdbEnum do: [ :result | 
			self assert: (keys at: i) equals: result key asString.
			self assert: (values at: i) equals: result data asString.
			i := i + 1 ]
]

{ #category : #tests }
CDBDumperTest >> testInsertOneChar [

	| maker dumper result |
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	maker addKey: 'a' value: 'toto'.
	maker finish.
	
	dumper := CDBDumper new initializeWithFilePath: 'test.cdb'.
	result := dumper nextElement.
	self assert: 'a' equals: result key asString.
	self assert: 'toto' equals: result data asString.
]

{ #category : #tests }
CDBDumperTest >> testNextElementFromLowLevelInitialization [

	| em element |
	em := CDBDumper new.
	em initializeWithByteArray: CDBTest encodedCDBFileContentsPlanets base64Decoded readStream.
	element := em nextElement.
	self assert: element key asString equals: 'Sun'.
	self assert: element data asString equals: '1 392 000, 1.9889x10^30'.
	
	element := em nextElement.
	self assert: element key asString equals: 'Jupiter'.
	self assert: element data asString equals: '142 984, 1.8986x10^27'.

]

{ #category : #tests }
CDBDumperTest >> testOneEnumeration [
	"Playground example for use CDB make"

	| i maker dumper values |
	values := self data.
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.
	
	dumper := CDBDumper new initializeWithFilePath: 'test.cdb'.
 	i := 0.
 	dumper
      do: [ :result | 
			i := i + 1.
			self assert: (values at: i) key equals: result key asString.
			self assert: (values at: i) value equals: result data asString.
	   ].
	self assert: i equals: values size 
]
