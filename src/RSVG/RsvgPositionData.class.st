Class {
	#name : 'RsvgPositionData',
	#superclass : 'RsvgStructure',
	#classVars : [
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : 'RSVG-Base',
	#package : 'RSVG',
	#tag : 'Base'
}

{ #category : 'field definition' }
RsvgPositionData class >> fieldsDesc [

	^ #(
	int x;
	int y
	)
]

{ #category : 'accessing - structure variables' }
RsvgPositionData >> x [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_X
]

{ #category : 'accessing - structure variables' }
RsvgPositionData >> x: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_X put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgPositionData >> y [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_Y
]

{ #category : 'accessing - structure variables' }
RsvgPositionData >> y: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_Y put: anObject
]
