"
How to add more resources (CBD examples) to the test class?

- Use a script as the following to generate a little file.

	| cdb maker values result |
	values :=  {('Sun' -> '1 392 000, 1.9889x10^30') . ('Jupiter' -> '142 984, 1.8986x10^27') . ('Neptune' -> '49 528, 1.0243x10^26') . 
	('Mars' -> '6 780, 6.4185x10^23')}.
	maker := CDBCreator new.
	maker start: 'testPlanets.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.

- then turn the file contents into a string using the following for example

(File named: 'testPlanets.cdb' asFileName) readStream contents asByteArray base64Encoded



CDB dumpFileOnTranscript: 'myFromPythonImplementation.cdb'.
CDB dumpFileOnTranscript: 'testCerise.cdb'.
CDB dumpFileOnTranscript: 'my2.cdb'

OldCdbEnumeration new 
	initializeWithByteArray: CDBTest encodedCDBFileContentsPython base64Decoded ;
	dump
"
Class {
	#name : #CDBTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #'CDBFormat-Test-New'
}

{ #category : #ressources }
CDBTest class >> cdbFile [

	^ 'file.cdb'
]

{ #category : #ressources }
CDBTest class >> cdbFileContents [
	
	^ 'VQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAACAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAIAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAIAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAAAFAAAAFQAAAHRocmVlR29sZGVuIFN0YXRlIFdhcnJpb3JzBAAAABcAAABmb3VyUmVjb3JkIG9mIENoaWNhZ28gQnVsbHMDAAAABQAAAG9uZVJhbWJva0brCgAIAAAAAAAAAAAAAAAAAAAAAAAAgVuHC0UIAACrLm58IggAAAAAAAAAAAAA'
]

{ #category : #ressources }
CDBTest class >> decodedCDBFileContents [
	^ self encodedCDBFileContents base64Decoded
]

{ #category : #ressources }
CDBTest class >> encodedCDBFileContents [
	"this string is a base64encoded cdb file."
	^ 'VQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAAAAAAAVQgAAAAAAABVCAAAAAAAAFUIAAACAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAAAAABlCAAAAAAAAGUIAAAAAAAAZQgAAAIAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAAAAAB1CAAAAAAAAHUIAAAAAAAAdQgAAAIAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAACFCAAAAAAAAIUIAAAAAAAAhQgAAAAAAAAFAAAAFQAAAHRocmVlR29sZGVuIFN0YXRlIFdhcnJpb3JzBAAAABcAAABmb3VyUmVjb3JkIG9mIENoaWNhZ28gQnVsbHMDAAAABQAAAG9uZVJhbWJva0brCgAIAAAAAAAAAAAAAAAAAAAAAAAAgVuHC0UIAACrLm58IggAAAAAAAAAAAAA'
]

{ #category : #ressources }
CDBTest class >> encodedCDBFileContentsCerise [
	"this string is a base64Encoded cdb file generated for these facts: 
		
{ ('aaa' -> 'ami') . ('bal' -> 'balance') . ('c123' -> 'cerise') . ('doul' -> 'dentiste') }.
"
	^   'RggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAgAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAACAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAAAAABmCAAAAAAAAGYIAAAAAAAAZggAAAIAAAB2CAAAAAAAAHYIAAAAAAAAdggAAAAAAAB2CAAAAAAAAHYIAAAAAAAAdggAAAAAAAB2CAAAAAAAAHYIAAAAAAAAdggAAAAAAAB2CAAAAAAAAHYIAAAAAAAAdggAAAAAAAB2CAAAAgAAAIYIAAAAAAAAhggAAAAAAACGCAAAAAAAAIYIAAAAAAAAhggAAAAAAACGCAAAAAAAAIYIAAAAAAAAhggAAAAAAAADAAAAAwAAAGFhYWFtaQMAAAAHAAAAYmFsYmFsYW5jZQQAAAAGAAAAYzEyM2NlcmlzZQQAAAAIAAAAZG91bGRlbnRpc3RldvpvfCAIAAAAAAAAAAAAAKQyhwsACAAAAAAAAAAAAAAAAAAAAAAAAOpHhwsOCAAA9wZrfDIIAAAAAAAAAAAAAA=='
]

{ #category : #ressources }
CDBTest class >> encodedCDBFileContentsPlanets [
	"this string is a base64Encoded cdb file generated for these facts: 
		
 {  ('Sun' -> '1 392 000, 1.9889x10^30') . ('Jupiter' -> '142 984, 1.8986x10^27') . ('Neptune' -> '49 528, 1.0243x10^26') . 
	('Mars' -> '6 780, 6.4185x10^23')}
"
	^    'iAgAAAIAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAAAAACYCAAAAAAAAJgIAAAAAAAAmAgAAAIAAACoCAAAAAAAAKgIAAAAAAAAqAgAAAAAAACoCAAAAAAAAKgIAAACAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAAAAAAAuAgAAAAAAAC4CAAAAAAAALgIAAACAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAADICAAAAAAAAMgIAAAAAAAAyAgAAAAAAAADAAAAFwAAAFN1bjEgMzkyIDAwMCwgMS45ODg5eDEwXjMwBwAAABUAAABKdXBpdGVyMTQyIDk4NCwgMS44OTg2eDEwXjI3BwAAABQAAABOZXB0dW5lNDkgNTI4LCAxLjAyNDN4MTBeMjYEAAAAEwAAAE1hcnM2IDc4MCwgNi40MTg1eDEwXjIzAAAAAAAAAAAApRoLIggAAAAAAAAAAAAASD+AfGkIAAAAAAAAAAAAAE0NiAsACAAA1CbBxkYIAAAAAAAAAAAAAA=='
]

{ #category : #ressources }
CDBTest class >> encodedCDBFileContentsPython [
	"this string is a base64Encoded cdb file generated from the python implementation for these facts: 
		
k: 'a' v: 1
k: 'bcd' v: '234'
k: 'def' v: '567'

"
	^  'JggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAAAAAAAJggAAAAAAAAmCAAAAAAAACYIAAACAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAAAAAAANggAAAAAAAA2CAAAAAAAADYIAAACAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAAAAAEYIAAAAAAAARggAAAAAAABGCAAAAgAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAABWCAAAAAAAAFYIAAAAAAAAVggAAAAAAAABAAAAAQAAAGExAwAAAAMAAABiY2QyMzQDAAAAAwAAAGRlZjU2NwAAAAAAAAAAIEeHCwoIAABiHocLGAgAAAAAAAAAAAAAAAAAAAAAAADEtQIAAAgAAA=='
]

{ #category : #tests }
CDBTest >> createTestFile [

	| values maker |
	values := self data.
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.
	
	
	
	
]

{ #category : #tests }
CDBTest >> data [

	^  {  ('Sun' -> '1 392 000, 1.9889x10^30') . ('Jupiter' -> '142 984, 1.8986x10^27') . ('Neptune' -> '49 528, 1.0243x10^26') . 
	('Mars' -> '6 780, 6.4185x10^23')}
	
]

{ #category : #tests }
CDBTest >> testFind [

	| values maker cdb i result |
	values := self data.
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.
	
	
	cdb := CDB new.
	cdb createFromFile: 'test.cdb'.
	i := 1.
	[ i <= 2 ]
        whileTrue: [  
	          result := (cdb find: (values at: i) key) asString.
	          self assert: (values at: i) value equals: result.
	          i := i + 1.
	     ].
	cdb close.
]

{ #category : #tests }
CDBTest >> testFindNotInReturnsNil [

	| cdb maker values result |
	values := {  ('a' -> 'ami') . ('b' -> 'balance') . ('c' -> 'cerise') . ('d' -> 'dentiste') . ('a' -> 'ennemi') }.
	maker := CDBCreator new.
	maker start: 'testCerise.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.
	
	cdb := CDB new.
	cdb createFromFile: 'testCerise.cdb'.
	result := (cdb find: 'spirou'). 
	self assert: result isNil.
	cdb close.
]

{ #category : #tests }
CDBTest >> testFindWithDuplicatedKeysOnlyGetTheLatest [

	| cdb maker values result |
	values := {  ('a' -> 'ami') . ('b' -> 'balance') . ('c' -> 'cerise') . ('d' -> 'dentiste') . ('a' -> 'ennemi') }.
	maker := CDBCreator new.
	maker start: 'testCerise.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.
	
	cdb := CDB new.
	cdb createFromFile: 'testCerise.cdb'.
	result := (cdb find: 'a'). 
	self assert: result asString equals: 'ennemi'.
	result := (cdb find: 'a'). 
	self assert: result asString equals: 'ennemi'.
	cdb close.
]

{ #category : #tests }
CDBTest >> testFindWithbetterIteratingLogic [

	| values maker cdb |
	values := self data.
	maker := CDBCreator new.
	maker start: 'test.cdb'.
	values do: [ :v | maker addKey: v key value: v value ].
	maker finish.
	
	cdb := CDB new.
	cdb createFromFile: 'test.cdb'.
	values do: [ :v | 
				| result |
	          result := (cdb find: v key) asString.
	          self assert: v value equals: result.
	     ].
	cdb close.
]

{ #category : #tests }
CDBTest >> testReadFile [

	| em element |
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class cdbFile)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class encodedCDBFileContents ].
		
	em := CDBDumper new.
	em initializeWithByteArray: (testingWorkingDirectory / self class cdbFile) contents base64Decoded.
	element := em nextElement.
	self assert: element key asString equals: 'three'.
	self assert: element data asString equals: 'Golden State Warriors'.
	
	element := em nextElement.
	self assert: element key asString equals: 'four'.
	self assert: element data asString equals: 'Record of Chicago Bulls'.

]

{ #category : #tests }
CDBTest >> testReadFile2 [

	| em element |
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class cdbFile)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class encodedCDBFileContents ].
		
	em := CDBDumper new.
	em initializeWithByteArray: (testingWorkingDirectory / self class cdbFile) contents base64Decoded.
	element := em nextElement.
	self assert: element key asString equals: 'three'.
	self assert: element data asString equals: 'Golden State Warriors'.
	
	element := em nextElement.
	self assert: element key asString equals: 'four'.
	self assert: element data asString equals: 'Record of Chicago Bulls'.

]

{ #category : #'tests via internal buffer' }
CDBTest >> testReadFromByteArray [

	| em element |
	em := CDBDumper new.
	em initializeWithByteArray: self class cdbFileContents base64Decoded.
	element := em nextElement.
	self assert: element key asString equals: 'three'.
	self assert: element data asString equals: 'Golden State Warriors'.
	
	element := em nextElement.
	self assert: element key asString equals: 'four'.
	self assert: element data asString equals: 'Record of Chicago Bulls'.

]
