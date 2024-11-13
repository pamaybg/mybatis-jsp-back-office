<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="custVeiwPopup">
	<div class="row tb-type">
		<div class="user-info">
			<p class="tit"></p>
			<div class="set-item male step01">트럭운행</div> <!-- 남녀 성별에 따라 male female / 연령대에 따라 step01 ~ step04 -->
		</div>
		<div class="user-info">
			<p class="tit"> 가치등급</p> 
			<div class="set-item grd01">VIP</div> <!-- 등급에따라 grd01 ~ grd04 -->
		</div>
		<div class="user-info">
			<p class="tit">가치등급(이익)</p>
			<div class="set-item grd_bf">일반</div>	
		</div>
		<div class="user-info">
			<p class="tit">평균구매금액</p>
			<div class="set-item pch_average">1,123,123원</div>
		</div>
		<div class="user-info">
			<p class="tit">이탈가능성</p>
			<div class="set-item dpt-step01">20%</div> <!-- 이탈 가능성 정도에따라 dpt-step01 ~ dpt-step05 로 클래스이름을 바꾸어주시면 됩니다. -->
		</div>
	</div>
	
	
	<div class="row" style="padding:15px; background:#f1f1f138">
			<p class="tit">활동정보</p>
		<div class="tb-type">
			<div style="width:25%">
				<div>
					<div class="total">448</div>
					<div>누적</div>
				</div>
			</div>
			<div style="width:25%">
				<ul class="user-info-date">
					<li><span>가입정보</span><span>온라인(web)</span></li>
					<li><span>최초 가입일</span><span>2020-01-02</span></li>
					<li><span>마지막 방문</span><span>2020-01-02</span></li>
					<li><span>마지막 구매</span><span>2020-01-02</span></li>
				</ul>
			</div>
			<div class="" style="width:50%">
				<ul class="tb-type activity-detail">
					<li style="width:25%">
						<p>구매</p>
						<p>112</p>
					</li>
					<li style="width:25%">
						<p>홈페이지</p>
						<p>112</p>
					</li>
					<li style="width:25%">
						<p>App</p>
						<p>112</p>
					</li>
					<li style="width:25%">
						<p>알림응답</p>
						<p>112</p>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="row">
		<p class="tit">라이프사이클</p>
		<div class="tb-type">
			<div style="width:20%">연속</div>
			<div>
				<div id="grpArea" style="height: 280px;"></div>
			</div>	
		</div>
	</div>
</div>

<script type="text/javascript">
	// 그래프 그리기
	function grpArea(){
		// 그래프 data
		var data =  [{ x:'1', y:0 }, { x:'2', y:20 }, { x:'3', y:25 }, { x:'4', y:0 }, { x:'5', y:10 }];
		// 그래프내부 파란색으로 칠하는 영역
		var segment = {start:2, end:3}
		
		$("#grpArea").ifvsfChart(
		        {	// y축 option
		            primaryYAxis:
		            {	
		                range: { min:-5, max:35, interval:5 },
		                labelFormat: "{value}",
		                axisLine:{ offset:5 },
		               
					},
					 primaryXAxis:
			            {
						 	range:{ interval:1 },
						 	stripLine:
		                    [
		                        {
		                            start: segment.start,
		                            end:segment.end,
		                            text: 'segment',
		                            textAlignment: 'middlecenter',
		                            color: '#d1e2ff',
		                            font: { size: '18px', color: 'black' },
		                            zIndex: 'behind',
		                            borderWidth: 0,
		                            visible: true
		                        },
		                    ],
			            },
		            //Initializing Common Properties for all the series
					commonSeriesOptions: 
					{
		                type: 'spline', 
						enableAnimation: true,                           
						tooltip: {visible: true, format: "#point.x# <br/> #series.name# : #point.y#"}
		            },			
					//Initializing Series
					series: 
					[
						{
		                    points:data,
		                    name: 'lifeCycle'
		                }			           
					],
					load:"loadTheme",
					canResize:true,
		            legend: { visible: true }
		        }
		    );
	}
	
	grpArea();
	
</script>


