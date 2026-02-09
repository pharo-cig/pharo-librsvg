Class {
	#name : 'BaselineOfRSVG',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRSVG',
	#package : 'BaselineOfRSVG'
}

{ #category : 'baselines' }
BaselineOfRSVG >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec package: 'RSVG' ]
]
