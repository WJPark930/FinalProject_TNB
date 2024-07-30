<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../../resources/include/commons.jsp"%>
<%@ include file="../../resources/include/header.jsp"%>
 
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style type="text/css">
@import url(http://fonts.googleapis.com/earlyaccess/notosanskr.css);

#container {
	padding: 0;
	padding-top: 75px;
}

th {
	background-color: navy;
	color: white;
}

table {
	width: 100%;
	margin-top: 20px;
}

td {
	text-align: center;
}

a {
	text-decoration: none;
	text-align: center;
	color: navy;
}

.btn-group {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 30px;
}

.btn-group button {
	margin: 0 10px;
}

#boardName {
	text-align: center;
	font-size: 1.5em;
	margin: 20px 0;
	padding: 10px 20px;
	border-bottom: 1px solid #dee2e6;
	color: #006600;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	width: 100%;
	font-weight: bold;
	margin-top: 50px;
}

.container_cummunity {
	margin-bottom: 100px;
}

.left_section {
	width: 280px;
	padding: 20px;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	text-align: center;
}

.right_section {
	width: 70%;
	padding: 20px;
	background-color: #f8f9fa;
	border: 1px solid #dee2e6;
	border-radius: 5px;
	margin-left: 5%;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.right_section table {
	width: 100%;
	border-collapse: collapse;
}

.right_section th, .right_section td {
	padding: 12px;
	text-align: center;
	border: 1px solid #dee2e6;
	background-color: #f1f1f1;
}

.right_section th {
	background-color: #343a40;
	color: white;
	border-color: #343a40;
}

.right_section td a {
	color: #007bff;
	text-decoration: none;
	font-weight: bold;
}

.right_section td a:hover {
	text-decoration: underline;
}

.right_section form {
	margin-top: 20px;
	display: flex;
	align-items: center;
	justify-content: center;
}

.right_section select, .right_section input[type="text"], .right_section input[type="submit"]
	{
	margin: 0 5px;
	padding: 10px;
	border: 1px solid #ced4da;
	border-radius: 4px;
	font-size: 14px;
}

.right_section input[type="submit"] {
	background-color: #28a745;
	color: white;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.right_section input[type="submit"]:hover {
	background-color: #218838;
}

.hot-board {
	padding: 10px 20px;
	border-bottom: 1px solid #dee2e6;
	background-color: #80B156;
	color: #ffffff;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
	margin-top: 20px;
	margin-bottom: 20px;
}

.popular-posts {
	margin-bottom: 20px;
	overflow: hidden;
	height: 450px;
}

.popular-posts ol {
	padding-left: 20px;
}

.popular-posts li {
	text-align: left;
	margin-bottom: 5px;
}

.list-type {
	list-style-type: none;
}
</style>

<div class="container" id="container">
	<div>
		<div class="btn-group" role="group"
			aria-label="Basic mixed styles example">
			<button type="button" class="btn btn-success"
				onclick="filterByCategory(1)"
				style="background-color: #80B156; border: 0px;">자유 게시판</button>
			<button type="button" class="btn btn-success"
				onclick="filterByCategory(2)"
				style="background-color: #80B156; border: 0px;">떠나봄 게시판</button>
			<button type="button" class="btn btn-success"
				onclick="filterByCategory(3)"
				style="background-color: #80B156; border: 0px;">구인 · 구직 게시판</button>
			<button type="button" class="btn btn-success" onclick="startChat()"
				style="background-color: #80B156; border: 0px;">채팅 시작하기</button>
		</div>

		<div id="boardName" align="center">자유 게시판</div>
	</div>

	<div class="container_cummunity row">
		<div class="left_section col-3">
			<div class="popular-posts">
				<h5 class="hot-board">인기 게시물 TOP10</h5>
				<div class="popular-searches" id="popularPostsList">
					<ol class="list-type">
						<!-- 조회수 TOP10 들어올 자리 -->
					</ol>
				</div>
			</div>
		</div>

		<div class="right_section col-9">
			<form id="searchForm" onsubmit="searchBoards(); return false;">
				<select name="whatColumn" id="whatColumn">
<!-- 				<option value="all">전체검색</option> -->
					<option value="title">제목</option>
					<option value="content">내용</option>
				</select> <input type="text" name="keyword" id="keyword"> <input
					type="submit" class="btn btn-success" value="검색"> <input
					type="button" class="btn btn-success" name="insert" value="추가하기"
					onclick="location.href='write.bd'">
			</form>




			<table class="table table-hover" border="1" id="boardTable">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>작성일</th>
						<th>수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="bl" items="${BoardLists}">
						<tr>
							<td>${bl.bid}</td>
							<td align="left"><a
								href="content.bd?bid=${bl.bid}&pageNumber=${pageInfo.pageNumber}">${bl.title}</a>
							</td>
							<td>${bl.user_email}</td>
							<td>${bl.readcount}</td>
							<td><fmt:formatDate value="${bl.created_at}"
									pattern="yyyy/MM/dd HH:mm" /></td>
							<td><fmt:formatDate value="${bl.updated_at}"
									pattern="yyyy/MM/dd HH:mm" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div id="pagingContainer" align="center">
				${pageInfo.pagingHtml}</div>
		</div>
	</div>
</div>

<script>
    let currentCategory = 1; // 현재 카테고리 아이디를 저장

    $(document).ready(function() {
        filterByCategory(1); // 페이지가 로드될 때 전체 게시판 로드

        $.ajax({
            url: 'topReadCountBoards.bd',
            method: 'GET',
            success: function(response) {
                var popularPostsList = $('#popularPostsList ol');
                popularPostsList.empty();
                $.each(response, function(index, post) {
                    var listItem = $('<li>');
                    var rank = $('<span>').addClass('rank').text(index + 1);
                    var link = $('<a>').attr('href', 'content.bd?bid=' + post.bid).text(post.title);
                    listItem.append(rank).append('위 ').append(link);
                    popularPostsList.append(listItem);
                });
                startAutoRolling();
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
		
        //자동롤링하는 함수
        function startAutoRolling() {
            var popularPostsList = $('#popularPostsList ol');
            var listHeight = popularPostsList.find('li').outerHeight();
            var speed = 2000; // 시간 간격 (밀리초)

            setInterval(function() {
                popularPostsList.animate({
                    marginTop: -listHeight
                }, 600, function() {
                    popularPostsList.find('li:first').appendTo(popularPostsList);
                    popularPostsList.css('marginTop', 0);
                });
            }, speed);
        }
    });

    function filterByCategory(categoryId, pageNumber = 1) {
        currentCategory = categoryId;
        updateBoardName(categoryId);
        loadPage(pageNumber);
    }

    function updateBoardName(categoryId) {
        let boardName = "";
        switch (categoryId) {
            case 1:
                boardName = "자유 게시판";
                break;
            case 2:
                boardName = "떠나봄 게시판";
                break;
            case 3:
                boardName = "구인 · 구직 게시판";
                break;
            default:
                boardName = "게시판";
                break;
        }
        document.getElementById('boardName').innerText = boardName;
    }

    function loadPage(pageNumber) {
        const whatColumn = $('#whatColumn').val();
        const keyword = $('#keyword').val();

        console.log("Sending request with cate_id:", currentCategory, "pageNumber:", pageNumber, "whatColumn:", whatColumn, "keyword:", keyword);

        $.ajax({
            url: 'filterByCategory.bd',
            method: 'GET',
            data: {
                cate_id: currentCategory,
                pageNumber: pageNumber,
                whatColumn: whatColumn,
                keyword: keyword
            },
            success: function(response) {
                console.log("Response received:", response);
                var tableBody = '';
                $.each(response.BoardLists, function(index, board) {
                    tableBody += '<tr>';
                    tableBody += '<td>' + board.bid + '</td>';
                    tableBody += '<td align="left">';
                    tableBody += '<a href="content.bd?bid=' + board.bid + '&pageNumber=' + pageNumber + '">' + board.title + '</a>';
                    tableBody += '</td>';
                    tableBody += '<td>' + board.user_email + '</td>';
                    tableBody += '<td>' + board.readcount + '</td>';
                    tableBody += '<td>' + new Date(board.created_at).toLocaleString() + '</td>';
                    tableBody += '<td>' + new Date(board.updated_at).toLocaleString() + '</td>';
                    tableBody += '</tr>';
                });
                $('#boardTable tbody').html(tableBody);
                $('#pagingContainer').html(response.pageInfo.pagingHtml);

                $('#pagingContainer a').click(function(e) {
                    e.preventDefault();
                    var pageNumber = $(this).attr('href').split('pageNumber=')[1].split('&')[0];
                    loadPage(pageNumber);
                });
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }

    function searchBoards(pageNumber = 1) {
        const whatColumn = $('#whatColumn').val();
        const keyword = $('#keyword').val();

        console.log("Searching with cate_id:", currentCategory, "pageNumber:", pageNumber, "whatColumn:", whatColumn, "keyword:", keyword);

        $.ajax({
            url: 'filterByCategory.bd',
            method: 'GET',
            data: {
                cate_id: currentCategory,
                pageNumber: pageNumber,
                whatColumn: whatColumn,
                keyword: keyword
            },
            success: function(response) {
                console.log("Search response received:", response);
                var tableBody = '';
                $.each(response.BoardLists, function(index, board) {
                    tableBody += '<tr>';
                    tableBody += '<td>' + board.bid + '</td>';
                    tableBody += '<td align="left">';
                    tableBody += '<a href="content.bd?bid=' + board.bid + '&pageNumber=' + pageNumber + '">' + board.title + '</a>';
                    tableBody += '</td>';
                    tableBody += '<td>' + board.user_email + '</td>';
                    tableBody += '<td>' + board.readcount + '</td>';
                    tableBody += '<td>' + new Date(board.created_at).toLocaleString() + '</td>';
                    tableBody += '<td>' + new Date(board.updated_at).toLocaleString() + '</td>';
                    tableBody += '</tr>';
                });
                $('#boardTable tbody').html(tableBody);
                $('#pagingContainer').html(response.pageInfo.pagingHtml);

                $('#pagingContainer a').click(function(e) {
                    e.preventDefault();
                    var pageNumber = $(this).attr('href').split('pageNumber=')[1].split('&')[0];
                    loadPage(pageNumber);
                });
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
            }
        });
    }
    
    var isLoggedIn = <% if (session.getAttribute("loginInfo") != null) { %> true <% } else { %> false <% } %>;
    
    function startChat() {
        if (isLoggedIn) {
            window.open('http://192.168.0.223:8080/ex/chat', '_blank', 'width=380,height=650');
        } else {
            alert('로그인 후에 이용해주세요');
        }
    }
</script>


<%@ include file="../../resources/include/footer.jsp"%>
