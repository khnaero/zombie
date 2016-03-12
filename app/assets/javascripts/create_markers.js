function initialize() {
  var mapProp = {
    center:new google.maps.LatLng(30.2848, -97.7213),
    zoom: 12,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);

  $.ajax({
    dataType: 'json',
    url: '/zombies.json',
    success: function(data) {
      console.log(JSON.stringify(data));

      for (i = 0; i < data.length; i++) {
        var marker = new google.maps.Marker({
        position: {lat: data[i].geometry.coordinates[1], lng: data[i].geometry.coordinates[0]},
        title: data[i].properties.name,
        map: map,
        });
      }
    }
  });
}
google.maps.event.addDomListener(window, 'load', initialize);