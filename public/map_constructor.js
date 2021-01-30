mapboxgl.accessToken = "pk.eyJ1IjoiZW1lbGRtb24iLCJhIjoiY2tobWhmMWpnMGZtejJzazFidWE5eHZ2eSJ9.fZilTg2I6AyrsFZ9ElV8VQ";

export class Map {
  constructor({ container, zoom, center, setupControls }) {
    this.map = new mapboxgl.Map({
      container: container,
      style: 'mapbox://styles/mapbox/streets-v11',
      zoom: zoom,
      center: center
    });

    this.map.addControl(
      new mapboxgl.GeolocateControl({
        positionOptions: { enableHighAccuracy: true },
        trackUserLocation: true
      })
    );
  }

  addMarker({ latitude, longitude }) {
    new mapboxgl
      .Marker()
      .setLngLat([longitude, latitude])
      .addTo(this.map);
  }
}
