Class {
	#name : 'RsvgRectangle',
	#superclass : 'RsvgStructure',
	#classVars : [
		'OFFSET_HEIGHT',
		'OFFSET_WIDTH',
		'OFFSET_X',
		'OFFSET_Y'
	],
	#category : 'RSVG-Base',
	#package : 'RSVG',
	#tag : 'Base'
}

{ #category : 'field definition' }
RsvgRectangle class >> fieldsDesc [

	^ #(
	double x;
	double y;
	double width;
	double height
	)
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> height [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_HEIGHT
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> height: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_HEIGHT put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> width [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_WIDTH
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> width: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_WIDTH put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> x [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_X
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> x: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_X put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> y [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_Y
]

{ #category : 'accessing - structure variables' }
RsvgRectangle >> y: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_Y put: anObject
]
