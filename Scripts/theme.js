// $('.header_area').load('layout-header.html');
// $('.footer').load('layout-footer.html');


$(document).ready(function () {

   //語言選單
   $('[data-btn-click="openLag"]').click(function(){
    $('.lang-select-panel').fadeToggle('fast');
    });

    $('.lang-select-panel a').click(function(){
        var curLang = $(this).text();
        $('.lang-select-panel').fadeToggle('fast');
        $('[data-btn-click="openLag"]').find('span').text(curLang);
    });

    //主選單收合
    $('.navbar-toggler').click(function(){
        $('.vertical-menu').toggleClass('navbar-show');
        $('.main_menu').toggleClass('show');
    });
    $('.header_area .mask_overlay').click(function(){
        $('.main_menu, .navbarMenu').removeClass('show');
        $('.navbar-toggler').attr("aria-expanded","false");        
    });


    // HERO 
    var swiper1 = new Swiper("#hero-slider", {
    loop: true,
    slidesPerView: 1,
    effect: "fade",
    speed: 1000, //Duration of transition between slides (in ms)
    autoplay: {
        delay: 3500,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
        renderBullet: function (index, className) {
        //   return '<span class="' + className + '">' + (index + 1) + "</span>";
            return '<span class="' + className + '">' +'<img src="images/banner/thumb-'+ (index + 1) + '.png"></span>';
        },
        },   
    
    });


    // 推薦遊戲
    var swiper2 = new Swiper("#game-recommend", {
    // loop: true,
    slidesPerView: 2,
    freeMode: true,
    navigation: {
        nextEl: "#game-recommend .swiper-button-next",
    },
    breakpoints: {
        540: {
            slidesPerView: 5,
            freeMode: false
            
        },
    }
    });

    // 最新遊戲
    var swiper3 = new Swiper("#game-new", {
    // loop: true,
    slidesPerView: 2,
    freeMode: true,
    navigation: {
        nextEl: "#game-new .swiper-button-next",
    },
    breakpoints: {
        540: {
            slidesPerView: 5,
            freeMode: false
            
        },
    }
    });

    // 賭場遊戲
    var swiper4 = new Swiper("#pop-casino", {
    // loop: true,
    slidesPerView: 2,
    freeMode: true,
    navigation: {
        nextEl: "#pop-casino .swiper-button-next",
    },
    breakpoints: {
        540: {
            slidesPerView: 5,
            freeMode: false
            
        },
    }
    });


	
	

});


