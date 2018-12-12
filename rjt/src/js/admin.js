$(() => {
  ["#testitems", "#packages", "#youtube", "#instagram"].forEach(e => {
    $(e).sortable();
    $(e).disableSelection();
  });
});

$(":file").on("change", function(e) {
  const filepathInput = $(this).siblings(".imgSrc")[0];
  const previewImage = $(this).siblings(".preview")[0];
  var file = this.files[0];

  let data = new FormData();
  data.append("image", file);

  $.ajax({
    url: "/admin/images",
    type: "POST",
    data,
    processData: false,
    contentType: false
  })
    .done(res => {
      filepathInput.value = res;
      let imgSrc = "/img" + res;
      if (previewImage) {
        previewImage.src = imgSrc;
      } else {
        let img = new Image();
        img.classList.add("preview");
        img.src = "/img/" + res;
        $(filepathInput).after(img);
      }
    })
    .fail(function() {
      $(filepathInput).after("<p>Error, could not upload file</p>");
    });
});

document.getElementById("adminSave").addEventListener("click", e => {
  e.preventDefault();

  const data = $("form#content").serializeObject();
  data.testimonialsPage.testimonials.forEach(t => {
    if (t.testimonialImgSrc === "") t.testimonialImgSrc = null;
  });
  data.videosPage.youtubeSlugs = data.videosPage.youtubeSlugs.filter(
    s => s.length
  );
  data.videosPage.instagramSlugs = data.videosPage.instagramSlugs.filter(
    s => s.length
  );

  var xhr = new XMLHttpRequest();
  xhr.open("POST", "/admin/content", true);
  xhr.setRequestHeader("Content-Type", "application/json; charset=UTF-8");

  xhr.onreadystatechange = () => {
    if (xhr.readyState === 4 && xhr.status === 200) {
      document.getElementById("result").innerHTML = "Content updated";
    }
    if (xhr.readyState === 4 && xhr.status === 500) {
      document.getElementById("result").innerHTML = "ERROR";
    }
  };

  xhr.send(JSON.stringify(data));
});
