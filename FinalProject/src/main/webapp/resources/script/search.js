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

window.addEventListener('load', function() {
    let currentDate = new Date();
    const formattedDate = `${currentDate.getMonth() + 1}/${currentDate.getDate()}/${currentDate.getFullYear()}`;
    currentDate.setDate(currentDate.getDate()+1)
    const formattedDate_next = `${currentDate.getMonth() + 1}/${currentDate.getDate()}/${currentDate.getFullYear()}`;
    //console.log(formattedDate);

    $("#txtDate").daterangepicker({
        showMonthAfterYear: true,
        yearSuffix: '년',	
    })

    $("#txtDate").daterangepicker({
        locale:{
        "separator":"~", // 시작일시와 종료일시 구분자
        "format":'MM.DD', // 일시 노출 포맷
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

    const travel = document.querySelector('.search_travel');

    travel.addEventListener('keyup', () => {
        //console.log(travel.value);
        $.ajax({
            url: 'search.sh',
            method: 'GET',
            dataType:'json',
            contentType: 'application/json',
            data: { keyword: travel.value},
            success: function(response) {
                console.log(1);
                //console.log("response.keyword:"+response.keyword);
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });

      });

});


