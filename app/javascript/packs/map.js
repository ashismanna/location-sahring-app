// const page_title = $("#pagetitle").attr("title");

const map = new ol.Map({
	target: 'map',
	layers: [
	  new ol.layer.Tile({
	    source: new ol.source.OSM(),
	    title: "base-layer"

	  })
	],
	view: new ol.View({
	  center: [9843520.749788892, 2581059.5347631634],
	  zoom: 6
	})
})

$(document).ready(function(e){
	let page_title = $("#pagetitle").attr("title");
	if(page_title=="Home"){
		$.ajax({
		    url: "get_all_latlong_for_current_user",
		    method: "get",
		    success: function(d){
		    	let public_shared_locations = d.public_shared_locations
		    	let location_shared_with_user = d.location_shared_with_user
		    	$.each( public_shared_locations, function( key, value ) {
		    		let longlat = []
		    		longlat[0] = parseFloat(value["lon"])
		    		longlat[1] = parseFloat(value["lat"])
		    		add_marker(longlat)
		    	})
		    	$.each( location_shared_with_user, function( key, value ) {
		    		let longlat = []
		    		longlat[0] = parseFloat(value["lon"])
		    		longlat[1] = parseFloat(value["lat"])
		    		add_marker_for_locationSharedUser(longlat)
		    	})
		    },
		    error: function () {
		    }
		})
	}
	else if(page_title=="User Page"){
		let username = $("#pagetitle").attr("username")
		$.ajax({
		    url: "get_all_latlong_for_current_user",
		    method: "get",
		    data: {
		    	username: username
		    },
		    success: function(d){
		    	let public_shared_locations = d.public_shared_locations
		    	// let location_shared_with_user = d.location_shared_with_user
		    	$.each( public_shared_locations, function( key, value ) {
		    		let longlat = []
		    		longlat[0] = parseFloat(value["lon"])
		    		longlat[1] = parseFloat(value["lat"])
		    		add_marker(longlat)
		    	})
		    	// $.each( location_shared_with_user, function( key, value ) {
		    	// 	let longlat = []
		    	// 	longlat[0] = parseFloat(value["lon"])
		    	// 	longlat[1] = parseFloat(value["lat"])
		    	// 	add_marker(longlat)
		    	// })
		    },
		    error: function () {
		    }
		})
	}

	// save shared location both public and with friends
	$(".btnfinalShare").on("click",function(e){
		var this_btn = $(this)
		this_btn.prop("disabled", true);
		var allVals=[]
		let can_save=false
		let lat = $("#lat").html()
		let lon = $("#lon").html()
		let is_public = false

		if(lat=="" || lon==""){
			displayFlashMessage("Please select a location to procced !",false)
			this_btn.prop("disabled", false);
		}
		else{
			if ($("#public-radio-btn").is(":checked")) {
					is_public = true
					users = ""
					can_save = true
				}
			else if($("#friends-radio-btn").is(":checked")) {
				$("input[type='checkbox']").each(function() {
					if($(this).is(":checked")){
						allVals.push($(this).val());
					}
	     		})
				if(allVals.length > 0){
					users = allVals.join(",")
					can_save = true
				}
				else{
					displayFlashMessage("Please select user to share location !",false)
					this_btn.prop("disabled", true);
				}
			}
		}
		if(can_save){
			$.ajax({
			    url: "save_shared_location",
			    method: "post",
			    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			    data: {
			    	latitude: lat,
			    	longitude: lon,
			    	is_public: is_public,
			    	users: users
			    },
			    success: function(d){
			    	displayFlashMessage(d.message,d.flag)
			    	location.reload();
			    },
			    error: function () {
			    	displayFlashMessage("something went wrong",false)
			    	this_btn.prop("disabled", true);
			    }
			})
		}
	})


	$(".btnShareOptions").on("click", function(){
		$(".publicDiv").show()
		$(".friendsDiV").show()
	})
	$("#public-radio-btn").on("click", function(){
		$(".btnfinalShare").show()
		$(".frndShareOptions").hide()
	})
	$("#friends-radio-btn").on("click", function(){
		$(".frndShareOptions").show()
		$(".btnfinalShare").show()
	})
})

map.on("click",function(e){
	let page_title = $("#pagetitle").attr("title");
	if(page_title != "Share Location"){
		e.preventDefault()
        return false
	}
	else{
		var lonlat = ol.proj.transform(e.coordinate, 'EPSG:3857', 'EPSG:4326')

		// remove previous marker if present
		remove_previous_marker(map.getLayers())

		// create marker position on clicked co-ordinate
		add_marker(lonlat)

		// print latlong on view
		$("#lon").html("").html(lonlat[0])
		$("#lat").html("").html(lonlat[1])
	}
})

function remove_previous_marker(layers){
	layers.forEach(function(element, index, array){
		if(element.get("title")==="marker"){
			element.setVisible(false)
		}
	})
}

function add_marker(lonlat){
	const iconFeature = new ol.Feature({
	geometry: new ol.geom.Point(ol.proj.fromLonLat(lonlat)),
	name: 'marker-icon',
	});
	const markerLayer =	new ol.layer.Vector({
		source: new ol.source.Vector({
			features: [iconFeature]
		}),
		style: new ol.style.Style({
			image: new ol.style.Icon({
				anchor: [0.5, 46],
				anchorXUnits: 'fraction',
				anchorYUnits: 'pixels',
				src: 'https://openlayers.org/en/latest/examples/data/icon.png'
				// color: '#8959A8'

			})
		}),
		title: "marker",
		visible: true
	})
	map.addLayer(markerLayer)
}

function add_marker_for_locationSharedUser(lonlat){
	const iconFeature = new ol.Feature({
	geometry: new ol.geom.Point(ol.proj.fromLonLat(lonlat)),
	name: 'marker-icon',
	});
	const markerLayer =	new ol.layer.Vector({
		source: new ol.source.Vector({
			features: [iconFeature]
		}),
		style: new ol.style.Style({
			image: new ol.style.Icon({
				anchor: [0.5, 46],
				anchorXUnits: 'fraction',
				anchorYUnits: 'pixels',
				src: 'https://openlayers.org/en/latest/examples/data/icon.png',
				color: '#FFC300'
			})
		}),
		title: "marker",
		visible: true
	})
	map.addLayer(markerLayer)
}




// flash message mehod
function displayFlashMessage(message, flag) {
	var flash_message_container = $("<div></div>");
    flash_message_container.addClass("flash-message-container").text(message);
    if(flag == true) {
    	flash_message_container.addClass("success");
    } else {
    	flash_message_container.addClass("error");
    }
    
    $("body").append(flash_message_container);
    setTimeout(function () {
        flash_message_container.css("bottom", "25px").css("opacity", 1);
        setTimeout(function () {
            flash_message_container.remove("style");
            setTimeout(function () {
                flash_message_container.remove();
            }, 1000);
        }, 3000);
    }, 100);
}

  
