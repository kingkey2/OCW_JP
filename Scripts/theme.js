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
    var heroIndex = new Swiper("#hero-slider", {
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

    var heroLobby = new Swiper("#hero-slider-lobby", {
    loop: true,
    slidesPerView: 3,
    // effect: "fade",
    speed: 1000, //Duration of transition between slides (in ms)
    autoplay: {
        delay: 3500,
        disableOnInteraction: false,
    },
    pagination: {
        el: ".swiper-pagination",
        clickable: true,
        renderBullet: function (index, className) {      
            // return '<span class="' + className + '">' +'<img src="images/banner/thumb-'+ (index + 1) + '.png"></span>';
        },
        },   
    
    });


    // 推薦遊戲
    var gameRecommend = new Swiper("#game-recommend", {
        // loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#game-recommend .swiper-button-next",
        },
        breakpoints: {
            1200: {
                slidesPerView: 6,
                freeMode: false
                
            }
        }


    });

    // 最新遊戲
    var gameNew = new Swiper("#game-new", {
        // loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#game-new .swiper-button-next",
        },
        breakpoints: {
            1200: {
                slidesPerView: 6,
                freeMode: false
                
            }
        }
    });

    // 賭場遊戲
    var gameCasino = new Swiper("#pop-casino", {
    // loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#pop-casino .swiper-button-next",
        },
        breakpoints: {
            1200: {
                slidesPerView: 6,
                freeMode: false
                
            }
        }
    });

    var gamelobby_1 = new Swiper("#lobbyGame-1", {
        loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#lobbyGame-1 .swiper-button-next",
        },
        breakpoints: {
            540: {
                slidesPerView: 3,
                
            },
            768: {
                slidesPerView: 5,
                
            },
            1200: {
                slidesPerView: 7,                
            },
            1920: {
                slidesPerView: 10,                
            },
        }
    });

    var gamelobby_2 = new Swiper("#lobbyGame-2", {
        loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#lobbyGame-2 .swiper-button-next",
        },
        breakpoints: {
            540: {
                slidesPerView: 3,
                
            },
            768: {
                slidesPerView: 5,
                
            },
            1200: {
                slidesPerView: 7,                
            },
            1920: {
                slidesPerView: 10,                
            },
        }
    });

    var gamelobby_3 = new Swiper("#lobbyGame-3", {
        loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#lobbyGame-3 .swiper-button-next",
        },
        breakpoints: {
            540: {
                slidesPerView: 3,
                
            },
            768: {
                slidesPerView: 5,                
            },
            1200: {
                slidesPerView: 7,                
            },
            1920: {
                slidesPerView: 10,                
            },
        }
    });

    var gamelobby_4 = new Swiper("#lobbyGame-4", {
        // loop: true,
        slidesPerView: 2,
        freeMode: true,
        navigation: {
            nextEl: "#lobbyGame-4 .swiper-button-next",
        },
        breakpoints: {
            540: {
                slidesPerView: 7,
                freeMode: false
                
            }
        }
    });

    var gamelobby_randomRem = new Swiper("#lobbyGame-randomRem", {
            effect: "coverflow",
            grabCursor: true,
            centeredSlides: true,
            slidesPerView: "auto",
            // slidesPerView: 5,
            coverflowEffect: {
                rotate: 20,
                stretch: 0,
                depth: 200,
                modifier: 1,
                slideShadows: true,
            },
            // pagination: {
            //     el: ".swiper-pagination",
            // },
            loop: true,
            autuplay: {
                delay: 100,
                disableOnInteraction: false,
            }
    });
	

});


