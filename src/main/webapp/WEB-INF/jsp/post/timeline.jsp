<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

  	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  	
  	 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
  	 
  	 <link rel="stylesheet" href="/static/css/style.css">
  
</head>
<body>

	<div class="container">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="d-flex justify-content-center">
			<div class="col-lg-7">
				
				<!--  입력 상자  -->
				<div class="border rounded mt-3">
					<div>
						<textarea class="form-control w-100 border-0 non-resize" rows=3 id="contentInput"></textarea>
					</div>
					<div class="d-flex justify-content-between m-2">
						<input class="input-control d-none" type="file" id="fileInput">
						<a href="#" id="imageUploadBtn"><i class="bi bi-image image-upload-icon"></i></a>
						<button class="btn btn-sm btn-info" id="uploadBtn">업로드</button>
					</div>
				</div>
				<!--  /입력 상자  -->
				
				<!-- 피드 -->
				
				<c:forEach  var="postWithComments" items="${postList }">
				
				<div class="card border rounded mt-3">
					<!-- 타이틀 -->
					<div class="d-flex justify-content-between p-2 border-bottom">
						<div>
							<img src="https://mblogthumb-phinf.pstatic.net/20150203_225/hkjwow_1422965971196EfkMV_JPEG/%C4%AB%C5%E5%C7%C1%BB%E7_31.jpg?type=w210" width="30">
							${postWithComments.post.userName }
						</div>
						<div class="more-icon" >
							<a class="text-dark moreBtn" href="#"  data-toggle="modal" data-target="#deleteModal" data-post-id=""> 
								<i class="bi bi-three-dots-vertical"></i> 
							</a>
							
						</div>
					</div>
					<!--이미지 -->
					<div>
						<img src="${postWithComments.post.imagePath }" class="w-100 imageClick" data-post-id="${postWithComments.post.id }">
					</div>
					<!-- 좋아요 -->
					
					<div class="m-2">
						<a href="#" class="likeBtn" data-post-id="${postWithComments.post.id }">
						<c:choose>
							<c:when test="${postWithComments.like }" >
								<i class="bi bi-heart-fill heart-icon text-danger" data-status="like" id="heartIcon-${postWithComments.post.id }"></i>
							</c:when>
							<c:otherwise>
								<i class="bi bi-heart heart-icon text-dark" id="heartIcon-${postWithComments.post.id }"></i>	
							</c:otherwise>
						</c:choose>
						</a>
						<span class="middle-size ml-1"> 좋아요 <span id="likeCount-${postWithComments.post.id }" >${postWithComments.likeCount }</span>개 </span>
					</div>
					
					<!--  content -->
					<div class="middle-size m-2">
						<b>${postWithComments.post.userName }</b> ${postWithComments.post.content }
					</div>
					
					<!--  댓글 -->
					
					<div class="mt-2">
						<div class=" border-bottom m-2">
							<!-- 댓글 타이틀 -->
							<div  class="middle-size">
								댓글
							</div>
						</div>
						
						<!--  댓글  -->
						<div class="middle-size m-2">
						<c:forEach var="comment" items="${postWithComments.commentList }" >
							<div class="mt-1">
								<b>${comment.userName }</b> ${comment.content }
							</div>
						</c:forEach>
						</div>
						
						
						<!-- 댓글 입력 -->
						<div class="d-flex mt-2 border-top">
							<input type="text" class="form-control border-0 " id="commentInput-${postWithComments.post.id }">
							<button class="btn btn-info ml-2 commentBtn" data-post-id="${postWithComments.post.id }">게시</button>
						</div>
						
					
					</div>
			
				</div>
				
				
				</c:forEach>
				<!-- /피드 -->
			</div>
			
		</section>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		
	
	</div>
	
	<!-- Modal -->
	<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
	    <div class="modal-content">
	      
	      <div class="modal-body text-center">
	        <a href="#" data-post-id="">삭제하기</a>
	      </div>
	  
	    </div>
	  </div>
	</div>
	<script>
	
	$.processLike = function(postId) {
		$.ajax({
			type:"get",
			url:"/post/like",
			data:{"postId": postId},
			success:function(data) {
				// 좋아요
				if(data.like) {
					
					$("#heartIcon-" + postId).removeClass("bi-heart");
					$("#heartIcon-" + postId).addClass("bi-heart-fill");
					
					$("#heartIcon-" + postId).removeClass("text-dark");
					$("#heartIcon-" + postId).addClass("text-danger");
				} else { // unlike
					$("#heartIcon-" + postId).addClass("bi-heart");
					$("#heartIcon-" + postId).removeClass("bi-heart-fill");
					
					$("#heartIcon-" + postId).addClass("text-dark");
					$("#heartIcon-" + postId).removeClass("text-danger");
				}
				$("#likeCount-" + postId).text(data.likeCount);
				
				//location.reload();
					
			},
			error:function(e) {
				alert("error");
			}
			
		});
	};
	
	
	$(document).ready(function() {
			$("#uploadBtn").on("click", function() {
				let content = $("#contentInput").val().trim();
					
				if(content == null || content == "") {
					alert("내용을 입력하세요");
					return ;
				}
				
				if($("#fileInput")[0].files.length == 0) {
					alert("파일을 추가하세요");
					return ;
				}
				
				var formData = new FormData();
				formData.append("file", $("#fileInput")[0].files[0]);
				formData.append("content", content);
				
				$.ajax({
					enctype: 'multipart/form-data', // 필수
					type:"POST",
					url:"/post/create",
					processData: false, // 필수 
		        	contentType: false, // 필수 
					data:formData,
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("글쓰기에 실패했습니다.");
						}
						
					}, error:function(e) {
						alert("error ");
					}
				});
				
			});		
			
			$("#imageUploadBtn").on("click", function() {
				$("#fileInput").click();
			});
			
			$(".commentBtn").on("click", function() {
				var postId = $(this).data("post-id");
				// $("#commentInput-1")
				var comment = $("#commentInput-" + postId).val().trim();
				
				if(comment == null || comment == "") {
					alert("내용을 입력하세요");
					return;
				}
				
				$.ajax({
					type:"post",
					url:"/post/comment/create",
					data:{"postId":postId, "content":comment},
					success:function(data) {
						if(data.result == "success") {
							location.reload();
						} else {
							alert("댓글 작성 실패");
						}
					},
					error:function(e) {
						alert("error");
					}
					
				});
			});
			
			$(".likeBtn").on("click", function(e) {
				e.preventDefault();
				var postId = $(this).data("post-id");
				
				$.processLike(postId);
				
			});
			
			$(".imageClick").on("dblclick", function() {
				var postId = $(this).data("post-id");
				
				$.processLike(postId);
			});
			
			$(".moreBtn").on("click", function() {
				// postId를 모델에 삭제 버튼에 주입한다. 
			});
	
		});		
	
		
	</script>
</body>
</html>