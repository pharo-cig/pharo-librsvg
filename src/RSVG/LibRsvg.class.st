"
Bindings for librsvg (the gnome svg renderer): https://wiki.gnome.org/Projects/LibRsvg

Generated with: 
```smalltalk
CigCLibraryGenerator new
	packageName: 'RSVG';
	prefix: 'Rsvg';
	libraryName: 'rsvg';
	importUnit: '
typedef bool Boolean;
#include <rsvg.h>';
	cIncludePath: '/home/esteban/dev/pharo/pulsar/librsvg-2.0';
	cIncludePath: '/home/esteban/dev/pharo/pulsar/librsvg-2.0/librsvg';
	nameGenerator: (CigNameGenerator new withoutPrefixInFunctionName);
	generate.
```

**WARNING:** This library is part of the gnome sub-system, to work it requires also glib/gio. 
"
Class {
	#name : 'LibRsvg',
	#superclass : 'FFILibrary',
	#pools : [
		'RsvgConstants',
		'RsvgTypedef'
	],
	#category : 'RSVG-Library',
	#package : 'RSVG',
	#tag : 'Library'
}

{ #category : 'rendering' }
LibRsvg class >> renderFromString: aString size: aPoint [
	"This method requires Alexandrie installed to work"
	| rsvg errorHandle data handle surface width height cr viewport renderResult form |

	rsvg := self uniqueInstance.
	
	width := aPoint x. 
	height := aPoint y.

	data := aString utf8Encoded.
	errorHandle := GError newValueHolder.
	handle := rsvg 
		handle_new_from_data: data
		data_len: data size
	  	error: errorHandle.
	handle isNullOrNil ifTrue: [
	 	self error: ('{1}: {2}' format: { 
	 		errorHandle value code.
	 		errorHandle value messageString }) ].
	 
	surface := AeCairoImageSurface 
		unownedNewWithFormat: AeCairoSurfaceFormat argb32
		width: width 
		height: height.
	cr := AeCairoContext unownedNewFor: surface.

	cr saveState.
	cr setOperatorClear.
	cr paint.
	cr restoreState.

	viewport := RsvgRectangle new 
		width: width;
		height: height;
		yourself.

	errorHandle := GError newValueHolder.
	renderResult := rsvg 
		handle_render_documentHandle: handle 
		cr: cr getHandle 
		viewport: viewport 
		error: errorHandle.
	form := renderResult = 1
		ifTrue: [ surface asForm ]
		ifFalse: [ nil ].

	cr externallyFree.
	surface externallyFree.
	GObject objectUnref: handle getHandle. 

	^ form
]

{ #category : 'public - rsvg' }
LibRsvg >> cleanup [
	"/**
	 * rsvg_cleanup:
	 *
	 * This function does nothing.
	 *
	 * Since: 2.36
	 * Deprecated: 2.46: No-op. This function should not be called from normal programs.
	 */"

	^ self ffiCall: #(int rsvg_cleanup())
]

{ #category : 'public - rsvg' }
LibRsvg >> error_get_type [

	^ self ffiCall: #(int rsvg_error_get_type())
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_flags_get_type [

	^ self ffiCall: #(int rsvg_handle_flags_get_type())
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_base_uri: handle [
	"/**
	 * rsvg_handle_get_base_uri: (attributes org.gtk.Method.get_property=base-uri)
	 * @handle: A [class@Rsvg.Handle]
	 *
	 * Gets the base uri for this [class@Rsvg.Handle].
	 *
	 * Returns: the base uri, possibly null
	 * Since: 2.8
	 */"

	^ self ffiCall: #(const char* rsvg_handle_get_base_uri(RsvgHandle* handle))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_desc: handle [
	"/**
	 * rsvg_handle_get_desc:
	 * @handle: An [class@Rsvg.Handle]
	 *
	 * Returns: (nullable): This function always returns `NULL`.
	 *
	 * Since: 2.4
	 *
	 * Deprecated: 2.36.  Librsvg does not read the metadata/desc/title elements;
	 * this function always returns `NULL`.
	 */"

	^ self ffiCall: #(const int* rsvg_handle_get_desc(RsvgHandle* handle))
]

{ #category : 'public - rsvg-cairo' }
LibRsvg >> handle_get_geometry_for_elementHandle: handle id: id out_ink_rect: out_ink_rect out_logical_rect: out_logical_rect error: error [
	"/**
	 * rsvg_handle_get_geometry_for_element:
	 * @handle: An [class@Rsvg.Handle]
	 * @id: (nullable): An element's id within the SVG, starting with ""#"" (a single
	 * hash character), for example, `#layer1`.  This notation corresponds to a
	 * URL's fragment ID.  Alternatively, pass `NULL` to compute the geometry for the
	 * whole SVG.
	 * @out_ink_rect: (out)(optional): Place to store the ink rectangle of the element.
	 * @out_logical_rect: (out)(optional): Place to store the logical rectangle of the element.
	 * @error: return location for a `GError`
	 *
	 * Computes the ink rectangle and logical rectangle of a single SVG element.
	 *
	 * While `rsvg_handle_get_geometry_for_layer` computes the geometry of an SVG element subtree with
	 * its transformation matrix, this other function will compute the element's geometry
	 * as if it were being rendered under an identity transformation by itself.  That is,
	 * the resulting geometry is as if the element got extracted by itself from the SVG.
	 *
	 * This function is the counterpart to `rsvg_handle_render_element`.
	 *
	 * Element IDs should look like an URL fragment identifier; for example, pass
	 * `#foo` (hash `foo`) to get the geometry of the element that
	 * has an `id=""foo""` attribute.
	 *
	 * The ""ink rectangle"" is the bounding box that would be painted
	 * for fully- stroked and filled elements.
	 *
	 * The ""logical rectangle"" just takes into account the unstroked
	 * paths and text outlines.
	 *
	 * Note that these bounds are not minimum bounds; for example,
	 * clipping paths are not taken into account.
	 *
	 * You can pass `NULL` for the @id if you want to measure all
	 * the elements in the SVG, i.e. to measure everything from the
	 * root element.
	 *
	 * This operation is not constant-time, as it involves going through all
	 * the child elements.
	 *
	 * Returns: `TRUE` if the geometry could be obtained, or `FALSE` on error.  Errors
	 * are returned in the @error argument.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Panics: this function will panic if the @handle is not fully-loaded.
	 *
	 * Since: 2.46
	 */"

	^ self ffiCall: #(int rsvg_handle_get_geometry_for_element(RsvgHandle* handle, const char* id, RsvgRectangle* out_ink_rect, RsvgRectangle* out_logical_rect, int** error))
]

{ #category : 'public - rsvg-cairo' }
LibRsvg >> handle_get_geometry_for_layerHandle: handle id: id viewport: viewport out_ink_rect: out_ink_rect out_logical_rect: out_logical_rect error: error [
	"/**
	 * rsvg_handle_get_geometry_for_layer:
	 * @handle: An [class@Rsvg.Handle]
	 * @id: (nullable): An element's id within the SVG, starting with ""#"" (a single
	 * hash character), for example, `#layer1`.  This notation corresponds to a
	 * URL's fragment ID.  Alternatively, pass `NULL` to compute the geometry for the
	 * whole SVG.
	 * @viewport: Viewport size at which the whole SVG would be fitted.
	 * @out_ink_rect: (out)(optional): Place to store the ink rectangle of the element.
	 * @out_logical_rect: (out)(optional): Place to store the logical rectangle of the element.
	 * @error: return location for a `GError`
	 *
	 * Computes the ink rectangle and logical rectangle of an SVG element, or the
	 * whole SVG, as if the whole SVG were rendered to a specific viewport.
	 *
	 * Element IDs should look like an URL fragment identifier; for example, pass
	 * `#foo` (hash `foo`) to get the geometry of the element that
	 * has an `id=""foo""` attribute.
	 *
	 * The ""ink rectangle"" is the bounding box that would be painted
	 * for fully-stroked and filled elements.
	 *
	 * The ""logical rectangle"" just takes into account the unstroked
	 * paths and text outlines.
	 *
	 * Note that these bounds are not minimum bounds; for example,
	 * clipping paths are not taken into account.
	 *
	 * You can pass `NULL` for the @id if you want to measure all
	 * the elements in the SVG, i.e. to measure everything from the
	 * root element.
	 *
	 * This operation is not constant-time, as it involves going through all
	 * the child elements.
	 *
	 * Returns: `TRUE` if the geometry could be obtained, or `FALSE` on error.  Errors
	 * are returned in the @error argument.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Panics: this function will panic if the @handle is not fully-loaded.
	 *
	 * Since: 2.46
	 */"

	^ self ffiCall: #(int rsvg_handle_get_geometry_for_layer(RsvgHandle* handle, const char* id, const RsvgRectangle* viewport, RsvgRectangle* out_ink_rect, RsvgRectangle* out_logical_rect, int** error))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_intrinsic_dimensionsHandle: handle out_has_width: out_has_width out_width: out_width out_has_height: out_has_height out_height: out_height out_has_viewbox: out_has_viewbox out_viewbox: out_viewbox [
	"/**
	 * rsvg_handle_get_intrinsic_dimensions:
	 * @handle: An [class@Rsvg.Handle]
	 * @out_has_width: (out)(optional): Will be set to `TRUE`; see below.
	 * @out_width: (out)(optional): Will be set to the computed value of the `width` property in the toplevel SVG.
	 * @out_has_height: (out)(optional): Will be set to `TRUE`; see below.
	 * @out_height: (out)(optional): Will be set to the computed value of the `height` property in the toplevel SVG.
	 * @out_has_viewbox: (out)(optional): Will be set to `TRUE` if the toplevel SVG has a `viewBox` attribute
	 * @out_viewbox: (out)(optional): Will be set to the value of the `viewBox` attribute in the toplevel SVG
	 *
	 * In simple terms, queries the `width`, `height`, and `viewBox` attributes in an SVG document.
	 *
	 * If you are calling this function to compute a scaling factor to render the SVG,
	 * consider simply using [method@Rsvg.Handle.render_document] instead; it will do the
	 * scaling computations automatically.
	 *
	 * Before librsvg 2.54.0, the `out_has_width` and `out_has_height` arguments would be set to true or false
	 * depending on whether the SVG document actually had `width` and `height` attributes, respectively.
	 *
	 * However, since librsvg 2.54.0, `width` and `height` are now [geometry
	 * properties](https://www.w3.org/TR/SVG2/geometry.html) per the SVG2 specification; they
	 * are not plain attributes.  SVG2 made it so that the initial value of those properties
	 * is `auto`, which is equivalent to specifing a value of `100%`.  In this sense, even SVG
	 * documents which lack `width` or `height` attributes semantically have to make them
	 * default to `100%`.  This is why since librsvg 2.54.0, `out_has_width` and
	 * `out_has_heigth` are always returned as `TRUE`, since with SVG2 all documents *have* a
	 * default width and height of `100%`.
	 *
	 * As an example, the following SVG element has a `width` of 100 pixels and a `height` of 400 pixels, but no `viewBox`.  This
	 * function will return those sizes in `out_width` and `out_height`, and set `out_has_viewbox` to `FALSE`.
	 *
	 * ```
	 * <svg xmlns=""http://www.w3.org/2000/svg"" width=""100"" height=""400"">
	 * ```
	 *
	 * Conversely, the following element has a `viewBox`, but no `width` or `height`.  This function will
	 * set `out_has_viewbox` to `TRUE`, and it will also set `out_has_width` and `out_has_height` to `TRUE` but
	 * return both length values as `100%`.
	 *
	 * ```
	 * <svg xmlns=""http://www.w3.org/2000/svg"" viewBox=""0 0 100 400"">
	 * ```
	 *
	 * Note that the `RsvgLength` return values have `RsvgUnits` in them; you should
	 * not assume that they are always in pixels.  For example, the following SVG element
	 * will return width and height values whose `units` fields are `RSVG_UNIT_MM`.
	 *
	 * ```
	 * <svg xmlns=""http://www.w3.org/2000/svg"" width=""210mm"" height=""297mm"">
	 * ```
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Panics: this function will panic if the @handle is not fully-loaded.
	 *
	 * Since: 2.46
	 */"

	self ffiCall: #(void rsvg_handle_get_intrinsic_dimensions(RsvgHandle* handle, int* out_has_width, RsvgLength* out_width, int* out_has_height, RsvgLength* out_height, int* out_has_viewbox, RsvgRectangle* out_viewbox))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_intrinsic_size_in_pixelsHandle: handle out_width: out_width out_height: out_height [
	"/**
	 * rsvg_handle_get_intrinsic_size_in_pixels:
	 * @handle: An [class@Rsvg.Handle]
	 * @out_width: (out)(optional): Will be set to the computed width; you should round this up to get integer pixels.
	 * @out_height: (out)(optional): Will be set to the computed height; you should round this up to get integer pixels.
	 *
	 * Converts an SVG document's intrinsic dimensions to pixels, and returns the result.
	 *
	 * This function is able to extract the size in pixels from an SVG document if the
	 * document has both `width` and `height` attributes
	 * with physical units (px, in, cm, mm, pt, pc) or font-based units (em, ex).  For
	 * physical units, the dimensions are normalized to pixels using the dots-per-inch (DPI)
	 * value set previously with [method@Rsvg.Handle.set_dpi].  For font-based units, this function
	 * uses the computed value of the `font-size` property for the toplevel
	 * `<svg>` element.  In those cases, this function returns `TRUE`.
	 *
	 * For historical reasons, the default DPI is 90.  Current CSS assumes a default DPI of 96, so
	 * you may want to set the DPI of a [class@Rsvg.Handle] immediately after creating it with
	 * [method@Rsvg.Handle.set_dpi].
	 *
	 * This function is not able to extract the size in pixels directly from the intrinsic
	 * dimensions of the SVG document if the `width` or
	 * `height` are in percentage units (or if they do not exist, in which
	 * case the SVG spec mandates that they default to 100%), as these require a
	 * <firstterm>viewport</firstterm> to be resolved to a final size.  In this case, the
	 * function returns `FALSE`.
	 *
	 * For example, the following document fragment has intrinsic dimensions that will resolve
	 * to 20x30 pixels.
	 *
	 * ```
	 * <svg xmlns=""http://www.w3.org/2000/svg"" width=""20"" height=""30""/>
	 * ```
	 *
	 * Similarly, if the DPI is set to 96, this document will resolve to 192×288 pixels (i.e. 96×2 × 96×3).
	 *
	 * ```
	 * <svg xmlns=""http://www.w3.org/2000/svg"" width=""2in"" height=""3in""/>
	 * ```
	 *
	 * The dimensions of the following documents cannot be resolved to pixels directly, and
	 * this function would return `FALSE` for them:
	 *
	 * ```
	 * <!-- Needs a viewport against which to compute the percentages. -->
	 * <svg xmlns=""http://www.w3.org/2000/svg"" width=""100%"" height=""100%""/>
	 *
	 * <!-- Does not have intrinsic width/height, just a 1:2 aspect ratio which
	 *      needs to be fitted within a viewport. -->
	 * <svg xmlns=""http://www.w3.org/2000/svg"" viewBox=""0 0 100 200""/>
	 * ```
	 *
	 * Instead of querying an SVG document's size, applications are encouraged to render SVG
	 * documents to a size chosen by the application, by passing a suitably-sized viewport to
	 * [method@Rsvg.Handle.render_document].
	 *
	 * Returns: `TRUE` if the dimensions could be converted directly to pixels; in this case
	 * @out_width and @out_height will be set accordingly.  Note that the dimensions are
	 * floating-point numbers, so your application can know the exact size of an SVG document.
	 * To get integer dimensions, you should use `ceil()` to round up to the nearest integer
	 * (just using `round()`, may may chop off pixels with fractional coverage).  If the
	 * dimensions cannot be converted to pixels, returns `FALSE` and puts 0.0 in both
	 * @out_width and @out_height.
	 *
	 * Since: 2.52
	 */"

	^ self ffiCall: #(int rsvg_handle_get_intrinsic_size_in_pixels(RsvgHandle* handle, int* out_width, int* out_height))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_metadata: handle [
	"/**
	 * rsvg_handle_get_metadata:
	 * @handle: An [class@Rsvg.Handle]
	 *
	 * Returns: (nullable): This function always returns `NULL`.
	 *
	 * Since: 2.9
	 *
	 * Deprecated: 2.36.  Librsvg does not read the metadata/desc/title elements;
	 * this function always returns `NULL`.
	 */"

	^ self ffiCall: #(const int* rsvg_handle_get_metadata(RsvgHandle* handle))
]

{ #category : 'public - rsvg-pixbuf' }
LibRsvg >> handle_get_pixbuf_and_errorHandle: handle error: error [
	"/**
	 * rsvg_handle_get_pixbuf_and_error:
	 * @handle: An [class@Rsvg.Handle]
	 * @error: return location for a `GError`
	 *
	 * Returns the pixbuf loaded by @handle.  The pixbuf returned will be reffed, so
	 * the caller of this function must assume that ref.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * This function depends on the [class@Rsvg.Handle]'s dots-per-inch value (DPI) to compute the
	 * ""natural size"" of the document in pixels, so you should call [method@Rsvg.Handle.set_dpi]
	 * beforehand.
	 *
	 * Returns: (transfer full) (nullable): A pixbuf, or %NULL on error
	 * during rendering.
	 *
	 * Since: 2.59
	 **/"

	^ self ffiCall: #(int* rsvg_handle_get_pixbuf_and_error(RsvgHandle* handle, int** error))
]

{ #category : 'public - rsvg-pixbuf' }
LibRsvg >> handle_get_pixbuf_subHandle: handle id: id [
	"/**
	 * rsvg_handle_get_pixbuf_sub:
	 * @handle: An #RsvgHandle
	 * @id: (nullable): An element's id within the SVG, starting with ""#"" (a single
	 * hash character), for example, `#layer1`.  This notation corresponds to a
	 * URL's fragment ID.  Alternatively, pass `NULL` to use the whole SVG.
	 *
	 * Creates a `GdkPixbuf` the same size as the entire SVG loaded into @handle, but
	 * only renders the sub-element that has the specified @id (and all its
	 * sub-sub-elements recursively).  If @id is `NULL`, this function renders the
	 * whole SVG.
	 *
	 * This function depends on the [class@Rsvg.Handle]'s dots-per-inch value (DPI) to compute the
	 * ""natural size"" of the document in pixels, so you should call [method@Rsvg.Handle.set_dpi]
	 * beforehand.
	 *
	 * If you need to render an image which is only big enough to fit a particular
	 * sub-element of the SVG, consider using [method@Rsvg.Handle.render_element].
	 *
	 * Element IDs should look like an URL fragment identifier; for example, pass
	 * `#foo` (hash `foo`) to get the geometry of the element that
	 * has an `id=""foo""` attribute.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Returns: (transfer full) (nullable): a pixbuf, or `NULL` if an error occurs
	 * during rendering.
	 *
	 * Since: 2.14
	 **/"

	^ self ffiCall: #(int* rsvg_handle_get_pixbuf_sub(RsvgHandle* handle, const char* id))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_title: handle [
	"/**
	 * rsvg_handle_get_title:
	 * @handle: An [class@Rsvg.Handle]
	 *
	 * Returns: (nullable): This function always returns `NULL`.
	 *
	 * Since: 2.4
	 *
	 * Deprecated: 2.36.  Librsvg does not read the metadata/desc/title elements;
	 * this function always returns `NULL`.
	 */"

	^ self ffiCall: #(const int* rsvg_handle_get_title(RsvgHandle* handle))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_get_type [

	^ self ffiCall: #(int rsvg_handle_get_type())
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_has_subHandle: handle id: id [
	"/**
	 * rsvg_handle_has_sub:
	 * @handle: a [class@Rsvg.Handle]
	 * @id: An element's id within the SVG, starting with ""#"" (a single hash
	 * character), for example, `#layer1`.  This notation corresponds to a URL's
	 * fragment ID.
	 *
	 * Checks whether the element @id exists in the SVG document.
	 *
	 * Element IDs should look like an URL fragment identifier; for example, pass
	 * `#foo` (hash `foo`) to get the geometry of the element that
	 * has an `id=""foo""` attribute.
	 *
	 * Returns: `TRUE` if @id exists in the SVG document, `FALSE` otherwise.
	 *
	 * Since: 2.22
	 */"

	^ self ffiCall: #(int rsvg_handle_has_sub(RsvgHandle* handle, const char* id))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_internal_set_testingHandle: handle testing: testing [
	"/**
	 * rsvg_handle_internal_set_testing:
	 * @handle: a [class@Rsvg.Handle]
	 * @testing: Whether to enable testing mode
	 *
	 * Do not call this function.  This is intended for librsvg's internal
	 * test suite only.
	 **/"

	self ffiCall: #(void rsvg_handle_internal_set_testing(RsvgHandle* handle, int testing))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_new [
	"/**
	 * rsvg_handle_new:
	 *
	 * Returns a new rsvg handle.  Must be freed with [method@GObject.Object.unref].  This
	 * handle can be used to load an image.
	 *
	 * The preferred way of loading SVG data into the returned [class@Rsvg.Handle] is with
	 * [method@Rsvg.Handle.read_stream_sync].
	 *
	 * The deprecated way of loading SVG data is with [method@Rsvg.Handle.write] and
	 * [method@Rsvg.Handle.close]; note that these require buffering the entire file
	 * internally, and for this reason it is better to use the stream functions:
	 * [ctor@Rsvg.Handle.new_from_stream_sync], [method@Rsvg.Handle.read_stream_sync], or
	 * [ctor@Rsvg.Handle.new_from_gfile_sync].
	 *
	 * After loading the [class@Rsvg.Handle] with data, you can render it using Cairo or get
	 * a GdkPixbuf from it. When finished, free the handle with [method@GObject.Object.unref]. No
	 * more than one image can be loaded with one handle.
	 *
	 * Note that this function creates an [class@Rsvg.Handle] with no flags set.  If you
	 * require any of [flags@Rsvg.HandleFlags] to be set, use any of
	 * [ctor@Rsvg.Handle.new_with_flags], [ctor@Rsvg.Handle.new_from_stream_sync], or
	 * [ctor@Rsvg.Handle.new_from_gfile_sync].
	 *
	 * Returns: (transfer full): A new [class@Rsvg.Handle] with no flags set.
	 **/"

	^ self ffiCall: #(RsvgHandle* rsvg_handle_new())
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_new_from_data: data data_len: data_len error: error [
	"/**
	 * rsvg_handle_new_from_data:
	 * @data: (array length=data_len): The SVG data
	 * @data_len: The length of @data, in bytes
	 * @error: return location for a `GError`
	 *
	 * Loads the SVG specified by @data.  Note that this function creates an
	 * [class@Rsvg.Handle] without a base URL, and without any [flags@Rsvg.HandleFlags].  If you
	 * need these, use [ctor@Rsvg.Handle.new_from_stream_sync] instead by creating
	 * a [class@Gio.MemoryInputStream] from your data.
	 *
	 * Returns: (transfer full) (nullable): A [class@Rsvg.Handle] or `NULL` if an error occurs.
	 * Since: 2.14
	 */"

	^ self ffiCall: #(RsvgHandle* rsvg_handle_new_from_data(const int* data, int data_len, int** error))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_new_from_fileFilename: filename error: error [
	"/**
	 * rsvg_handle_new_from_file:
	 * @filename: The file name to load, or a URI.
	 * @error: return location for a `GError`
	 *
	 * Loads the SVG specified by @file_name.  Note that this function, like
	 * [ctor@Rsvg.Handle.new], does not specify any loading flags for the resulting
	 * handle.  If you require the use of [flags@Rsvg.HandleFlags], use
	 * [ctor@Rsvg.Handle.new_from_gfile_sync].
	 *
	 * Returns: (transfer full) (nullable): A [class@Rsvg.Handle] or `NULL` if an error occurs.
	 * Since: 2.14
	 */"

	^ self ffiCall: #(RsvgHandle* rsvg_handle_new_from_file(const int* filename, int** error))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_new_from_gfile_syncFile: file flags: flags cancellable: cancellable error: error [
	"/**
	 * rsvg_handle_new_from_gfile_sync:
	 * @file: a `GFile`
	 * @flags: flags from [flags@Rsvg.HandleFlags]
	 * @cancellable: (nullable): a `GCancellable`, or `NULL`
	 * @error: return location for a `GError`
	 *
	 * Creates a new [class@Rsvg.Handle] for @file.
	 *
	 * This function sets the ""base file"" of the handle to be @file itself, so SVG
	 * elements like `<image>` which reference external
	 * resources will be resolved relative to the location of @file.
	 *
	 * If @cancellable is not `NULL`, then the operation can be cancelled by
	 * triggering the cancellable object from another thread. If the
	 * operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
	 * returned in @error.
	 *
	 * Returns: (transfer full) (nullable): a new [class@Rsvg.Handle] on success, or `NULL` with @error filled in
	 *
	 * Since: 2.32
	 */"

	^ self ffiCall: #(RsvgHandle* rsvg_handle_new_from_gfile_sync(int* file, RsvgHandleFlags flags, int* cancellable, int** error))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_new_from_stream_syncInput_stream: input_stream base_file: base_file flags: flags cancellable: cancellable error: error [
	"/**
	 * rsvg_handle_new_from_stream_sync:
	 * @input_stream: a `GInputStream`
	 * @base_file: (nullable): a `GFile`, or `NULL`
	 * @flags: flags from [flags@Rsvg.HandleFlags]
	 * @cancellable: (nullable): a `GCancellable`, or `NULL`
	 * @error: return location for a `GError`
	 *
	 * Creates a new [class@Rsvg.Handle] for @stream.
	 *
	 * This function sets the ""base file"" of the handle to be @base_file if
	 * provided.  SVG elements like `<image>` which reference
	 * external resources will be resolved relative to the location of @base_file.
	 *
	 * If @cancellable is not `NULL`, then the operation can be cancelled by
	 * triggering the cancellable object from another thread. If the
	 * operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
	 * returned in @error.
	 *
	 * Returns: (transfer full) (nullable): a new [class@Rsvg.Handle] on success, or `NULL` with @error filled in
	 *
	 * Since: 2.32
	 */"

	^ self ffiCall: #(RsvgHandle* rsvg_handle_new_from_stream_sync(int* input_stream, int* base_file, RsvgHandleFlags flags, int* cancellable, int** error))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_new_with_flags: flags [
	"/**
	 * rsvg_handle_new_with_flags:
	 * @flags: flags from [flags@Rsvg.HandleFlags]
	 *
	 * Creates a new [class@Rsvg.Handle] with flags @flags.  After calling this function,
	 * you can feed the resulting handle with SVG data by using
	 * [method@Rsvg.Handle.read_stream_sync].
	 *
	 * Returns: (transfer full): a new [class@Rsvg.Handle]
	 *
	 * Since: 2.36
	 **/"

	^ self ffiCall: #(RsvgHandle* rsvg_handle_new_with_flags(RsvgHandleFlags flags))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_read_stream_syncHandle: handle stream: stream cancellable: cancellable error: error [
	"/**
	 * rsvg_handle_read_stream_sync:
	 * @handle: a [class@Rsvg.Handle]
	 * @stream: a `GInputStream`
	 * @cancellable: (nullable): a `GCancellable`, or `NULL`
	 * @error: return location for a `GError`
	 *
	 * Reads @stream and writes the data from it to @handle.
	 *
	 * Before calling this function, you may need to call [method@Rsvg.Handle.set_base_uri]
	 * or [method@Rsvg.Handle.set_base_gfile] to set the ""base file"" for resolving
	 * references to external resources.  SVG elements like
	 * `<image>` which reference external resources will be
	 * resolved relative to the location you specify with those functions.
	 *
	 * If @cancellable is not `NULL`, then the operation can be cancelled by
	 * triggering the cancellable object from another thread. If the
	 * operation was cancelled, the error `G_IO_ERROR_CANCELLED` will be
	 * returned.
	 *
	 * Returns: `TRUE` if reading @stream succeeded, or `FALSE` otherwise
	 *   with @error filled in
	 *
	 * Since: 2.32
	 */"

	^ self ffiCall: #(int rsvg_handle_read_stream_sync(RsvgHandle* handle, int* stream, int* cancellable, int** error))
]

{ #category : 'public - rsvg-cairo' }
LibRsvg >> handle_render_documentHandle: handle cr: cr viewport: viewport error: error [
	"/**
	 * rsvg_handle_render_document:
	 * @handle: An [class@Rsvg.Handle]
	 * @cr: A Cairo context
	 * @viewport: Viewport size at which the whole SVG would be fitted.
	 * @error: return location for a `GError`
	 *
	 * Renders the whole SVG document fitted to a viewport.
	 *
	 * The @viewport gives the position and size at which the whole SVG document will be
	 * rendered.  The document is scaled proportionally to fit into this viewport.
	 *
	 * The @cr must be in a `CAIRO_STATUS_SUCCESS` state, or this function will not
	 * render anything, and instead will return an error.
	 *
	 * Returns: `TRUE` on success, `FALSE` on error.  Errors are returned
	 * in the @error argument.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Panics: this function will panic if the @handle is not fully-loaded.
	 *
	 * Since: 2.46
	 */"

	^ self ffiCall: #(int rsvg_handle_render_document(RsvgHandle* handle, int* cr, const RsvgRectangle* viewport, int** error))
]

{ #category : 'public - rsvg-cairo' }
LibRsvg >> handle_render_elementHandle: handle cr: cr id: id element_viewport: element_viewport error: error [
	"/**
	 * rsvg_handle_render_element:
	 * @handle: An [class@Rsvg.Handle]
	 * @cr: A Cairo context
	 * @id: (nullable): An element's id within the SVG, starting with ""#"" (a single
	 * hash character), for example, `#layer1`.  This notation corresponds to a
	 * URL's fragment ID.  Alternatively, pass `NULL` to render the whole SVG document tree.
	 * @element_viewport: Viewport size in which to fit the element
	 * @error: return location for a `GError`
	 *
	 * Renders a single SVG element to a given viewport.
	 *
	 * This function can be used to extract individual element subtrees and render them,
	 * scaled to a given @element_viewport.  This is useful for applications which have
	 * reusable objects in an SVG and want to render them individually; for example, an
	 * SVG full of icons that are meant to be be rendered independently of each other.
	 *
	 * Element IDs should look like an URL fragment identifier; for example, pass
	 * `#foo` (hash `foo`) to get the geometry of the element that
	 * has an `id=""foo""` attribute.
	 *
	 * You can pass `NULL` for the @id if you want to render all
	 * the elements in the SVG, i.e. to render everything from the
	 * root element.
	 *
	 * The `element_viewport` gives the position and size at which the named element will
	 * be rendered.  FIXME: mention proportional scaling.
	 *
	 * Returns: `TRUE` on success, `FALSE` on error.  Errors are returned
	 * in the @error argument.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Panics: this function will panic if the @handle is not fully-loaded.
	 *
	 * Since: 2.46
	 */"

	^ self ffiCall: #(int rsvg_handle_render_element(RsvgHandle* handle, int* cr, const char* id, const RsvgRectangle* element_viewport, int** error))
]

{ #category : 'public - rsvg-cairo' }
LibRsvg >> handle_render_layerHandle: handle cr: cr id: id viewport: viewport error: error [
	"/**
	 * rsvg_handle_render_layer:
	 * @handle: An [class@Rsvg.Handle]
	 * @cr: A Cairo context
	 * @id: (nullable): An element's id within the SVG, starting with ""#"" (a single
	 * hash character), for example, `#layer1`.  This notation corresponds to a
	 * URL's fragment ID.  Alternatively, pass `NULL` to render the whole SVG document tree.
	 * @viewport: Viewport size at which the whole SVG would be fitted.
	 * @error: return location for a `GError`
	 *
	 * Renders a single SVG element in the same place as for a whole SVG document.
	 *
	 * The @viewport gives the position and size at which the whole SVG document would be
	 * rendered.  The document is scaled proportionally to fit into this viewport; hence the
	 * individual layer may be smaller than this.
	 *
	 * This is equivalent to [method@Rsvg.Handle.render_document], but it renders only a
	 * single element and its children, as if they composed an individual layer in
	 * the SVG.  The element is rendered with the same transformation matrix as it
	 * has within the whole SVG document.  Applications can use this to re-render a
	 * single element and repaint it on top of a previously-rendered document, for
	 * example.
	 *
	 * Element IDs should look like an URL fragment identifier; for example, pass
	 * `#foo` (hash `foo`) to get the geometry of the element that
	 * has an `id=""foo""` attribute.
	 *
	 * You can pass `NULL` for the @id if you want to render all
	 * the elements in the SVG, i.e. to render everything from the
	 * root element.
	 *
	 * Returns: `TRUE` on success, `FALSE` on error.  Errors are returned
	 * in the @error argument.
	 *
	 * API ordering: This function must be called on a fully-loaded @handle.  See
	 * the section ""[API ordering](class.Handle.html#api-ordering)"" for details.
	 *
	 * Panics: this function will panic if the @handle is not fully-loaded.
	 *
	 * Since: 2.46
	 */"

	^ self ffiCall: #(int rsvg_handle_render_layer(RsvgHandle* handle, int* cr, const char* id, const RsvgRectangle* viewport, int** error))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_set_base_gfileHandle: handle base_file: base_file [
	"/**
	 * rsvg_handle_set_base_gfile:
	 * @handle: a [class@Rsvg.Handle]
	 * @base_file: a `GFile`
	 *
	 * Set the base URI for @handle from @file.
	 *
	 * Note: This function may only be called before [method@Rsvg.Handle.write] or
	 * [method@Rsvg.Handle.read_stream_sync] have been called.
	 *
	 * Since: 2.32
	 */"

	self ffiCall: #(void rsvg_handle_set_base_gfile(RsvgHandle* handle, int* base_file))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_set_base_uriHandle: handle base_uri: base_uri [
	"/**
	 * rsvg_handle_set_base_uri: (attributes org.gtk.Method.set_property=base-uri)
	 * @handle: A [class@Rsvg.Handle]
	 * @base_uri: The base uri
	 *
	 * Set the base URI for this SVG.
	 *
	 * Note: This function may only be called before [method@Rsvg.Handle.write] or
	 * [method@Rsvg.Handle.read_stream_sync] have been called.
	 *
	 * Since: 2.9
	 */"

	self ffiCall: #(void rsvg_handle_set_base_uri(RsvgHandle* handle, const char* base_uri))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_set_cancellable_for_renderingHandle: handle cancellable: cancellable [
	"/**
	 * rsvg_handle_set_cancellable_for_rendering:
	 * @handle: A [class@Rsvg.Handle].
	 * @cancellable: A [class@Gio.Cancellable] or `NULL`.
	 *
	 * Sets a cancellable object that can be used to interrupt rendering
	 * while the handle is being rendered in another thread.  For example,
	 * you can set a cancellable from your main thread, spawn a thread to
	 * do the rendering, and interrupt the rendering from the main thread
	 * by calling g_cancellable_cancel().
	 *
	 * If rendering is interrupted, the corresponding call to
	 * rsvg_handle_render_document() (or any of the other rendering
	 * functions) will return an error with domain `G_IO_ERROR`, and code
	 * `G_IO_ERROR_CANCELLED`.
	 *
	 * Since: 2.59.0
	 */"

	self ffiCall: #(void rsvg_handle_set_cancellable_for_rendering(RsvgHandle* handle, int* cancellable))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_set_dpiHandle: handle dpi: dpi [
	"/**
	 * rsvg_handle_set_dpi:
	 * @handle: An [class@Rsvg.Handle]
	 * @dpi: Dots Per Inch (i.e. as Pixels Per Inch)
	 *
	 * Sets the DPI at which the @handle will be rendered. Common values are
	 * 75, 90, and 300 DPI.
	 *
	 * Passing a number <= 0 to @dpi will reset the DPI to whatever the default
	 * value happens to be, but since [id@rsvg_set_default_dpi] is deprecated, please
	 * do not pass values <= 0 to this function.
	 *
	 * Since: 2.8
	 */"

	self ffiCall: #(void rsvg_handle_set_dpi(RsvgHandle* handle, double dpi))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_set_dpi_x_yHandle: handle dpi_x: dpi_x dpi_y: dpi_y [
	"/**
	 * rsvg_handle_set_dpi_x_y:
	 * @handle: An [class@Rsvg.Handle]
	 * @dpi_x: Dots Per Inch (i.e. Pixels Per Inch)
	 * @dpi_y: Dots Per Inch (i.e. Pixels Per Inch)
	 *
	 * Sets the DPI at which the @handle will be rendered. Common values are
	 * 75, 90, and 300 DPI.
	 *
	 * Passing a number <= 0 to @dpi will reset the DPI to whatever the default
	 * value happens to be, but since [id@rsvg_set_default_dpi_x_y] is deprecated,
	 * please do not pass values <= 0 to this function.
	 *
	 * Since: 2.8
	 */"

	self ffiCall: #(void rsvg_handle_set_dpi_x_y(RsvgHandle* handle, double dpi_x, double dpi_y))
]

{ #category : 'public - rsvg' }
LibRsvg >> handle_set_stylesheetHandle: handle css: css css_len: css_len error: error [
	"/**
	 * rsvg_handle_set_stylesheet:
	 * @handle: A [class@Rsvg.Handle].
	 * @css: (array length=css_len): String with CSS data; must be valid UTF-8.
	 * @css_len: Length of the @css data in bytes.
	 * @error: return location for a `GError`
	 *
	 * Sets a CSS stylesheet to use for an SVG document.
	 *
	 * The @css_len argument is mandatory; this function will not compute the length
	 * of the @css string.  This is because a provided stylesheet, which the calling
	 * program could read from a file, can have nul characters in it.
	 *
	 * During the CSS cascade, the specified stylesheet will be used with a ""User""
	 * [origin](https://drafts.csswg.org/css-cascade-3/#cascading-origins).
	 *
	 * Note that `@import` rules will not be resolved, except for `data:` URLs.
	 *
	 * Returns: `TRUE` on success, `FALSE` on error.  Errors are returned
	 * in the @error argument.
	 *
	 * Since: 2.48
	 */"

	^ self ffiCall: #(int rsvg_handle_set_stylesheet(RsvgHandle* handle, const int* css, int css_len, int** error))
]

{ #category : 'accessing - platform' }
LibRsvg >> macLibraryName [

	^ FFIMacLibraryFinder new
		userPaths: #('./CIG/lib');
		findLibrary: 'librsvg-2.dylib'
]

{ #category : 'accessing' }
LibRsvg >> runner [
	
	^ TFProcessLocalWorker new 
		defaultWorker: TFSameThreadRunner uniqueInstance;
		yourself
]

{ #category : 'public - rsvg' }
LibRsvg >> set_default_dpi: dpi [
	"/**
	 * rsvg_set_default_dpi:
	 * @dpi: Dots Per Inch (aka Pixels Per Inch)
	 *
	 * Do not use this function.  Create an [class@Rsvg.Handle] and call
	 * [method@Rsvg.Handle.set_dpi] on it instead.
	 *
	 * Since: 2.8
	 *
	 * Deprecated: 2.42.3: This function used to set a global default DPI.  However,
	 * it only worked if it was called before any [class@Rsvg.Handle] objects had been
	 * created; it would not work after that.  To avoid global mutable state, please
	 * use [method@Rsvg.Handle.set_dpi] instead.
	 */"

	^ self ffiCall: #(int rsvg_set_default_dpi(double dpi))
]

{ #category : 'public - rsvg' }
LibRsvg >> set_default_dpi_x_yDpi_x: dpi_x dpi_y: dpi_y [
	"/**
	 * rsvg_set_default_dpi_x_y:
	 * @dpi_x: Dots Per Inch (aka Pixels Per Inch)
	 * @dpi_y: Dots Per Inch (aka Pixels Per Inch)
	 *
	 * Do not use this function.  Create an [class@Rsvg.Handle] and call
	 * [method@Rsvg.Handle.set_dpi_x_y] on it instead.
	 *
	 * Since: 2.8
	 *
	 * Deprecated: 2.42.3: This function used to set a global default DPI.  However,
	 * it only worked if it was called before any [class@Rsvg.Handle] objects had been
	 * created; it would not work after that.  To avoid global mutable state, please
	 * use [method@Rsvg.Handle.set_dpi] instead.
	 */"

	^ self ffiCall: #(int rsvg_set_default_dpi_x_y(double dpi_x, double dpi_y))
]

{ #category : 'accessing - platform' }
LibRsvg >> unix64LibraryName [

	^ FFIUnix64LibraryFinder new
		userPaths: #('./CIG/lib');
		findAnyLibrary: #('librsvg-2.so' 'librsvg-2.so.2')
]

{ #category : 'accessing - platform' }
LibRsvg >> win32LibraryName [

	^ FFIWindowsLibraryFinder new
		userPaths: #('./CIG/lib');
		findLibrary: 'librsvg-2.dll'
]
