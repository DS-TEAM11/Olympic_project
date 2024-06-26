<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
    <script src="../js/jquery-3.7.1.min.js"></script>
    <script src="../js/ticket_carousel.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.min.js"></script>
    <script>
		function pagination() {
		    var req_num_row = 3; //보여지는 행 개수
		    var $tr = $('tbody tr');
		    var total_num_row = $tr.length;  //테이블의 총 행 개수
		    var num_pages = Math.ceil(total_num_row / req_num_row); //몇페이지
		    var max_visible_pages = 3;  //하단 페이징 번호 수
		    var current_page = 1;  //현재 페이지 번호(초기값은 1)
		    var current_page_group = 1; // 페이지 그룹 번호
		
		    function showPage(page) {
		        $tr.hide(); //모든 행 숨기고
		        var start = (page - 1) * req_num_row;  //보여줄 행의 시작
		        for (var i = 0; i < req_num_row; i++) {
		            $tr.eq(start + i).show();    //해당 행만 보여주기
		        }
		    }
		
		    function renderPagination(current_page, current_page_group) {
		        $('.pagination').empty();
		        $('.pagination').append("<li><a class='prev' href='#'>이전&nbsp;</a></li>");
		        var start_page = (current_page_group - 1) * max_visible_pages + 1; //현재 페이지 그룹의 시작 페이지 계산
		        var end_page = Math.min(start_page + max_visible_pages - 1, num_pages); //그룹의 끝페이지 계신
		        
		        for (var i = start_page; i <= end_page; i++) {
		            $('.pagination').append("<li><a class='pagination-link' href='#'>" + i + "&nbsp;</a></li>"); //번호 추가
		        }
		        
		        $('.pagination').append("<li><a class='next' href='#'>다음&nbsp;</a></li>");
		        $('.pagination a.pagination-link').removeClass('active').filter(function() {
		            return $(this).text() == current_page; //현재 페이지와 일치하는 페이지 번호
		        }).addClass('active'); //현재 페이지 나타내기
		        
		        
		        if (current_page == 1) {
		            $('.prev').parent().addClass('disabled'); //현재 페이지가 1이면 버튼 비활성화
		        } else {
		            $('.prev').parent().removeClass('disabled');
		        }
		        if (current_page_group * max_visible_pages >= num_pages) {
		            $('.next').parent().addClass('disabled'); //마지막 그룹이면 다음 버튼 비활성화
		        } else {
		            $('.next').parent().removeClass('disabled');
		        }
		    }
		
		    showPage(current_page);
		    renderPagination(current_page, current_page_group);
		
		    //페이지 번호 클릭하면 해당 페이지의 데이터 표시 및 페이지 번호 업데이트
		    $('.pagination').on('click', '.pagination-link', function(e) {
		        e.preventDefault();
		        current_page = parseInt($(this).text());
		        showPage(current_page);
		        renderPagination(current_page, current_page_group);
		    });
		    
			//이전 그룹으로 이동
		    $('.pagination').on('click', '.prev', function(e) {
		        e.preventDefault();
		        if (current_page_group > 1) {
		            current_page_group--;
		            current_page = (current_page_group - 1) * max_visible_pages + 1;
		            showPage(current_page);
		            renderPagination(current_page, current_page_group);
		        }
		    });
		
		    //다음 그룹으로 이동
		    $('.pagination').on('click', '.next', function(e) {
		        e.preventDefault();
		        if (current_page_group * max_visible_pages < num_pages) {
		            current_page_group++;
		            current_page = (current_page_group - 1) * max_visible_pages + 1;
		            showPage(current_page);
		            renderPagination(current_page, current_page_group);
		        }
		    });
		}
		
		$(document).ready(function() {
		    pagination();
		});
		</script>
    <style>
        .table {
            width: 100%;
            table-layout: auto;
        }
        th, td {
            word-wrap: break-word;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        th {
            font-weight: bold;
            font-size: 13px;
        }
        td {
            font-size: 12px;
        }
        .pagination {
            display: flex;
            justify-content: center;
            list-style-type: none;
            padding: 0;
            overflow: hidden;
        }
        .pagination li {
            display: inline-block;
            margin-right: 5px;
        }
        .pagination a {
            padding: 5px 10px;
            text-decoration: none;
            cursor: pointer;
            color: black;
        }
        .pagination a.pagination-link.active {
            color: #dc3545;
            border-color: #007bff;
        }
        .carousel-control-prev-icon,
		.carousel-control-next-icon {
		    background-color: black;
		    opacity: 0.5; /* 투명도 조정 */
		}
		.carousel-item {
		    display: none;
		    width: 100%;
		}
		.carousel-item.active {
		    display: block;
		}
		.carousel-inner {
		    position: relative;
		    overflow: hidden;
		    display: flex;
		}
		.carousel-control-prev,
		.carousel-control-next {
		    width: 5%; /* 슬라이드 바깥쪽으로 위치 조정 */
		    z-index: 1; /* 슬라이드와 겹치지 않도록 함 */
		    opacity: 0.7; /* 투명도 조정 */
		}

    </style>
</head>
<body>
    <!-- 공통 모달 - 헤더 장바구니 등 클릭 시 나오는 사이드 창 -->
    <jsp:include page="../common/modals.jsp"/>
    <!-- 타이틀 - 카테고리 - 아이콘들 포함된 헤더 -->
    <jsp:include page="../common/header.jsp"/>
    <!-- 헤더 하단 현재 경로 노출 -->
    <jsp:include page="../common/breadcrumb.jsp"/>
    <!-- 메인 컨텐트 CONTENT 태그 찾아서 그 부분만 사용하면됨 -->
    <section class="pt-7 pb-12">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <!-- Heading -->
                    <h3 class="mb-10">예매 내역 확인</h3>
                </div>
            </div>
            <div class="row">
                <jsp:include page="../common/mypage.jsp"/>
                <div class="col-12 col-md-9 col-lg-8 offset-1 p-0">
                    <!-- Heading -->
                    <h5 class="mt-7 mb-5">예매 확인/취소</h5>
                    <p class="fs-7">상세보기 클릭시 결제 내역을 확인하실 수 있습니다.</p>
                    <!-- Card -->
                    <div id="favoritelist" class="table-responsive">
                        <table class="table text-center fs-8 table-bordered">
                            <colgroup>
                                <col width=28%>
                                <col width=12%>
                                <col width=20%>
                                <col width=15%>
                                <col width=14%>
                                <col width=5%>
                                <col width=6%>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th class="px-0 py-2" scope="col">주문번호</th>
                                    <th class="px-0 py-2" scope="col">주문일</th>
                                    <th class="px-0 py-2" scope="col">경기정보</th>
                                    <th class="px-0 py-2" scope="col">경기장</th>
                                    <th class="px-0 py-2" scope="col">경기일자</th>
                                    <th class="px-0 py-2" scope="col">매수</th>
                                    <th class="px-0 py-2" scope="col">상세보기</th>
                                </tr>
                            </thead>
                            <tbody class="table-group-divider" id="orderBody">
                                <!-- 반복문 -->
                                <c:choose>
                                    <c:when test="${empty order}">
                                        <tr>
                                            <td colspan="6" onclick='event.cancelBubble=true;'>예매 내역이 없습니다.</td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="orderItem" items="${order}">
                                            <tr class="order-row">
                                                <td class="py-4 px-1">${orderItem.order_no}</td>
                                                <td class="py-4 px-1"><fmt:formatDate value="${orderItem.buy_date}" pattern="yyyy-MM-dd"/></td>
                                                <td class="py-4 px-1">${orderItem.sport_name} ${orderItem.tournament }</td>
                                                <td class="py-4 px-1">${orderItem.stadium_name}</td>
                                                <td class="py-2 px-1"><fmt:formatDate value="${orderItem.korea_date}" pattern="yyyy-MM-dd"/><br>${orderItem.korea_time}</td>
                                                <td class="py-4 px-1">${orderItem.ticket_count }</td>
                                                <td class="py-4 px-1" id="show">
                                                    <a class="showTicket danger" data-bs-toggle="modal" data-order-no="${orderItem.order_no}" href="#ticketModal">상세보기</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                        <ul class="pagination mt-2">
                            <!-- 페이징 하단 바 -->
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- 푸터 -->
    <jsp:include page="../common/footer.jsp"/>
</body>
</html>