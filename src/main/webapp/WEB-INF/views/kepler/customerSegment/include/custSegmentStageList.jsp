<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span>세분화 단계</span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button" btnType="plus" text="O00046" id="btnAddSegStage" objCode="btnAddSegStage_OBJ"/>
		<ifvm:inputNew type="button"  text="수정" id="btnEditSegStage" objCode="btnEditSegStage_OBJ" />
		<ifvm:inputNew type="button"  btnType="minus" text="O00047" id="btnRemoveSegStage" objCode="btnRemoveSegStage_OBJ"/>
	</div>
</div>

<div id="custSegmentStageGrid"></div>
<div id="segmentStageGrid"></div>
<div id="popupPopupContainer" class="popup_container"></div>

<script type="text/javascript">
	var custSegmentStageList = function () {
		var _rid = null;
		
		var urlParams = $.ifvGetParams();
		var stageRid = urlParams.rid;
		
	    this.setRid = function (rid) {
	    	 ifvGlobal["custSegStageRid"]= rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
            return _rid;
        },
        this.getPgmRid = function () {
            return _pgmRid;
        },
        this.segmentStageGridOption = null,
        this.setGridAndDataLoad = function (url) {
        	var _serializeGridData = function (data) {
        		data.csegMstId=stageRid;
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
            };
        	var _recordDoubleClick = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
                this.openPopup();
            };
            var ejGridOption = {
				serializeGridData: _serializeGridData,
				rowSelected: _rowSelected.bind(this),
				recordDoubleClick: _recordDoubleClick.bind(this),
				dataUrl: '<ifvm:action name="getCustSegStageList"/>',
				columns: [	// '고객 분류', '유형', '고객 세분화 단계', '고객 세분화 룰', '등록자 ', '등록일시'
					{
					    field: 'rid',
					    visible: false
					}, {
					    field: 'csegCustCtgNm',
					    headerText: '고객 분류',
					    width: '50px',
					    textAlign: 'center'
					 }, {
					    field: 'csegCustTypeNm',
					    headerText: '고객 유형',
					    width: '50px',
					    textAlign: 'center'					 
					}, {
					    field: 'csegStageNm',
					    headerText: '세분화 단계',
					    width: '100px',
					    textAlign: 'center',
					    customAttributes: {
		                    searchable: true,
		                    index : 'csegStageNm'
		               }
					},{
					    field: 'csegStageIndex',
					    headerText: '단계 순서',
					    width: '50px',
					    textAlign: 'center'
					},{
					    field: 'csegCustRuleNm',
					    headerText: '고객 세분화 룰',
					    width: '150px',
					    textAlign: 'center',
					    customAttributes: {
		                    searchable: true,
		                    index : 'csegCustRuleNm'
		               }
					}, {
					    field: 'createBy',
					    headerText: '등록자',
					    width: '80px',
					    textAlign: 'center'
					}, {
	                    field: 'createDate',
	                    headerText: '등록 일시',
	                    width: '80px',
	                    textAlign: 'center'
	                }],
				requestGridData: {
				    sidx: 'csegStageIndex',
				 	sord : 'asc'
				    
				},
				radio: true
            };
            
            this.segmentStageGridOption = $("#segmentStageGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
      	},
      	/* 팝업 오픈 */
        this.openPopup = function () {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="custSegmentStagePop"/>',
                '세분화 단계', 660);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddSegStage").click(function () {
                this.setRid(null);
                this.openPopup();
            }.bind(this));

            $("#btnRemoveSegStage").click(function () {
                this.removeAction();
            }.bind(this));
            
            $("#btnEditSegStage").click(function(){
            	
            	if(!$.fn.ifvmIsNotEmpty(this.getRid())){
            		alert("수정할 목록을 선택해주세요");
            	}else{
            	 	this.getRid();
            		this.openPopup();     
            	}
            }.bind(this));
        },
        /* 삭제 액션 */
        this.removeAction = function () {
            var _success = function () {
                $.ifvProgressControl(false);
                setTimeout(`alert('<spring:message code="L00085"/>')`, 0);
                this.setGridAndDataLoad();
            };

            var _fail = function (result) {
                $.ifvProgressControl(false);
                setTimeout(`alert(result.message)`, 0);
            };

            var _rid = this.getRid();
			            
            if ($.fn.ifvmIsNotEmpty(this.getRid())) {
                if (confirm('<spring:message code="O00056"/>')) {
                    $.ifvProgressControl(true);
                    $.ifvPostJSON('<ifvm:action name="removeCustSegmentStage"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }else{
            	alert("삭제할 목록을 선택해주세요.")
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	}
	
	$(document).ready(function () {
		var custSegmentStageGrid = new custSegmentStageList();
		ifvGlobal['custSegmentStageList'] = custSegmentStageGrid;
		custSegmentStageGrid.init();
	});
</script>




