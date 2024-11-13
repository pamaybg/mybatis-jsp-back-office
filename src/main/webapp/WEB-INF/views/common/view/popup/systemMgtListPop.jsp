<%@ page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div id="systemMgtGrid"></div>
<div class="pop_btn_area">
	<button class="btn btn-sm btn_gray" id="btnSystemSelect" objCode="btnSystemSelect_OBJ">
		<spring:message code="L00072" />
	</button>
	<button class="btn btn-sm btn_lightGray2" id="btnSystemCancle" objCode="btnSystemCancle_OBJ">
		<spring:message code="M00441" />
	</button>
</div>

<script type="text/javascript">
var sytemMgtListPop = function () {
	    var _rid = null;
	    var _host = null;
	    var _port = null;
	
	    this.getRid = function () {
	        return _rid;
	    },
        this.setRid = function (rid) {
            _rid = rid;
        },
        this.getHost = function () {
            return _host;
        },
        this.setHost = function (host) {
        	_host = host;
        },
        this.getPort = function () {
            return _port;
        },
        this.setPort = function (port) {
        	_port = port;
        },
        /* 그리드 생성 */
        this.setGridAndDataLoad = function () {
            var _rowSelected = function (args) {
                var data = args.data;
                this.setRid(data.rid);
                this.setHost(data.host);
                this.setPort(data.port);
            };

            var ejGridOption = {
                rowSelected: _rowSelected.bind(this),
                serializeGridData: function (data) {
                    return data;
                },
                dataUrl : '<ifvm:action name="getSystemMgtListPop"/>',
                columns : [
            	{
		      		  field : 'systemNm', headerText : '시스템명', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {searchable: true,}
		      	  },{
		      		  field : 'systemTypeCd', headerText : '시스템 유형', headerTextAlign : 'center', textAlign : 'center',
		      		  customAttributes : {searchable: true,}
		      	  },{
              		  field : 'port', headerText : 'PORT 번호', headerTextAlign : 'center', textAlign : 'center',
              			customAttributes : {searchable: true,}
              	  },{
            		  field : 'host', headerText : 'HOST명', headerTextAlign : 'center',
    	      		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'company', headerText : '회사명', headerTextAlign : 'center',
    	      		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'statCd', headerText : '상태', headerTextAlign : 'center', textAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'purposeCd', headerText : '사이트용도', headerTextAlign : 'center',
            		  customAttributes : {searchable: true,}
            	  },{
            		  field : 'rid', headerText : 'rid', headerTextAlign : '' ,visible: false,
            	  }
                ],
                requestGridData: {
                    sidx: 'createDate',
                },
                rowList : [10,25,50,100],
                radio: true
            };
            $("#systemMgtGrid").ifvsfGrid({
                ejGridOption: ejGridOption
            });
        },
        /* 버튼 세팅 */
        this.setButtons = function () {
            $("#btnSystemSelect").on('click', function () {
               	$("#host").val(this.getHost());
        		$("#systemRid").val(this.getRid());
        		$("#port").val(this.getPort());
    			$.fn.ifvmPopupClose();
            }.bind(this));

            $("#btnSystemCancle").on('click', function () {
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
    var systemMgtPop = new sytemMgtListPop();
	systemMgtPop.init();
});
</script>
