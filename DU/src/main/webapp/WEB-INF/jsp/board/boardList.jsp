<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="css/main.css">
	<link href="css/bootstrap/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
	
	<style>
		header {
			margin-bottom: 10px;
		}
		h1 {
			margin: auto;
		}
		.rightBtnDiv {
			display: flex; 
			float: right; 
			width: 13%;
		}
		.leftBtnDiv {
			display: flex; 
			float: left; 
			width: 6%;
		}
		img {
			margin-left: auto;
			margin-right: auto; 
			display: block;
		}
		#paginationBox {
		    justify-content: center;
		    display: flex;
		}
		#filterDiv {
			display: flex;
			justify-content: space-between;
		}
	</style>
	<title>Main Page</title>
</head>
<body>
	<header>
		<div class="logoDiv">
			<img alt="logo" src="images/04-1.jpg" onclick="window.location.href='mainPage.do'">
		</div>
		<div class="userInfoDiv">
			[<c:out value="${USER.name}"></c:out>]님 반갑습니다
	
			<button type="button" class ="btn btn-primary btn-md" style="float: right" onclick="window.location.href='logout.do'"> 
			로그아웃 </button>
	
			<button type="button" class ="btn btn-outline-primary btn-md" style="float: right" onclick="window.location.href='userInfoConfirm.do'"> 
			내정보 </button>
					
		</div>
	</header>
	
	<div id="filterDiv">
		<table>
			<tr>
				<th>제목</th>
				<td><input type="text" id="searchTitle"></td>
				<td><button type="button" class="btn btn-info" id="searchBtn">검색</button></td>
			</tr>
		</table>
		<button type="button" class="btn btn-success"
			onclick="window.location.href='boardWritePage.do'">게시글 등록</button>
	</div>
	<section>	
		<table id="dataList" class="table table-striped">
			<colgroup>  
			    <col style="width:5%">    	
		        <col style="width:65%">
		        <col style="width:5%">
		        <col style="width:10%">
		        <col style="width:5%">
			</colgroup>
			<thead>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록날짜</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${boardList}" var="item">
					<tr>
						<td><c:out value="${item.idx}"/></td>
						<td><c:out value="${item.title}"/></td>
						<td><c:out value="${item.writerName}"/></td>
						<td><c:out value="${item.registDate}"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<!-- pagination{s} -->
		<div id="paginationBox" >
			<ul class="pagination">
				<c:if test="${pagination.prev}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a></li>
				</c:if>

				<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
					<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a></li>
				</c:forEach>
					
				<c:if test="${pagination.next}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.range}', 
						'${pagination.range}', '${pagination.rangeSize}')" >Next</a></li>
				</c:if>
			</ul>
		</div>
		<!-- pagination{e} -->
		
	</section>
</body>

<script>

	window.onload = function(){
		var searchBtn = document.getElementById("searchBtn");
		var searchTitle = document.getElementById("searchTitle");
		
 		searchTitle.addEventListener("keyup", function(event) {
		    if (event.keyCode === 13) {
		    	searchBtn.click();
	    	}
		}); 
		
		searchBtn.onclick = function() {
	/* 		var table = document.getElementById("dataList");
	 		var tbody = table.getElementsByTagName("tbody")[0];
	 		var tr = tbody.getElementsByTagName("tr");
			
	 		for (var item of tr) {
	 		    var title = item.getElementsByTagName("td")[1].innerHTML;
				
	 			if(title.includes(searchTitle.value)){
	 				item.style.display = '';
	 			} else {
	 				item.style.display = 'none';
	 			}
	 		} */
	 		
			var url = "boardListPage.do";
			url = url + "?title=" + searchTitle.value;
			location.href = url;
		}
	}
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "boardListPage.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&title=" + searchTitle.value;
		location.href = url;
	}
  	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, searchType, keyword) {
		var url = "boardListPage.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&title=" + searchTitle.value;
		location.href = url;	
	}
	//다음 버튼 이벤트
	function fn_next(page, range, rangeSize) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "boardListPage.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&title=" + searchTitle.value;
		location.href = url;
	}
</script>
</html>