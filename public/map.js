mapboxgl.accessToken = "pk.eyJ1IjoiZW1lbGRtb24iLCJhIjoiY2tobnM1YXhmMGZmMDJyazhpa2g4ZDhsaSJ9.j7xg-pGQhSsvZoHAkoAr9w";

const map = new mapboxgl.Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v11',
  zoom: 12,
  center: [35.8703535, 48.5317201]
});

map.addControl(
  new mapboxgl.GeolocateControl({
    positionOptions: { enableHighAccuracy: true },
    trackUserLocation: true
  })
);

const locations = document.getElementsByClassName("js-location");
const locationsCount = locations.length;

console.log("locations::", locations);

for (i = 0; i < locations.length; i++) {
  let locationData = locations[i].dataset;
  new mapboxgl.Marker().setLngLat([locationData.longitude, locationData.latitude]).addTo(map);
}
