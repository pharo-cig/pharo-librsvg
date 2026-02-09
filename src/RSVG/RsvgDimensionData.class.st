Class {
	#name : 'RsvgDimensionData',
	#superclass : 'RsvgStructure',
	#classVars : [
		'OFFSET_EM',
		'OFFSET_EX',
		'OFFSET_HEIGHT',
		'OFFSET_WIDTH'
	],
	#category : 'RSVG-Base',
	#package : 'RSVG',
	#tag : 'Base'
}

{ #category : 'field definition' }
RsvgDimensionData class >> fieldsDesc [

	^ #(
	int width;
	int height;
	int em;
	int ex
	)
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> em [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_EM
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> em: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_EM put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> ex [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_EX
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> ex: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_EX put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> height [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_HEIGHT
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> height: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_HEIGHT put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> width [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_WIDTH
]

{ #category : 'accessing - structure variables' }
RsvgDimensionData >> width: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_WIDTH put: anObject
]
