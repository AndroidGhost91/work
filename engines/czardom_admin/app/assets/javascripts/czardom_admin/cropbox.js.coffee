jQuery ($) ->

  new CropBox


class CropBox

  width_crop = 730
  height_crop = 430
  constructor: ->
    $('#cropbox').Jcrop
      aspectRatio: 73 / 43
      setSelect: [0, 0, width_crop, height_crop]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    @updatePreview(coords)
    $('#slide_crop_x').val(coords.x)
    $('#slide_crop_y').val(coords.y)
    $('#slide_crop_w').val(coords.w)
    $('#slide_crop_h').val(coords.h)

  updatePreview: (coords) =>
  	$('#preview').css
  		width: Math.round(width_crop/coords.w * $('#cropbox').width()) + 'px'
  		height: Math.round(height_crop/coords.h * $('#cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round(width_crop/coords.w * coords.x) + 'px'
  		marginTop: '-' + Math.round(height_crop/coords.h * coords.y) + 'px'

