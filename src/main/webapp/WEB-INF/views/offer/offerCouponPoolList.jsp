<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var ofrCpnPoolGrid = null;
	var OfferCpnPoolList = function () {
	    // 프로그램 RID
	    var _rid = null;
	    this.setRid = function (rid) {
	    	ifvGlobal["offerCpnMbrRid"] = rid;
	        _rid = rid;
	    }, this.getRid = function () {
	        return _rid;
	    },
        this.offerCpnPoolGridOptions = null,
        /* 프로그램 목록 */
        this.setGridAndDataLoad = function (url) {

            var _serializeGridData = function (data) {
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
            };
            var _recordDoubleClick = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
            };
            var ejGridOption = {
                serializeGridData: _serializeGridData,
                rowSelected: _rowSelected.bind(this),
                recordDoubleClick: _recordDoubleClick.bind(this),
                dataUrl: '<ifvm:action name="getOfferCouponPoolList"/>',
                columns: [ // '유형', '쿠폰번호', '검색번호',  '발급여부', '발급일자', '등록일자'
                    {
                        field: 'issueTypeCdNm',
                        headerText: '<spring:message code="O00051"/>',
                        width: '80px',
                        textAlign: 'center',
                        customAttributes: {
                            index: 'issueTypeCd'
                        }
                    }, {
                        field: 'cpnNo',
                        headerText: '<spring:message code="O00093"/>',
                        width: '150px',
                        textAlign: 'center',
                        customAttributes: {
                            searchable: true
                        }
                    }, {
                        field: 'searchNo',
                        headerText: '<spring:message code="O00120"/>',
                        width: '100px',
                        textAlign: 'center',
                       	customAttributes: {
                               searchable: true
                        }
                    }, {
                        field: 'issueApplyFlagNm',
                        headerText: '<spring:message code="O00119"/>',
                        width: '80px',
                        textAlign: 'center',
                        customAttributes: {
                        	index: 'issueApplyFlag',
                            searchable: true
                        }
                    }, {
                        field: 'issueApplyDate',
                        headerText: '<spring:message code="O00094"/>',
                        width: '100px',
                        textAlign: 'center'
                    }, {
                        field: 'createDate',
                        headerText: '<spring:message code="O00116"/>',
                        width: '100px',
                        textAlign: 'center'
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false
                    }, {
                        field: 'ridOfr',
                        headerText: 'ridOfr',
                        visible: false
                    }, {
                        field: 'ridCpnM',
                        headerText: 'ridCpnM',
                        visible: false
                    }, {
                        field: 'ridMbr',
                        headerText: 'ridMbr',
                        visible: false
                    }],
                requestGridData: {
                    sidx: 'cpnNo',
                },
                radio: true,
                gridDataInit: false
            };
            ofrCpnPoolGrid = $("#ofrCpnPoolGrid").ifvsfGrid({ ejGridOption : ejGridOption });
        },
        /* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', null,
                '<ifvm:url name="offerCpnPoolListCondPopup"/>',
                '<spring:message code="O00099"/>', 860);
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            // 조회
            $('#searchCondBtn').on('click', function () {

                //var _offerCpnPoolGridOptions = this.offerCpnPoolGridOptions;
                var _offerCpnPoolGridOptions = ofrCpnPoolGrid;
                $.fn.ifvmSubmitSearchCondition("offerCpnPoolSearchList", function () {
                    _offerCpnPoolGridOptions.searchGrid({ item: requestitem });
                });

            }.bind(this));
            //초기화
            $('#searchCondInitBtn').on('click', function () {
            	$.fn.ifvmSetCommonCondList("offerCpnPoolSearchList", "OFFER_COUPON_POOL_LIST", "offerCpnPoolList");
            }.bind(this));
        },
        
        /* 공통 조회 조건 목록 설정 */
        this.initSearchCondition = function () {
            $.fn.ifvmSetCommonCondList("offerCpnPoolSearchList", "OFFER_COUPON_POOL_LIST", "offerCpnPoolList");
        },
        
        /* 페이지 초기화 */
        this.init = function () {
            // 공통 조회 조건 목록 설정
            this.initSearchCondition();
            // 그리드 설정 및 데이터 로드
            this.setGridAndDataLoad();
            // 버튼 설정
            this.setButtons();
        }
	};
	
	// 현황 팝업 열기
	function fnOfferCpnPoolCondPopup(){
		 $("#offerCpnPoolCondDialog").ifvsfPopup({
		  enableModal : true,
		        enableResize: false,
		        contentUrl: '<ifvm:url name="offerCpnPoolListCondPopup"/>' ,
		        contentType: "ajax",
		        title:  '<spring:message code="O00099"/>',
		        width: '700px',
		        close : 'fnOfferCpnPoolCondPopClose'
		    });
	}
	
	// 현황 팝업 닫기
	function fnOfferCpnPoolCondPopClose() {
		offerCpnPoolCondDialog._destroy();
	}
	
	// 엑셀 다운로드
	function targetListDownload(){
		$.ifvExcelDn('<ifvm:action name="exportExcelOfferCpnPoolList"/>','ofrCpnPoolGrid');	
	}
	
	$(document).ready(function () {
		var offerCpnPoolGrid = new OfferCpnPoolList();
		offerCpnPoolGrid.init();
	});
</script>

<div class="page-title">
	<h1>
		<spring:message code="O00192" />
		&gt; <spring:message code="O00105" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="O00107" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCondBtn" objCode="offerCpnPoolListsearchCondBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="O00105" />
			</button>
			<button class="btn btn-sm" id="searchCondInitBtn" objCode="offerCpnPoolListsearchCondInitBtn_OBJ">
				<spring:message code="O00106" />
			</button>
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="offerCpnPoolSearchList"></div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span><spring:message code="O00108" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" text="O00099" id="btnOfferCpnPoolCond" btnFunc="fnOfferCpnPoolCondPopup" objCode="ofrCouponPoolCond_OBJ"/>
			<ifvm:inputNew type="button" text="O00084" id="excelDownloadBtn" btnFunc="targetListDownload" objCode="offerCouponPoolDown_OBJ"/>
		</div>
	</div>
	<div id="ofrCpnPoolGrid" class="white_bg grid_bd0"></div>
</div>

<div id="offerCpnPoolCondDialog" class="popup_container"></div>