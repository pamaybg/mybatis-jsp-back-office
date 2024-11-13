<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<script type="text/javascript">
var custSegMartList = function () {
    var _rid = null;
    var _lgcCompId = null;
    this.setRid = function (rid) {
        _rid = rid;
    }, this.getRid = function () {
        return _rid;
    },
    this.segGridOptions = null,
    this.optionFields = [
        { fieldName: "csegMtStatusCd", commCode: "ANL_CSEG_MT_STATUS_CD "}   /* 상태 */
        ],
    this.setGridAndDataLoad = function () {

        var _serializeGridData = function (data) {
            return data;
        };
        var _rowSelected = function (args) {
            var _data = args.data;
            this.setRid(_data.rid);
            _lgcCompId=_data.lgcCompId;
        };
        var _recordDoubleClick = function (args) {
            var _data = args.data;
            this.setRid(_data.rid);
            this.goToDetail();
        };
        var ejGridOption = {
            serializeGridData: _serializeGridData,
            rowSelected: _rowSelected.bind(this),
            recordDoubleClick: _recordDoubleClick.bind(this),
            dataUrl: '<ifvm:action name="getCustSegMartList"/>',
            columns: [ 
            	{ /* 로지컬 컴포넌트 */
                    field: 'lgcCompNm',
                    headerText: '로지컬 컴포넌트',
                    width: '90px',
                    textAlign: 'center',
                    customAttributes: {
                    	searchable: true
                    },
            	},{ /* 로지컬 컴포넌트 그룹명 */
                    field: 'lgcCompTblIntNm',
                    headerText: '로지컬 컴포넌트 그룹',
                    width: '70px',
                    textAlign: 'center'
               	},
            	{ /* 고객 세분화 마트 항목명 */
                    field: 'csegMtNm',
                    headerText: '고객 세분화 마트 항목명',
                    width: '160px',
                    textAlign: 'center',
                    customAttributes: {
                    	searchable: true
                    }                    
                },
                { /* 상태 */
                    field: 'csegMtStatusNm',
                    headerText: '상태',
                    width: '40px',
                    textAlign: 'center',
                    customAttributes: {
                           index: 'csegMtStatusCd'
                     }
                }, 
                {/* 적용 시작 시간 */
                    field: 'aplyStartDd',
                    headerText: '적용 시작 시간',
                    width: '80px',
                    textAlign: 'center'
                },
                {/* 적용 종료 시간 */
                    field: 'aplyEendDd',
                    headerText: '적용 종료 시간',
                    width: '80px',
                    textAlign: 'center'
                },
                {/* 등록자*/
                    field: 'createBy',
                    headerText: '등록자',
                    width: '80px',
                    textAlign: 'left'
               }, {/* 등록자*/
                    field: 'createDate',
                    headerText: '등록일',
                    width: '40px',
                    visible: false
                },{
                	field: 'lgcCompId',
                    headerText: 'lgcCompId',
                    visible: false
                },               	              	
            	{
                     field: 'rid',
                     headerText: 'rid',
                     visible: false
                 }],
            requestGridData: {
                sidx: 'rid',
                sord : 'asc'
            },
            radio: true
        };

        this.segGridOptions = $("#segMartList").ifvsfGrid({
            ejGridOption: ejGridOption
        });
    },
    /* 버튼 세팅 */
    this.setButtons = function () {
        // 조회
        $('#searchCondBtn').on('click', function () {
            var _segGridOptions = this.segGridOptions;
            $.fn.ifvmSubmitSearchCondition("searchList", function () {
                _segGridOptions.searchGrid({ item: requestitem });
            });

        }.bind(this));

        // 초기화
        $("#searchCondInitBtn").on('click', function () {
        	this.initSearchCondition();
        }.bind(this));

        // 신규 클릭시
        $('#btnAdd').on('click', function () {
            qtjs.href('<ifvm:url name="custSegmentMartDetail"/>');
        });

        // 삭제
        $('#btnRemove').on('click', function () {
            this.removeAction();
        }.bind(this));

        //수동실행
        $('#btnExec').on('click', function () {
            this.execAction();
        }.bind(this));
        
    },
    /* 상세 이동 */
    this.goToDetail = function () {
        var _rid = this.getRid();
        qtjs.href('<ifvm:url name="custSegmentMartDetail"/>' + "?rid=" + _rid);
    },
    /* 공통 조회 조건 목록 설정 */
    this.initSearchCondition = function () {
        $.fn.ifvmSetCommonCondList("searchList", "ANL_CUST_SEGMENT", "custSegMartList");
    },
    /* 삭제 액션 */
    this.removeAction = function () {
        var _success = function () {
            alert('<spring:message code="L00085"/>');
            this.setGridAndDataLoad();
            $.ifvProgressControl(false);
        };

        var _fail = function (result) {
            alert(result.message);
            $.ifvProgressControl(false);
        };

        var _rid = this.getRid();

        if ($.fn.ifvmIsNotEmpty(_rid)) {
            if (confirm('<spring:message code="L00086"/>')) {
                $.ifvProgressControl(true);
                $.ifvPostJSON('<ifvm:action name="removeCustSegmentMart"/>', { rid: _rid }, _success.bind(this), _fail);
            }
        }
    },
    this.execAction = function(){
    	   var _success = function (result) {
              alert(result.message);
               this.setGridAndDataLoad();
               $.ifvProgressControl(false);
           };

           var _fail = function (result) {
               alert(result.message);
               $.ifvProgressControl(false);
           };

           var _rid = this.getRid();

           if ($.fn.ifvmIsNotEmpty(_rid)) {
               if (confirm('수동 실행 하시겠습니까?')) {
                   $.ifvProgressControl(true);
                   $.ifvPostJSON('<ifvm:action name="execSegMartSql"/>', { rid: _rid, lgcCompId:_lgcCompId }, _success.bind(this), _fail);
               }
           }
    },
    /* 페이지 초기화 */
    this.init = function () {
        // 공통 조회 조건 목록 설정
        this.initSearchCondition();
        // 그리드 설정 및 데이터 로드
        this.setGridAndDataLoad();
        $.ifvSetSelectOptions(this.optionFields);
        // 버튼 설정
        this.setButtons();
    }
};

$(document).ready(function () {
	var custSegMartListGrid = new custSegMartList();
	custSegMartListGrid.init();
});
</script>

<div class="page-title">
	<h1>
		고객 세분화 기준정보
		&gt; <spring:message code="O00105" />
	</h1>
</div>

<div>
	<div class="page_btn_area">
		<div class="col-xs-7">
			<span><spring:message code="L01838" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<button class="btn btn-sm" id="searchCondBtn" objCode="offerListsearchCondBtn_OBJ">
				<i class="fa fa-search"></i>
				<spring:message code="O00105" />
			</button>
			<button class="btn btn-sm" id="searchCondInitBtn" objCode="offerListsearchCondInitBtn_OBJ">
				<spring:message code="O00106" />
			</button>
			
		</div>
	</div>
	<div class="well form-horizontal well_bt5" id="searchList"></div>
</div>
<!-- 조회결과 -->
<div>
	<div class="page_btn_area" id=''>
		<div class="col-xs-7">
			<span><spring:message code="O00108" /></span>
		</div>
		<div class="col-xs-5 searchbtn_r">
			<ifvm:inputNew type="button" btnType="plus" text="M01852" id="btnAdd" objCode="btnAdd_OBJ" />
			<ifvm:inputNew type="button" btnType="minus" text="M01854" id="btnRemove" objCode="btnRemove_OBJ" />
			<ifvm:inputNew type="button" text="수동 실행" id="btnExec" objCode="btnExec_OBJ"/>
<%-- 			<ifvm:inputNew type="button" text="다 건 수동 실행" id="btnExec" />
 --%>		</div>
	</div>
	<div id="segMartList" class="white_bg grid_bd0"></div>
</div>