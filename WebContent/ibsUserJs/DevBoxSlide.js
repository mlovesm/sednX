/**
slide관련 스크립트 
**/
$(function(){
		$('.bxslider').bxSlider({
			mode: 'fade',
			auto: true,
			speed: 1000,
			controls: true
		}); //메인 슬라이드
		$('.default-y').bxSlider({
			mode: 'horizontal',
			slideWidth: 288,
			pager: false,
			captions: true,
			minSlides: 2,
			maxSlides: 6,     
			slideMargin: 11,
			controls: true,
			moveSlides: 6
		}); //기본 세로형
		$('.default-x').bxSlider({
			mode: 'horizontal',
			slideWidth: 288,
			pager: false,
			captions: true,
			minSlides: 2,
			maxSlides: 6,     
			slideMargin: 11,
			controls: true,
			moveSlides: 6
		}); //기본 가로형
		$('.list-y').bxSlider({
			mode: 'horizontal',
			slideWidth: 587,
			pager: false,
			captions: true,
			minSlides: 1,
			maxSlides: 3,     
			slideMargin: 11,
			controls: true,
			moveSlides: 3
		}); //리스트 세로형
		$('.list-x').bxSlider({
			mode: 'horizontal',
			slideWidth: 587,
			pager: false,
			captions: true,
			minSlides: 1,
			maxSlides: 3,     
			slideMargin: 11,
			controls: true,
			moveSlides: 3
		}); //리스트 가로형
		$('.list-xy').bxSlider({
			mode: 'horizontal',
			slideWidth: 288,
			pager: false,
			captions: true,
			minSlides: 2,
			maxSlides: 6,     
			slideMargin: 11,
			controls: true,
			moveSlides: 6
		}); //이미지 가로 세로 리스트
		$('.thumnail-mix').bxSlider({
			mode: 'horizontal',
			slideWidth: 288,
			pager: false,
			captions: true,
			minSlides: 1,
			maxSlides: 6,     
			slideMargin: 11,
			controls: true,
			moveSlides: 6
		}); //썸네일 혼합형
		$('.list-mix').bxSlider({
			mode: 'horizontal',
			slideWidth: 288,
			pager: false,
			captions: true,
			minSlides: 1,
			maxSlides: 6,     
			slideMargin: 11,
			controls: true,
			moveSlides: 6
		}); //리스트 혼합형
		$(window).on("load",function(){
			$(".scrollbar").mCustomScrollbar({
				theme:"inset"
			});
		});
	});