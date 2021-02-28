import { Map } from './map_constructor.js';

const getLocationData = () => {
  const locations = document.getElementsByClassName('js-location');
  const locationData = locations[0].dataset;

  return locationData;
};

const locationData = getLocationData();

const map = new Map({
  container: 'map',
  style: 'mapbox://styles/mapbox/streets-v11',
  zoom: 14,
  center: [locationData.longitude, locationData.latitude],
});

map.addMarker({
  latitude: locationData.latitude,
  longitude: locationData.longitude,
});

const setupDeleteLocationConfirmation = () => {
  const deleteLocationForm = document.getElementsByClassName('js-delete-location')[0];

  deleteLocationForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const isDeletionConfirmed = confirm('Are you sure?');

    if (isDeletionConfirmed) { deleteLocationForm.submit(); }
  });
};

setupDeleteLocationConfirmation();
