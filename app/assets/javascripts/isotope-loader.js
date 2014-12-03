$(document).ready(function(){
	// Isotope Loader
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
});