Class {
	#name : 'RsvgConstants',
	#superclass : 'SharedPool',
	#classVars : [
		'LIBRSVG_VERSION'
	],
	#category : 'RSVG-Library',
	#package : 'RSVG',
	#tag : 'Library'
}

{ #category : 'accessing - constants' }
RsvgConstants class >> LIBRSVG_VERSION [

	^ LIBRSVG_VERSION
]

{ #category : 'class initialization' }
RsvgConstants class >> initialize [

	LIBRSVG_VERSION := '2.61.3'
]
