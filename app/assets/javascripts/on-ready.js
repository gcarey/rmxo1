$(document).ready(function(){
	// Site-wide
  setTimeout(function(){
    $('.alert').fadeOut(500, function() { $(this).remove(); });
  }, 3000);

	  // Find Friends
	  function popupCenter(url, width, height, name) {
	    var left = (screen.width/2)-(width/2);
	    var top = (screen.height/2)-(height/2);
	    return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
	  }

	  $("a.popup").click(function(e) {
	    popupCenter($(this).attr("href")+"?popup=true", $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
	    e.stopPropagation(); return false;
	  });

	  // Settings
	  Dropzone.autoDiscover = false;

	// Tips Pages  
	var $container = $('#page');

  if ( $(window).width() > 768) {     
		$container.isotope({itemSelector: '.tip', layoutMode: 'masonryHorizontal', stamp: '#stamp' });
	}

	$( window ).resize(function() {
	  if ( $(window).width() > 768) {     
			$container.isotope({itemSelector: '.tip', layoutMode: 'masonryHorizontal', stamp: '#stamp' });
		}
		else {
			$container.isotope('destroy')
		}
	});
})


// Profile
$(".users.show").ready(function(){
  if ( $(window).width() > 768) {     
	  var $profile = $('.profile-page')
		$('.counts').on( 'click', '.filter', function() {
		  var filterValue = $(this).attr('data-filter');
		  $profile.isotope({ filter: filterValue });
		  $('.filter').toggleClass("active");
		});
	}
})


// Inbox
$(".pages.inbox").ready(function(){
  if ( $(window).width() > 768) { 
	  var $inbox = $('.inbox-page')
		$('.filters').on( 'click', 'label', function() {
		  var filterValue = $(this).attr('data-filter');
		  $inbox.isotope({ filter: filterValue });
		  $('.active').removeClass("active");
		  $(this).toggleClass("active");
		});
	}

	$('.tip').on( 'click', 'h3, img', function() {
	  location.reload();
	});
})


// Mobile Settings
$(".pages.mobile_settings").ready(function(){

	var uploadPhoto = new Dropzone(".dropzone", {
			maxFilesize: 2,
			paramName: "user[avatar]",
			maxFiles: 1,
			thumbnailWidth: 190,
			thumbnailHeight: 190,
	});

	uploadPhoto.on("success", function(file) {
		$(".dropzone").prepend("<div class='success-msg'><h3>Looking Good!</h3><p>Here's your new profile photo. Happy with it?</p><%= escape_javascript(link_to 'Return to Profile', root_path, class: 'btn btn-primary') %><p>Want to try again?</p><a id='retry' class='btn btn-default'>Upload Another</a>");

		$(".dropzone").on( 'click', '#retry', function() {
			$('.success-msg').remove();
		 	uploadPhoto.enable();
			uploadPhoto.removeAllFiles();
		});
  });

  $(".m-notification-toggle").on( 'click', 'a', function() {
		$(this).siblings().removeClass('active');
		$(this).addClass('active');
	});
})


// Omni
$(".popups.failure").ready(function(){
  $( '.closer' ).click(function() {
		window.close()
  });
});
