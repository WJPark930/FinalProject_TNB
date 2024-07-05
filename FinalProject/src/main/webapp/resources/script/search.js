function plus_people(){
    let people_count = document.querySelector('#people_count');
    let people = document.querySelector('.search_people');
    let people_word = people.value.split(' ');
    //console.log(people_count.innerHTML);
    if(people_count.innerHTML < 10){
        let count = Number(people_count.innerHTML) + 1;
        let people_text = people_word[0]+" "+count+" "+people_word[2];
        people.value = people_text;
        //console.log(count);
        people_count.innerHTML = count;
    }
}

function minus_people(){
    let people_count = document.querySelector('#people_count');
    //console.log(people_count.innerHTML);
    let people = document.querySelector('.search_people');
    let people_word = people.value.split(' ');
    if(people_count.innerHTML > 2){
        let count = Number(people_count.innerHTML) - 1;
        let people_text = people_word[0]+" "+count+" "+people_word[2];
        people.value = people_text;
        //console.log(people_text);
        people_count.innerHTML = count;
    }
}

function check_search(){
    let currentDate = new Date();
    let keyword = document.querySelector('.search_travel');
    let calender = document.querySelector('.search_calender');
    let calender_word = calender.value.split('~');
    let day1 = document.querySelector('input[name="day1"]');
    let day2 = document.querySelector('input[name="day2"]');
    let people = document.querySelector('.search_people');
    let people_word = people.value.split(' ');
    let people_input = document.querySelector('input[name="people"]');

    if(keyword.value != ""){
        day1.value = currentDate.getFullYear()+"-"+calender_word[0];
        day2.value =  currentDate.getFullYear()+"-"+calender_word[1];
        people_input.value = people_word[1];
        //console.log(day1.value);
        //console.log(day2.value);
        //console.log(people_input.value);
    }else{
        alert("검색어를 입력해주세요");
        //console.log("검색어없음");
        return false;
    }

}

window.addEventListener('load', function() {
    let currentDate = new Date();
    let formattedDate = `${currentDate.getMonth() + 1}/${currentDate.getDate()}/${currentDate.getFullYear()}`;
    currentDate.setDate(currentDate.getDate()+1)
    let formattedDate_next = `${currentDate.getMonth() + 1}/${currentDate.getDate()}/${currentDate.getFullYear()}`;
    //console.log(formattedDate);

    $("#txtDate").daterangepicker({
        locale:{
        "separator":"~", // 시작일시와 종료일시 구분자
        "format":'MM-DD', // 일시 노출 포맷
        "applyLabel":"확인",// 확인 버튼 텍스트
        "daysOfWeek": ["일","월","화","수","목","금","토"],
        "monthNames": ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
        "applyLabel": "적용",
        "cancelLabel": "취소",
        },
        "startDate": formattedDate,
        "endDate": formattedDate_next,
        "minDate": formattedDate,
        "maxDate": "12/31/"+currentDate.getFullYear(),
        function (start, end, label) {
            console.log('선택된 날짜: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
        }
    });

    /* const travel = document.querySelector('.search_travel');

    travel.addEventListener('keyup', () => {
        $.ajax({
            url: 'search.sh',
            method: 'GET',
            //dataType: 'json',
            success: function(data) {
                console.log(1);
                console.log('응답 데이터:', data);
            }

        });
    }); */

});


