import { Map } from "./map_constructor.js";

const map = new Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v11',
  zoom: 14,
  center: [35.8753535, 48.5017201]
});

const locations = document.getElementsByClassName("js-location");
const locationsCount = locations.length;

for (let i = 0; i < locations.length; i++) {
  let locationData = locations[i].dataset;
  locationData = {
    longitude: locationData.longitude,
    latitude: locationData.latitude,
  };

  map.addMarker(locationData);
}
