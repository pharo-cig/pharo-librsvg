Class {
	#name : 'RsvgHandleClass',
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
RsvgHandleClass class >> fieldsDesc [

	^ #(
	int parent;
	int_15 _abi_padding
	)
]

{ #category : 'accessing - structure variables' }
RsvgHandleClass >> _abi_padding [
	"This method was automatically generated"
	^(FFIArray ofType: #FFIInt32 size: 15) fromHandle: (handle copyFrom: OFFSET__ABI_PADDING to: OFFSET__ABI_PADDING + 59)
]

{ #category : 'accessing - structure variables' }
RsvgHandleClass >> _abi_padding: anObject [
	"This method was automatically generated"
	handle replaceFrom: OFFSET__ABI_PADDING to: OFFSET__ABI_PADDING + 59 with: anObject getHandle startingAt: 1
]

{ #category : 'accessing - structure variables' }
RsvgHandleClass >> parent [
	"This method was automatically generated"
	^handle signedLongAt: OFFSET_PARENT
]

{ #category : 'accessing - structure variables' }
RsvgHandleClass >> parent: anObject [
	"This method was automatically generated"
	handle signedLongAt: OFFSET_PARENT put: anObject
]
