<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags/marketing" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/x-jsrender" id="ynTemplate">
	{{if
promYn == 1 }}
		Y
	{{else}}
		N
	{{/
if}}

</script>

<script>
    var campaignResultGrid;			//조회결과 그리드 (캠페인 목록)
    var campaignChnlExecGrid;		//채널실행 그리드
    var campaignperReactionGrid;     //구매반응 정보 그리드
    var camId;						//캠페인ID
    var itemId;
    var chnlId;
    var dataType;

    //권한
    var empId = '';
    var authType = '';
    var brandCd = '';

    //검색
    var startDate;
    var endDate;

    /**
     * 화면 초기화
     */
    function initCampaignExecInfo() {

        camId = '';
        campaignResult();
    }

    /**
     * 캠페인 목록
     */
    function campaignResult() {

        var ejGridOption = {
            serializeGridData: function (data) {
                if ($.fn.ifvmIsNotEmpty(requestitem)) {
                    data.item = requestitem;
                }
                return data;
            },
            rowSelected: function (args) {
                var selectData = args.data;
                camId = selectData.id;
                dateSet(args.data.camStartDd);
                $.fn.ifvmSubmitSearchCondition("campaignChnlExecGrid", getCampaignChnlExecGrid);
                setTimeout(function () {
                    campaignChnlExecGrid.opt.gridControl.selectRows(0);
                }, 500)
            },
            loadComplete: function (args) {
                getCampaignChnlExecGrid();
                getCampaignperReactionGrid();

            },
            dataUrl: '<ifvm:action name="getCampaignListForExecResult"/>',
            columns: [
                {
                    field: 'dispNo',
                    headerText: '<spring:message code="M02291"/>',
                    headerTextAlign: 'center',
                    width: '110px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'T1.DISP_NO'
                    }/*번호 */
                },
                {
                    field: 'c2markName',
                    headerText: '<spring:message code="M00598"/>',
                    headerTextAlign: 'center',
                    width: '70px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'C2.MARK_NAME'
                    }/*유형*/
                }, {
                    field: 'camNm',
                    headerText: '<spring:message code="M00592"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Left,
                    customAttributes: {
                        index: 'T1.CAM_NM'
                    }/*캠페인명 */
                }, {
                    field: 'concatChnlType',
                    headerText: '<spring:message code="M00402"/>',
                    headerTextAlign: 'center',
                    width: '100px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        searchable: false, sortable: false
                    }/*발송채널 */
                }, {
                    field: 'recentSendDt',
                    headerText: '<spring:message code="M03095"/>',
                    headerTextAlign: 'center',
                    width: '150px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        searchable: false, sortable: false
                    }/*최근 발송일시 */
                }
                <%--{--%>
                <%--    field: 'camStartDd',--%>
                <%--    headerText: '<spring:message code="M00593"/>',--%>
                <%--    headerTextAlign: 'center',--%>
                <%--    width: '80px',--%>
                <%--    textAlign: ej.TextAlign.Center,--%>
                <%--    customAttributes: {--%>
                <%--        index: 'T1.CAM_START_DD'--%>
                <%--    }/*시작일 */--%>
                <%--}, {--%>
                <%--    field: 'camEndDd',--%>
                <%--    headerText: '<spring:message code="M00594"/>',--%>
                <%--    headerTextAlign: 'center',--%>
                <%--    width: '80px',--%>
                <%--    textAlign: ej.TextAlign.Center,--%>
                <%--    customAttributes: {--%>
                <%--        index: 'T1.CAM_END_DD'--%>
                <%--    }/*종료일 */--%>
                <%--}--%>
                , {
                    field: 'c1markName',
                    headerText: '<spring:message code="M00595"/>',
                    headerTextAlign: 'center',
                    width: '50px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'C1.MARK_NAME'
                    }/*상태 */
                }, {
                    field: 'campaignApprovalStatusCodeName',
                    headerText: '<spring:message code="M03042"/>',
                    headerTextAlign: 'center',
                    width: '80px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c3.MARK_NAME'
                    } /*결재상태*/
                },
                {
                    field: 'planOrgCodeName',
                    headerText: '소속',
                    headerTextAlign: 'center',
                    width: '90px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'd1.div_nm'
                    } /*조직*/
                },
                {
                    field: 'name',
                    headerText: '<spring:message code="M03096"/>',
                    headerTextAlign: 'center',
                    width: '110px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'E1.NAME'
                    } /*요청자*/
                },
                /*{
                    field : 'createDate', headerText : '<spring:message code="M01132"/>', headerTextAlign : 'center', width : '120px', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'T1.CREATE_DATE' }/!*등록일 *!/
	      	  },*/
                {
                    field: 'id', headerText: 'id', visible: false,
                    customAttributes: {
                        index: 'T1.ID'
                    }/* */
                },
                {
                    field: 'exeDt', headerText: 'exeDt', visible: false,
                    customAttributes: {
                        index: 'eii.EXE_DT'
                    }/* */
                }
            ],
            requestGridData: {
                empId: empId,
                authType: authType,
                brandCd: brandCd,
                sidx: 'T1.CREATE_DATE',
                sord: 'desc'
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: 'ifvGridSimplePageTemplete'

        };

        campaignResultGrid = $("#campaignResultGrid").ifvsfGrid({ejGridOption: ejGridOption});

        dateSet();

        setTimeout(function () {
            campaignResultGrid.opt.gridControl.selectRows(0);
        }, 400)
    }

    /**
     * 채널 실행 정보 조회
     */
    function getCampaignChnlExecGrid() {

        $('#chnlExecGridArea').show();

        var ejGridOption = {
            serializeGridData: function (data) {
                data.camId = camId;
                return data;
            },
            rowSelected: function (args) {
                dateSet(args.data.exeDt);
                itemId = args.data.t1Id;
                chnlId = args.data.t2Id;
                dataType = args.data.chnlTypeCd;
                $.fn.ifvmSubmitSearchCondition("campaignperReactionGrid", getCampaignperReactionGrid);
            },
            showStackedHeader: true,
            stackedHeaderRows: [{
                stackedHeaderColumns:
                    [
                        {
                            headerText: " ",
                            textAlign: 'center',
                            column: "exeSeq, exeDt, c1markName, c2markName, exeTgtAmt, camTgtCnt"
                        },
                        {headerText: "실발송수", textAlign: 'center', column: "sendSucesCnt,sendFailCnt, resultWait,chnlSendCnt"},
                        {headerText: "제외수", textAlign: 'center', column: "ctrlGroupCnt, exceptRmvCnt"},
                        {headerText: " ", textAlign: 'center', column: "readSucesCnt, perReadSuces"}
                    ]
            }],
            dataUrl: '<ifvm:action name="getCampaignListForExecResultOfList"/>',
            columns: [
                {
                    field: 'exeSeq',
                    headerText: '<spring:message code="M00889"/>',
                    headerTextAlign: 'center',
                    width: '50px',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'exeSeq'
                    }/*차수 */
                }, {
                    field: 'exeDt',
                    headerText: '<spring:message code="M01359"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'exeDt'
                    }/*실행일시 */
                }, {
                    field: 'c1markName',
                    headerText: '<spring:message code="M01275"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c1markName'
                    }/*유형 */
                }, {
                    field: 'c2markName',
                    headerText: '<spring:message code="M01307"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: 'c2markName'
                    }/*상태 */
                },/*{
	      		  field : 'c3markName', headerText : '<spring:message code="M02988"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center,
	      		  customAttributes : {
	      			  index : 'c3markName' }/!*상태(상세) *!/
	      	  },*/{
                    field: 'camTgtCnt',
                    headerText: '<spring:message code="M00860"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'camTgtCnt'
                    }/*대상자수 */
                },
                {
                    field: 'chnlSendCnt',
                    headerText: '<spring:message code="M03097"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'chnlSendCnt'
                    } /*실발송수*/
                },
                {
                    field: 'sendSucesCnt',
                    headerText: '<spring:message code="L02028"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'sendSucesCnt'
                    }/*발송성공수 */
                }, {
                    field: 'sendFailCnt',
                    headerText: '<spring:message code="L02030"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'sendFailCnt'
                    }/*발송실패수 */
                }, {
                    field: 'resultWait',
                    headerText: '결과 대기',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'resultWait'
                    }/*결과 대기 */
                }, {
                    field: 'ctrlGroupCnt',
                    headerText: '대조군',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'ctrlGroupCnt'
                    }/*대조군 */
                }, {
                    field: 'exceptRmvCnt',
                    headerText: '<spring:message code="M03038"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: ''
                    }/*기타 */
                }/*,{
	      		  field : 'chnlSendCnt', headerText : '<spring:message code="M02989"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'chnlSendCnt' }/!*채널 전송수*!/
	      	  },{
	      		  field : 'prmsChkRmvCnt', headerText : '<spring:message code="M02801"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'prmsChkRmvCnt' }/!*퍼미션 제외건수 *!/
	      	  }
 	      	  ,{
 	      		  field : 'fatiChkRmv', headerText : '<spring:message code="M02802"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
 	      		  customAttributes : {
 	      			  index : 'fatiChkRmv' }/!*피로도 제외건수 *!/
	      	  }
	      	  ,{
	      		  field : 'exceptRmvCnt', headerText : '<spring:message code="M02991"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'exceptRmvCnt' }/!*기타 제외수 *!/
	      	  }
            ,{
	      		  field : 'revSucesCnt', headerText : '<spring:message code="M02918"/>', headerTextAlign : 'center', textAlign : ej.TextAlign.Center, format : '{0:n0}',
	      		  customAttributes : {
	      			  index : 'revSucesCnt' }/!*수신성공수 *!/
	      	  }*/, {
                    field: 'readSucesCnt',
                    headerText: '<spring:message code="M03037"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',
                    customAttributes: {
                        index: 'readSucesCnt'
                    }/*읽음(오픈)성공수 */
                }, {
                    field: 'perReadSuces',
                    headerText: '<spring:message code="M03039"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    customAttributes: {
                        index: ''
                    }/*오픈율 */
                },{
                    field: 'chnlTypeCd', headerText: 'chnlTypeCd', visible: false,
                    customAttributes: {
                        index: 'T2.CHNL_TYPE_CD'
                    }/* */
                },
                {
                    field: 't1Id', headerText: 'itemId', visible: false,
                    customAttributes: {
                        index: 'T1.ID'
                    }/* */
                },
                {
                    field: 't2Id', headerText: 'chnlId', visible: false,
                    customAttributes: {
                        index: 'T2.ID'
                    }/* */
                }
            ],
            requestGridData: {
                sidx: 'exeSeq desc, exeDt',
                sord: 'desc',
            },
            rowList: [10, 25, 50, 100],
            radio: true,
            tempId: 'ifvGridSimplePageTemplete',
        };
        campaignChnlExecGrid = $("#campaignChnlExecGrid").ifvsfGrid({ejGridOption: ejGridOption});
    }

    //공통 조회 조건 목록 설정
    function searchCondInit(gridId) {
        $.fn.ifvmSetCommonCondList("commSearchList", "STNCAM002", gridId);
    }

    // 공통 조회 호출
    function camExecSerach() {
        $.fn.ifvmSubmitSearchCondition("commSearchList", function () {
            campaignResultGrid.searchGrid({
                item: requestitem
            });
        });

        setTimeout(function () {
            campaignResultGrid.opt.gridControl.selectRows(0);
        }, 100)
    }


    //숫자 콤마표시
    function numberFormat(cellvalue) {
        var value = "";
        if ($.fn.ifvmIsNotEmpty(cellvalue)) {
            value = $.fn.ifvmNumberWithCommas(cellvalue);
        }
        return value;
    }

    function chkFlag(cellValue) {
        if (cellValue == '1') return 'Y';
        else return 'N';
    }


    function commonDtlPopup() {
        if (campaignChnlExecGrid.opt.gridControl.getSelectedRecords().length > 0) {
            if(campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0].c1markName !='' && campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0].c1markName != null) {
                var itemId = campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0].t1Id;
                var chnlId = campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0].t2Id;
                var dataType = campaignChnlExecGrid.opt.gridControl.getSelectedRecords()[0].chnlTypeCd;
                $("#channelUnsentPopup").ifvsfPopup({
                    enableModal: true,
                    enableResize: false,
                    contentUrl: '<ifvm:url name="execStatusChannelUnsentPop"/>',
                    contentType: "ajax",
                    title: '<spring:message code="M01217" />',
                    width: 1000,
                    maxWidth: 2000,
                    close: 'channelUnsentPopClose',
                    beforeOpen: function (args) {
                        initCampaignExecInfo(itemId, chnlId, dataType);
                    }
                });
            } else {
                alert('작업 진행 이전에는 대상자 반응을 조회 할 수 없습니다.');
            }
        } else {
            alert('<spring:message code="M00004" />');
        }
    }

    function channelUnsentPopClose() {
        channelUnsentPopup._destroy();
    }

    //그리드 -> 엑셀 다운로드
    function setcamStatusExcelExport() {
        if (campaignChnlExecGrid.opt.gridControl.model.dataSource.length != 0) {
            $.ifvExcelDn('<ifvm:action name="downCampaignListStatus"/>', 'campaignChnlExecGrid');
        } else {
            alert('<spring:message code="M00004" />');
        }
    }

    function campaignAuth() {
        $.ifvSyncPostJSON('<ifvm:action name="selectCampaignAuth"/>', {}, function (result) {
            empId = result.rows[0].empId;
            authType = result.rows[0].authType;
            brandCd = result.rows[0].brandCd;
        });
    }


    //구매반응 정보 조회
    function getCampaignperReactionGrid() {

        $('#perReactionGridArea').show();

        var ejGridOption = {
            serializeGridData: function (data) {
                data.camId = camId;
                return data;
            },
            allowResizing : false,
            dataUrl: '<ifvm:action name="selectPurReaction"/>',
            columns: [
                {/*대상자유형 */
                    field: 'tgtCatgory',
                    headerText: '유형',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,customAttributes :{sortable :  false }
                }, {/*대상자 수 */
                    field: 'tgtCnt',
                    headerText: '<spring:message code="M00860"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }, {/*구매자 수 */
                    field: 'purCustCnt',
                    headerText: '<spring:message code="M03074"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }, {/*구매율 */
                    field: 'purPer',
                    headerText: '<spring:message code="M03041"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }, {/*구매건수 */
                    field: 'purCnt',
                    headerText: '<spring:message code="M03075"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }, {/*구매금액 */
                    field: 'purAmt',
                    headerText: '<spring:message code="L00967"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }, {/*주문단가 */
                    field: 'ordAmt',
                    headerText: '<spring:message code="M03076"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }, {/*객단가 */
                    field: 'custTrans',
                    headerText: '<spring:message code="M03077"/>',
                    headerTextAlign: 'center',
                    textAlign: ej.TextAlign.Center,
                    format: '{0:n0}',customAttributes :{sortable :  false }
                }
            ],
            requestGridData: {
                startDate: $('#vaildStartDt').val() + " 00:00:00",
                endDate: $('#vaildEndDt').val() + " 23:59:59",
                itemId: itemId,
                chnlId: chnlId,
                dataType: dataType,
                sidx: 'exeSeq desc, exeDt',
                sord: 'desc',
            },
            rowList: [10, 25, 50, 100],
            tempId: 'ifvGridSimpleTemplete',
        };
        campaignperReactionGrid = $("#campaignperReactionGrid").ifvsfGrid({ejGridOption: ejGridOption});

    }

    function dateSet(startDate) {
        var vaildStartDt = $("#vaildStartDt");
        var vaildEndDt = $("#vaildEndDt");

        if($.fn.ifvmIsNotEmpty(startDate)){
            vaildStartDt.val(startDate);
        } else {
            vaildStartDt.val($.ifvGetNewDate('m', -1).newDateS);
        }
        vaildEndDt.val($.ifvGetTodayDate());
        vaildStartDt.ifvDateChecker({});
        vaildEndDt.ifvDateChecker({});

    }


    $(document).ready(function () {
        //권한 불러오기
        campaignAuth()

        //공통 조회 조건 목록 설정
        searchCondInit();

        //화면 초기화
        initCampaignExecInfo();

        //캠페인 목록 그리드 선택
        $('#campaignResultGrid .page').on('click', function () {
            setTimeout(function () {
                campaignResultGrid.opt.gridControl.selectRows(0);
            }, 500)
        });

        //조회
        $('#campaignListSearchBtn').on('click', function () {
            camExecSerach();
//       $.fn.ifvmSubmitSearchCondition("campaignViewList", campaignResult);
        });

        // 초기화
        $("#campaignListSearchInitBtn").on('click', function () {
            searchCondInit('campaignResultGrid');
//         $.fn.ifvmSetCommonCondList("campaignViewList", "STNCAM002");
        });

        $("#commonDtlBtn").on('click', function () {
            commonDtlPopup();
        });


        //조회
        $('#searchBtn').on('click', function () {
            getCampaignChnlExecGrid();
        });

        //그리드 -> 엑셀 다운로드
        $('#camStatusExcelExportBtn').on('click', function () {
            setcamStatusExcelExport();
        });

        //구매반응정보 검색
        $('#perReactionSearch').on('click', function () {
            getCampaignperReactionGrid();
        });

        //getCampaignperReactionGrid();

    });
</script>

<div class="page-title">
    <h1>
        <spring:message code="O00196"/>
        &gt; <spring:message code="M00273"/>
    </h1>
</div>

<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="L01838"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="campaignListSearchBtn" objCode="campaignExecListSearchBtn_OBJ">
                <i class="fa fa-search"></i>
                <spring:message code="M00135"/>
            </button>
            <%-- <button class="btn btn-sm" id="campaignListSearchInitBtn" objCode="campaignExecListSearchInitBtn_OBJ">
                <spring:message code="L00082"/>
            </button> --%>
        </div>
    </div>
    <div class="well form-horizontal well_bt5" id="commSearchList">
    </div>
</div>

<!-- 캠페인 목록 -->
<div>
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M00967"/></span>
        </div>
    </div>
    <div id="campaignResultGrid" class="white_bg grid_bd0"></div>
</div>

<!-- 채널 실행 정보 -->
<div id="chnlExecGridArea">
    <div class="page_btn_area" id=''>
        <div class="col-xs-7">
            <span><spring:message code="M02805"/></span>
        </div>
        <div class="col-xs-5 searchbtn_r">
            <button class="btn btn-sm" id="searchBtn" objCode="camStatusSearchBtn_OBJ"><i class="fa fa-search"></i>
                <spring:message code="M00135"/>
            </button>
            <%--<button class="btn btn-sm" id="camStatusExcelExportBtn" objCode="camStatusExcelExportBtn_OBJ">
                <spring:message code="M00838"/>&lt;%&ndash; 다운로드 &ndash;%&gt;
            </button>--%>
            <%-- 대상자 반응 조회 --%>
            <button class="btn btn-sm" id="commonDtlBtn" objCode="commonDtlBtn_OBJ">
                <spring:message code="M01424"/>
            </button>
        </div>
    </div>
    <div id="campaignChnlExecGrid" class="white_bg grid_bd0 grid_scroll5"></div>
</div>

<!-- 구매반응 정보 -->
<div id="perReactionGridArea">
    <div class="page_btn_area">
        <div class="col-xs-7">
            <span><spring:message code="M03071"/></span>
        </div>
    </div>
    <br>
    <div class="row qt_border">
        <div>
            <div class="col-xs-4 control_content">
            <ifvm:inputNew type="dateTerm" startDto="vaildStartDt" endDto="vaildEndDt" startId="vaildStartDt"
                           endId="vaildEndDt" conClass="8" label="M00607" labelClass="1"/>
                <button class="btn btn-sm btn_gray" id='perReactionSearch' objCode="perReactionSearch_OBJ"><i class="fa fa-search"></i><spring:message code="M00135"/></button>
            </div>

        </div>
    </div>
    <div class="row qt_border">
        <div id="campaignperReactionGrid" class="white_bg grid_bd0 grid_scroll5"></div>
    </div>
</div>

<div id="channelUnsentPopup" class="popup_container"></div>
