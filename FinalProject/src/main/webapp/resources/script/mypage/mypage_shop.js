function addShop(count){
    if(count>=10){
        alert('시설은 최대 10개까지 등록가능합니다.');
    }else{
        location.href="insert_shop.mp";
    }
}

function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}

function guide_add() {
    let guide_length = $('.guide_content').length;
    const guide_div = document.createElement("div");
    guide_div.className = "guide_content guideNum"+guide_length;
    guide_div.innerHTML = `<p>제목</p> <input type="text" name="guide_title" placeholder="이용정보 소제목을 정해주세요. (최대 30자)">
    <p>내용</p> <textarea name="guide_content" placeholder="상세 내용을 입력해주세요. (최대 200자)"></textarea>`;
    document.querySelector('.guide_area').append(guide_div);
}

function guide_delete(){
    const guide_area = document.querySelector('.guide_area');
    guide_area.removeChild(guide_area.lastElementChild);
}

function checkSubmit(){
    let guide_length = $('.guide_content').length;
    for(var i=0; i<guide_length; i++){
        let guide_title = document.querySelector('.guideNum'+i+' input').value;
        let guide_content = document.querySelector('.guideNum'+i+' textarea').value;
        //console.log(guide_title);
        //console.log(guide_content);
        if(guide_title.trim()=="" || guide_content.trim()==""){
            document.querySelector('.guide_err').innerHTML = "모든 이용정보를 입력해주세요.";
            return false;
        }
    }
    document.querySelector('.guide_err').innerHTML = "";
}