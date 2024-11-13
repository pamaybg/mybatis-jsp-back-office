<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="corpCustGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnCorpCustSelect" objCode="">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnCorpCustCancle" objCode="">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
	var CorpCustListPop = function () {
	    var _rid = null;
	    var _custNm = null;
	    var _custNo = null;
	
	    this.getRid = function () {
	        return _rid;
	    },
        this.setRid = function (rid) {
            _rid = rid;
        },
        this.getCustNm = function () {
            return _custNm;
        },
        this.setCustNm = function (custNm) {
        	_custNm = custNm;
        },
        this.getCustNo = function () {
            return _custNo;
        },
        this.setCustNo = function (custNo) {
        	_custNo = custNo;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.setCustNm(data.custNm);
                this.setCustNo(data.custNo);
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
                dataUrl : '<ifvm:action name="getCorpCustListPage"/>',
                columns : [
                {
              		  field : 'custNo', headerText : '고객번호', headerTextAlign : 'center', textAlign : 'center',
              			customAttributes : {searchable: true,}
              	  },{
            		  field : 'custNm', headerText : '고객명', headerTextAlign : 'center',
    	      		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'hhp', headerText : '전화번호', headerTextAlign : 'center',
    	      		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'custTypeCdNm', headerText : '유형', headerTextAlign : 'center', textAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'custStatCdNm', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'sbscDate', headerText : '가입일', headerTextAlign : 'center', textAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'chnlNm', headerText : '가입채널', headerTextAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'createDate', headerText : '등록일시', headerTextAlign : 'center', textAlign : 'center',
            	  },{
            		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
            	  }
                ],
                requestGridData: {
                    sidx: 'chnl_no',
                },
                rowList : [10,25,50,100],
                radio: true
            };
            $("#corpCustGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnCorpCustSelect").on('click', function () {
               	$("#custNm, #corpCustNm").val(this.getCustNm());
        		$("#rid, #ridCust, #ridCorpCust").val(this.getRid());
        		$("#custNo, #corpCustNo").val(this.getCustNo());
    			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnCorpCustCancle").on('click', function () {
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
	    var CorpCustPop = new CorpCustListPop();
	    CorpCustPop.init();
	});
</script>
