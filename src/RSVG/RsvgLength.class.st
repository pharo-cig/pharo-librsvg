Class {
	#name : 'RsvgLength',
	#superclass : 'RsvgStructure',
	#classVars : [
		'OFFSET_LENGTH',
		'OFFSET_UNIT'
	],
	#category : 'RSVG-Base',
	#package : 'RSVG',
	#tag : 'Base'
}

{ #category : 'field definition' }
RsvgLength class >> fieldsDesc [

	^ #(
	double length;
	RsvgUnit unit
	)
]

{ #category : 'accessing - structure variables' }
RsvgLength >> length [
	"This method was automatically generated"
	^handle doubleAt: OFFSET_LENGTH
]

{ #category : 'accessing - structure variables' }
RsvgLength >> length: anObject [
	"This method was automatically generated"
	handle doubleAt: OFFSET_LENGTH put: anObject
]

{ #category : 'accessing - structure variables' }
RsvgLength >> unit [
	"This method was automatically generated"
	^RsvgUnit fromInteger: (handle unsignedLongAt: OFFSET_UNIT)
]

{ #category : 'accessing - structure variables' }
RsvgLength >> unit: anObject [
	"This method was automatically generated"
	handle unsignedLongAt: OFFSET_UNIT put: anObject value
]
