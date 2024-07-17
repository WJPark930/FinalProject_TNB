<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../resources/include/commons.jsp" %>  
<%@ include file="../../resources/include/header.jsp" %>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Community Main</title>
    <link rel="stylesheet" href="resources/css/bootstrap.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="resources/js/bootstrap.js"></script>
</head>
<body>
    <style>
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
            margin: 20px 0;
            height: 100px;
        }

        .btn-group button {
            margin: 0 10px;
        }
    </style>

    <div class="btn-group" role="group" aria-label="Basic outlined example">
        <button type="button" class="btn btn-outline-primary" onclick="filterByCategory(1)">전체 게시판</button>
        <button type="button" class="btn btn-outline-primary" onclick="filterByCategory(2)">자유 게시판</button>
        <button type="button" class="btn btn-outline-primary" onclick="filterByCategory(3)">구인 · 구직 게시판</button>
        <button type="button" class="btn btn-outline-primary" onclick="startChat()">채팅 시작하기</button>
    </div>

    <form id="searchForm" action="list.bd" align="center">
        <select name="whatColumn" id="whatColumn">
            <option value="all">전체검색</option>
            <option value="title">제목</option>
            <option value="user_id">작성자</option>
        </select>
        <input type="text" name="keyword" id="keyword">
        <input type="hidden" name="cate_id" id="cate_id" value="${param.cate_id}">
        <input type="submit" value="검색">
    </form>

    <div class="container">
        <table class="table table-hover" border="1" id="boardTable">
            <thead>
            	<tr>
            		<td colspan="6">
						<input type="button" name="insert" value="추가하기"  onclick="location.href='write.bd'">
    				</td>	
            	</tr>
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
                        <td align="left">
                            <a href="content.bd?bid=${bl.bid}&pageNumber=${pageInfo.pageNumber}">${bl.title}</a>
                        </td>  
                        <td>${bl.user_email}</td>
                        <td>${bl.readcount}</td>
                        <td><fmt:formatDate value="${bl.created_at}" pattern="yyyy/MM/dd HH:mm" /></td>
                        <td><fmt:formatDate value="${bl.updated_at}" pattern="yyyy/MM/dd HH:mm" /></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div id="pagingContainer" align="center">
            ${pageInfo.pagingHtml}
        </div>
    </div>

    <script>
        let currentCategory = 1; // 현재 카테고리 아이디를 저장

        function filterByCategory(categoryId, pageNumber = 1) {
            currentCategory = categoryId;
            loadPage(pageNumber);
        }

        function loadPage(pageNumber) {
            const whatColumn = $('#whatColumn').val();
            const keyword = $('#keyword').val();

            $.ajax({
                url: 'filterByCategory.bd',
                method: 'GET',
                data: { cate_id: currentCategory, pageNumber: pageNumber, whatColumn: whatColumn, keyword: keyword },
                success: function(response) {
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

                    // 페이지네이션 링크에 클릭 이벤트 추가
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
            document.getElementById('searchForm').submit();
        }

        $(document).ready(function() {
            //페이지가 로드되면 기본 보기(ajax요청이 없는 게시판 보기)
            
        });
        
        function startChat() {
            window.location.href = "http://192.168.0.223:8080/ex/chat";
        }
    </script>
</body>
</html>

<%@ include file="../../resources/include/footer.jsp" %>  
