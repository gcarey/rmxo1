$(document).ready(function(){
	// Site-wide
  setTimeout(function(){
    $('.alert').fadeOut(500, function() { $(this).remove(); });
  }, 3000);

  $('[data-toggle="tooltip"]').tooltip({ 
  	delay: { "show": 300, "hide": 100 },
  });

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
})


// Profile
$(".users.show").ready(function(){    
  var $profile = $('.profile-page')
	$('.counts').on( 'click', '.filter', function() {
	  var filterValue = $(this).attr('data-filter');
	  $profile.isotope({ filter: filterValue });
	  $('.filter').toggleClass("active");
	});

  var target = document.location.hash.replace("#", "");
  if (target.length) {
    if(target=="friends"){
      $('#settings').modal()
			$.getScript( "/settings.js", function( data, textStatus, jqxhr ) {
				$('#settings-nav a[href="#friends"]').tab('show');
			});
    }else if(target=="email"){
      $('#settings').modal()
			$.getScript( "/settings.js", function( data, textStatus, jqxhr ) {
				$('#settings-nav a[href="#notifications"]').tab('show');
			});
    }
  }
})


// Inbox
$(".pages.inbox").ready(function(){
  var $inbox = $('.inbox-page')
	$('.filters').on( 'click', 'label', function() {
	  var filterValue = $(this).attr('data-filter');
	  $inbox.isotope({ filter: filterValue });
	  $('.active').removeClass("active");
	  $(this).toggleClass("active");
	});

	$('.tip').on( 'click', 'h3, img', function() {
	  $(this).parent().parent().removeClass('new').addClass('visited');
	});

	var target = document.location.hash.replace("#", "");
  if (target.length) {
    if(target=="new"){
			$('#page').isotope({ filter: '.new' });
			$('.active').removeClass("active");
			$('label[data-filter=".new"]').addClass('active');
    }
  }
})


// Mobile Settings
$(".pages.mobile_settings").ready(function(){

	var uploadPhoto = new Dropzone(".dropzone", {
			maxFilesize: 10,
			paramName: "user[avatar]",
			maxFiles: 1,
			thumbnailWidth: 190,
			thumbnailHeight: 190,
	});

	uploadPhoto.on("success", function(file) {
		$(".dropzone").prepend("<div class='success-msg'><h3>Looking Good!</h3></div>");
		$(".dropzone").append("<div class='success-msg'><p>Here's your new profile photo.<br>Happy with it?</p><a href='http://www.tipster.to' class='btn btn-primary'>Return to Profile</a><p>Want to try again?</p><a id='retry' class='btn btn-default'>Upload Another</a>");


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


// Index
$(".pages.index").ready(function(){
	$('#head').css('max-height',$(window).height());
	$('.content').css('top',$('#head').height()/2);

	$( window ).resize(function() {
		$('#head').css('max-height',$(window).height());
		$('.content').css('top',$('#head').height()/2);
	});

	if ( $(window).width() > 768) {     
		$.stellar({
			horizontalScrolling: false,
		});
	} 
});

// Welcome
$(".pages.tour").ready(function(){
  $('.slider').slick({
  });
});
