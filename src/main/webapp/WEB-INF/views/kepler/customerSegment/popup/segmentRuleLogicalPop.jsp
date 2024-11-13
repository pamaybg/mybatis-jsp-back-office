<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="chnlGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSelect" objCode="btnSelect_OBJ">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCancle" objCode="btnCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var LogicalListPop = function () {
	  var custSegRuleNm=null;
	  var csegCustRuleId=null;
	       /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
            	 var data = args.data;
            	 custSegRuleNm=data.custSegRuleName;
            	 csegCustRuleId=data.custSegRuleId;
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
         		
                    return data;
                },
                dataUrl: '<ifvm:action name="getCustSegRuleList"/>',
                columns: [ 
                    {
                        field: 'segmentName',
                        headerText: '세그먼트 명',
                        width: '180px',
                        textAlign : 'center',
                          customAttributes: { searchable: true }
                    },{
                    	field: 'custSegRuleName',
                        headerText: '고객 세분화 룰',
                        width: '180px',
                        textAlign : 'center',
                          customAttributes: {
                              	searchable: true }
                    },{
                    	field: 'createByName',
                        headerText: '등록자',
                        width: '130px',
                        textAlign : 'center',
                        customAttributes: {
                              	searchable: true }
                    },{
                    	field: 'createDate',
                        headerText: '등록일시',
                        textAlign : 'center',
                        width: '160px',
                         customAttributes: {
                              	searchable: true }
                    }
               		              
               ],
                requestGridData: {
                    sidx: 'createDate',
                },
                rowList : [10,25,50,100],
                radio: true
            };
            $("#chnlGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnSelect").on('click', function () {
               	$("#csegCustRuleNm").val(custSegRuleNm);
               	$("#csegCustRuleId").val(csegCustRuleId)
     			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnCancle").on('click', function () {
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
	    var LogicalList = new LogicalListPop();
	    LogicalList.init();
	});
</script>
