<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

popup.jsp<br>


<h1>주소검색 팝업창</h1>
<button class='popup-close-btn'>닫기</button>

<script type="text/javascript">
(($,window,document)=>{
	const popupCloseBtn = $('.popup-close-btn');
	popupVloseBtn.on({
		click(e){
			e.preventDefault();
			window.close();
		}
	})
})(jQuery,window,document);

</script>