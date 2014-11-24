$(document).ready(function(){
	// Site-wide
  setTimeout(function(){
    $('.alert').fadeOut(500, function() { $(this).remove(); });
  }, 3000);

  function popupCenter(url, width, height, name) {
    var left = (screen.width/2)-(width/2);
    var top = (screen.height/2)-(height/2);
    return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
  }

  $("a.popup").click(function(e) {
    popupCenter($(this).attr("href")+"?popup=true", $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
    e.stopPropagation(); return false;
  });

  // Profile
  var $profile = $('.profile-page')
	$('.counts').on( 'click', '.filter', function() {
	  var filterValue = $(this).attr('data-filter');
	  $profile.isotope({ filter: filterValue });
	  $('.filter').toggleClass("active");
	  console.dir("profile");
	});

  // Inbox
  var $inbox = $('.inbox-page')
	$('.filters').on( 'click', 'label', function() {
	  var filterValue = $(this).attr('data-filter');
	  $inbox.isotope({ filter: filterValue });
	  $('.active').removeClass("active");
	  $(this).toggleClass("active");
	  console.dir("inbox");
	});

	$('.tip').on( 'click', 'h3, img', function() {
	  location.reload();
	});
 })