$(() => {
  ["#testitems", "#packages", "#youtube", "#instagram"].forEach(e => {
    $(e).sortable();
    $(e).disableSelection();
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
  console.log(data);

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
