Class {
	#name : 'RsvgTypedef',
	#superclass : 'SharedPool',
	#classVars : [
		'RsvgError',
		'_RsvgDimensionData',
		'_RsvgHandle',
		'_RsvgHandleClass',
		'_RsvgPositionData',
		'_RsvgRectangle',
		'__float128',
		'bool',
		'int16_t',
		'int32_t',
		'int64_t',
		'int8_t',
		'int_15',
		'int_16',
		'pid_t',
		'time_t',
		'uint16_t',
		'uint32_t',
		'uint64_t',
		'uint8_t',
		'uintptr_t'
	],
	#category : 'RSVG-Library',
	#package : 'RSVG',
	#tag : 'Library'
}

{ #category : 'class initialization' }
RsvgTypedef class >> initialize [

	uint16_t := #uint16.
	uint64_t := #uint64.
	uint8_t := #uint8.
	int32_t := #int32.
	uint32_t := #uint32.
	time_t := #int.
	pid_t := #int.
	__float128 := #float128.
	int8_t := #int8.
	int16_t := #int16.
	int64_t := #int64.
	bool := #Boolean.
	uintptr_t := #'void *'.
	RsvgError := #int.
	int_16 := FFIArray ofType: 'int' size: 16 requestor: self.
	_RsvgHandle := RsvgHandle.
	int_15 := FFIArray ofType: 'int' size: 15 requestor: self.
	_RsvgHandleClass := RsvgHandleClass.
	_RsvgDimensionData := RsvgDimensionData.
	_RsvgPositionData := RsvgPositionData.
	_RsvgRectangle := RsvgRectangle
]
