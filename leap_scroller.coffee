$ ->
	leap()

last_pointer = false

scroll = (pointer) ->
	return unless pointer
	if  ! last_pointer
		last_pointer = pointer
	
	if last_pointer.id != pointer.id
		last_pointer = pointer
	distance = Math.round((pointer.tipPositionY - last_pointer.tipPositionY) / 5) * 5
	return unless distance
	
	scroll_top = $(window).scrollTop() + distance
	$('html, body').scrollTop(scroll_top);
	$('#dot').css({position: 'absolute', left: '20px', top: scroll_top});
	last_pointer = pointer

leap = () ->
	Leap.loop (frame) ->
		pointables = frame.pointables.map (d) ->
			id: d.id
			handId: d.handId
			length: d.length
			directionX: d.direction[0]
			directionY: d.direction[1]
			directionZ: d.direction[2]
			tipPositionX: d.tipPosition[0]
			tipPositionY: d.tipPosition[1]
			tipPositionZ: d.tipPosition[2]
			tipVelocityX: d.tipVelocity[0]
			tipVelocityY: d.tipVelocity[1]
			tipVelocityZ: d.tipVelocity[2]
		if pointables[0] && pointables[1]
			scroll pointables[0] # pass first one, idgaf