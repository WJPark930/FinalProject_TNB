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

function copy() {
    var copyTxt = document.querySelector("#address");
    copyTxt.select();
    copyTxt.setSelectionRange(0, 99999); 
    navigator.clipboard.writeText(copyTxt.value);
    alert("복사되었습니다.");
}

function selectReview(column) {

}

function recommend(like,review_id,user_id) {
    const count = document.querySelector('#recommend_count'+review_id).innerHTML;
    // console.log(count);
    if(user_id==null){
        user_id=1;
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
