console.log("Here we are");

const logCoords = (position) => {
  console.log("Lat:", position.coords.latitude);
  console.log("Lon:", position.coords.longitude);
};

const populateCoordinateInputs = (position) => {
  //console.log(document.getElementsByClassName("js-latitude"));
  document.getElementsByClassName("js-latitude")[0].value = position.coords.latitude;
  document.getElementsByClassName("js-longitude")[0].value = position.coords.longitude;
};

if (navigator.geolocation) {
  navigator.geolocation.getCurrentPosition(populateCoordinateInputs);
}
