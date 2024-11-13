<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<link href="${pageContext.request.contextPath}/resources/css/marketing/campaignHome.css?after" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/css/kepler/analysis.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/resources/js/marketing/diagram/css/diagramStyle.css" rel="stylesheet"/>

<style type="text/css">
    #camPrcArea {
        display: none;
    }

    #homeNotice {
        display: none;
    }

    #homePromotion {
        display: none;
    }

    /*#homeApproval{display: none;}*/
    #homeApprovalReq {
        display: none;
    }

    #homeAllAct {
        display: none;
    }

    .moreButton {
        border: none;
        background: none;
        cursor: pointer;
    }

    .lastUpdateDate {
        color: gray;
        font-size: 95%;
    }

    .fontSize {
        font-size: 13px;
    }

    /*.home_wrap .tb-cell p.data-area.item06{
        padding-top : 65px;
        padding-left : 53px;
    }*/

    /*.item06{
        font-family: 'NotoSans';
        text-align: left;
        font-size: 11px;
        padding-left :20%;
    }

    .item06 .pntValue{
        display : inline-block;
        text-align: right;
        width: 33%;
     }*/

    /*.item05, .item02{
        font-family: 'NotoSans';
        font-size: 11px;
        padding-top:4%;
        text-align: center;
    }	*/

    /* .home_wrap .tb-cell  */
    .upper2 {
        color: lightseagreen;
    }

    table {
        width: 100%;
    }

    table tbody tr {
        border-bottom-width: 10px;
        border-bottom: dashed 0.1px lightgray;
    }

    table tbody tr th {
        font-family: 'NotoSans';
        font-weight: 400;
        padding: 5px;
    }


</style>

<script type="text/javascript">
    var campaignHomeGrid;
    var campaignHomeGrid2;
    var empId;
    var authType;
    var brandCd;
    var empType;
    var iciganlHome = function () {
        this.dataField = [],
            this.init = function () {
                this.setButton();
                this.campaignAuth();	//권한
                this.getCrmHome();
                this.getCampaignOfMonth(); //당월 캠페인 실행(월별 누적)
                this.getHomeCamList();//당월 실행 캠체인 목록
                this.getHomeCamList2();//당월 캠페인 진행 예정 목록


                // this.getTotalCust();              //전체 고객수
                // this.getNewCustOfMonth();   //당월 신규 고객수

                // this.getHomeApprovalReqList(); //결제 요청문서
                // this.getMktAvailableMbr(); //마켓팅 가능 회원 수

                //this.getNewCustOfDay();      // 금일 신규 고객수
                //this.getPointRst(); 				 //포인트 현황
                //this.getHomeApprovalList(); //결재 문서
                //this.getHomeNoticeList();// 공지사항
                //this.getExitSignCust(); //추후개발
                //this.getPromotionOfMonth();
                //this.getReactRateForPromOfMonth();

                // 가입자수 변동추이
                // this.getHomeVolatility();
                // 캠페인 구매 반응률
// 		this.getCampaignPurResponse();
            },
            this.campaignAuth = function() {
                $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
                    empId = result.rows[0].empId;
                    authType = result.rows[0].authType;
                    brandCd = result.rows[0].brandCd;
                    empType = result.rows[0].empType;
                });
            },
            this.getCrmHome = function () {
                $.ifvPostJSON('<ifvm:action name="getCrmHome"/>', {}, function (result) {

                    if ($.fn.ifvmIsNotEmpty(result)) {
                        var actMbrCnt = result.actMbrCnt; //활성회원수(당일 활성 회원 수)
                        var actMbrCntPm = result.actMbrCntPm; //전월 활성 회원 수(전월 말일자 기준 활성 회원 수)
                        var actMbrCntPy = result.actMbrCntPy; //전년 활성 회원 수(전년 12월 말일자 기준 활성 회원 수)
                        $(".item01 .count1")[0].innerHTML = this.setComma(actMbrCnt);
                        $(".item01 .count2")[0].innerHTML = ((actMbrCnt - actMbrCntPm) / (actMbrCntPm == 0 ? 1 : actMbrCntPm) * 100).toFixed(1) + "%";
                        $(".item01 .count3")[0].innerHTML = ((actMbrCnt - actMbrCntPy) / (actMbrCntPy == 0 ? 1 : actMbrCntPy) * 100).toFixed(1) + "%";

                        $(".item02 .cnt")[0].innerHTML = this.setComma(result.newMbrCnt); //신규 회원 수(당일 신규 회원 수)
                        $(".item02 .cnt2")[0].innerHTML = this.setComma(result.dorMbrCnt); //휴면 회원 수(당일 휴면 회원 수)
                        $(".item02 .cnt3")[0].innerHTML = this.setComma(result.secsnMbrCnt); //탈퇴 회원 수(당일 탈퇴 회원 수)
                        var loginCntD = result.loginCntD; //당일 로그인 수
                        var loginCntPd = result.loginCntPd; //전일 로그인 수
                        var loginCntM = result.loginCntM; //당월 로그인 수
                        var loginCntPm = result.loginCntPm; //전월 로그인 수(전월 1일~말일 까지의 로그인 수 합계)
                        var loginCntY = result.loginCntY; //당해 로그인 수(당해 1월~현재 월까지의 로그인 수 합계)
                        var loginCntPy = result.loginCntPy; //전년 로그인 수(전년 1월~12월까지의 로그인 수 합계)

                        $(".item02 .cnt4")[0].innerHTML = this.setComma(loginCntD);
                        $(".item02 .cnt5")[0].innerHTML = ((loginCntM - loginCntPm) / loginCntPm).toFixed(1) + "%";
                        $(".item02 .cnt6")[0].innerHTML = ((loginCntY - loginCntPy) / loginCntPy).toFixed(1) + "%";

                        $(".item05 .cnt")[0].innerHTML = this.setComma(result.smsAgrMbrCnt); //당일 SMS 동의 회원 수
                        $(".item05 .cnt2")[0].innerHTML = this.setComma(result.pushAgrMbrCnt); //당일 PUSH 동의 회원 수
                        $(".item05 .cnt3")[0].innerHTML = this.setComma(result.emailAgrMbrCnt); //당일 EMAIL 동의 회원 수
                    }

                }.bind(this));

                var date = this.getTodayDate(-1);

                $("#tcLastUpdateDate")[0].innerHTML = date;
                $("#ncomLastUpdateDate")[0].innerHTML = date;
                $("#escLastUpdateDate")[0].innerHTML = date;

            },
            this.getTotalCust = function () { //전체회원수

                $.ifvPostJSON('<ifvm:action name="getTotalCust"/>', {}, function (result) {
                    $(".item01 .count1")[0].innerHTML = this.setComma(0);
                    $(".item01 .count2")[0].innerHTML = this.setComma(0);
                    $(".item01 .count3")[0].innerHTML = this.setComma(0);
                    // $(".item01 .count1")[0].innerHTML = this.setComma(result.countsI);
                    // $(".item01 .count2")[0].innerHTML = this.setComma(result.countsE);
                    // $(".item01 .count3")[0].innerHTML = this.setComma(result.countsX);
                    // $(".item01 .count4")[0].innerHTML = this.setComma(result.countsO);
                }.bind(this));

                $("#tcLastUpdateDate")[0].innerHTML = this.getTodayDate();
            },
            this.getNewCustOfMonth = function () { //당월 신규회원수

                $.ifvPostJSON('<ifvm:action name="getNewCustOfMonth"/>', {}, function (result) {
                    if (result != null) {
                        //var currCnt = result.currCnt>=10?result.currCnt:'0'+result.currCnt;
                        //var currFirstMonthCnt =result.currFirstMonthCnt>=10?result.currFirstMonthCnt:'0'+result.currFirstMonthCnt;

                        $(".item02 .cnt")[0].innerHTML = this.setComma(result.currCnt);
                        // if(result.plusCnt>0) $(".item02 .upper")[0].innerHTML = "+"+this.setComma(result.plusCnt)+"명";
                        // else $(".item02 .upper")[0].innerHTML = this.setComma(result.plusCnt)+"명";

                        $(".item02 .cnt2")[0].innerHTML = this.setComma(0);
                        // if(result.firstPluscnt>=0) $(".item02 .upper2")[0].innerHTML = "+"+this.setComma(result.firstPluscnt)+"명";
                        // else $(".item02 .upper2")[0].innerHTML = this.setComma(result.firstPluscnt)+"명";
                        $(".item02 .cnt3")[0].innerHTML = this.setComma(0);

                    }
                    /* else{
                        $(".item02 .count")[0].innerHTML = "집계된 데이터가 없습니다";
                        $(".item02 .upper")[0].innerHTML = "집계된 데이터가 없습니다";
                    } */

                    // if(result.lastUpdateDate != null){
                    // 	var updateDate = result.lastUpdateDate;
                    // 	updateDate =  updateDate.substr(4,2) + "." + updateDate.substr(6);
                    // 	//updateDate = "("+updateDate.substr(0,4) + "/"+ updateDate.substr(4,2) + "/" + updateDate.substr(6)+")";
                    // 	$("#ncomLastUpdateDate")[0].innerHTML = updateDate;
                    // }
                }.bind(this));
                $("#ncomLastUpdateDate")[0].innerHTML = this.getTodayDate();

            }, this.getNewCustOfDay = function () { //금일 신규회원수
            $.ifvPostJSON('<ifvm:action name="getNewCustOfDay"/>', {}, function (result) {
                if (result != null) {
                    //var cuurCntDay = result.cuurCntDay>=10?result.cuurCntDay:'0'+result.cuurCntDay;
                    //var currFirstDayCnt =result.currFirstDayCnt>=10?result.currFirstDayCnt:'0'+result.currFirstDayCnt;

                    //  $(".item05 .cnt")[0].innerHTML = this.setComma(result.cuurCntDay);
                    // if(result.plusCnt>=0) $(".item05 .upper")[0].innerHTML = "+"+this.setComma(result.plusCnt)+"명";
                    // else $(".item05 .upper")[0].innerHTML = this.setComma(result.plusCnt)+"명";

                    /*$(".item05 .cnt2")[0].innerHTML = this.setComma(result.currFirstDayCnt);
                    if(result.firstPluscnt>=0) $(".item05 .upper2")[0].innerHTML = "+"+this.setComma(result.firstPluscnt)+"명";
                    else $(".item05 .upper2")[0].innerHTML = this.setComma(result.firstPluscnt)+"명";*/
                }
                $("#escLastUpdateDate")[0].innerHTML = this.getTodayDate();
            }.bind(this));
        }, this.getCampaignOfMonth = function () {
            $.ifvPostJSON('<ifvm:action name="getCampaignOfMonth"/>', {
                empId: empId,
                authType: authType,
                brandCd: brandCd,
            }, function (result) {
                if (result != null) {
                    /* 		var totProgCntRst = result.totProgCnt>=10?result.totProgCnt:'0'+result.totProgCnt;
                            var totExtCntRst =  result.totExtCnt>=10?result.totExtCnt:'0'+result.totExtCnt;
                            var monthProgCntRst = result.monthProgCnt>=10?result.monthProgCnt:'0'+result.monthProgCnt;
                            var monthExtCntRst = result.monthExtCnt>=10?result.monthExtCnt:'0'+result.monthExtCnt;
                            $(".item07 .totProgCnt")[0].innerHTML = this.setComma(result.totProgCnt);
                            $(".item07 .totExtCnt")[0].innerHTML = this.setComma(result.totExtCnt);
                            $(".item07 .monthProgCnt")[0].innerHTML = this.setComma(result.monthProgCnt);
                            $(".item07 .monthExtCnt")[0].innerHTML = this.setComma(result.monthExtCnt); */
                    //totCampaignCnt 캠페인 수
                    $(".item07 .totCampaignCnt")[0].innerHTML = this.setComma(result.totCampaignCnt);
                    //sendSucesCnt 성공
                    $(".item07 .sendSucesCnt")[0].innerHTML = this.setComma(result.sendSucesCnt);
                    //camTgtCnt 타겟
                    $(".item07 .camTgtCnt")[0].innerHTML = this.setComma(result.camTgtCnt);

                }
            }.bind(this));
            $("#rrfpomLastUpdateDate")[0].innerHTML = this.getTodayDate();
        },
            this.getExitSignCust = function () { //이탈징후고객수

                //추후개발 TBD
                //$.ifvPostJSON('<ifvm:action name="getExitSignCust"/>',{ },function(result){}.bind(this));

                $("#escLastUpdateDate")[0].innerHTML = this.getTodayDate();

            },
            this.getPromotionOfMonth = function () { //당월 프로모션 진행건

                $.ifvPostJSON('<ifvm:action name="getPromotionOfMonth"/>', {}, function (result) {
                    $(".item06 .count")[0].innerHTML = this.setComma(result);
                    //	$("#pomLastUpdateDate")[0].innerHTML = this.getTodayDate();
                }.bind(this));

            }, this.getPointRst = function () {

            $.ifvPostJSON('<ifvm:action name="getPointStatus"/>', {}, function (result) {
                if (result != null) {
                    $(".item06 #basePnt")[0].innerHTML = this.setComma(result.basePnt);
                    // $(".item06 #acrlMonth")[0].innerHTML = this.setComma(result.acrlMonth);
                    // $(".item06 #rdmPnt")[0].innerHTML = this.setComma(result.rdmPnt);
                    // $(".item06 #acrlBeforeDay")[0].innerHTML = this.setComma(result.acrlBeforeDay);
                    // $(".item06 #usePntBeforeDay")[0].innerHTML = this.setComma(result.usePntBeforeDay);
                }
            }.bind(this));
            $("#pomLastUpdateDate")[0].innerHTML = this.getTodayDate();
        },
            this.getReactRateForPromOfMonth = function () { //당월 프로모션 반응률
                //추후개발 TBD
                //$.ifvPostJSON('<ifvm:action name="getReactRateForPromOfMonth"/>',{ },function(result){}.bind(this));
                $("#rrfpomLastUpdateDate")[0].innerHTML = this.getTodayDate();
                ////당월 프로모션 반응률 그래프 그리는 함수, 해당 함수는 당월 프로모션 반응률을 삽입시에 호출 해주시는 방향으로 수정하시면 됩니다.
                //this.prmRespGrp = function (){
// 			var data =  [{ x: 'res', y: 90, text: '90%', fill:"#518be9"}, { x: 'non-res', y: 10, text: '10%',fill:"#a2c1f2" },]
// 			//그래프 드로잉
// 			$("#grp03").ifvsfChart(
// 			        {
// 						//Initializing Series
// 			            series:
// 						[	
// 							{
// 			                    points:data,
// /* 			                    marker: 
// 								{
// 			                        dataLabel: 
// 									{
// 										visible:true,
// 			                            shape: 'none', 
// 										connectorLine: { type: 'bezier',color: 'black' },
// 			                            font: {size:'9px'}
// 									}
// 			                    }, */
// 			                    name: 'response', 
// 								type: 'doughnut',
// 								enableAnimation : true,

// 			                }
// 			            ],
// 			            commonSeriesOptions:{
// 			              doughnutCoefficient :0.5,
// 			              doughnutSize : 0.5
// 			            },
// 						canResize:true,
// 						title: { text: '' },
// 			            legend: { visible: false}
// 			        });
// 		//}

            },
            this.getMktAvailableMbr = function () {
                $.ifvPostJSON('<ifvm:action name="getNewCustOfDay"/>', {}, function (result) {
                    if (result != null) {
                        //var cuurCntDay = result.cuurCntDay>=10?result.cuurCntDay:'0'+result.cuurCntDay;
                        //var currFirstDayCnt =result.currFirstDayCnt>=10?result.currFirstDayCnt:'0'+result.currFirstDayCnt;

                        //SMS
                        $(".item05 .cnt")[0].innerHTML = this.setComma(0);
                        //App푸시
                        $(".item05 .cnt2")[0].innerHTML = this.setComma(0);
                        //이메일
                        $(".item05 .cnt3")[0].innerHTML = this.setComma(0);
                    }
                    $("#escLastUpdateDate")[0].innerHTML = this.getTodayDate();
                }.bind(this));
            },
            this.setComma = function (value) {
                var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
                value += '';                          // 숫자를 문자열로 변환
                while (reg.test(value)) {
                    value = value.replace(reg, '$1' + ',' + '$2');
                }
                return value;
            },
            this.setButton = function () {

                $("#goPromList").on('click', function () {
                    qtjs.href('<ifvm:url name="camExecStatusList"/>');
                });

                $("#goPromList2").on('click', function () {
                    qtjs.href('<ifvm:url name="campaignList"/>');
                });

                $("#goNoticeList").on('click', function () {
                    qtjs.href('<ifvm:url name="noticeBoList"/>');
                });

                /* $("#goApprovalList").on('click',function(){
                    qtjs.href('
                <ifvm:url name="approvalListNew"/>');
		});
		
		$("#goApprovalReqList").on('click',function(){
			qtjs.href('
                <ifvm:url name="approvalListReqListNew"/>');
		}); */

                /* $("#changeApr").click(function(){
                    //this.changeApproval();
                }.bind(this)); */
            },
            this.changeApproval = function () {
                var btnNm = $("#changeApr").attr('name');
                $("#approval").children().remove();
                if (btnNm == "aprReqList") {
                    var temp = $("#approvalReqListTemp").tmpl(1);
                    $("#approval").append(temp);
                    this.getHomeApprovalReqList();
                } else {
                    var temp = $("#approvalListTemp").tmpl(1);
                    $("#approval").append(temp);
                    this.getHomeApprovalList();
                }
            },
            // 당원 캠페인 진행예정 목록
            this.getHomeCamList = function () {
                $.ifvPostJSON('<ifvm:action name="getHomeCamList"/>', {
                        empId: empId,
                        authType: authType,
                        brandCd: brandCd,
                    },
                    function (result) {
                        if (result.rows.length > 0) {
                            $('#homePromotion').show();
                            $('#emptyHomePromotion').hide();
                            var temp = $("#activeCampaignTableTemp").tmpl(result.rows);
                            //var temp = $("#campaignPromTemp").tmpl(result.rows);
                            $(".home_promotion").append(temp);
                        } else {
                            $('#homePromotion').hide();
                            $('#emptyHomePromotion').show();
                        }
                    });
            },
            this.getHomeCamList2 = function () {
                $.ifvPostJSON('<ifvm:action name="getHomeCamList2"/>', {
                        empId: empId,
                        authType: authType,
                        brandCd: brandCd,
                    },
                    function (result) {
                        if (result.rows.length > 0) {
                            $('#homePromotion2').show();
                            $('#emptyHomePromotion2').hide();
                            var temp = $("#campaignOfMonthTableTemp").tmpl(result.rows);
                            $(".home_promotion2").append(temp);
                        } else {
                            $('#homePromotion2').hide();
                            $('#emptyHomePromotion2').show();
                        }

                    });
            },
            //결재 문서
            this.getHomeApprovalList = function () {
                $.ifvPostJSON('<ifvm:action name="getHomeApprovalList"/>', {},
                    function (result) {
                        if (result.rows.length > 0) {
                            $('#homeApproval').show();
                            $('#emptyHomeApproval').hide();
                            var temp = $("#campaignApprovalTemp").tmpl(result.rows);
                            $(".home_approval").append(temp);
                        } else {
                            $('#homeApproval').hide();
                            $('#emptyHomeApproval').show();
                        }
                    });
            },
            //결재요청문서
            this.getHomeApprovalReqList = function () {
                $.ifvPostJSON('<ifvm:action name="getHomeApprovalReqList"/>', {},
                    function (result) {
                        var temp = $("#campaignApprovalReqTemp").tmpl(result.rows);
                        $(".home_approvalReq").append(temp);
                        // if(result.rows.length > 0){
                        // 	$('#homeApprovalReq').show();
                        // 	$('#emptyHomeApprovalReq').hide();
                        // 	var temp = $("#campaignApprovalReqTemp").tmpl(result.rows);
                        //     $(".home_approvalReq").append(temp);
                        // }
                        // else {
                        // 	$('#homeApprovalReq').hide();
                        // 	$('#emptyHomeApprovalReq').show();
                        // }
                    });
            },
            // 공지사항(새로운 메뉴 생성 및 수정필요)
            this.getHomeNoticeList = function () {
                $.ifvPostJSON('<ifvm:action name="getHomeNoticeList"/>', {},
                    function (result) {
                        if (result.rows.length > 0) {
                            $('#homeNotice').show();
                            $('#emptyHomeNotice').hide();
                            var temp = $("#campaignNoticeTemp").tmpl(result.rows);
                            $(".home_notice").append(temp);
                        } else {
                            $('#homeNotice').hide();
                            $('#emptyHomeNotice').show();
                        }
                    });
            },
            // 가입자수 변동추이
            // this.getHomeVolatility = function (){
            <%--var dataArr = [], yearMonthArr = [] , yearArr =[], monthArr = [],  totalArr = [];--%>
            <%--var sbscDate = [];--%>
            <%--var camNm = [];--%>
            <%--var lastSbscDate = [];--%>
            <%--var data = {};--%>
            <%--var lastYear = [],  thisYear = [];--%>
            <%--var lastUpdateDate;--%>
            <%--var sysdate;--%>

            <%--$.ifvPostJSON('<ifvm:action name="getHomeVolatility"/>', {}, function(result){--%>
            <%--	var volat = result.rows;--%>
            <%--	this.dataField = result.rows;--%>
            <%--	for(var i = 0; i< volat.length; i++ ){--%>
            <%--		/* yearMonthArr[i] = volat[i].yearMonth;--%>
            <%--		yearArr[i] = volat[i].yearMonth.substr(0,4);--%>
            <%--		monthArr[i] = volat[i].yearMonth.substr(4);--%>
            <%--		totalArr[i] = volat[i].total;`--%>
            <%--		lastUpdateDate = volat[i].lastUpdateDate; */--%>
            <%--		sbscDate[i] = volat[i].sbscDate;--%>
            <%--		camNm[i]    = volat[i].camNm;--%>
            <%--		totalArr[i] = volat[i].total;--%>
            <%--		sysdate = volat[i].mmDate--%>
            <%--	}--%>
            <%--	var uniqSbscDate = sbscDate.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);--%>
            <%--	//var uniqMonth = monthArr.reduce(function(a,b){if(a.indexOf(b)<0)a.push(b);return a;},[]);--%>

            <%--	// data setting--%>
            <%--	this.dataField.forEach(function(a, index){--%>
            <%--		data = { x : a.sbscDate.substr(6,6) +'일', y : a.total , name : a.camNm, total : a.total+ '명'};--%>
            <%--		for(var j =0; j<uniqSbscDate.length; j++){--%>
            <%--			if(a.sbscDate.substr(6,6) == uniqSbscDate[j].substr(6,6)){--%>
            <%--				//this.dateField[index] = data;--%>
            <%--				lastSbscDate[index] = data;--%>
            <%--				return;--%>
            <%--			}/* else{--%>
            <%--				thisYear[index- lastYear.length] = data;--%>
            <%--				return;--%>
            <%--			} */--%>
            <%--		}--%>
            <%--	})--%>

            <%--	/* var data01 =[--%>
            <%--		{ x:1, y:3 }, { x:2, y:3.5 }, { x:3, y:7 }, { x:'4', y:13.5 },--%>
            <%--        { x:'5', y:19 }, { x:'6', y:20 }, { x:'7', y:26 }, { x:'8', y:25 },--%>
            <%--        { x:'9', y:13 }, { x:'10', y:18 }, { x:'11', y:21 }, { x:12, y:90 }--%>
            <%--       ]--%>

            <%--	var data02 =[--%>
            <%--		{ x:'1', y:-1 }, { x:'2', y:-1 }, { x:'3', y:2 }, { x:'4', y:8 },--%>
            <%--		{ x:'5', y:13 }, { x:'6', y:18 }, { x:'7', y:21 }, { x:'8', y:20 },--%>
            <%--		{ x:'9', y:13 }, { x:'10', y:18 }, { x:'11', y:21 }, { x:'12', y:20 }--%>
            <%--	]; */--%>
            <%--	var largest = Math.max.apply(Math, totalArr);--%>
            <%--	seriesArr =--%>
            <%--	//그래프 드로잉--%>
            <%--	$("#volatility").ifvsfChart(--%>
            <%--        {--%>
            <%--            primaryYAxis:--%>
            <%--            {--%>
            <%--            	// y축 범위설정--%>
            <%--                range: { min:0, max: largest+5 , interval: largest/2 },--%>
            <%--                axisLine:{ offset:5 }--%>
            <%--			},--%>
            <%--			 primaryXAxis:--%>
            <%--	            {--%>
            <%--				 	range:{ interval:1 }--%>
            <%--	            },--%>
            <%--            //Initializing Common Properties for all the series--%>
            <%--			commonSeriesOptions:--%>
            <%--			{--%>
            <%--                type: 'line',--%>
            <%--				enableAnimation: false,--%>
            <%--                marker:--%>
            <%--                {--%>
            <%--                    shape: 'circle',--%>
            <%--					size:--%>
            <%--                    {--%>
            <%--                        height:10, width:10--%>
            <%--                    },--%>
            <%--                    visible: true--%>
            <%--                },--%>
            <%--				tooltip: {visible: true, format: "가입자수 : #point.total# <br/><br/> <진행된 캠페인> <br/> #point.name#"}--%>
            <%--            },--%>
            <%--			//Initializing Series--%>
            <%--			series:--%>
            <%--			[--%>
            <%--				{--%>
            <%--					points: lastSbscDate,--%>
            <%--					name  : sysdate--%>
            <%--                }--%>
            <%--			],--%>
            <%--			load:"loadTheme",--%>
            <%--			canResize:true,--%>
            <%--            legend: { visible: true }--%>
            <%--        }--%>
            <%--    );--%>
            <%--	if(lastUpdateDate != null){--%>
            <%--		lastUpdateDate =  lastUpdateDate.substr(4,2) + "." + lastUpdateDate.substr(6);--%>
            <%--		$("#vLastUpdateDate")[0].innerHTML = lastUpdateDate;--%>
            <%--	}--%>

            // }.bind(this));

            // },
            //캠패인 구매 반응률
// 	this.getCampaignPurResponse = function (){

// 		var data = [
// 	        {x:'구매고객 대상 설문참여',y:20},
// 	        {x:'다구매 빈번 고객 프로모션',y:140},
// 	        {x:'신규가입 고객 프로모션',y:10},
// 	        {x:'7월 구매보상 쿠폰 지급',y:70},
// 	        {x:'실시간 참여 이벤트',y:30},
// 	   ]
// 		//그래프 드로잉
// 		$("#promotionResponse").ifvsfChart({
// 			//Initializing Primary X Axis
// 			primaryXAxis:
// 			{
// 				rangePadding: 'Additional',
// 				labelRotation: 45,
// 			},	
// 	       // Intializing data
// 	       commonSeriesOptions:{
// 	                dataSource: data,
// 					xName: "x",
// 					yName: "y",
// 					isTransposed : true	
// 	       },
// 			//Initializing Series	
// 			series: 
// 			[
// 				{
// 					name: 'promotionResponse', 
// 					type: 'column',
// 					enableAnimation: true,
// 					fill:"#69D2E7",
// 				}
// 			],
// 			canResize:true,          
// 			legend: { visible: false }
// 		 });

// 		$("#prLastUpdateDate")[0].innerHTML = this.getTodayDate();
// 	},
            this.getTodayDate = function (insertDate) { //오늘날짜 계산
                var date = new Date();
                if ($.fn.ifvmIsEmpty(insertDate)) insertDate = 0;

                var year = date.getFullYear();
                var month = date.getMonth() + 1;
                if (month < 10) month = "0" + month;
                var day = date.getDate();
                day = day+insertDate;
                if (day < 10) day = "0" + day;
                var hours = date.getHours();
                var minutes = date.getMinutes();
                var seconds = date.getSeconds();
                if (seconds < 10) seconds = "0" + seconds;
                return year + "." + month + "." + day;
            }
    }

    //문서 변경
    function changeApproval() {
        var home = new iciganlHome();
        var btnNm = $("#changeApr").attr('name');
        $("#approval").children().remove();
        if (btnNm == "aprReqList") {
            var temp = $("#approvalReqListTemp").tmpl(1);
            $("#approval").append(temp);
            home.getHomeApprovalReqList();
        } else {
            var temp = $("#approvalListTemp").tmpl(1);
            $("#approval").append(temp);
            home.getHomeApprovalList();
        }
    }

    //결재 리스트 목록으로가기
    function goApprList(obj) {
        var id = obj.id;
        if (id == "goApprovalList") {
            qtjs.href('<ifvm:url name="approvalListNew"/>');
        } else {
            qtjs.href('<ifvm:url name="approvalListReqListNew"/>');
        }
    }

    //결재 미리보기 팝업
    function loadPop(obj) {
        var id = obj.id;
        var text = 'aprv';
        var campaignId = null;
        $("#empRefPopupCon").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="approvalLineInfoPop"/>?id=' + id + "&type=" + text + '&campaignId=' + campaignId,
            contentType: "ajax",
            title: '<spring:message code="M00392"/>',
            width: '1240px',
            height: '700px',
            close: 'popupClose'
        });
    }

    function popupClose() {
        $.fn.ifvmPopupClose();
    }


    function showNotice(obj) {
        ifvGlobal["noticeRid"] = obj.id;

        $("#popupContainer").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="previewNoticeBo"/>' + '?rid=' + obj.id,
            contentType: "ajax",
            title: "<spring:message code="공지 사항"/>",
            width: '860px',
            close: 'popupClose',
        });
    }

    var setChartTooltipInitialize = function (args) {
        var seriesIdx = args.data.seriesIndex;
        var pointIdx = args.data.pointIndex;

        var seriesObj = args.model.series[seriesIdx];
        var pointObj = seriesObj.points[pointIdx];

        var tooltipText = "";
        tooltipText += "Column : " + seriesObj.name + "<br />";
        tooltipText += "Row : " + pointObj.x + "<br />";
        tooltipText += "Value : " + $.ifvNumberFormat(pointObj.y);

        args.data.currentText = tooltipText;
    };

    $(document).ready(function () {

        var home = new iciganlHome();
        home.init();

    });

</script>

<%-- 당월 실행,진행 캠페인 목록 TEMP --%>
<script id="campaignOfMonthTemp" type="text/x-jquery-tmpl"><%--txtlist_subject--%>
<li>
	<div class="txtlist_inner" id="${'${'}camId}">
		<span class=""  style="margin-right: 20%">${'${'}createBy}</span>
		<div class="txtlist_desc_info" style="margin-right: 10%">
			<span class="txtlist_date">${'${'}camStartDd} ~ ${'${'}camEndDd}</span>
		</div>
		<a href="<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=${'${'}camId}" class="txtlist">${'${'}camNm}</a>
	</div>
</li>

</script>

<script id="activeCampaignTableTemp" type="text/x-jquery-tmpl"><%--txtlist_subject class="txtlist_inner"--%>
<tr  id="${'${'}camId}">
	<th>${'${'}createBy}</th>
	<th>${'${'}camStartDd} ~ ${'${'}camEndDd}</th>
	<th class="txtlist" >${'${'}camNm}</th>
</tr>

</script>

<script id="campaignOfMonthTableTemp" type="text/x-jquery-tmpl"><%--txtlist_subject class="txtlist_inner"--%>
<tr  id="${'${'}camId}">
	<th>${'${'}createBy}</th>
	<th>${'${'}camStartDd} ~ ${'${'}camEndDd}</th>
	<th><a href="<ifvm:url name="campaignWorkFlow"/>?type=MKT&id=${'${'}camId}" class="txtlist">${'${'}camNm}</a></th>
</tr>

</script>

<script id="campaignPromTemp" type="text/x-jquery-tmpl">
<li>
	<div class="txtlist_inner" id="${'${'}promId}">
		<a href="<ifvm:url name="campaignWorkFlowLoy"/>?type=LOY&id=${'${'}promId}" class="txtlist_subject">${'${'}promNm}</a>
		<div class="txtlist_desc_info">
			<span class="txtlist_date">${'${'}createDate}</span>
		</div>
	</div>
</li>

</script>

<script id="campaignApprovalTemp" type="text/x-jquery-tmpl">
<li>
	<div class="txtlist_inner" id="${'${'}id}">
		<button id="${'${'}id}" class="txtlist_subject2 moreButton" onclick="loadPop(this)">${'${'}elecAprvTitle}</button>
		<div class="txtlist_desc_info">
			<span class="txtlist_date">${'${'}createDate}</span>
		</div>
	</div>
</li>

</script>

<script id="campaignApprovalReqTemp" type="text/x-jquery-tmpl">
<li>
	<div class="txtlist_inner" id="${'${'}id}">
		<button id="${'${'}id}" class="txtlist_subject2 moreButton" onclick="loadPop(this)">${'${'}elecAprvTitle}</button>
		<div class="txtlist_desc_info">
			{{if
elecAprvStatusCode == "010"}}
			<span class="txtlist">${'${'}createDate}</span>&nbsp;&nbsp;
			{{else}}
			<span class="txtlist">${'${'}lastApvDd}</span>&nbsp;&nbsp;
			{{/
if}}
			<span class="txtlist_date">${'${'}elecAprvStatusCd}</span>
		</div>
	</div>
</li>

</script>

<script id="campaignNoticeTemp" type="text/x-jquery-tmpl">
<li>
	<div class="txtlist_inner" id="${'${'}segId}">
		<button id="${'${'}rid}" class="txtlist_subject moreButton" onclick="showNotice(this)">${'${'}noticeNm}</button>
		<div class="txtlist_desc_info">
			<span class="txtlist_date">${'${'}modifyDate}</span>
		</div>
	</div>
</li>

</script>

<script id="approvalListTemp" type="text/x-jquery-tmpl">
<div class="homebox_btn_area">
	<div class="row">
		<div class="col-md-5 text-left"><h4 style="color : gray;"><button id="changeApr" class="moreButton" name="aprReqList"  onclick="changeApproval();">결재요청문서</button></h4></div>
		<div class="col-md-5 text-left"><h4>결재할문서</h4></div>
		<div class="col-md-2 text-right"><span><button id="goApprovalList" class="moreButton" onclick="goApprList(this);">More</button></span></div>
	</div>
</div>
<div id="homeMyApproval">
	<div id="homeApproval" class="cnt_type_list">
		<ul class="home_approval"></ul>				
	</div>						
	<div id="emptyHomeApproval" class="cnt_type_list">
		<p class="cnt_list_blank"><spring:message code="M01827"/></p>
	</div>
</div>

</script>

<script id="approvalReqListTemp" type="text/x-jquery-tmpl">
<div class="homebox_btn_area">
	<div class="row">
		<div class="col-md-5 text-left"><h4 style="color : gray;"><button id="changeApr" class="moreButton" name="aprList"  onclick="changeApproval();">결재할문서</button></h4></div>
		<div class="col-md-5 text-left"><h4>결재요청문서</h4></div>
		<div class="col-md-2 text-right"><span><button id="goApprovalReqList" class="moreButton" onclick="goApprList(this);">More</button></span></div>
	</div>
</div>
<div id="homeMyApprovalReq">
	<div id="homeApprovalReq" class="cnt_type_list">
		<ul class="home_approvalReq"></ul>				
	</div>						
	<div id="emptyHomeApprovalReq" class="cnt_type_list">
		<p class="cnt_list_blank"><spring:message code="M01827"/></p>
	</div>
</div>

</script>

<div class="page-title">
    <h1><spring:message code="M02507"/></h1>
</div>

<div class="home_wrap">
    <div class="dashboard_area">
        <div class="home-top">
            <ul class="top-area">
                <li class="home_box box_campaign_current">
                    <div class="homebox_btn_area">
                        <div class="row">
                            <div class="col-md-12"><h4>활성 회원 수</h4><br></div>
                            <div id="tcLastUpdateDate" class="lastUpdateDate">-</div>
                        </div>
                    </div>
                    <div class="cnt_campaign">
                        <div class="tb-cell">
                            <p class="data-area item01"></p>
                            <p class="item01 fontSize" style="font-family: 'NotoSans'; text-align: left;">
                                누적회원수 : <span class="count1"> 0 </span> 명<br>
                                전월 대비 증감률: <span class="count2"> 0% </span><br>
                                전년 대비 증감률: <span class="count3"> 0% </span>
                            </p>
                        </div>
                    </div>
                </li>
                <li class="home_box box_campaign_current">
                    <div class="homebox_btn_area">
                        <div class="row">
                            <div class="col-md-12"><h4>신규 회원 수</h4><br></div>
                            <div id="ncomLastUpdateDate" class="lastUpdateDate">-</div>
                        </div>
                    </div>
                    <div class="cnt_campaign">
                        <br>
                        <div class="tb-cell">
                            <p class="data-area item02"></p>
                            <p class="item02 fontSize"
                               style="text-align: left; width: 35%; display: inline-block; float: left;">
                                신규: <span class="cnt">0</span> 명<br>
                                휴면: <span class="cnt2">0</span> 명<br>
                                탈회: <span class="cnt3">0</span> 명
                                <%--(<span class="upper">+0명</span>,전월대비)--%>
                                <%--첫 구매고객 수 : <span class="cnt2">0</span> 명
                                (<span class="upper2">+0명</span>,전월대비)--%>
                            </p>

                            <p class="item02 fontSize" style="text-align: left; width: 65%; display: inline-block;">
                                로그인수: <span class="cnt4">0</span> 명<br>
                                전월(전년) 대비 증감률: <span class="cnt5"> 0% </span>(<span class="cnt6 upper2"> 0% </span>)
                            </p>
                            <br>
                        </div>

                    </div>
                </li>
                <li class="home_box box_campaign_current">
                    <div class="homebox_btn_area">
                        <div class="row">
                            <div class="col-md-12"><h4>마케팅 수신동의자수</h4><h4>(캠페인 발송 가능 회원수)</h4></div>
                            <div id="escLastUpdateDate" class="lastUpdateDate">-</div>
                        </div>
                    </div>
                    <div class="cnt_campaign">
                        <div class="tb-cell">
                            <p class="data-area item05"></p>
                            <p class="item05 fontSize" style="text-align: left;">
                                SMS : <span class="cnt">0</span> 명<br>
                                <%--(<span class="upper">+0명</span>,전일대비)--%>
                                App푸시 : <span class="cnt2">0</span> 명<br>
                                <%--(<span class="upper2">+0명</span>,전일대비)</p>--%>
                                이메일 : <span class="cnt3">0</span> 명
                        </div>
                    </div>
                </li>
                <%--			<li class="home_box box_campaign_current" id="pnt_div">--%>
                <%--				 <div class="homebox_btn_area">--%>
                <%--					<div class="row">--%>
                <%--						<div class="col-md-12"><h4>포인트 현황</h4></div>--%>
                <%--						<div id="pomLastUpdateDate"  class="lastUpdateDate">-</div>--%>
                <%--					</div>--%>
                <%--				</div>--%>
                <%--				<div class="cnt_campaign">--%>
                <%--					<div class="tb-cell">--%>
                <%--						<p class="data-area item06">--%>
                <%--						  <p class="item06">--%>
                <%--						  	&lt;%&ndash;누적 포인트 잔액 : <span class="pntValue" id="basePnt" >0</span><br>--%>
                <%--						     당월 적립 포인트 : <span class="pntValue" id="acrlMonth" >0</span><br>--%>
                <%--						     당월 사용 포인트 : <span class="pntValue" id="rdmPnt" >0</span><br>--%>
                <%--						     전일 적립 포인트 : <span class="pntValue" id="acrlBeforeDay" >0</span><br>--%>
                <%--						     전일 사용 포인트 : <span class="pntValue" id="usePntBeforeDay" >0</span><br>&ndash;%&gt;--%>
                <%--							전체가용포인트 : <span class="pntValue" id="basePnt">0</span>--%>
                <%--						</p>  --%>
                <%--					</div>--%>
                <%--				</div>--%>
                <%--			</li>--%>
                <li class="home_box box_campaign_current" id="cam_div">
                    <div class="homebox_btn_area">
                        <div class="row">
                            <div class="col-md-12"><h4>당월 캠페인 실행</h4><h4>(월별 누적)</h4></div>
                            <div id="rrfpomLastUpdateDate" class="lastUpdateDate">-</div>
                        </div>
                    </div>
                    <div class="cnt_campaign">
                        <div class="tb-cell">
                            <%--
                                  전체 :  진행(<span class="totProgCnt" >0</span>건) /  종료(<span class="totExtCnt" >0</span>건)<br>
                                  당월 :  진행(<span class="monthProgCnt" >0</span>건)  /  종료(<span class="monthExtCnt" >0</span>건)
                            --%>

                            <p class="data-area item07 fontSize" style="font-family: 'NotoSans'; text-align: left;">
                                캠페인 수: <span class="totCampaignCnt">0</span> 건<br>
                                타겟수/발송성공수: <span class="camTgtCnt">0</span>/<span class="sendSucesCnt">0</span><br>
                            </p><br>
                        </div>
                </li>
            </ul>
        </div>
        <div class="home_row dual"> <!-- 3개 들어갈땐 trp 로 클래스를 바꿔주시면 됩니다. -->
            <div class="home_box box_my_campaign" id="approval">
                <div class="homebox_btn_area">
                    <div class="row">
                        <%--<div class="col-md-5 text-left"><h4 style="color : gray;"><button id="changeApr" class="moreButton" name="aprReqList" onclick="changeApproval();">결재요청문서</button></h4></div>--%>
                        <div class="col-md-10 text-left"><h4 style="text-align: center;" id="changeApr">당월 실행 캠페인
                            목록</h4></div>
                        <%--<div class="col-md-5 text-left"><h4>결재할문서</h4></div>--%>
                        <%--<div class="col-md-2 text-right"><span><button id="goApprovalList" class="moreButton" onclick="goApprList(this);">More</button></span></div>--%>
                        <div class="col-md-2 text-right"><span><button id="goPromList" class="moreButton">More</button></span>
                        </div>
                    </div>
                </div>
                <div id="homeMyCampaign" class="">
                    <div id="homePromotion" class="cnt_type_list">
                        <%--<ul class="home_promotion"></ul>--%>
                        <table>
                            <%--<thead>
                            <tr>
                                <th>작성자</th>
                                <th>실행일</th>
                                <th>캠페인명</th>
                            </tr>
                            </thead>--%>
                            <tbody class="home_promotion">

                            </tbody>
                        </table>
                    </div>
                    <div id="emptyHomePromotion" class="cnt_type_list">
                        <p class="cnt_list_blank"><spring:message code="M01827"/></p>
                    </div>
                </div>
            </div>
            <div class="home_box box_my_campaign" class="">
                <div class="homebox_btn_area">
                    <div class="row">
                        <div class="col-md-10"><h4>당월 캠페인 진행 예정 목록</h4></div>
                        <div class="col-md-2 text-right"><span><button id="goPromList2" class="moreButton">More</button></span>
                        </div>
                    </div>
                </div>
                <div id="homeMyCampaign2" class="">
                    <div id="homePromotion2" class="cnt_type_list">
                        <%--<ul class="home_promotion2"></ul>--%>
                        <table>
                            <%--<thead>
                            <tr>
                                <th>작성자</th>
                                <th>실행일</th>
                                <th>캠페인명</th>
                            </tr>
                            </thead>--%>
                            <tbody class="home_promotion2">

                            </tbody>
                        </table>
                    </div>
                    <div id="emptyHomePromotion2" class="cnt_type_list">
                        <p class="cnt_list_blank"><spring:message code="M01827"/></p>
                    </div>
                </div>
            </div>
            <%--<div class="home_box box_my_campaign">--%>
            <%--	 <div class="homebox_btn_area">--%>
            <%--		<div class="row">--%>
            <%--		<div class="col-md-10"><h4>시스템 공지사항</h4></div>--%>
            <%--		<div class="col-md-2 text-right"><button id="goNoticeList" class="moreButton">More</button></div>--%>
            <%--		</div>--%>
            <%--	</div> 	--%>
            <%--	<div id="homeNotice" class="cnt_type_list">--%>
            <%--		<ul class="home_notice"></ul>--%>
            <%--	</div>					--%>
            <%--	<div id="emptyHomeNotice" class="cnt_type_list">--%>
            <%--		<p class="cnt_list_blank"><spring:message code="M01827" /></p>--%>
            <%--	</div>--%>
            <%--</div>--%>
        </div>

        <%--		<div class="home_box box_campaign_current">--%>
        <%--			 <div class="homebox_btn_area">--%>
        <%--				<div class="row">--%>
        <%--					<div class="col-md-12"><h4>가입자수 변동추이</h4></div>--%>
        <%--					<div id="vLastUpdateDate"  class="lastUpdateDate">-</div>--%>
        <%--				</div>--%>
        <%--			</div>--%>
        <%--			<div class="cnt_campaign_current ">--%>
        <%--				<div id="volatility" style="height:300px"></div>--%>
        <%--			</div>--%>
        <%--		</div>--%>


        <!-- 		<div  class="home_box box_response_rate"> -->
        <!-- 			 <div class="homebox_btn_area"> -->
        <!-- 				<div class="row"> -->
        <%-- 					<div class="col-md-12"><h4><spring:message code="M01823" /></h4></div> --%>
        <!-- 					<div id="prLastUpdateDate" class="lastUpdateDate">-</div> -->
        <!-- 				</div> -->
        <!-- 			</div> -->
        <!-- 			<div id="promotionResponse" class="pm-response"></div> -->
        <!-- 		</div> -->
        <!-- 	</div> -->


    </div>

    <div id="empRefPopupCon" class="popup_container"></div>
    <div id="popupContainer" class="popup_container"></div>

