window.addEventListener('DOMContentLoaded', function() {  

    document.querySelector('.search_travel').disabled =true; 
     
    document.querySelector("button[data-scroll='shop_info']").addEventListener('click', function() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    document.querySelectorAll("button[data-scroll='shop_room']").forEach(function(button) {
        button.addEventListener('click', function() {
            scrollToElement('#shop_room', 170);
        });
    });

    document.querySelectorAll("button[data-scroll='shop_review']").forEach(function(button) {
        button.addEventListener('click', function() {
            scrollToElement('#shop_review', 150);
        });
    });


    function scrollToElement(selector, offset) {
        const element = document.querySelector(selector);
        if (element) {
            const y = element.getBoundingClientRect().top + window.pageYOffset - offset;
            window.scrollTo({ top: y, behavior: 'smooth' });
        }
    }

    var address = document.querySelector('#address').value;
    naver.maps.Service.geocode({
        query: address
    }, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert('Something wrong!');
        }

        var result = response.v2, // 검색 결과의 컨테이너
            items = result.addresses; // 검색 결과의 배열
        //console.log(items);
        //console.log(items[0].x);
        //console.log(items[0].y);
        x_coordinate = items[0].x;
        y_coordinate = items[0].y;
        map_setting(x_coordinate,y_coordinate);
        // do Something
    });

    function map_setting(x_coordinate,y_coordinate){
        //console.log(x_coordinate);
        //console.log(y_coordinate);
        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(y_coordinate, x_coordinate), //지도의 초기 중심 좌표
            zoom: 14, //지도의 초기 줌 레벨
            minZoom: 10, //지도의 최소 줌 레벨
            });
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(y_coordinate, x_coordinate),
            map: map
        });
    }
  
})

let sliderWidth = 220;  //이미지 가로값

function slider_btn(id,type,count){
    let currentIndex = parseInt(document.querySelector(`.review_num${id} .currentIndex`).value);
    let sliderCount = count-3;
    if(count>4){
        console.log("currentIndex:"+currentIndex);
        console.log("sliderCount:"+sliderCount);

        let prevIndex = (currentIndex + sliderCount-1) % sliderCount
        let nextIndex = (currentIndex + 1) % sliderCount
    
        console.log("prevIndex:"+prevIndex);
        console.log("nextIndex:"+nextIndex);

        if(type=="prev"){
            gotoSlider(prevIndex,id);
        } else {
            gotoSlider(nextIndex,id);
        }
    }

}

function gotoSlider(num,id){
    console.log("num:"+num);
    let review_image = document.querySelector(`.review_num${id} .review_image`);
    review_image.style.transition = "all 400ms"
    review_image.style.transform = "translateX("+ -sliderWidth * num+"px)"
    //console.log(region_currentIndex);
    let current_input = document.querySelector(`.review_num${id} .currentIndex`);
    current_input.value = num;
}

function copy() {
    var copyTxt = document.querySelector("#address");
    copyTxt.select();
    copyTxt.setSelectionRange(0, 99999); 
    navigator.clipboard.writeText(copyTxt.value);
    alert("복사되었습니다.");
}

function recommend(like,review_id,user_id) {
    const count = document.querySelector('#recommend_count'+review_id).innerHTML;
    // console.log(count);
    if(user_id==null){
        alert("로그인이 필요한 기능입니다.");        
        return location.href="loginForm.mb";
    }
    const command = `?like=${like}&review_id=${review_id}&user_id=${user_id}`;
    // console.log(command);

    $.ajax({
        url: 'recommend.sh'+command,
        method: 'POST',
        success: function() {
            if(like == 'unlike'){
                document.querySelector('#recommend_unlike'+review_id).style.display = 'none';
                document.querySelector('#recommend_like'+review_id).style.display = 'inline';        
                document.querySelector('#recommend_count'+review_id).innerHTML = Number(count)+1;
            }else{
                document.querySelector('#recommend_unlike'+review_id).style.display = 'inline';
                document.querySelector('#recommend_like'+review_id).style.display = 'none';        
                document.querySelector('#recommend_count'+review_id).innerHTML = Number(count)-1;
            }
        }

    });
}


$(window).scroll(  
    function(){  
        //console.log($(window).scrollTop());
        const body_height =  document.body.offsetHeight;
        const footer_height =  document.querySelector("footer").offsetHeight
        let max_height = body_height - footer_height - 855;
        //console.log(body_height) ;   
        //console.log(max_height) ;        
        if($(window).scrollTop() > 500 && $(window).scrollTop() < max_height){  
            $('.content_nav').css("margin-top",($(window).scrollTop()-550)+"px");  

        }
        if ($(window).scrollTop() <= 500){  
            $('.content_nav').css("margin-top","0px");              
        }  
    }  
);  




 function popClose() {

    var modalPop_room = $('.modal_wrap_room');
    var modalPop_shop = $('.modal_wrap_shop');
    var modalBg = $('.modal_bg');

    $(modalPop_shop).hide();
    $(modalPop_room).hide();
    $(modalBg).hide();

}

function mainImg(src,type,choice){
    console.log(choice);
    if(type=="room"){
        document.querySelector(".room_main_image").setAttribute('src',src);
        $(".modal_img_box").css("border","0");
        $(".modal_img_box").css("padding","4px");
        choice.style.padding = "2px";
        choice.style.border = "2px solid #33692B";
    }else{
        document.querySelector(".shop_main_image").setAttribute('src',src);
        $(".modal_img_box").css("border","0");
        $(".modal_img_box").css("padding","4px");
        choice.style.padding = "2px";
        choice.style.border = "2px solid #33692B";
    }
}
