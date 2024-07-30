window.addEventListener('load', function() {  

    const grade_range = document.querySelector('input[name="grade"]');

    grade_range.addEventListener("change", (e) => {
        document.querySelector('.grade_text').innerHTML = grade_range.value;
    });

})

function insertImg(){
    let file_length = $('.file_area').length;
    //console.log(file_length);
    let save_length = $('.save_area').length;
    //console.log(save_length);
    if(save_length != null && save_length > 0){
        file_length = file_length + save_length;
    }
    //console.log(file_length);

    if(file_length<10){
        const file_div = document.createElement("div");
        file_div.className = "file_area";
        file_div.innerHTML = `<input type="file" name="upload">`;
        document.querySelector('.insert_img_area').append(file_div);
    }else{
        alert("이미지는 최대 10개까지 업로드 가능합니다.");
    }

}

function deleteSaveImg(review_img_id){
    document.querySelector('.save_img'+review_img_id).remove();
    let save_length = $('.save_area').length;
    if(save_length <= 0){
        document.querySelector('input[name="image"]').value = "";
        console.log(document.querySelector('input[name="image"]').value);
    }
}

function image_delete(){
    const image_area = document.querySelector('.insert_img_area');
    let file_length = $('.file_area').length;
    if(file_length<=1){
        alert("최소 1개이상의 이미지를 등록해주세요.");
    }else{
        image_area.removeChild(image_area.lastElementChild);
    }
}


