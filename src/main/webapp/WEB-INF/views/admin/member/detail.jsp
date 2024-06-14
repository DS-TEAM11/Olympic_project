<%@page import="com.fasterxml.jackson.annotation.JsonInclude.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.7.1.min.js"></script>

<script>
$(document).ready(function() {
	$('#dataTable').DataTable({
        paging: true, // 페이지네이션 사용
        searching: true, // 검색 기능 사용
        ordering: true, // 정렬 기능 사용
        lengthMenu: [ [1, 3, 5], [1, 3, 5] ],
    });

    // 문의 내역 테이블 초기화
    $('#dataTableQnA').DataTable({
        paging: true,
        searching: true,
        ordering: true,
        lengthMenu: [ [1, 3, 5], [1, 3, 5] ],
    });
    
  
});
</script>
<style>
	#info-container{
		margin-top: 20px;
	}
	
    #info-item {
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px; 
    }

    #info-label {
        font-weight: bold;
        margin-right: 10px;
    }
    
    .table-responsive {
    height: 360px;
    overflow-y: auto; 
    
    }
    #memberdetail{
	 	position: fixed; 
		height: 500px;
	}
	#dataTableQnA_info {
	    display: none;
	}

    
</style>
</head>

<body>
<div id="wrapper">
    <!-- 슬라이더 바 -->
    <!-- 위치에 따라 경로 설정 필요 -->
    <%@include file="/WEB-INF/views/common/adminslide.jsp"%>

    <!-- Content Wrapper -->
    <div id="content-wrapper" class="d-flex flex-column">
 <%@include file="/WEB-INF/views/common/adminheader.jsp"%>
        <!-- Main Content -->
        <div id="content">
            <!-- 상단 툴바 -->
           
                
            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">회원 상세 정보</h1>
                <!--<p class="mb-2">회원 상세 정보 페이지 입니다.</p>  -->

                <!-- DataTables Example -->
                <div class="row p-4">
                    <!-- 회원 정보 -->
                    <div class="col-md-3 card shadow mb-4" id="memberdetail">
                        <div class="card-header">
                            <h6 class="m-0 font-weight-bold text-primary">회원 정보</h6>
                        </div>
                        <div class="card-body">
						    <div class="avatar avatar-xxl my-5 text-center">
						        <span class="avatar-title rounded-circle">
						            <i class="fa fa-user" style="font-size: 70px;" ></i>
						        </span>
						    </div>
						    <div id="info-container">
							    <div id="info-item">
							        <span id="info-label">이름:</span>
							        <span>${detail.name}</span>
							    </div>
							    <div id="info-item">
							        <span id="info-label">이메일:</span>
							        <span>${detail.email}</span>
							    </div>
							    <div id="info-item">
							        <span id="info-label">생년월일:</span>
							        <span>${detail.birthday}</span>
							    </div>
							    <div id="info-item">
							        <span id="info-label">연락처:</span>
							        <span>${detail.phone}</span>
							    </div>
							    <div id="info-item">
							        <span id="info-label">등급:</span>
							        <span>${detail.membership}</span>
							    </div>
							    <div id="info-item">
							        <span id="info-label">포인트:</span>
							        <span>${detail.point}</span>
							    </div>
						    </div>
						</div>
                    </div>

                    <!-- 예매 내역 및 문의 내역 -->
                    <div class="col-md-8 ml-auto">
                        <div class="row">
                            <!-- 예매 내역 -->
                            <div class="col-md-12 card shadow mb-4">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">예매 내역</h6>
                                </div>
                                <div class="card-body">
		                            <div class="table-responsive">
		                                <table class="table table-bordered text-center" id="dataTable" width="100%" cellspacing="0">
			                                <colgroup>
										    	<col width="12%" />
										    	<col width="10%" />
										    	<col width="10%" />
										        <col width="10%" />
										        <col width="10%" />
										        <col width="10%" />
										        <col width="10%" />
										        <col width="12%" />
										        <col width="10%" />
										    </colgroup>
		                                    <thead class="fs-3">
		                                        <tr>
		                                            <th>예매번호</th>
		                                            <th>종목</th>
		                                            <th>이름</th>
		                                            <th>좌석등급</th>
		                                            <th>구매가격</th>
		                                            <th>주문일자</th>
		                                            <th>경기날짜</th>
		                                            <th>edit</th>
		                                        </tr>
		                                    </thead>
		                                    
		                                    <tbody id="oderlist">
		                                        <tr>
							                        <td>예시1</td>
							                        <td>예시1</td>
							                        <td>예시1</td>
							                        <td>예시1</td>
							                        <td>예시1</td>
							                        <td>예시1</td>
							                        <td>예시1</td>
		                                        	<td>
		                                        	<button type="button" class="editBtn btn btn-danger">취소</button>&ensp; 
		                                        	</td>
		                                        </tr>
		                                    </tbody>
		                                </table>
		                            </div>
	                        	</div>
                            </div>

                            <!-- 문의 내역 -->
                            <div class="col-md-12 card shadow">
                                <div class="card-header py-3">
                                    <h6 class="m-0 font-weight-bold text-primary">문의 내역</h6>
                                </div>
                                <div class="card-body">
		                            <div class="table-responsive">
		                                <table class="table table-bordered text-center" id="dataTableQnA" width="100%" cellspacing="0">
			                                 <colgroup>
										    	<col width="8%" />
										    	<col width="12%" />
										    	<col width="32%" />
										        <col width="20%" />
										        <col width="12%" />
										        <col width="15%" />
										    </colgroup>
		                                    <thead class="fs-2">
		                                        <tr>
		                                            <th>번호</th>
		                                            <th>분류</th>
		                                            <th>제목</th>
		                                            <th>작성일</th>
		                                            <th>답변상태</th>
		                                            <th>edit</th>
		                                        </tr>
		                                    </thead>
		                                    
		                                    <tbody id="qnalist">
		                                    <c:choose>
			                                    <c:when test="${empty qna}">
			                                        <tr>
			                                            <td colspan="6" onclick='event.cancelBubble=true;'>문의 내역이 없습니다.</td>
			                                        </tr>
			                                    </c:when>
			                                    <c:otherwise>
			                                        <c:forEach var="qnaItem" items="${qna}">
			                                            <tr style="cursor : pointer;">
			                                                <td class="py-2 qna" id="qna" data-qna-no="${qnaItem.qna_no}">${qnaItem.qna_no}</td>
			                                                <td class="py-2">
															    ${qnaItem.type == 0 ? '경기'
																    : qnaItem.type == 1 ? '일반'
																    : qnaItem.type == 2 ? '결제'
																    : qnaItem.type == 3 ? '티켓'
																    : '기타'
																}
															</td>
			                                                <td class="py-2">${qnaItem.title}</td>
			                                                <td class="py-2"><fmt:formatDate value="${qnaItem.regdate}" pattern="yyyy-MM-dd"/></td>
			                                                <td class="py-2">
			                                                    <c:choose>
			                                                        <c:when test="${qnaItem.reply != null}">답변 완료</c:when>
			                                                        <c:otherwise>미완료</c:otherwise>
			                                                    </c:choose>
			                                                </td>
			                                                <td class="py-2"><button type="button" class="p-1 editBtn btn btn-danger">삭제하기</button>
			                                                </td>
			                                            </tr>
			                                        </c:forEach>
			                                    </c:otherwise>
			                                </c:choose>
		                                    </tbody>
		                                </table>
		                            </div>
	                        	</div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
            <!-- /.container-fluid -->

        </div>
        <!-- End of Main Content -->

        <!-- Footer -->
        <%@include file="/WEB-INF/views/common/adminfooter.jsp"%>
        <!-- End of Footer -->

    </div>
    <!-- End of Content Wrapper -->
</div>
</body>
</html>