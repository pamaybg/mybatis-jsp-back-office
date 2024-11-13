<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="CardBinGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnCardBinSelect" objCode="">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCardBinCancle" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var CardBinListPop = function () {
	    var _rid = null;
	    var _corpCustNm = null;
	
	    this.getRid = function () {
	        return _rid;
	    },
        this.setRid = function (rid) {
            _rid = rid;
        },
        this.getCorpCustNm = function () {
            return _corpCustNm;
        },
        this.setCorpCustNm = function (corpCustNm) {
        	_corpCustNm = corpCustNm;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.setCorpCustNm(data.corpCustNm);
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                	data.ridCardKind = cardTypeRid;
                    return data;
                },
                dataUrl : '<ifvm:action name="getCardBinList"/>',
                columns : [
        	      {
      	      		  field : 'startNo', headerText : '<spring:message code="M02968"/>', headerTextAlign : 'center', textAlign : 'right',
      	      		  customAttributes : {
      	      			  index : 'T1.START_NO' }
      	      	  },{
      	      		  field : 'endNo', headerText : '<spring:message code="M02969"/>', headerTextAlign : 'center', textAlign : 'right',
      	      		  customAttributes : {
      	      			  index : 'T1.END_NO' }
      	      	  },{
      	      		  field : 'chnlNm', headerText : '<spring:message code="M02958"/>', headerTextAlign : 'center', textAlign : 'center',
      	      			customAttributes: { searchable: true  }
      	      	  },{
      	      		  field : 'corpCustNm', headerText : '<spring:message code="M02957"/>', headerTextAlign : 'center', textAlign : 'center',
      	      			customAttributes: { searchable: true  }
      	      	  },{
      	      		  field : 'statNm', headerText : '<spring:message code="C00125"/>', headerTextAlign : 'center', textAlign : 'center',
      	      			customAttributes: { searchable: true  }
      	      	  },{
      	      		  field : 'modifyDate', headerText : '<spring:message code="E00094"/>', headerTextAlign : 'center', textAlign : 'center',
      	      		  customAttributes : {
      	      			  index : 'T1.MODIFY_DATE' }
      	      	  },{
      	      		  field : 'modifyBy', headerText : '<spring:message code="L00044"/>', headerTextAlign : 'center', textAlign : 'center',
      	      		  customAttributes : {
      	      			  index : 'E1.NAME' }
      	      	  },{
      	      		  field : 'rid', headerText : 'rid', visible : false,
      	      	  },{
      	      		  field : 'ridChnl', headerText : 'ridChnl', visible : false,
      	      	  },{
      	      		  field : 'ridCorpCust', headerText : 'ridCorpCust', visible : false,
      	      	  },   
                ],
                requestGridData: {
                    sidx: 'chnl_no',
                },
                radio: true
            };
            $("#CardBinGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnCardBinSelect").on('click', function () {
               	$("#corpCustNm").val(this.getCorpCustNm());
        		$("#ridCardBin").val(this.getRid());
    			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnCardBinCancle").on('click', function () {
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
	    var CardBinPop = new CardBinListPop();
	    CardBinPop.init();
	});
</script>
