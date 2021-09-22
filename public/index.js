const getFirstElementByClassName = (className) => {
  return document.getElementsByClassName(className)[0];
};

const autoTheme = () => {
  currentHour = new Date().toLocaleTimeString('en-US', { hour: "2-digit", hour12: false });
  
  if (currentHour > 18 || currentHour < 6) {
    document.body.classList.toggle("dark-theme");
  }
};

const locationButton = getFirstElementByClassName("js-get-location-btn");

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

locationButton.addEventListener("click", getLocation);

autoTheme();
