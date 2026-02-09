Class {
	#name : 'RsvgHandleFlags',
	#superclass : 'RsvgEnumeration',
	#classVars : [
		'RSVG_HANDLE_FLAGS_NONE',
		'RSVG_HANDLE_FLAG_KEEP_IMAGE_DATA',
		'RSVG_HANDLE_FLAG_UNLIMITED'
	],
	#category : 'RSVG-Base',
	#package : 'RSVG',
	#tag : 'Base'
}

{ #category : 'accessing enum' }
RsvgHandleFlags class >> RSVG_HANDLE_FLAGS_NONE [
	"This method was automatically generated"
	^ RSVG_HANDLE_FLAGS_NONE
]

{ #category : 'accessing enum' }
RsvgHandleFlags class >> RSVG_HANDLE_FLAG_KEEP_IMAGE_DATA [
	"This method was automatically generated"
	^ RSVG_HANDLE_FLAG_KEEP_IMAGE_DATA
]

{ #category : 'accessing enum' }
RsvgHandleFlags class >> RSVG_HANDLE_FLAG_UNLIMITED [
	"This method was automatically generated"
	^ RSVG_HANDLE_FLAG_UNLIMITED
]

{ #category : 'enum declaration' }
RsvgHandleFlags class >> enumDecl [

	^ #(
	RSVG_HANDLE_FLAGS_NONE 0
	RSVG_HANDLE_FLAG_UNLIMITED 1
	RSVG_HANDLE_FLAG_KEEP_IMAGE_DATA 2 )
]
