<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="chnlPopGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnChnlSelect" objCode="chnlPopBtnChnlSelect_OBJ">
		<i class="glyphicon glyphicon-check"></i>
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnChnlCancle" objCode="chnlPopBtnChnlCancel_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var ChnlListPop = function () {
	    var _chnlRid = null;
	    var _chnlNm = null;

	    this.getChnlRid = function () {
	        return _chnlRid;
	    },
        this.setChnlRid = function (chnlRid) {
            _chnlRid = chnlRid;
        },
        this.getChnlNm = function () {
            return _chnlNm;
        },
        this.setChnlNm = function (chnlNm) {
            _chnlNm = chnlNm;
        },
        this.getChnlNo = function () {
            return _chnlNo;
        },
        this.setChnlNo = function (chnlNo) {
            _chnlNo = chnlNo;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setChnlRid(data.rid);
                this.setChnlNm(data.chnlNm);
                this.setChnlNo(data.chnlNo);
            };

            var _getSearchCond = function() {
                if (typeof ifvGlobal.searchHelp !== 'undefined' && typeof ifvGlobal.searchHelp.searchCond !== 'undefined' ) {
                    $.extend(ejGridOption.requestGridData, ifvGlobal.searchHelp.searchCond);
                    delete ifvGlobal.searchHelp.searchCond;
                }
            }

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
          		recordDoubleClick : function(args){
          			var data = args.data;     					
          			$("#chnlNm, #chnlPrNm, #issChnl").val(data.chnlNm);
	        		$("#chnlPrRid, #chnlRid, #ridChnl, #issChnlRid").text(data.rid); 							
	        		$("#chnlPrRid, #chnlRid, #ridChnl, #issChnlRid").val(data.rid);  							
	        		$("#chnlNo").val(data.chnlNo);  							
	        		chnlRid = data.rid;  							
	        		chnlNo = data.chnlNo;  								        		
	        		$.fn.ifvmPopupClose();

               	},
                dataUrl: '<ifvm:action name="getChnlPopup"/>',
                columns: [
                	{
                        field: 'chnlNm',
                        headerText: '<spring:message code="L00129"/>',
                        customAttributes: { searchable: true  }
                    }, 
                    {
                        field: 'chnlNo',
                        headerText: '<spring:message code="L00128"/>',
                        textAlign : 'center',
                        customAttributes: { searchable: true }
                    }, {
                        field: 'chnlTypeCdNm',
                        headerText: '<spring:message code="L00165"/>', textAlign : 'center',
                        customAttributes: { index: 'chnlTypeCd' }
                    }, {
                        field: 'parChnlNm',
                        headerText: '<spring:message code="L00130"/>', textAlign : 'center',
                    }, {
                        field: 'modifyBy',
                        headerText: '<spring:message code="L00095"/>',
                        visible : false
                    }, {
                        field: 'modifyDate',
                        headerText: '<spring:message code="L00094"/>',
                        visible : false
                    }, {
                        field: 'rid',
                        headerText: 'rid',
                        visible: false,
                    }],
                requestGridData: {
                    sidx: 'chnlNo',
                },
                radio: true
            };
			
            _getSearchCond();
            $("#chnlPopGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnChnlSelect").on('click', function () {
               	$("#chnlNm, #chnlPrNm, #issChnl").val(this.getChnlNm());
        		$("#chnlPrRid, #chnlRid, #ridChnl").text(this.getChnlRid());
        		$("#chnlPrRid, #chnlRid, #ridChnl, #issChnlRid").val(this.getChnlRid());
        		$("#chnlNo").val(this.getChnlNo());
        		chnlRid = this.getChnlRid();
        		chnlNo = this.getChnlNo();
    			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnChnlCancle").on('click', function () {
    			$.fn.ifvmPopupClose();
            }.bind(this));
        },
        /* 페이지 초기화 */
        this.init = function () {
            this.setGridAndDataLoad();
            this.setButtons();
        }
	};

	$(document).ready(function () {
		
	    var chnlListPop = new ChnlListPop();
	    chnlListPop.init();
	});
</script>
