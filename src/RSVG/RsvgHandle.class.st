Class {
	#name : 'RsvgHandle',
	#superclass : 'RsvgStructure',
	#classVars : [
		'OFFSET_PARENT',
		'OFFSET__ABI_PADDING'
	],
	#category : 'RSVG-Base',
	#package : 'RSVG',
	#tag : 'Base'
}

{ #category : 'field definition' }
RsvgHandle class >> fieldsDesc [

	^ #(
	int parent;
	int_16 _abi_padding
	)
]

{ #category : 'accessing - structure variables' }
RsvgHandle >> _abi_padding [
	"This method was automatically generated"
	^(FFIArray ofType: #FFIInt32 size: 16) fromHandle: (handle copyFrom: OFFSET__ABI_PADDING to: OFFSET__ABI_PADDING + 63)
]

{ #category : 'accessing - structure variables' }
RsvgHandle >> _abi_padding: anObject [
	"This method was automatically generated"
	handle replaceFrom: OFFSET__ABI_PADDING to: OFFSET__ABI_PADDING + 63 with: anObject getHandle startingAt: 1
]

{ #category : 'accessing - structure variables' }
RsvgHandle >> parent [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_PARENT
]

{ #category : 'accessing - structure variables' }
RsvgHandle >> parent: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_PARENT put: anObject
]
