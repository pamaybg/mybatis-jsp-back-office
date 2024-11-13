<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%!
    public String cleanXss(String str) {

        if (str != null) {
            str = str.replaceAll("<", "&lt;");
            str = str.replaceAll(">", "&gt;");
        }
        return str;
    }
%>
<!-- 회원번호 값에 걸 링크로 사용할 템플릿 -->
<script type="text/x-jsrender" id="mbrNoTemplate">
	<span style="color:#1266FF; text-decoration:underline;">{{:
mbrNo}}</span>

</script>

<script type="text/x-jsrender" id="custtypeTemplate">
{{:
custTypeCdNm}}/{{:
mbrTypeCdNm}}

</script>


<script type="text/javascript">
    var ridCheck = '<%= cleanXss(request.getParameter("rid")) %>';
    ridCheck = ridCheck === 'null' ? null : ridCheck;
    var noCheck = '<%= cleanXss(request.getParameter("mbr_no")) %>';
    noCheck = noCheck === 'null' ? null : noCheck;

    var mbrListGrid = null;
    var newCustNo = null;

    //권한
    var empId;
    var empType;
    var authType;
    var brandCd;

    //고객 목록
    function getMbrtList() {

        var ejGridOption = {
            loadComplete: function (obj) {
                //로그 저장 -> 회원상세로 들어갈때만 로그저장 하게 바꿈
                //$.fn.ifvmComCondLogging("LOY_MBR_NEW_LIST", mbrListGrid.opt.data.records);
            },
            serializeGridData: function (data) {
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                return data;
            },
            recordDoubleClick: function (args) {
                var rid = args.data.rid;
                var custTypeCd = args.data.custTypeCd;
                goMbrDetail(rid, custTypeCd);
            },
            recordClick: function (args) {
                if (args.columnName == '회원번호') {
                    var rid = args.data.rid;
                    var custTypeCd = args.data.custTypeCd;
                    goMbrDetail(rid, custTypeCd);
                }
            },
            showStackedHeader: true,
            stackedHeaderRows: [{
                stackedHeaderColumns:
                    [
                        {
                            headerText: "브랜드별 등급",
                            textAlign: 'center',
                            column: "tierDSTNm,tierLCSNm,tierUMBNm,tierDSGNm,tierLCGNm,tierMSWNm"
                        }
                    ]
            }],
            dataUrl: '<ifvm:action name="getMbrListNewPage"/>',
            columns: [
                {
                    field: 'mbrNo', headerText: '회원번호', headerTextAlign: 'center', textAlign: 'left', customAttributes: {index: 'lmm.MBR_NO'}, width: 120, template: '#mbrNoTemplate'
                }, {
                    field: 'custTypeCdNm', headerText: '회원유형', headerTextAlign: 'center', textAlign: 'center', customAttributes: {index: 'lc.CUST_TYPE_CD'}, width: 70,
                }
                // ,
                // {
                //     field : 'mbrTypeCdNm', headerText : '상세유형',headerTextAlign : 'center', textAlign : 'center',customAttributes : {index : 'lmm.MBR_TYPE_CD'},width: 130
                // }
                , {
                    field: 'custNm', headerText: '회원명', headerTextAlign: 'center', textAlign: 'center', customAttributes: {index: 'lc.CUST_NM'}, width: 100,
                }, {
                    field: 'hhp', headerText: '휴대전화번호', headerTextAlign: 'center', textAlign: 'left', customAttributes: {index: 'lc.HHP'}, width: 100,
                }, {
                    field: 'maskEmail', headerText: '이메일', headerTextAlign: 'center', textAlign: 'left', customAttributes: {index: 'lc.EMAIL'}, width: 150,
                }, {
                    field: 'genCdNm', headerText: '성별', headerTextAlign: 'center', textAlign: 'center', customAttributes: {index: 'lc.GEN_CD'}, width: 50,
                }, {
                    field: 'birthDate', headerText: '나이', headerTextAlign: 'center', textAlign: 'center', width: 40,
                },{
                    field: 'userId', headerText: '웹아이디', headerTextAlign: 'center', textAlign: 'left', customAttributes: {index: 'lcli.USER_ID'}, width: 120,
                }, {
                    field: 'sbscTypeCdNm', headerText: '가입유형', headerTextAlign: 'center', textAlign: 'center', customAttributes: {index: 'lmm.SBSC_TYPE_CD'}, width: 70,
                }, {
                    field: 'tierDSTNm', headerText: 'DST', headerTextAlign: 'center', textAlign: 'center', width: 60, customAttributes:{index : 'a.tierDST'}
                }, {
                    field: 'tierLCSNm', headerText: 'LCS', headerTextAlign: 'center', textAlign: 'center', width: 80, customAttributes:{index : 'a.tierLCS'}
                }, {
                    field: 'tierUMBNm', headerText: 'UMB', headerTextAlign: 'center', textAlign: 'center', width: 60, customAttributes:{index : 'a.tierUMB'}
                }, {
                    field: 'tierDSGNm', headerText: 'DSG', headerTextAlign: 'center', textAlign: 'center', width: 60, customAttributes:{index : 'a.tierDSG'}
                }, {
                    field: 'tierLCGNm', headerText: 'LCG', headerTextAlign: 'center', textAlign: 'center', width: 60, customAttributes:{index : 'a.tierLCG'}
                }, {
                    field: 'tierMSWNm', headerText: 'MSW', headerTextAlign: 'center', textAlign: 'center', width: 60, customAttributes:{index : 'a.tierMSW'}
                },
                /*{
                    field: 'proGolfYn', headerText: '프로골퍼', headerTextAlign: 'center', textAlign: 'center', width: '5%',
                }, {
                    field: 'drcYn', headerText: 'DRC', headerTextAlign: 'center', textAlign: 'center', width: '3%',
                },*/ {
                    field: 'mbrStatCdNm', headerText: '상태', headerTextAlign: 'center', textAlign: 'center', customAttributes: {index: 'lmm.MBR_STAT_CD'}, width: 50,
                }, {
                    field: 'sbscDate', headerText: '가입일자', headerTextAlign: 'center', textAlign: 'center', customAttributes: {index: 'sbscDate'}, width: 90,
                }, {
                    field: 'sbscChnlNm', headerText: '가입채널', headerTextAlign: 'center', textAlign: 'left', customAttributes: {index: 'lcc.CHNL_NM'}, width: 180,
                },
                // {
                //     field : 'livingFriends', headerText : '리빙',headerTextAlign : 'center', textAlign : 'center' ,customAttributes : {index : 'lmma.livingFriends'},width: 40
                // },
                // {
                //     field : 'greenMate', headerText : '그린',headerTextAlign : 'center', textAlign : 'center' ,customAttributes : {index : 'lmma.opinionLeader'},width: 40
                // },
                // {
                //     field : 'opinionLeader', headerText : '오피니언',headerTextAlign : 'center', textAlign : 'center' ,customAttributes : {index : 'lmma.greenMate'},width: 50
                // },
                // {
                //     field : 'robinsonCustomer', headerText : '주요고객',headerTextAlign : 'center', textAlign : 'center' ,customAttributes : {index : 'lmma.robinsonCustomer'},width: 50
                // },
                {
                    field: 'rid', headerText: 'rid', headerTextAlign: '', visible: false,
                }

            ],
            requestGridData: {
                empId: empId,
                empType: empType,
                authType: authType,
                brandCd: brandCd,
                sidx: '16',
                sord: 'desc'
            },
            rowList: [10, 25, 50, 100],
            gridDataInit: false,
            radio: true,
            isHorizontalScroll: true,
            allowResizing: true,
            tempId: 'ifvGridSimplePageTemplete2'
        };

        mbrListGrid = $("#mbrListGrid").ifvsfGrid({ejGridOption: ejGridOption});
    }

    //고객 상세 이동
    function goMbrDetail(rid, custTypeCd) {
        if (custTypeCd == 'C') {
            $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true);
            //개인정보 조회 이력남기기(법인)
            qtjs.href('<ifvm:url name="corpMbrDetailNewPage"/>' + '?rid=' + rid);
        } else if (custTypeCd == 'I' || custTypeCd == 'E' || custTypeCd == 'D' || custTypeCd == 'O' || custTypeCd == 'X') {
            $.fn.ifvmPersonalCondLogPageId("LOY_MBR_NEW_LIST", true);
            //개인정보 조회 이력남기기(개인/임직원)
            qtjs.href('<ifvm:url name="mbrDetailNewPage"/>' + '?rid=' + rid);
        }
    }

    //공통 조회 조건 목록 설정
    function searchCondInit(gridId) {

        $.fn.ifvmSetCommonCondList("commSearchList", "LOY_MBR_NEW_LIST", gridId);
    }

    //공통 조회 호출
    function mbrListSearch() {
        $.fn.ifvmSubmitSearchCondition("commSearchList", function (bool) {
            bool ? alert('최소 1개의 조회조건을 입력해주세요.') : mbrListGrid.searchGrid({item: requestitem});
        });
    }

    //마스크해제
    function clearMaskAction() {
        var v_rid;
        if ($.fn.ifvmIsNotEmpty(mbrListGrid.opt.gridControl.getSelectedRecords()[0])) {
            v_rid = mbrListGrid.opt.gridControl.getSelectedRecords()[0].rid;
        } else {
            alert('<spring:message code="M02219"/>');
        }

        if ($.fn.ifvmIsNotEmpty(v_rid)) {
            $.ifvSyncPostJSON('<ifvm:action name="clearMaskListMbr"/>', {
                    rid: v_rid
                },
                function (result) {
                    var gridObj = mbrListGrid.opt.gridControl;
                    var selectedIdx = gridObj.getIndexByRow(gridObj.getSelectedRows());
                    gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('custNm'), result.unMaskCustNm);
                    gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('hhp'), result.unMaskHhp);
                    gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('userId'), result.unMaskEmail);
                    gridObj.setCellText(selectedIdx, gridObj.getColumnIndexByField('maskEmail'), result.unMaskEmailAddr);
                });
        }
    }


    function addNewCustomer() {
        $("#addNewCumstContainer").ifvsfPopup({
            enableModal: true,
            enableResize: false,
            contentUrl: '<ifvm:url name="newCustAddPop"/>',
            contentType: "ajax",
            title: '<spring:message code="L02589"/>',
            width: 1000,
            close: 'newCustPopClose',
            open: function () {
                new ifvm.PopupCenter({
                    popupDivId: 'popupContainer'
                });
            }
        });
    }

    function newCustPopClose() {
        addNewCumstContainer._destroy();
    }

    //권한 불러오기(매장 사용자 거르기 위한 용도)
    function getAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            authType = result.rows[0].authType;
            brandCd = result.rows[0].brandCd;
            empType = result.rows[0].empType;
        });
    }


    $(document).ready(function () {
        getAuth();
        //공통 조회 조건 목록 설정2
        searchCondInit();

        getMbrtList();

        //조회
        $('#searchCondBtn').on('click', function () {
            mbrListSearch();
        });

        //초기화
        $("#searchCondInitBtn").on('click', function () {
            searchCondInit("mbrListGrid");
        });

        //마스킹해제 클릭시
        $('#clearMaskBtn').on('click', function () {
            clearMaskAction();
        });

        //회원가입
        $('#addNewMemBtn').on('click', function () {
            addNewCustomer();
        });

        /*  $('#testMail').on('click', function(){
             if(confirm("메일을 보내시겠습니까?")){
                  $.ifvSyncPostJSON('
        <ifvm:action name="testMail"/>', {},function(result){
    			 if(result.message) alert(result.message);
    			 else alert("성공");
    		 },function(result){
    			 if(result.message) alert(result.message);
    			 else alert("실패");
    		 });
    	}
    }); */

        //엑셀다운로드
        $("#excelDownMem").on('click', function () {
            if ($.fn.ifvmIsNotEmpty(mbrListGrid.opt.gridControl.model.dataSource)) {
                $.ifvExcelDn('<ifvm:action name="getMbrListNewPageExcelDown"/>', 'mbrListGrid');
            } else {
                alert("다운로드 할 대상을 조회 해주세요.")
            }
        });

    });

</script>

<div id="pop_main_div_offer">

    <div class="page-title">
        <h1>
            <spring:message code="M01749"/>
            &gt; <spring:message code="L00081"/>
        </h1>
    </div>

    <div>
        <div class="page_btn_area">
            <div class="col-xs-7">
                <span><spring:message code="L01838"/></span>
            </div>
            <div class="col-xs-5 searchbtn_r">
                <button class="btn btn-sm" id="searchCondBtn" objCode="mbrListsearchCondBtn_OBJ"><i
                        class="fa fa-search"></i>
                    <spring:message code="L00081"/>
                </button>
                <button class="btn btn-sm" id="searchCondInitBtn" objCode="mbrListsearchCondInitBtn_OBJ">
                    <spring:message code="L00082"/>
                </button>
            </div>
        </div>
        <div class="well form-horizontal well_bt5" id="commSearchList">
        </div>
    </div>
    <!-- 조회결과 -->
    <div>
        <div class="page_btn_area" id=''>
            <div class="col-xs-7">
                <span><spring:message code="M00277"/></span>
            </div>
            <div class="col-xs-5 searchbtn_r">
                <%-- <ifvm:inputNew type="button" id="testMail" text="testMail" /> --%>
                <!-- 회원가입 -->
                <%--         	<ifvm:inputNew type="button" id="addNewMemBtn" text="L02589" objCode="mbrListJoin_OBJ"/> --%>
                <!-- 엑셀 다운로드 -->
                <ifvm:inputNew type="button" id="excelDownMem" text="다운로드" objCode="mbrListNewPageExcelDown_OBJ"/>
                <!-- 마스킹해제 -->
                <ifvm:inputNew type="button" id="clearMaskBtn" text="L00326" objCode="mbrListClearMask_OBJ"/>
            </div>
        </div>
        <div id="mbrListGrid" class="white_bg grid_bd0"></div>
    </div>
    <div id="certiPopup" class="popup_container"></div>
</div>

<!-- 회원가입 팝업 -->
<div id=addNewCumstContainer class="popup_container"></div>