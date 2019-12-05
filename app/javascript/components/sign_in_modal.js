const isUserSignedIn = () => {
  const isUserSignedInElement = document.querySelector('[data-user-signed-in]');
  return isUserSignedInElement.dataset.userSignedIn;
};

const showModal = (event) => {
  if (isUserSignedIn() == "false") {
    $('#modalSignIn').modal('show');
    event.preventDefault();
  }
};

const addRequiredSignIn = () => {
  const requiredSignInElements = document.querySelectorAll('.sign_in_required')
  requiredSignInElements.forEach((element) => {
    element.addEventListener('click', showModal);
  });
};


export { addRequiredSignIn };
