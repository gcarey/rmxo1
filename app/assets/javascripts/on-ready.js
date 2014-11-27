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

  // Profile
  if ( $(window).width() > 768) {     
	  var $profile = $('.profile-page')
		$('.counts').on( 'click', '.filter', function() {
		  var filterValue = $(this).attr('data-filter');
		  $profile.isotope({ filter: filterValue });
		  $('.filter').toggleClass("active");
		});
	}

  // Inbox
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

	// Omni
  $( '.closer' ).click(function() {
		window.close()
  });
 })