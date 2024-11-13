<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style>
	.tab-contents .page_btn_area .btn.disabled, .tab-contents .page_btn_area .btn[disabled] {
		display: inline;
	}
</style>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="O00001" /></span>
	</div>
	<div class="col-sm-5 searchbtn_r">
		<ifvm:inputNew type="button"  text="O00046" id="btnAddOfferJoinPgm" objCode="offerJoinPgmListNew_OBJ"/>
		<ifvm:inputNew type="button"  text="O00047" id="btnRemoveOfferJoinPgm" objCode="offerJoinPgmListRemove_OBJ"/>
	</div>
</div>
<div id="joinPgmGrid"></div>


<script type="text/javascript">
var ofrJoinPgmRid = null;


	var OfferJoinPgmList = function () {
		var _rid = null;
	    this.setRid = function (rid) {
		    ifvGlobal["joinPgmRid"] = rid;
	        _rid = rid;
	    },
	    this.getRid = function () {
            return _rid;
        },
        this.getPgmRid = function () {
            return _pgmRid;
        },
        this.joinPgmGridOptions = null,
        this.setGridAndDataLoad = function (url) {
        	var _serializeGridData = function (data) {
        		data.ridOfr = ifvGlobal["offerRid"];
                return data;
            };
            var _rowSelected = function (args) {
                var _data = args.data;
                this.setRid(_data.rid);
            };
        	/* var _recordDoubleClick = function (args) {
                var _data = args.data;
                ofrJoinPgmRid = _data.rid;
                this.setRid(_data.rid);
                this.openPopup(ofrJoinPgmRid);
            }; */
            var ejGridOption = {
				serializeGridData: _serializeGridData,
				rowSelected: _rowSelected.bind(this),
				//recordDoubleClick: _recordDoubleClick.bind(this),
				dataUrl: '<ifvm:action name="getOfferJoinPgmList"/>',
				columns: [	// '프로그램번호', '프로그램 명', '주관', '유형', '상태', '개설일'
					{
					    field: 'rid',
					    visible: false
					}, {
					    field: 'pgmNo',
					    headerText: '<spring:message code="O00048"/>',
					    width: '80px',
					    textAlign: 'center',
					    customAttributes: {
                            searchable: true
                        }
					}, {
					    field: 'pgmNm',
					    headerText: '<spring:message code="O00049"/>',
					    width: '250px',
					    textAlign: 'left',
					    customAttributes: {
                            searchable: true
                        }
					}, {
					    field: 'chnlPrNm',
					    headerText: '<spring:message code="O00050"/>',
					    width: '150px',
					    textAlign: 'left'
					}, {
					    field: 'pgmTypeNm',
					    headerText: '<spring:message code="O00051"/>',
					    width: '80px',
					    textAlign: 'center',
					    customAttributes: {
	                        index: 'pgmType'
	                    }
					}, {
					    field: 'pgmStatNm',
					    headerText: '<spring:message code="O00052"/>',
					    width: '80px',
					    textAlign: 'center',
					    customAttributes: {
					        index: 'pgmStat'
					    }
					}, {
	                    field: 'createDate',
	                    headerText: '<spring:message code="O00053"/>',
	                    width: '80px',
	                    textAlign: 'center'
	                }],
				requestGridData: {
				    sidx: 'createDate'
				},
				radio: true
            };
            
            this.joinPgmGridOptions = $("#joinPgmGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
      	},
      	/* 팝업 오픈 */
        this.openPopup = function (ofrJoinPgmRid) {
            $.fn.ifvmPopupOpen('popupContainer', this.getRid(),
                '<ifvm:url name="offerLoyPgmListPopup"/>'+'?ofrJoinPgmRid='+ofrJoinPgmRid,
                '<spring:message code="O00054"/>', 860);
        },
        /* 버튼 클릭 시 액션 세팅 */
        this.setButtons = function () {
            $("#btnAddOfferJoinPgm").click(function () {
                this.setRid(null);
                ofrJoinPgmRid = null;
                this.openPopup();
            }.bind(this));

            $("#btnRemoveOfferJoinPgm").click(function () {
                this.removeAction();
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
                    $.ifvPostJSON('<ifvm:action name="removeOfferJoinPgm"/>', { rid: _rid }, _success.bind(this), _fail);
                }
            }
        },
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	}
	
	$(document).ready(function () {
		var offerJoinPgmGrid = new OfferJoinPgmList();
		offerJoinPgmGrid.init();
	});
	
	ofrStatSaveValid();
</script>




