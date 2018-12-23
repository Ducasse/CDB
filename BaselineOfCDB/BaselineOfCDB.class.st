Class {
	#name : #BaselineOfCDB,
	#superclass : #BaselineOf,
	#category : #BaselineOfCDB
}

{ #category : #baselines }
BaselineOfCDB >> baseline: spec [
	<baseline>

	spec
		for: #pharo
		do: [ 
			spec
				package: 'CDBFormat'. 
			spec
				package: 'CDBFormat-Tests'
				with: [ spec requires: #('CDBFormat') ].
			 ]
]
