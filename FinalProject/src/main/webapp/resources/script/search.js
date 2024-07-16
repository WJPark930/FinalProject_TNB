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
    let day1 = document.querySelector('input[name="day1"]').value;
    let day2 = document.querySelector('input[name="day2"]').value;
    
    let currentDate = new Date();
    let formattedDate = `${currentDate.getMonth() + 1}/${currentDate.getDate()}/${currentDate.getFullYear()}`;
    const formattedDate_min = formattedDate;
    if(day1!=""){
        let day1_word = day1.split('-'); 
        formattedDate = `${day1_word[1]}/${day1_word[2]}/${day1_word[0]}`;
    }
    currentDate.setDate(currentDate.getDate()+1) 
    let formattedDate_next = `${currentDate.getMonth() + 1}/${currentDate.getDate()}/${currentDate.getFullYear()}`;
    if(day2!=""){
        let day2_word = day2.split('-');
        formattedDate_next = `${day2_word[1]}/${day2_word[2]}/${day2_word[0]}`;
    }
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
        "minDate": formattedDate_min,
        "maxDate": "12/31/"+currentDate.getFullYear(),
        function (start, end, label) {
            console.log('선택된 날짜: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
        }
    });

    const price_range = document.querySelector('input[name="price_range"]');
    const whatColumn = document.querySelector('select[name="whatColumn"]');

    if(whatColumn != null){
        
        $('input[name="category_id"]').click(function(e) {
            document.querySelector('form[name="searchForm"]').submit();
         });
    
        $('input[name="service"]').click(function(e) {
            document.querySelector('form[name="searchForm"]').submit();
         });
    
        price_range.addEventListener("change", (e) => {
            document.querySelector('form[name="searchForm"]').submit();
        });
    
        whatColumn.addEventListener("change", (e) => {
            document.querySelector('form[name="searchForm"]').submit();
        });

    }

    const travel = document.querySelector('.search_travel'); 
    const travel_menu = $('.search_travel_menu'); 
    travel.addEventListener('keyup', () => {
        keyword_list(travel,travel_menu);
    });


});

function changeSearch(word){
    //console.log(word);
    const travel = document.querySelector('.search_travel'); 
    const travel_menu = $('.search_travel_menu'); 
    travel.value = word;
    keyword_list(travel,travel_menu);
}
 
function keyword_list(travel,travel_menu){
    $.ajax({
        type: 'GET',
        url: 'keyword.sh',
        data: { keyword: travel.value },
        dataType: "json",
        success: function(response) {
            console.log("____________");   
            let word_list = "";
            $.each(response, function(index, word) { 	
                // console.log(response);
                // console.log(index);
                // console.log(word);
                word_list += `<li><a class="dropdown-item" href="javascript:changeSearch('${word}')">${word}</a></li>`
            });
            travel_menu.html(word_list);
        },
        error: function (xhr) {
            console.error('오류:', xhr);
        }
    });
}