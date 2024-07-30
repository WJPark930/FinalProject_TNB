<%@ page import="community.model.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="/resources/include/header.jsp"%>
 
<!DOCTYPE html>
<html>
<head>
<title>Detail View</title>

<style type="text/css">

    table {
        width: 1000px;
        margin: 0 auto;
    }

    td, th {
        text-align: center;
    }

    a {
        text-decoration: none;
        text-align: center;
    }

    .btn-custom {
        background-color: #80B156;
        border: 0px;
        color: white;
    }

    .reply-form, .nested-comments-row {
        display: none;
    }
    
     .nested-comments-container, .nested-comment, .reply-form td, .nested-comments-row td {
        text-align: center;
     }
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function () {
    var bid = '${content.bid}';// 게시글 번호
    var user_email = '${sessionScope.user_email}'; // 현재 로그인한 사용자 이메일
    var content_user_email = '${content.user_email}'; // 게시글 작성자 이메일
    var pageNumber = '${pageNumber}'; // 현재 페이지 번호

    // 페이지 로드 시 추천수를 가져와서 UI에 반영
    $.ajax({
        type: 'GET',
        url: '${pageContext.request.contextPath}/getRecommendCount.bd',
        data: { bid: bid },
        success: function (response) {
            $('#recommendCount').text(response);// 추천수 갱신
        },
        error: function (xhr) {
            console.error('추천수 가져오기 오류:', xhr);
        }
    });

    // 추천 버튼 클릭 시 처리
    $('#recommendButton').click(function () {
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/recommend.bd',
            data: { bid: bid },
            success: function (response) {
                $('#recommendCount').text(response); // 추천수 갱신
                alert('추천되었습니다.');
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else if (xhr.status === 409) {
                    alert('이미 추천한 게시물입니다.');
                } else {
                    alert('추천에 실패했습니다.');
                }
                console.error('추천 오류:', xhr);
            }
        });
    });

    // 댓글 목록 로드 함수 호출
    loadComments();

    // 댓글 입력 폼 제출 시 처리
    $('#commentForm').submit(function (event) {
        event.preventDefault(); // 기본 동작 방지

        var formData = $(this).serialize();

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/comment/add.bd',
            data: formData,
            success: function (response) {
                loadComments(); // 새로운 댓글 추가 후 목록 다시 불러오기
                $('#commentContent').val(''); // 댓글 입력창 초기화

                // 댓글 작성 완료 알림창 띄우기
                alert('댓글이 성공적으로 작성되었습니다.');
            },
            error: function (error) {
                console.error('댓글 작성 오류:', error);
                if (error.status === 500) {
                    alert('로그인이 필요합니다.');
                }
            } 
        });
    });
    
    // 댓글 목록을 가져와서 테이블에 추가하는 함수
 function loadComments() {
    $.ajax({
        type: 'GET',
        url: '${pageContext.request.contextPath}/comment/list.bd',
        data: { bid: bid },
        success: function (comments) {
            console.log(comments); // 응답 데이터 확인
            var table = $('#commentsTable').find('tbody');
            table.empty();

            if (comments.length === 0) {
                var noCommentsRow = '<tr><td colspan="7">댓글이 없습니다.</td></tr>';
                table.append(noCommentsRow);
            } else {
                comments.forEach(function (comment) {
                    appendComment(comment);
                });
            }
        },
        error: function (error) {
            console.error('댓글 목록 불러오기 오류:', error);
        }
    });
}


    // ISO 8601 포맷으로 날짜 변환
    function formatDate(isoDate) {
        var date = new Date(isoDate);
        return date.toLocaleString(); // 원하는 포맷으로 변경할 수 있음
    }

  //댓글 행 추가하는 함수
    function appendComment(comment) {
        var table = $('#commentsTable').find('tbody');
        var commentRow = '<tr align="center">' + 
        '<td>' + comment.content + '</td>' +
        '<td>' + comment.user_email + '</td>' +
        '<td>' + formatDate(comment.created_at) + '</td>' +
        '<td>' + (comment.recommend_count || 0) + '</td>' +
        '<td><button class="bi bi-reply-all reply-btn" style=" border: 0px;" data-comment-id="' + comment.id + '">답글 작성</button>' +
        '<td><button class="bi bi-hand-thumbs-up-fill comment-recommend-btn" style=" border: 0px;" data-comment-id="' + comment.id + '"></button></td>' +
        '<td><button class="bi bi-trash-fill comment-delete-btn" style=" border: 0px;" data-comment-id="' + comment.id + '"></button></td>' +
  		'</tr>';
        table.append(commentRow);

        // 대댓글이 있는 경우
        if (comment.nested_comments && comment.nested_comments.length > 0) {
            comment.nested_comments.forEach(function (nestedComment) {
                appendNestedComment(nestedComment, comment.id);
            });
        }

     // 답글 버튼 추가
        var replyButtonRow = '<tr align="center">' +
                                '<td colspan="7"><button class="btn btn-success toggle-nested-comments-btn" style="background-color: #80B156; border: 0px; color: white;" data-comment-id="' + comment.id + '">답글 보기/감추기</button></td>' +
                            '</tr>';
        table.append(replyButtonRow);
    }

 // 대댓글 보기/감추기 버튼 클릭 시 처리
    $(document).on('click', '.toggle-nested-comments-btn', function () {
        var commentId = $(this).data('comment-id');
        var parentRow = $(this).closest('tr');
        var nestedCommentsRow = parentRow.next('.nested-comments-row');

        // 대댓글 행이 이미 표시되어 있으면 숨기고, 그렇지 않으면 불러와서 표시
        if (nestedCommentsRow.length > 0) {
           if($(".nested-comments-row").css("display") == "none"){
              $(".nested-comments-row").css("display","table-row");
           }else{
              $(".nested-comments-row").css("display","none");
           }
            
        } else {
            // 대댓글 불러오는 함수 호출
            loadNestedComments(commentId);
        }
    });
 
 // 대댓글 불러오는 함수
    function loadNestedComments(commentId) {
        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/nested_comment/list.bd',
            data: { parent_id: commentId },
            success: function (nestedComments) {
                var parentRow = $('.toggle-nested-comments-btn[data-comment-id="' + commentId + '"]').closest('tr');
                var nestedCommentsRow = parentRow.next('.nested-comments-row');

                if (nestedComments.length > 0) {
                    var nestedCommentsHtml = '<tr class="nested-comments-row" align="center"><td colspan="7" align="center"><div class="nested-comments-container" align="center">';

                    nestedComments.forEach(function (nestedComment) {
                        var recommendationCount = nestedComment.recommendation_count || 0;
                        nestedCommentsHtml += '<div class="nested-comment" align="center" data-nested-comment-id="' + nestedComment.id + '">';
                        nestedCommentsHtml += '<p>' + ' 답글내용: ' +nestedComment.content + ' 작성자: ' + nestedComment.user_email + ' 작성일: ' + formatDate(nestedComment.created_at) + ' 추천 수: <span class="recommendation-count">' + recommendationCount + '</span>' + '<button style="border:0px;" class="bi bi-hand-thumbs-up-fill recommend-button nested-comment-recommend-btn" data-nested-comment-id="' + nestedComment.id + '"></button>' + '<button style="border:0px;" class="bi bi-trash-fill delete-nested-comment" data-nested-comment-id="' + nestedComment.id + '"></button>' + '</p>';
                        nestedCommentsHtml += '</div>';
                    });

                    nestedCommentsHtml += '</div></td></tr>';

                    if (nestedCommentsRow.length > 0) {
                        nestedCommentsRow.html(nestedCommentsHtml);
                    } else {
                        parentRow.after(nestedCommentsHtml);
                    }

                    updateRecommendCounts();
                } else {
                    var noCommentsHtml = '<tr class="nested-comments-row" align="center"><td colspan="7" align="center">답글이 없습니다</td></tr>';

                    if (nestedCommentsRow.length > 0) {
                        nestedCommentsRow.html(noCommentsHtml);
                    } else {
                        parentRow.after(noCommentsHtml);
                    }
                }
            },
            error: function (xhr, status, error) {
                console.error('Error loading nested comments:', error);
            }
        });
    }
 
 // 대댓글 추천 수 업데이트 함수
    function updateRecommendCounts() {
        $('.nested-comment').each(function () {
            var nestedCommentId = $(this).data('nested-comment-id');
            var recommendationCountElement = $(this).find('.recommendation-count');

            $.ajax({
                type: 'GET',
                url: '${pageContext.request.contextPath}/nested_comment/getRecommendCount.bd',
                data: { nested_comment_id: nestedCommentId },
                success: function (recommendCount) {
                    recommendationCountElement.text(recommendCount);
                },
                error: function (xhr, status, error) {
                    console.error('Error loading recommendation count:', error);
                }
            });
        });
    }

    $(document).ready(function() {
        updateRecommendCounts(); // 페이지 로드 시 추천 수 업데이트
    });

    // 숫자 한 자리수에 0 붙이는 함수
    function padZero(number) {
        return number < 10 ? '0' + number : number;
    }

    // 게시물 삭제 시 처리
    window.deletePost = function(bid, pageNumber) {
        var passwd = prompt('비밀번호를 입력하세요:');

        if (passwd != null && passwd != "") {
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/delete.bd',
                data: {
                    bid: bid,
                    passwd: passwd,
                    pageNumber: pageNumber
                },
                success: function(response) {
                    if (response.success) {
                        alert('게시물이 삭제되었습니다.');
                        window.location.href = '${pageContext.request.contextPath}/list.bd?pageNumber=' + pageNumber;
                    } else {
                        alert('비밀번호가 일치하지 않습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('삭제 요청 오류:', error);
                    alert('게시물 삭제 중 오류가 발생했습니다.');
                }
            });
        }
    }
    
    // 댓글 삭제 버튼 클릭 시 처리
    $(document).on('click', '.comment-delete-btn', function () {
        var comment_id = $(this).data('comment-id');

        if (!comment_id || isNaN(comment_id)) {
            console.error('댓글 ID가 정의되지 않았거나 잘못된 값입니다:', comment_id);
            alert('댓글 ID가 정의되지 않았거나 잘못된 값입니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/comment/delete.bd',
            data: { comment_id: comment_id },
            success: function (response) {
                $('button[data-comment-id="' + comment_id + '"]').closest('tr').remove(); 
                alert('댓글이 성공적으로 삭제되었습니다.');
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else {
                    alert('본인 댓글만 삭제 가능합니다.');
                }
            }
        });
    });

    //대댓글 삭제하는 함수
    $(document).on('click', '.delete-nested-comment', function() {
        var commentId = $(this).data('nested-comment-id'); 
        var confirmation = confirm('정말로 이 답글을 삭제하시겠습니까?');

        if (confirmation) {
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/nested_comment/delete.bd',
                data: { commentId: commentId },
                success: function(response) {
                    $('button[data-nested-comment-id="' + commentId + '"]').closest('tr').remove(); // 수정: comment_id를 commentId로 변경
                    alert('답글이 삭제되었습니다.');
                },
                error: function(error) {
                    console.error('Failed to delete nested comment:', error);
                    alert('답글 삭제에 실패했습니다. 잠시 후 다시 시도해주세요.');
                    if (error.status === 401) {
                        alert('로그인이 필요합니다.');
                    } else {
                        alert('본인 댓글만 삭제 가능합니다.');
                    }
                }
            });
        }
    });



    // 댓글 추천 버튼 클릭 시 처리
    $(document).on('click', '.comment-recommend-btn', function () {
        var comment_id = $(this).data('comment-id');

        if (!comment_id || isNaN(comment_id)) {
            console.error('댓글 ID가 정의되지 않았거나 잘못된 값입니다:', comment_id);
            alert('댓글 ID가 정의되지 않았거나 잘못된 값입니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/comment/commentrecommend.bd',
            data: { comment_id: comment_id },
            success: function (response) {
                var commentRow = $('button[data-comment-id="' + comment_id + '"]').closest('tr');
                commentRow.find('td:nth-child(4)').text(response);
                alert('댓글을 추천하였습니다.');
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else if (xhr.status === 409) {
                    alert('이미 추천한 댓글입니다.');
                } else {
                    alert('추천에 실패했습니다.');
                }
                console.error('댓글 추천 오류:', xhr);
            }
        });
    });
    
    //대댓글 추천 버튼 클릭
    $(document).on('click', '.nested-comment-recommend-btn', function () {
        var nested_comment_id = $(this).data('nested-comment-id');
        console.log('답글 번호 :', nested_comment_id);

        if (!nested_comment_id || isNaN(nested_comment_id)) {
            alert('유효하지 않은 답글 입니다.');
            return;
        }

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/nested_comment/nestedcommentrecommend.bd',
            data: { nested_comment_id: nested_comment_id },
            success: function (response) {
                var commentRow = $('button[data-nested-comment-id="' + nested_comment_id + '"]').closest('.nested-comment');
                alert('댓글을 추천하였습니다.');
            },
            error: function (xhr) {
                if (xhr.status === 401) {
                    alert('로그인이 필요합니다.');
                } else if (xhr.status === 409) {
                    alert('이미 추천한 댓글입니다.');
                } else {
                    alert('추천에 실패했습니다.');
                }
                console.error('댓글 추천 오류:', xhr);
            }
        });
    });

    

 // 답글 입력 폼 제출 시 처리(답글작성버튼은 로그인이 되어 있어야 생김)
    $(document).on('submit', '.nestedCommentForm', function (event) {
        event.preventDefault(); // 기본 동작 방지

        var formData = $(this).serialize();

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/nested_comment/add.bd',
            data: formData, // 직렬화된 폼 데이터 전송
            success: function (response) {
                loadComments(); // 새로운 답글 추가 후 목록 다시 불러오기
                alert('답글이 성공적으로 작성되었습니다.');
            },
            error: function (error) {
                console.error('답글 작성 오류:', error);
            }
        });
    });

 // 답글 버튼 클릭 시 답글 입력 폼 토글 처리
    $(document).on('click', '.reply-btn', function () {
        var replyFormRow = $(this).closest('tr').next('.reply-form');
       if($(".reply-form").css("display") == "none"){
          $(".reply-form").css("display","table-row");
       }else{
          $(".reply-form").css("display","none");
       }
       // 답글 입력 폼 보이기/감추기
    });
	    
 	// 답글 버튼 클릭 시 답글 입력 폼 표시
    $(document).on('click', '.reply-btn', function () {
        var commentId = $(this).data('comment-id');
        var replyForm = '<tr class="reply-form" align="center">' +
                            '<td colspan="7" align="center" style="text-align:center;">' +
                                '<form class="nestedCommentForm">' +
                                    '<textarea name="content" style= "width:100%; height="50px;" placeholder="답글을 입력하세요"></textarea>' +
                                    '<input type="hidden" name="parent_id" value="' + commentId + '">' +
                                    '<input type="hidden" name="user_id" value="' + ${sessionScope.loginInfo.user_id} + '">' +
                                    '<input type="submit" value="답글 작성" class="btn btn-success" style="background-color: #80B156; border:0px;">' +
                                '</form>' +
                            '</td>' +
                        '</tr>';

        if ($(this).closest('tr').next('.reply-form').length === 0) {
            $(replyForm).insertAfter($(this).closest('tr'));
        }
    });
    
    // 로그인 사용자와 게시물 작성자가 같은 경우 수정 및 삭제 버튼을 표시
    if (user_email === content_user_email) {
        var editButtons = '<button onclick="location.href=\'${pageContext.request.contextPath}/updateForm.bd?bid=' + bid + '&pageNumber=' + pageNumber + '\'">수정</button>' +
                          '<button onclick="deletePost(' + bid + ', ' + pageNumber + ')">삭제</button>';
        $('#actionButtons').html(editButtons);
    }
      
    
});
</script>

</head>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
</head>
<body>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
	<div class="container" style="margin-top: 75px">
		<form>
			<input type="hidden" id="bid" name="bid" value="${content.bid}">
			<input type="hidden" name="pageNumber" value="${pageNumber}">
			<table class="table table-striped" border="1" width="600" align="center">
				
				<tr align="center" height="30">	
					<th width="150">작성일</th>
					<td width="150"><fmt:formatDate value="${content.created_at}"
							pattern="yyyy/MM/dd HH:mm" /></td>
					<th width="150">수정일</th>
					<td width="150"><fmt:formatDate value="${content.updated_at}"
							pattern="yyyy/MM/dd HH:mm" /></td>
					<th width="150">추천수</th>
					<td width="150" id="recommendCount"></td>
				</tr>
				
				<tr align="center" height="50">
					<td colspan="6" width="450" height="350" align="left"><br>
					<h2 align="left">${content.title}</h2><br>
					<h6 align="left"><img src="<%=request.getContextPath()%>/resources/assets/image/작성자.png" style="height:15px; width:15px;"> ${content.user_email} 
					&nbsp;&nbsp;&nbsp;
					<img src="<%=request.getContextPath()%>/resources/assets/image/조회수.png" style="height:15px; width:15px;"> ${content.readcount}</h6><hr><br>
					${content.content}
					</td>
				</tr>

				<tr align="center" height="30">
					<td colspan="6">
					<input type="button" value="추천하기" id="recommendButton" class="btn btn-success" style="background-color: #80B156; border: 0px;"> 
					<input type="button" value="글수정" class="btn btn-secondary" onClick="location.href='update.bd?bid=${content.bid}&pageNumber=${pageNumber}'">
					<input type="button" value="글삭제" class="btn btn-secondary" onclick="deletePost(${content.bid}, ${pageNumber})"> 
					<input type="button" value="글목록" class="btn btn-secondary" onClick="location.href='list.bd?pageNumber=${pageNumber}'">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

	<div class="container mt-4" style="width: 100%;">
		<div class="row justify-content-center">
			<div>
				<div class="card" style="height: 270px;">
					<div class="card-header text-white" style="background-color: #80B156;">댓글 입력</div>
					<form id="commentForm">
						<input type="hidden" name="bid" value="${content.bid}"> <input
							type="hidden" name="userId"
							value="${sessionScope.loginInfo.user_id}">
						<div class="card-body">
							<div class="form-group">
								<textarea class="form-control" id="commentContent"
									name="content" rows="3" placeholder="댓글을 입력하세요"></textarea>
							</div>
							<div class="form-group">
								<%-- 작성자 : &nbsp; <input type="text" class="form-control-plaintext" value="${sessionScope.loginInfo.user_email}" readonly> --%>
							</div>
						</div>
						<div class="card-footer text-right" style="justify-content: flex-end;">
							<button type="submit" class="btn btn-success" style="background-color: #80B156; float: right; border: 0">댓글 입력</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

	<div class="container">
		<table class="table table-striped table-hover text-center"
			id="commentsTable" align="center">
			<thead>
				<tr>
					<th colspan="7" class="text-center">댓글 목록</th>
				</tr>
				<tr>
					<th>내용</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>추천수</th>
					<th>답글 작성</th>
					<th>추천</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody align="center">
				<!-- 댓글 목록이 나타날 자리 -->
			</tbody>
		</table>
	</div>

	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>

	
	<div class="container">
		<hr>
		<table class="table table-striped" border="1" align="center">
			<tr>
				<th colspan="6" align="center">게시물 목록</th>
			</tr>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>조회수</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
			<c:forEach var="bl" items="${BoardLists}">
				<tr>
					<td>${bl.bid}</td>
					<td align="left"><c:choose>
							<c:when test="${bl.cate_id == 1}">자유 게시판</c:when>
							<c:when test="${bl.cate_id == 2}">떠나봄 게시판</c:when>
							<c:when test="${bl.cate_id == 3}">구인,구직 게시판</c:when>
						</c:choose> <a
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
	<%-- 			<tr>
					<td colspan="6"><c:forEach var="i"
							begin="${pageInfo.beginPage}" end="${pageInfo.endPage}">
							<c:choose>
								<c:when test="${i eq pageInfo.pageNumber}">
	                                ${i}
	                            </c:when>
								<c:otherwise>
									<a
										href="list.bd?pageNumber=${i}&pageSize=${pageInfo.pageSize}&whatColumn=${pageInfo.whatColumn}&keyword=${pageInfo.keyword}">${i}</a>
								</c:otherwise>
							</c:choose>
						</c:forEach></td>
				</tr> --%>
		</table>
	</div>
</body>
</html>
<%@ include file="../../resources/include/footer.jsp"%>