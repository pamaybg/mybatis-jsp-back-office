<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="${pageContext.request.contextPath}/resources/css/marketing/campaignHome.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/js/marketing/diagram/css/diagramStyle.css" rel="stylesheet" />

<style type="text/css">
	#camPrcArea{display: none;}
	#homeSegment{display: none;}
	#homeMyAct{display: none;}
	#homeAllAct{display: none;}
</style>

<script type="text/javascript">
var array = new Array;

// circle 그래프 
 (function($){
	$.fn.circleGraphic=function(options){
		$.fn.circleGraphic.defaults={
			color:'#e99c68',
			startAngle: 0,
			//endAngle:50
		};

		var opts = $.extend({},$.fn.circleGraphic.defaults,options);
		
		var percentage=this.html();
		var ID="c"+percentage+Math.random();
		//alert(ID);

		this.append("<canvas id='"+ID+"'></canvas>");

		var canvas=document.getElementById(ID),
			context=canvas.getContext('2d');

		var Width = this.width();
		this.height(Width);
		var Height = this.height();

		canvas.width = Width;
		canvas.height = Height;

		var startAngle = opts.startAngle,
			endAngle = percentage/100,
			angle = startAngle,
			radius = Width*0.4;

		function drawTrackArc() {
			context.beginPath();
			context.strokeStyle = '#ECECEC';
			context.lineWidth = 5; //161125
			context.arc(Width/2,Height/2,radius,(Math.PI/180)*(startAngle*360-90),(Math.PI/180)*(endAngle*360+270),false);
			context.stroke();
			context.closePath();
		}

		function drawOuterArc(_angle,_color) {
			var angle = _angle;
			var color = _color;
			context.beginPath();
			context.strokeStyle = color;
			context.lineWidth = 5; //161125
			context.arc(Width/2,Height/2,radius,(Math.PI / 180) * (startAngle * 360 - 90), (Math.PI / 180) * (angle * 360 - 90), false);
	       	context.stroke();
	       	context.closePath();
		}	

		function numOfPercentage(_angle,_color){
			var angle;
			angle = Math.floor(_angle*100); //170102
			
			var color=_color;
			context.font = "23px tahoma"; 
			context.fillStyle = "#627482";
			var metrics = context.measureText(angle);
			var textWidth = metrics.width;
			var xPos = Width/2-textWidth/2-textWidth/6, 
			yPos = Height/2+textWidth/2-textWidth/4; //170102
			context.fillText(angle,xPos,yPos);
		}		
		function draw(){
			var loop = setInterval(function(){
				context.clearRect(0,0,Width,Height);
				drawTrackArc();
				drawOuterArc(angle,opts.color);
				numOfPercentage(angle,opts.color);
				angle = ((angle * 100) + 1) / 100;
				angle = Number(angle.toFixed(2)); //170102
				if(angle>endAngle){
					clearInterval(loop);
				}

			},1000/60);
		}
		draw();
		return this;
	};
})(jQuery);

// 캠페인 현황 조회
function getCampaignStatus() {
	$.ifvPostJSON('<ifvm:action name="getCampaignStatus"/>', {
	},
    function(result) {
    	$("#camAll").text($.fn.ifvmNumberWithCommas(String(result.camAll)));
    	$("#camAct").text($.fn.ifvmNumberWithCommas(String(result.camAct)));
    	$("#camEnd").text($.fn.ifvmNumberWithCommas(String(result.camEnd)));
    	$("#tgtMem").text($.fn.ifvmNumberWithCommas(String(result.tgtMem)));
    });
}

//캠페인 구매 반응률 
function getCampaignPrchaseRec() {

    $.ifvPostJSON('<ifvm:action name="getCampaignPrchaseRec"/>', {
    }, function(result) {

        if (result.length > 0) {
            $('#camPrcArea').show();
            $('#emptyCamPrcArea').hide();
            var i = 1;
            $.each(result, function(index, data) {
                data.testGrpVal = i;
                data.ctrlGrpVal = i + 1;
                data.circleGraphicClass1 = "circleGraphic" + i;
                data.circleGraphicClass2 = "circleGraphic" + (i + 1);

                var circleGraphicClass1 = null;
                var circleGraphicClass2 = null;
                array[i] = circleGraphicClass1 = ".circleGraphic" + i;
                array[i + 1] = circleGraphicClass2 = ".circleGraphic" + (i + 1);

                i += 2;
            });
            var temp = $("#campaignPrcRecTemp").tmpl(result);
            $(".campaign_prcrec").append(temp);

            // 그래프 그리기
            for (var i = 1; i < array.length; i++) {
                if (i % 2 == 0) {
                    $(array[i]).circleGraphic({ 'color' : '#e99c68' });
                }
                else {
                    $(array[i]).circleGraphic({ 'color' : '#1a8bc0' });
                }
            }
        }
        else {
            $('#camPrcArea').hide();
            $('#emptyCamPrcArea').show();
        }
    });
}

// 나의 활성 캠페인
function getCampaignMyAct(){
    
	$.ifvPostJSON('<ifvm:action name="getCampaignMyAct"/>', {
	},
    function(result) {
		if(result.length > 0){
			$('#homeMyAct').show();
       		$('#emptyHomeMyAct').hide();
			
			$.each(result, function(index, data) {
				if (result[index].chnlNm == 'LMS') {
					data.iconChannerClass = 'icon_channer_lms';	
				} else if(result[index].chnlNm == 'MMS') {
					data.iconChannerClass = 'icon_channer_mms';	
				} else if(result[index].chnlNm == 'SMS') {
					data.iconChannerClass = 'icon_channer_sms';	
				} else if(result[index].chnlNm == 'PUSH') {
					data.iconChannerClass = 'icon_channer_push';	
				} else if(result[index].chnlNm == 'EMAIL') {
					data.iconChannerClass = 'icon_channer_email';	
				} else if(result[index].chnlNm == 'CALL CENTER') {
					data.iconChannerClass = 'icon_channer_call';	
				} else if(result[index].chnlNm == 'COUPON') {
					data.iconChannerClass = 'icon_channer_coupon';
				}
			});
			var temp = $("#campaignActTemp").tmpl(result);
	        $(".campaign_total").append(temp);	
		}
		else {
			$('#homeMyAct').hide();
       		$('#emptyHomeMyAct').show();
		}
    });
}

// 전체 활성 캠페인
/* function getCampaignAllAct(){
    
	$.ifvPostJSON('<ifvm:action name="getCampaignAllAct"/>', {
	},
    function(result) {
        
		if(result.length > 0){
			$('#homeAllAct').show();
       		$('#emptyHomeAllAct').hide();
       		
			$.each(result, function(index, data) {
				if(result[index].chnlNm == 'LMS') {
					data.iconChannerClass = 'icon_channer_lms';	
				} else if(result[index].chnlNm == 'MMS') {
					data.iconChannerClass = 'icon_channer_mms';	
				} else if(result[index].chnlNm == 'SMS') {
					data.iconChannerClass = 'icon_channer_sms';	
				} else if(result[index].chnlNm == 'PUSH') {
					data.iconChannerClass = 'icon_channer_push';	
				} else if(result[index].chnlNm == 'EMAIL') {
					data.iconChannerClass = 'icon_channer_email';	
				} else if(result[index].chnlNm == 'CALL CENTER') {
					data.iconChannerClass = 'icon_channer_call';	
				} else if(result[index].chnlNm == 'COUPON') {
					data.iconChannerClass = 'icon_channer_coupon';
				}
			});
			var temp = $("#campaignActTemp").tmpl(result);
	        $(".campaign_allact").append(temp);
		}
		else {
			$('#homeAllAct').hide();
       		$('#emptyHomeAllAct').show();
		}
    });
} */

// 세그먼트
function getCampaignSeg() {
    
	$.ifvPostJSON('<ifvm:action name="getCampaignSeg"/>', {
	},
    function(result) {
		if(result.length > 0) {
			$('#homeSegment').show();
       		$('#emptyHomeSegment').hide();
			var temp = $("#campaignSegTemp").tmpl(result);
	        $(".campaign_seg").append(temp);	
		}
		else {
			$('#homeSegment').hide();
       		$('#emptyHomeSegment').show();
		}
    });
}
 
// 셀 선택 이벤트 캠페인
// 2018-02-01 Template에서 function 호출부분 제거 - sjbaek
// function selectCamCell(_this) {
// 	var _type = $(_this).attr("type");
// 	var _id = $(_this).attr("id");
	
// 	if (_type == "QUICK") {
// 		qtjs.href('<ifvm:url name="quickCampaign"/>?id='+ _id);
// 	}
// 	else {
// 		qtjs.href('<ifvm:url name="campaignWorkFlow"/>?id='+ _id;		);
// 	}
// }

//세그먼트 상세  이동
// 2018-02-01 Template에서 function 호출부분 제거 - sjbaek
// function selectSegCell(id) {
// 	qtjs.href('<ifvm:url name="segmentDetail_KPR"/>?segmentId='+ id);
// }
function getVolatility(){
	var data01 =[
		{ x:'1', y:3 }, { x:'2', y:3.5 }, { x:'3', y:7 }, { x:'4', y:13.5 },
        { x:'5', y:19 }, { x:'6', y:20 }, { x:'7', y:26 }, { x:'8', y:25 },
        { x:'9', y:13 }, { x:'10', y:18 }, { x:'11', y:21 }, { x:'12', y:30 }
       ]
	
	var data02 =[
		{ x:'1', y:-1 }, { x:'2', y:-1 }, { x:'3', y:2 }, { x:'4', y:8 }, 
		{ x:'5', y:13 }, { x:'6', y:18 }, { x:'7', y:21 }, { x:'8', y:20 },
		{ x:'9', y:13 }, { x:'10', y:18 }, { x:'11', y:21 }, { x:'12', y:20 }
	];
	$("#volatility").ejChart(
        {
            primaryYAxis:
            {
                range: { min:-5, max:35, interval:5 },
                labelFormat: "{value}",
                axisLine:{ offset:5 }
			},
			 primaryXAxis:
	            {
				 	range:{ interval:1 }
	            },
            //Initializing Common Properties for all the series
			commonSeriesOptions: 
			{
                type: 'line', 
				enableAnimation: true,
                marker:
                {
                    shape: 'circle',
					size:
                    {
                        height:5, width:5
                    },
                    visible: false
                },                              
				tooltip: {visible: true, format: "#point.x# <br/> #series.name# : #point.y#"}
            },			
			//Initializing Series
			series: 
			[
				{
                    points: data01,
                    name: '2019'
                },				
                {
                    points: data02,
					name: '2020'
                }             
			],
			load:"loadTheme",
			canResize:true,
            legend: { visible: true }
        }
    );
}
function getPromotionResponse(){
	
	var data = [
        {x:'구매고객 대상 설문참여',y:20},
        {x:'다구매 빈번 고객 프로모션',y:140},
        {x:'신규가입 고객 프로모션',y:10},
        {x:'7월 구매보상 쿠폰 지급',y:70},
        {x:'실시간 참여 이벤트',y:30},
   ]
	
	$("#promotionResponse").ifvsfChart({
		//Initializing Primary X Axis
		primaryXAxis:
		{
			rangePadding: 'Additional',
			labelRotation: 45,
		},	
       // Intializing data
       commonSeriesOptions:{
                dataSource: data,
				xName: "x",
				yName: "y",
				isTransposed : true	
       },
		//Initializing Series	
		series: 
		[
			{
				name: 'Country', 
				type: 'column',
				enableAnimation: true,
				fill:"#69D2E7",
			}
		],
		canResize:true,          
		legend: { visible: false }
	 });
}

function grp(){
	var data =  [{ x: 'Labour', y: 90, text: '90%' }, { x: 'Legal', y: 10, text: '10%' },]
	$("#grp03").ejChart(
	        {
				//Initializing Series
	            series:
				[	
					{
	                    points:data,
	                    name: 'Newyork', 
						type: 'doughnut',
						enableAnimation : true
	                }
	            ],
	            commonSeriesOptions:{
	              doughnutCoefficient :0.5,
	              doughnutSize : 0.5
	            },
				canResize:true,
				title: { text: '' },
	            legend: { visible: false}
	        });
}
$(document).ready(function() {
    
	// 캠페인 현황
	//getCampaignStatus();
	
	// 캠페인 구매 반응률
	//getCampaignPrchaseRec();
	
	// 나의활성 캠페인
	getCampaignMyAct();
	
	// 전체활성 캠페인
	//getCampaignAllAct();
	
	// 세그먼트
	getCampaignSeg();
	
	//프로모션 반응률
	getPromotionResponse();
	
	// 가입자수 변동추이
	getVolatility();
	
	grp();
	
	// 탭
	$("#homeCampaignTab a").on("click", function(){
		$("#homeCampaignTab a").removeClass("active");
		$(this).addClass("active");
	});
	
	
	
	

});

</script>

<script id="campaignPrcRecTemp" type="text/x-jquery-tmpl">
<li>
	<div class="cnt_type_list_inner" id="${'${'}camId}" type="${'${'}camTypeCd}" >
		<div class="home_list_title">
			<strong>${'${'}camNm}</strong>
			<p><span>${'${'}camStartDd}</span> ~ <span>${'${'}camEndDd}</span></p>
		</div>
		<div class="home_response_graph_group">
			<div class="circle_graph person_group">
				<div class="${'${'}circleGraphicClass1}" style="">${'${'}testGrp}</div>
			</div>
			<div class="circle_graph comparison_group">
				<div class="${'${'}circleGraphicClass2}" style="">${'${'}ctrlGrp}</div>								
			</div>
		</div>
	</div>
</li>
</script>

<script id="campaignActTemp" type="text/x-jquery-tmpl">
<li>
	<div class="pm_total" id="${'${'}camId}" type="${'${'}camTypeCd}">
		<div class="pm_total_tit">
			<strong>${'${'}camNm}</strong>
			<p><span>${'${'}camStartDd}</span> ~ <span>${'${'}camEndDd}</span></p>
		</div>
	</div>
	<div class=""><var>${'${'}tgtMemCnt}</var></div>
	<div class=""><var>${'${'}chnlNm}</var></div>	
	<div class=""><span class="">${'${'}chnlRspnsCnt}%</span></div>												
    <div class=""><span class="">${'${'}cpnRspnsCnt}%</span></div>									
</li>
</script>

<script id="campaignSegTemp" type="text/x-jquery-tmpl">
<li>
	<div class="txtlist_inner" id="${'${'}segId}">
		<a href="#" class="txtlist_subject">${'${'}segNm}</a>
		<div class="txtlist_desc_info">
			<span class="txtlist_date">${'${'}modifyDate}</span>
		</div>
	</div>
</li>
</script>

<div class="page-title">
	<h1><spring:message code="M02507" /></h1>
</div>

<div class="home_wrap" >
	<div class="dashboard_area">
	<div class="home-top">
		<ul class="top-area">
			<li class="home_box box_campaign_current">
				 <div class="homebox_btn_area">
					<div class="row">
						<div class="col-md-12"><h4>전체고객 수</h4></div>
					</div>
				</div>
				<div class="cnt_campaign">
					<div class="tb-cell">
						<p class="data-area"><span class="count" >54,123,123</span> 명</p>
						<p><span class="upper">+100명</span>(전월대비)</p>
					</div>
				</div>
			</li>
			<li class="home_box box_campaign_current">
				 <div class="homebox_btn_area">
					<div class="row">
						<div class="col-md-12"><h4>당월 신규고객 수</h4></div>
					</div>
				</div>
				<div class="cnt_campaign">
					<div class="tb-cell">
						<p class="data-area"><span class="count" >54,123,123</span> 명</p>
						<p><span class="upper">+100명</span>(전월대비)</p>
					</div>
					
				</div>
			</li>
			<li class="home_box box_campaign_current">
				 <div class="homebox_btn_area">
					<div class="row">
						<div class="col-md-12"><h4>이월징후고객 수</h4></div>
					</div>
				</div>
				<div class="cnt_campaign">
					<div class="tb-cell">
						<p class="data-area"><span class="count">123</span> 명</p>
						<p><span class="upper">+100명</span>(전월대비)</p>
					</div>
				</div>
			</li>
			<li class="home_box box_campaign_current">
				 <div class="homebox_btn_area">
					<div class="row">
						<div class="col-md-12"><h4>당월 프로모션 진행 건수</h4></div>
					</div>
				</div>
				<div class="cnt_campaign">
					<div class="tb-cell">
						<p class="data-area"><span class="count">123</span> 건</p>
						<p><span class="lower">-100명</span>(전월대비)</p>
					</div>
				</div>
			</li>
				<li class="home_box box_campaign_current ">
				 <div class="homebox_btn_area">
					<div class="row">
						<div class="col-md-12"><h4>당월 프로모션 반응률</h4></div>
					</div>
				</div>
				<div class="cnt_campaign">
					<div class="tb-cell reaction-area">
						<div class="grp-wrap"style="width:100%; height:150px; display:inline-block">
							<div id="grp03" style="width:200px; height:150px; display:inline-block" ></div>
						</div>
						<p class="data-area"><span class="count">99.12</span> %</P>
						<p><span class="upper">+100명</span>(전월대비)</p>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<div class="home_row type_left">
		<div class="home_box box_my_campaign">
			<div class="row">
				<div class="col-md-12">
					<div class="homebox_btn_area">
						<div class="row">
							<div class="col-md-11"><h4>전체 프로모션</h4></div>
							<div class="col-md-1 text-right"><span>More</span></div>
						</div>
					</div>
				<%-- 	<div class="btn-group btn-group-justified" id="homeCampaignTab">
						<a href="#homeMyCampaign" class="btn btn-default active" data-toggle="tab"><spring:message code="M01828" /></a>
						<a href="#homeAllCampaign" class="btn btn-default" data-toggle="tab"><spring:message code="M01829" /></a>
					</div> --%>										
<%-- 					<div class="tab-content">
						<!-- 나의 캠페인 -->
						
						<!-- 전체 캠페인  -->
						<div id="homeAllCampaign" class="tab-pane fade">
							<div id="homeAllAct" class="cnt_type_list">
								<div class="cnt_list_theader"><p class="cnt_theader_graph"><span><spring:message code="M01830" /></span><span><spring:message code="M01831" /></span></p></div>		
								<ul class="campaign_allact"></ul>				
							</div>												
							<div id="emptyHomeAllAct" class="cnt_type_list">
								<p class="cnt_list_blank"><spring:message code="M01827" /></p>				
							</div>												
						</div>
					</div>
					 --%>
					<div id="homeMyCampaign" class="tab-pane fade in active">
						<div id="homeMyAct" class="cnt_type_list">
							<div class="cnt_list_theader">
								<div></div>
                            	<div>참여자수</div>
                            	<div>알림채널</div>
                            	<div>채널 반응률</div>
                            	<div>쿠폰 반응률</div>       
                            </div>		
							<ul class="campaign_total"></ul>				
						</div>						
						<div id="emptyHomeMyAct" class="cnt_type_list">
							<p class="cnt_list_blank"><spring:message code="M01827" /></p>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="home_box box_campaign_current">
			 <div class="homebox_btn_area">
				<div class="row">
					<div class="col-md-12"><h4>가입자수 변동추이</h4></div>
				</div>
			</div> 
			<div class="cnt_campaign_current">
				<div id="volatility"></div>
			</div>
		</div>
	</div>	
	<div class="home_row type_right">
		<div class="home_box box_home_segment">
			 <div class="homebox_btn_area">
				<div class="row">
				<div class="col-md-11"><h4>공지사항</h4></div>
				<div class="col-md-1 text-right"><span>More</span></div>
				</div>
			</div> 	
			<div id="homeSegment" class="cnt_type_txtlist">
				<ul class="campaign_seg"></ul>
			</div>					
			<div id="emptyHomeSegment" class="cnt_type_txtlist">
				<p class="cnt_list_blank"><spring:message code="M01827" /></p>
			</div>
		</div>

		<div  class="home_box box_response_rate">
			 <div class="homebox_btn_area">
				<div class="row">
					<div class="col-md-12"><h4><spring:message code="M01823" /></h4></div>
				</div>
			</div>
			<div id="promotionResponse"></div>
		</div>
	</div>
	
</div>
</div>

