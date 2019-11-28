const showVideo = () =>  {

  let streaming = false;
  const video = document.querySelector('#video'),
      canvas       = document.querySelector('#canvas'),
      image        = document.querySelector('#image'),
      startbutton  = document.querySelector('#startbutton'),
      width = 200;
  let height = 0;

  navigator.getMedia = ( navigator.getUserMedia ||
                         navigator.webkitGetUserMedia ||
                         navigator.mozGetUserMedia ||
                         navigator.msGetUserMedia);

  navigator.getMedia(
{ audio: false, video: { facingMode: { exact: "environment" } } }
,
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

    video.addEventListener('canplay', function(ev){
    if (!streaming) {
      console.log('test');
      height = video.videoHeight / (video.videoWidth/width);
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
    form.submit();
  }

  startbutton.addEventListener('click', function(ev){
      takepicture();
    ev.preventDefault();
  }, false);

};

export { showVideo };
