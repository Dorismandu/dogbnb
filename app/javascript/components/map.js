const initShowMapOnClick = () => {
  const mapButton = document.querySelector(".map-button");
  if (mapButton) {
    const listButton = document.querySelector(".list-button");
    mapButton.addEventListener("click", (event) => {
      event.preventDefault();
      const mainBlock = document.querySelector(".main-block");
      const map = document.querySelector(".map-container");
      console.log(event);
      mainBlock.style.visibility = 'hidden';
      map.style.visibility = '';
    });
    listButton.addEventListener("click", (event) => {
      event.preventDefault();
      const mainBlock = document.querySelector(".main-block");
      const map = document.querySelector(".map-container");
      mainBlock.style.visibility = '';
      map.style.visibility = 'hidden';
    });
  }
};

export { initShowMapOnClick };
