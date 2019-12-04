const defineDimensions = (height, width) => {
  if (height > 360) {
    const ratio = height / 360;
    const newHeight = 360;
    const newWidth = width / ratio;
    return [newHeight, newWidth];
  }
  return [height, width];
};


const showVideo = () =>  {
  if (window.location.pathname === "/scans/new") {

    let streaming = false;
    const video = document.querySelector('#video'),
        canvas       = document.querySelector('#canvas'),
        image        = document.querySelector('#image'),
        startbutton  = document.querySelector('#startbutton');
    let width = 200;
    let height = 0;
    const snapVideo = document.querySelector('#snap_video');
    let aspectRatio = (window.innerHeight - 132) / window.innerWidth;
    const constraints = {
      audio: false,
      video: {
        facingMode: { ideal: "environment" },
        aspectRatio: aspectRatio
       }
    };
    const successCallback = stream => {
      video.srcObject = stream;
      video.play();
    }
    const errorCallback = err => {
      console.log("An error occured! ", err);
    }

    navigator.getUserMediaForOldBrowsers = (
      navigator.getUserMedia ||
      navigator.webkitGetUserMedia ||
      navigator.mozGetUserMedia ||
      navigator.msGetUserMedia
    );
    navigator.getUserMediaForOldBrowsers(constraints, successCallback, errorCallback);

    video.addEventListener('canplay', function(ev){
      if (!streaming) {
        const dimensions = defineDimensions(video.videoHeight, video.videoWidth);
        height = dimensions[0];
        width = dimensions[1];
        video.setAttribute('width', width);
        video.setAttribute('height', height);
        canvas.setAttribute('width', width);
        canvas.setAttribute('height', height);
        streaming = true;
      }
    }, false);

    const takepicture = () => {
      canvas.width = width;
      canvas.height = height;
      canvas.getContext('2d').drawImage(video, 0, 0, width, height);
      const data = canvas.toDataURL('image/png');
      image.value = data;
      const form = document.getElementById("form-scan");
      snapVideo.src = data;
      snapVideo.classList.remove("d-none");
      video.classList.add('d-none');
      form.submit();
    }

    const addLoadingScreen = () => {
      const loadingElement = document.querySelector('#loading');
      loadingElement.classList.remove('d-none');
    };

    startbutton.addEventListener('click', function(ev){
        takepicture();
        addLoadingScreen();
      ev.preventDefault();
    }, false);
  }
};

export { showVideo };
