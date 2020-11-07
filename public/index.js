const getFirstElementByClassName = (className) => {
  return document.getElementsByClassName(className)[0];
};

const getLocationButton = getFirstElementByClassName("js-get-location-btn");

const getLocation = () => {
  const geo = navigator.geolocation;

  if (geo) {
    geo.getCurrentPosition(
      (location) => {
        const latitudeInput = getFirstElementByClassName("js-latitude");
        const longitudeInput = getFirstElementByClassName("js-longitude");

        latitudeInput.value = location.coords.latitude;
        longitudeInput.value = location.coords.longitude;
      },
      (error) => {
        const errorMessage = error.message;
        console.log("errorMessage::", errorMessage);
      }
    );
  }
};

getLocationButton.addEventListener("click", getLocation);
