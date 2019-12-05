const autocomplete = () => {
  const input = document.querySelector(".autocomplete")
  if (input){
    input.addEventListener("keyup", (event) => {
      const query = event.currentTarget.value
      fetch(`/pages/autocomplete?query=${query}`, {
        method: "GET",
      })
      .then(response => response.json())
      .then((data) => {
        const searchResult = document.querySelector('.search-result');
        searchResult.innerHTML = ''
        data.forEach((beer) => {
          searchResult.insertAdjacentHTML('beforeend', `<li class="suggestion" data-name="${beer['name']}">${beer['name']}</li>`)
        });
        const suggestions = document.querySelectorAll('.suggestion')
        suggestions.forEach((beer) => {
         beer.addEventListener("click", (event) => {
          input.value = beer.dataset.name
          searchResult.innerHTML = ''
         });
        });
      });
    });
  }
};

export { autocomplete };
