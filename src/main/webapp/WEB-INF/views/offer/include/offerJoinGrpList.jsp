<%@page trimDirectiveWhitespaces="true"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="ifvm"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="page_btn_area">
	<div class="col-xs-7">
		<span><spring:message code="오퍼그룹" /></span>
	</div>
</div>
<div id="offerGroupGrid"></div>

<script type="text/javascript">
	var OfferJoinGrpList = function () {
		var _ridOfr = ifvGlobal["offerRid"];
        this.getRidOfr = function () {
            return _ridOfr;
        },
        this.setGridAndDataLoad = function (url) {
        	var _serializeGridData = function (data) {
        		data.ridOfr = this.getRidOfr();
                return data;
            };
            var ejGridOption = {
				serializeGridData: _serializeGridData.bind(this),
				dataUrl: '<ifvm:action name="getChildOfferGroupList"/>',
				columns: [	// '번호', '오퍼그룹명', '유형', '상태', '등록자', '등록일자'
					{
					    field: 'rid',
					    visible: false
					}, {
					    field: 'ofrgrpNo',
					    headerText: '<spring:message code="O00091"/>',
					    width: '80px',
					    textAlign: 'center',
					    customAttributes: {
                            searchable: true
                        }
					}, {
					    field: 'ofrgrpNm',
					    headerText: '<spring:message code="O00092"/>',
					    width: '250px',
					    textAlign: 'left',
					    customAttributes: {
                            searchable: true
                        }
					}, {
	                    field: 'ofrgrpTypeNm',
	                    headerText: '<spring:message code="O00051"/>',
	                    width: '100px',
	                    textAlign: 'center',
                    	customAttributes: {
                    		index: 'ofrgrpType'
                        }
					}, {
	                    field: 'statCdNm',
	                    headerText: '<spring:message code="O00018"/>',
	                    width: '100px',
	                    textAlign: 'center',
                    	customAttributes: {
                    		index: 'statCd'
                        }
					}, {
					    field: 'createBy',
					    headerText: '<spring:message code="O00080"/>',
					    width: '80px',
					    textAlign: 'left'
					}, {
	                    field: 'createDate',
	                    headerText: '<spring:message code="O00116"/>',
	                    width: '80px',
	                    textAlign: 'center'
					}],
				requestGridData: {
				    sidx: 'createDate'
				},
				radio: false
            };
            $("#offerGroupGrid").ifvsfGrid({ ejGridOption : ejGridOption });
      	},
        this.init = function () {
            this.setGridAndDataLoad();
        }
	}
	
	$(document).ready(function () {
		var offerJoinGrpGrid = new OfferJoinGrpList();
		offerJoinGrpGrid.init();
	});
</script>


