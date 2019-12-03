const fallBackVideo = () => {
  let aspectRatio = (window.innerHeight - 132) / window.innerWidth;
  navigator.getMedia(
    {
      audio: false,
      video: {
          aspectRatio: 1 / aspectRatio
        }
    },
    (stream) => {
      if (navigator.mozGetUserMedia) {

        video.mozSrcObject = stream;
      } else {
        const vendorURL = window.URL || window.webkitURL;
        video.srcObject = stream;
      }
      video.play();
    },
    function(err) {
      console.log("An error occured! " + err);
    }
  );

};

const defineDimensions = (height, width) => {
  if (height > 720) {
    const ratio = height / 720;
    const newHeight = 720;
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

    navigator.getMedia = ( navigator.getUserMedia ||
                           navigator.webkitGetUserMedia ||
                           navigator.mozGetUserMedia ||
                           navigator.msGetUserMedia ||
                           navigator.MediaDevices.getUserMedia);

    let aspectRatio = (window.innerHeight - 132) / window.innerWidth;

    navigator.getMedia(
      {
        audio: false,
        video: {
          facingMode: { exact: "environment" },
          aspectRatio: aspectRatio
         }
      },
      (stream) => {
        if (navigator.mozGetUserMedia) {

          video.mozSrcObject = stream;
        } else {
          const vendorURL = window.URL || window.webkitURL;
          video.srcObject = stream;
        }
        video.play();
      },
      function(err) {
        console.log("An error occured! " + err);
        fallBackVideo();
      }
    );

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
