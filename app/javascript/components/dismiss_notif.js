const dismissNotifListener = () => {
const crossElement = document.querySelector('.fas.fa-times-circle');
  crossElement.addEventListener('click', (event) => {
    const notifDiv = document.querySelector('.alert-notif');
    notifDiv.classList.add('d-none');
  });
};


export { dismissNotifListener };
