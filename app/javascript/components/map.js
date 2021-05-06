const initShowMapOnClick = () => {
  const mapButton = document.querySelector(".map-button");
  if (mapButton) {
    const listButton = document.querySelector(".list-button");
    mapButton.addEventListener("click", (event) => {
      event.preventDefault();
      const mainBlock = document.querySelector(".main-block");
      const map = document.querySelector(".map-container");
      console.log(event);
      mainBlock.classList.add("d-none");
      map.classList.remove("d-none");
    });
    listButton.addEventListener("click", (event) => {
      event.preventDefault();
      const mainBlock = document.querySelector(".main-block");
      const map = document.querySelector(".map-container");
      mainBlock.classList.remove("d-none");
      map.classList.add("d-none");
    });
  }
};

export { initShowMapOnClick };
