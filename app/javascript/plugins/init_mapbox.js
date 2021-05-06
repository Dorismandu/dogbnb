import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';


const fitMapToMarkersIndex = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15 })
};

const fitMapToMarkersShow = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  console.log(markers);
  bounds.extend([ markers.lng, markers.lat]);
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 5000 })
};


const initMapboxIndex = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
  const coordinates = JSON.parse(mapElement.dataset.markers);
  coordinates.forEach((coordinate) => {
    new mapboxgl.Marker()
    .setLngLat([ coordinate.lng, coordinate.lat ])
    .setPopup(new mapboxgl.Popup({ offset: 25 })
    .setHTML(coordinate.infoWindow.content))
    .addTo(map);
  });
  fitMapToMarkersIndex(map, coordinates);
  }
};

const initMapboxShow = () => {
  const mapElement = document.getElementById('map1');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map1',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const coordinates = JSON.parse(mapElement.dataset.markers);
    new mapboxgl.Marker()
    .setLngLat([ coordinates.lng, coordinates.lat ])
    .addTo(map);
    fitMapToMarkersShow(map, coordinates);
  }
};

export { initMapboxIndex, initMapboxShow };
