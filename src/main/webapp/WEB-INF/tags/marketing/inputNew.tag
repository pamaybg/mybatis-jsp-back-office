<%@ tag body-content="empty" pageEncoding="UTF-8"  description="유효성 검사 Input 태그"%>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ attribute name="type"       required="true" type="java.lang.String" %>
<%@ attribute name="id"         required="false" type="java.lang.String" %>
<%@ attribute name="dto"        required="false" type="java.lang.String" %>
<%@ attribute name="names"      required="false" type="java.lang.String" %>
<%@ attribute name="placeholder" required="false" type="java.lang.String" %>
<%@ attribute name="readonly"   required="false" type="java.lang.Boolean" %>
<%@ attribute name="disabled"   required="false" type="java.lang.Boolean" %>
<%@ attribute name="required"   required="false" type="java.lang.Boolean" %>
<%@ attribute name="checked"   required="false" type="java.lang.Boolean" %>
<%@ attribute name="valiItem"   required="false" type="java.lang.String" %>
<%@ attribute name="maxLength"      required="false" type="java.lang.String" %>
<%@ attribute name="minLength"      required="false" type="java.lang.Integer" %>
<%@ attribute name="rows"      required="false" type="java.lang.Integer" %>
<%-- 하단에 표시된 변수는 type이 [select || checkbox || radio] 일 경우에만 사용됨. --%>
<%@ attribute name="text"       required="false" type="java.lang.String" %>
<%@ attribute name="values"     required="false" type="java.lang.String" %>
<%@ attribute name="className"      required="false" type="java.lang.String" %>
<%@ attribute name="checkIndex" required="false" type="java.lang.Integer" %>
<%@ attribute name="title" required="false" type="java.lang.String" %>
<%@ attribute name="label" required="false" type="java.lang.String" %>
<%@ attribute name="labelClass" required="false" type="java.lang.String" %>
<%@ attribute name="conClass" required="false" type="java.lang.String" %>
<%@ attribute name="modalId" required="false" type="java.lang.String" %>
<%@ attribute name="btnId" required="false" type="java.lang.String" %>
<%@ attribute name="checkIndexs" required="false" type="java.lang.String" %>
<%@ attribute name="btnImg" required="false" type="java.lang.String" %>
<%@ attribute name="btnType" required="false" type="java.lang.String" %>
<%@ attribute name="btnFunc" required="false" type="java.lang.String" %>
<%@ attribute name="clearArgs" required="false" type="java.lang.String" %>
<%@ attribute name="hidId" required="false" type="java.lang.String" %>
<%@ attribute name="hidDto" required="false" type="java.lang.String" %>
<%@ attribute name="tabId" required="false" type="java.lang.String" %>
<%@ attribute name="desc" required="false" type="java.lang.String" %>
<%@ attribute name="mainText" required="false" type="java.lang.String" %>
<%@ attribute name="subText" required="false" type="java.lang.String" %>
<%@ attribute name="startId" required="false" type="java.lang.String" %>
<%@ attribute name="startDto" required="false" type="java.lang.String" %>
<%@ attribute name="startName" required="false" type="java.lang.String" %>
<%@ attribute name="startVal" required="false" type="java.lang.String" %>
<%@ attribute name="startDataBind" required="false" type="java.lang.String" %>
<%@ attribute name="endId" required="false" type="java.lang.String" %>
<%@ attribute name="endDto" required="false" type="java.lang.String" %>
<%@ attribute name="endName" required="false" type="java.lang.String" %>
<%@ attribute name="endVal" required="false" type="java.lang.String" %>
<%@ attribute name="endDataBind" required="false" type="java.lang.String" %>
<%@ attribute name="size" required="false" type="java.lang.String" %>
<%@ attribute name="sign" required="false" type="java.lang.String" %>
<%@ attribute name="url" required="false" type="java.lang.String" %>
<%@ attribute name="targetId" required="false" type="java.lang.String" %>
<%@ attribute name="urlObj" required="false" type="java.lang.String" %>
<%@ attribute name="varName" required="false" type="java.lang.String" %>
<%@ attribute name="maxCnt" required="false" type="java.lang.String" %>
<%@ attribute name="tempImgUrl" required="false" type="java.lang.String" %>
<%@ attribute name="tempUpload" required="false" type="java.lang.String" %>
<%@ attribute name="tempUploadIE" required="false" type="java.lang.String" %>
<%@ attribute name="category" required="false" type="java.lang.String" %>
<%@ attribute name="imgWidth" required="false" type="java.lang.String" %>
<%@ attribute name="imgHeight" required="false" type="java.lang.String" %>
<%@ attribute name="imgRotationBtn" required="false" type="java.lang.String" %>
<%@ attribute name="imgDeleteBtn" required="false" type="java.lang.String" %>
<%@ attribute name="noImageBg" required="false" type="java.lang.String" %>
<%@ attribute name="funcName" required="false" type="java.lang.String" %>
<%@ attribute name="width" required="false" type="java.lang.String" %>
<%@ attribute name="minNum" required="false" type="java.lang.String" %>
<%@ attribute name="maxNum" required="false" type="java.lang.String" %>
<%@ attribute name="progress" required="false" type="java.lang.String" %>
<%@ attribute name="defaultImage" required="false" type="java.lang.String" %>
<%@ attribute name="imgDeleteBtnId" required="false" type="java.lang.String" %>
<%@ attribute name="imgDeleteBtnFunc" required="false" type="java.lang.String" %>
<%@ attribute name="sideClass" required="false" type="java.lang.String" %>
<%@ attribute name="sideText" required="false" type="java.lang.String" %>
<%@ attribute name="useSortable" required="false" type="java.lang.Boolean" %>
<%@ attribute name="nuc" required="false" type="java.lang.Boolean" %>
<%@ attribute name="editable" required="false" type="java.lang.Boolean" %>
<%@ attribute name="useBlurEvent" required="false" type="java.lang.String" %>
<%@ attribute name="forId" required="false" type="java.lang.String" %>
<%@ attribute name="searchBlurEvent" required="false" type="java.lang.String" %>
<%@ attribute name="searchEnterEvent" required="false" type="java.lang.String" %>
<%@ attribute name="icon" required="false" type="java.lang.String" %>
<%@ attribute name="itemClass" required="false" type="java.lang.String" %>

<%@ attribute name="dataBind" required="false" type="java.lang.String" %>
<%@ attribute name="objCode" required="false" type="java.lang.String" %>

<%--
type        = text | date | radio | checkbox | number | select | password | textarea | checkboxType | radioType
id          = {string}
dto         = {string}
names       = {string} - radio, checkbox일 경우에 네임값이 필요.
placeholder = {string} - type이 Text, password, email 경우에만 적용.
readonly    = true | false - (기본값 : false)
disabled    = true | false - (기본값 : false)
checked     = true | false - (기본값 : false)
valiItem    = email | password | passwordConfirm | phone | url | kor | eng | number | exceptHangul
text        = {string} - array로 처리가 불가하여, |를 이용한 string의 값을 받아서 처리함. (select/checkbox/radio)
required    = true | false - (기본값 : false)
checkIndex  = {int} - radio버튼에 default 체크 index값.
maxLength   = {Integer} - 최대 글자수
minLength   = {Integer} - 최소 글자수
className   = {String} - 별도의 클래스 선언시.
title   	= {String} - title이 필요한 경우(


ex) radioType
<ifvm:input type="radio" names="targetMethod" checkIndex="1" text="I01602|I01603" values="Y|N" />
--%>
<c:set var="S" value="$"/>

<c:set var="typeValue"  value="${type}"/>
<c:set var="idValue"    value="${id}"/>
<c:set var="ids"    value="${fn:split(idValue,'|')}"/>
<c:set var="dtoValue"   value="${dto}"/>
<c:set var="dtos"   value="${fn:split(dtoValue,'|')}"/>
<c:set var="nameValue"  value="${names}"/>
<c:set var="readonly"   value="${readonly}"/>
<c:set var="disabled"   value="${disabled}"/>
<c:set var="required"   value="${required}"/>
<c:set var="checked"   value="${checked}"/>
<c:set var="valiItemValue" value="${valiItem}"/>
<c:set var="textValue" value="${text}"/>
<c:set var="placeholderValue" value="${placeholder}"/>
<c:set var="checkIdx" value="${checkIndex}" />
<c:set var="checkIndexs" value="${checkIndexs}" />
<c:set var="checkIdxs" value="${fn:split(checkIndexs,'|')}" />
<c:set var="val" value="${values}" />
<c:set var="vals" value="${fn:split(val,'|')}" />
<c:set var="maxLength" value="${maxLength}" />
<c:set var="maxLengths" value="${fn:split(maxLength,'|')}" />
<c:set var="minLength" value="${minLength}" />
<c:set var="rows" value="${rows}" />
<c:set var="classValue" value="${className}" />
<c:set var="title" value="${title}" />
<c:set var="labelValue" value="${label}" />
<c:set var="labelClassValue" value="${labelClass}" />
<c:set var="conClassValue" value="${conClass}" />
<c:set var="modalIdValue" value="${modalId}" />
<c:set var="btnIdValue" value="${btnId}" />
<c:set var="btnImgValue" value="${btnImg}" />
<c:set var="btnTypeValue" value="${btnType}" />
<c:set var="btnFuncValue" value="${btnFunc}" />
<c:set var="clearArgValues" value="${clearArgs}"/>
<c:set var="hidIdValue" value="${hidId}" />
<c:set var="hidDtoValue" value="${hidDto}" />
<c:set var="tabIdValue" value="${tabId}" />
<c:set var="tabIdValues" value="${fn:split(tabIdValue,'|')}" />
<c:set var="descValue" value="${desc}" />
<c:set var="mainTextValue" value="${mainText}" />
<c:set var="subTextValue" value="${subText}" />
<c:set var="startIdValue" value="${startId}" />
<c:set var="startDtoValue" value="${startDto}" />
<c:set var="startNameValue" value="${startName}" />
<c:set var="endIdValue" value="${endId}" />
<c:set var="endDtoValue" value="${endDto}" />
<c:set var="endNameValue" value="${endName}" />
<c:set var="sizeValue" value="${size}" />
<c:set var="signValue" value="${sign}" />
<c:set var="urlValue" value="${url}" />
<c:set var="targetIdValue" value="${targetId}" />
<c:set var="urlObjValue" value="${urlObj}" />
<c:set var="varNameValue" value="${varName}" />
<c:set var="maxCntValue" value="${maxCnt}" />
<c:set var="tempImgUrlValue" value="${tempImgUrl}" />
<c:set var="tempUploadValue" value="${tempUpload}" />
<c:set var="tempUploadIEValue" value="${tempUploadIE}" />
<c:set var="categoryValue" value="${category}" />
<c:set var="imgWidthValue" value="${imgWidth}" />
<c:set var="imgHeightValue" value="${imgHeight}" />
<c:set var="imgRotationBtnValue" value="${imgRotationBtn}" />
<c:set var="imgDeleteBtnValue" value="${imgDeleteBtn}" />
<c:set var="noImageBgValue" value="${noImageBg}" />
<c:set var="funcNameValue" value="${funcName}" />
<c:set var="widthValue" value="${width}" />
<c:set var="minNumValue" value="${minNum}" />
<c:set var="maxNumValue" value="${maxNum}" />
<c:set var="progress" value="${progress}" />
<c:set var="defaultImageValue" value="${defaultImage}" />
<c:set var="imgDeleteBtnIdValue" value="${imgDeleteBtnId}" />
<c:set var="imgDeleteBtnFuncValue" value="${imgDeleteBtnFunc}" />
<c:set var="sideClassValue" value="${sideClass}" />
<c:set var="sideTextValue" value="${sideText}" />
<c:set var="useSortableValue" value="${useSortable}" />
<c:set var="nucValue" value="${nuc}" />
<c:set var="editableValue" value="${editable}" />
<c:set var="useBlurEventValue" value="${useBlurEvent}" />
<c:set var="forIdValue" value="${forId}" />
<c:set var="searchBlurEventValue" value="${searchBlurEvent}" />
<c:set var="searchEnterEventValue" value="${searchEnterEvent}" />
<c:set var="iconValue" value="${icon}" />
<c:set var="itemClassValue" value="${itemClass}" />

<c:set var="objCode" value="${objCode}" />

<c:choose>
	<c:when test="${typeValue=='select'}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<select class="form-control <c:if test="${classValue != null}">${classValue}</c:if>"
					<c:if test="${idValue != null }"> id="${id}"</c:if>
					<c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
					<c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
					<c:if test="${disabled == true}"> disabled</c:if>
					<c:if test="${required == true}"> required</c:if>
					<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
					<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if>>

				<c:forTokens var="textVals" varStatus="status" items="${textValue}" delims="|">
					<option <c:if test="${vals[status.index] != '' && vals[status.index] != null }"> value="${vals[status.index]}"</c:if>
							<c:if test="${vals[status.index] == '' || vals[status.index] == null}">value="${status.count}"</c:if>
							<c:if test="${(checkIdx != null) && (checkIdx == status.count)}"> selected</c:if>>
						<c:if test="${nucValue == true}">${textVals}</c:if>
						<c:if test="${nucValue != true}"><spring:message code="${textVals}" /></c:if>
					</option>
				</c:forTokens>
			</select>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'checkbox') || (typeValue == 'radio')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<c:forTokens var="textVals" varStatus="status" items="${textValue}" delims="|">
			<c:if test="${typeValue == 'checkbox' }"> <span class="icheckbox"></c:if>
	        <c:if test="${typeValue == 'radio' }"> <span class="iradio"></c:if>
	            <label for="${id}${status.count}" <c:if test="${classValue != null}"> class="${classValue}"</c:if>>
	                <input <c:if test="${typeValue == 'checkbox' }"> type="checkbox"</c:if>
	                <c:if test="${typeValue == 'radio' }"> type="radio"</c:if>
	                <c:if test="${itemClassValue != null }"> class="${itemClassValue}"</c:if>
	                <c:if test="${idValue  != null }"> id="${id}${status.count}"</c:if>
	                <c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
	                <c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
	                <c:if test="${disabled == true}"> disabled</c:if>
	                <c:if test="${required == true}"> required</c:if>
	                <c:if test="${vals[status.index] != '' && vals[status.index] != null }"> value="${vals[status.index]}"</c:if>
	                <c:if test="${vals[status.index] == '' || vals[status.index] == null}"> value="${status.count}"</c:if>
	                <c:if test="${(typeValue == 'radio') && (checkIdx != null) && (checkIdx == status.count)}"> checked</c:if>
	                <c:if test="${(typeValue == 'checkbox') && (checkIdxs != null)}">
						<c:forTokens var="checkIdxes" varStatus="cstatus" items="${checkIndexs}" delims="|">
							<c:if test="${(checkIdxs[cstatus.index] == status.count)}"> checked</c:if>
						</c:forTokens>
					</c:if>
		            <c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
	                <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
	              	<c:if test="${nucValue == true}">${textVals}</c:if>
					<c:if test="${nucValue != true}"><spring:message code="${textVals}" /></c:if>
	            </label>
        	</span>
        </c:forTokens>
			<c:if test="${descValue != null}"><br/><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${typeValue == 'singleCheckbox' || typeValue == 'singleRadio'}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}" for="${id}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
	        <span class="<c:if test="${typeValue == 'singleCheckbox'}">icheckbox</c:if><c:if test="${typeValue == 'singleRadio'}">iradio</c:if>">
                <input type="<c:if test="${typeValue == 'singleCheckbox'}">checkbox</c:if><c:if test="${typeValue == 'singleRadio'}">radio</c:if>"
						<c:if test="${itemClassValue != null }"> class="${itemClassValue}"</c:if>
                <c:if test="${idValue  != null }"> id="${id}"</c:if>
                <c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
                <c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
                <c:if test="${disabled == true}"> disabled</c:if>
                <c:if test="${required == true}"> required</c:if>
            	<c:if test="${val != null }"> value="${val}"</c:if>
            	<c:if test="${checked == true}"> checked</c:if>
	            <c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
                <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
        	</span>
			<c:if test="${descValue != null}"><br/><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'date')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="smart-form">
				<div class="input"><i class="icon-append fa fa-calendar"></i>
					<input type="text" class="datepicker text-right <c:if test="${classValue != null}">${classValue}</c:if>" data-dateformat='yy-mm-dd'
							<c:if test="${idValue  != null }"> id="${id}"</c:if>
							<c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
							<c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
							<c:if test="${disabled == true}"> disabled</c:if>
							<c:if test="${required == true}"> required</c:if>
							<c:if test="${val != null }"> value="${val}"</c:if>
							<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
							<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
				</div>
			</div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'dateTerm')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="col-xs-12 col-md-6 cal_frt">
				<div class="smart-form">
					<div class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="datepicker text-right <c:if test="${classValue != null}">${classValue}</c:if>" data-dateformat='yy-mm-dd'
								<c:if test="${startIdValue  != null }"> id="${startId}"</c:if>
								<c:if test="${startDtoValue != null }"> dtoParam="${startDto}"</c:if>
								<c:if test="${startNameValue != null }"> name="${startName}"</c:if>
								<c:if test="${disabled == true}"> disabled</c:if>
								<c:if test="${required == true}"> required</c:if>
								<c:if test="${startVal != null }"> value="${startVal}"</c:if>
								<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
								<c:if test="${startDataBind != null}"> data-bind="${startDataBind}"</c:if> />
					</div>
				</div>
			</div>
			<div class="col-xs-1 swung_dash">~</div>
			<div class="col-xs-12 col-md-6 cal_scd">
				<div class="smart-form">
					<div class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="datepicker text-right <c:if test="${classValue != null}">${classValue}</c:if>" data-dateformat='yy-mm-dd'
								<c:if test="${endIdValue  != null }"> id="${endId}"</c:if>
								<c:if test="${endDtoValue != null }"> dtoParam="${endDto}"</c:if>
								<c:if test="${endNameValue != null }"> name="${endName}"</c:if>
								<c:if test="${disabled == true}"> disabled</c:if>
								<c:if test="${required == true}"> required</c:if>
								<c:if test="${endVal != null }"> value="${endVal}"</c:if>
								<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
								<c:if test="${endDataBind != null}"> data-bind="${endDataBind}"</c:if> />
					</div>
				</div>
			</div>
			<div style="clear: both;"></div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'monthTerm')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="col-xs-12 col-md-6 cal_frt">
				<div class="smart-form">
					<div class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="datepicker text-right <c:if test="${classValue != null}">${classValue}</c:if>" data-dateformat='yyyy-mm'
								<c:if test="${startIdValue  != null }"> id="${startId}"</c:if>
								<c:if test="${startDtoValue != null }"> dtoParam="${startDto}"</c:if>
								<c:if test="${startNameValue != null }"> name="${startName}"</c:if>
								<c:if test="${disabled == true}"> disabled</c:if>
								<c:if test="${required == true}"> required</c:if>
								<c:if test="${startVal != null }"> value="${startVal}"</c:if>
								<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
								<c:if test="${startDataBind != null}"> data-bind="${startDataBind}"</c:if> />
					</div>
				</div>
			</div>
			<div class="col-xs-1 swung_dash">~</div>
			<div class="col-xs-12 col-md-6 cal_scd">
				<div class="smart-form">
					<div class="input"> <i class="icon-append fa fa-calendar"></i>
						<input type="text" class="datepicker text-right <c:if test="${classValue != null}">${classValue}</c:if>" data-dateformat='yyyy-mm'
								<c:if test="${endIdValue  != null }"> id="${endId}"</c:if>
								<c:if test="${endDtoValue != null }"> dtoParam="${endDto}"</c:if>
								<c:if test="${endNameValue != null }"> name="${endName}"</c:if>
								<c:if test="${disabled == true}"> disabled</c:if>
								<c:if test="${required == true}"> required</c:if>
								<c:if test="${endVal != null }"> value="${endVal}"</c:if>
								<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
								<c:if test="${endDataBind != null}"> data-bind="${endDataBind}"</c:if> />
					</div>
				</div>
			</div>
			<div style="clear: both;"></div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'time')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="smart-form">
				<div class="input"><i class="icon-append fa fa-clock-o"></i>
					<input type="text" class="form-control text-right <c:if test="${classValue != null}">${classValue}</c:if>"
							<c:if test="${idValue  != null }"> id="${id}"</c:if>
							<c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
							<c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
							<c:if test="${disabled == true}"> disabled</c:if>
							<c:if test="${required == true}"> required</c:if>
							<c:if test="${val != null }"> value="${val}"</c:if>
							<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
							<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
				</div>
			</div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'timeTerm')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="col-xs-12 col-md-6 cal_frt">
				<div class="smart-form">
					<div class="input"><i class="icon-append fa fa-clock-o"></i>
						<input type="text" class="form-control text-right <c:if test="${classValue != null}">${classValue}</c:if>"
								<c:if test="${startIdValue  != null }"> id="${startId}"</c:if>
								<c:if test="${startDtoValue != null }"> dtoParam="${startDto}"</c:if>
								<c:if test="${startNameValue != null }"> name="${startName}"</c:if>
								<c:if test="${disabled == true}"> disabled</c:if>
								<c:if test="${required == true}"> required</c:if>
								<c:if test="${startVal != null }"> value="${startVal}"</c:if>
								<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
								<c:if test="${startDataBind != null}"> data-bind="${startDataBind}"</c:if> />
					</div>
				</div>
			</div>
			<div class="col-xs-1 swung_dash">~</div>
			<div class="col-xs-12 col-md-6 cal_scd">
				<div class="smart-form">
					<div class="input"><i class="icon-append fa fa-clock-o"></i>
						<input type="text" class="form-control text-right <c:if test="${classValue != null}">${classValue}</c:if>"
								<c:if test="${endIdValue  != null }"> id="${endId}"</c:if>
								<c:if test="${endDtoValue != null }"> dtoParam="${endDto}"</c:if>
								<c:if test="${endNameValue != null }"> name="${endName}"</c:if>
								<c:if test="${disabled == true}"> disabled</c:if>
								<c:if test="${required == true}"> required</c:if>
								<c:if test="${endVal != null }"> value="${endVal}"</c:if>
								<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
								<c:if test="${endDataBind != null}"> data-bind="${endDataBind}"</c:if> />
					</div>
				</div>
			</div>
			<div style="clear: both;"></div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'datetime')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<input type="text" class="form-control text-right <c:if test="${classValue != null}">${classValue}</c:if>"
					<c:if test="${idValue  != null }"> id="${id}"</c:if>
					<c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
					<c:if test="${nameValue != null }"> name="${name}"</c:if>
					<c:if test="${disabled == true}"> disabled</c:if>
					<c:if test="${required == true}"> required</c:if>
					<c:if test="${endVal != null }"> value="${endVal}"</c:if>
					<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
					<c:if test="${endDataBind != null}"> data-bind="${endDataBind}"</c:if> />
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'textarea')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
	        <textarea<c:if test="${idValue != null }"> id="${id}"</c:if>
	            <c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
	            <c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
	            <c:if test="${readonly == true}"> readonly</c:if>
	            <c:if test="${disabled == true}"> disabled</c:if>
	            <c:if test="${required == true}"> required</c:if>
	            <c:if test="${classValue != null}"> class="${classValue}"</c:if>
	            <c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
	            <c:if test="${placeholderValue != null}"> placeholder="<c:if test="${nucValue == true}">${placeholderValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${placeholderValue}" /></c:if>"</c:if>
	            <c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
	            <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if>
	            <c:if test="${rows != null}"> rows="${rows}"</c:if>></textarea>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'search')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="input-group search-form <c:if test="${editableValue == true}">search_input_bg</c:if>">
				<c:if test="${hidIdValue != null}">
					<input type="hidden" id="${hidId}" <c:if test="${hidDtoValue != null}">dtoParam="${hidDto}"</c:if> />
				</c:if>
				<input type="text"
					<%-- <c:if test="${disabled == null}"> disabled="disabled"</c:if> --%>
					   disabled="disabled"
						<c:if test="${classValue != null}"> class="${classValue}"</c:if>
						<c:if test="${ids[0] != null}"> id="${ids[0]}"</c:if>
						<c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
						<c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
						<c:if test="${readonly == true}"> readonly</c:if>
						<c:if test="${required == true}"> required</c:if>
						<c:if test="${placeholderValue != null}"> placeholder="<c:if test="${nucValue == true}">${placeholderValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${placeholderValue}" /></c:if>"</c:if>
						<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if>
						<c:if test="${searchBlurEventValue != null}"> onblur="${searchBlurEventValue}(this)"</c:if>
						<c:if test="${searchEnterEventValue != null}"> onkeydown="if(event.keyCode != 13) return; ${searchEnterEventValue}(this)"</c:if> />
				<c:if test="${clearArgValues != null}">
					<span <c:if test="${objCode != null}">objCode="${objCode}"</c:if>style="cursor:pointer" class="input-group-addon clearBtn" onclick="$.ifvSearchClear(${clearArgs})">
						<a><i class="fa fa-times"></i></a>
					</span>
				</c:if>
				<span <c:if test="${ids[1] != null}">id="${ids[1]}"</c:if><c:if test="${objCode != null}">objCode="${objCode}"</c:if>style="cursor:pointer" class="input-group-addon" <c:if test="${btnFuncValue != null}">onclick="${btnFunc}()"</c:if> >
					<a <c:if test="${modalIdValue != null}"> data-toggle="modal" data-target="#${modalId}"</c:if>>
						<c:if test="${btnImgValue == null }">
							<c:if test="${iconValue == null }">
								<i class="fa fa-search"></i>
							</c:if>
							<c:if test="${iconValue != null }">
								<i class="fa fa-${icon}"></i>
							</c:if>
						</c:if>
						<c:if test="${btnImgValue != null }"><img src="${btnImg}"/></c:if>
					</a>
				</span>
			</div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'file')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="input-group">
				<input type="text" disabled="disabled"
					   class="form-control <c:if test='${classValue != null}'>${classValue}</c:if>"
					   <c:if test="${ids[0] != null}">id="${ids[0]}"</c:if>
						<c:if test="${required == true}"> required</c:if>
						<c:if test="${placeholderValue != null}"> placeholder="<c:if test="${nucValue == true}">${placeholderValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${placeholderValue}" /></c:if>"</c:if> />
				<form method="POST" enctype="multipart/form-data" <c:if test="${ids[1] != null}">id="${ids[1]}"</c:if>>
					<input type="file" style="display:none;"
						   <c:if test="${ids[2] != null}">id="${ids[2]}"</c:if>
							<c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
							<c:if test="${urlValue != null }"> data-url="${urlValue}"</c:if> />
				</form>
				<span class="input-group-addon" onclick="$('#${ids[2]}').click()">
					<a href='javascript:;'>
						<c:if test="${btnImgValue == null }"><i class="fa fa-search"></i></c:if>
						<c:if test="${btnImgValue != null }"><img src="${btnImg}"/></c:if>
					</a>
				</span>
				<c:if test="${progress != null}"><div class="file_progress_wrap"><div class="file_progress" id="${progress}"></div></div></c:if>
			</div>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'justify')}">
		<div class="btn-group btn-group-justified just_show" style="
		<c:if test="${widthValue != null }">width: ${width}%;</c:if>
		<c:if test="${widthValue == null }">width: 100%;</c:if> margin: 0 auto;">
			<c:forTokens var="textVals" varStatus="status" items="${textValue}" delims="|">
				<div class="btn btn-default title_div" >
					<c:if test="${nucValue == true}">${textVals}</c:if>
					<c:if test="${nucValue != true}"><spring:message code="${textVals}" /></c:if>
				</div>
				<div class="btn btn-default cont_div" id="${id}${status.count}"></div>
			</c:forTokens>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'phone')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<c:forTokens var="sizes" varStatus="status" items="${sizeValue}" delims="|">
				<input type="text" vali-type="number" class="tag_phone_size"
						<c:if test="${idValue != null }"> id="${ids[status.index]}"</c:if>
						<c:if test="${dtoValue != null}"> dtoParam="${dtos[status.index]}"</c:if>
						<c:if test="${readonly == true}"> readonly</c:if>
						<c:if test="${disabled == true}"> disabled</c:if>
						<c:if test="${required == true}"> required</c:if>
						<c:if test="${maxLength != null}"> maxLength="${maxLengths[status.index]}"</c:if>
						<c:if test="${sizeValue != null}"> size="${sizes}"</c:if> />
				<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
				<c:if test="${not status.last}">
					<c:choose>
						<c:when test="${signValue != null}">
							${signValue}
						</c:when>
						<c:otherwise>
							-
						</c:otherwise>
					</c:choose>
				</c:if>
			</c:forTokens>
			<c:if test="${descValue != null}"><br/><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
			</span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'tab')}">
		<div class="btn-group btn-group-justified"
				<c:if test="${idValue != null }"> id="${id}"</c:if>>
			<c:forTokens var="textVals" varStatus="status" items="${textValue}" delims="|">
				<a href="javascript:$.ifvChangeTabContent(${urlObjValue}.${tabIdValues[status.index]}, '${tabIdValues[status.index]}', '${id}', '${targetIdValue}');" class="btn btn-default" id="${tabIdValues[status.index]}">
					<c:if test="${nucValue == true}">${textVals}</c:if>
					<c:if test="${nucValue != true}"><spring:message code="${textVals}" /></c:if>
				</a>
			</c:forTokens>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'button')}">
		<button type ="button" class='btn btn-sm <c:if test="${classValue != null}">${classValue}</c:if>'
				<c:if test="${disabled == true}"> disabled</c:if>
				<c:if test="${idValue != null }"> id="${id}"</c:if>
				<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
				<c:if test="${btnFuncValue != null }">
					onclick="
					<c:choose>
						<c:when test="${fn:contains(btnFunc,'(')}">
							${btnFunc};
						</c:when>
						<c:otherwise>
							${btnFunc}();
						</c:otherwise>
					</c:choose>
					"

				</c:if>>
			<c:if test="${btnImgValue != null }"><img src="${btnImg}"/> </c:if>
			<c:if test="${btnTypeValue != null && btnTypeValue == 'save'}">
				<i class="glyphicon glyphicon-check"></i>
			</c:if>
			<c:if test="${btnTypeValue != null && btnTypeValue != 'save'}">
				<i class="fa fa-${btnType}"></i>
			</c:if>
			<c:if test="${nucValue == null}">
				<spring:message code="${textValue}" />
			</c:if>
			<c:if test="${nucValue != null && textValue != null}">
				${textValue}
			</c:if>
		</button>
	</c:when>

	<c:when test="${(typeValue == 'sideBtn')}">
		<div class="col-xs-${conClass}">
			<button class='btn btn-sm btn-side <c:if test="${classValue != null}">${classValue}</c:if>'
					<c:if test="${disabled == true}"> disabled</c:if>
					<c:if test="${idValue != null }"> id="${id}"</c:if>
					<c:if test="${btnFuncValue != null }"> onclick="${btnFunc}()"</c:if>>
				<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
				<c:if test="${nucValue == true}">${textValue}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${textValue}" /></c:if>
			</button>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'mainTitle')}">
		<div class="page-title">
			<h1>
				<spring:message code="${mainTextValue}"/>
				<c:if test="${subTextValue != null}" >
					<span>
						<c:forTokens var="subTextVals" varStatus="status" items="${subTextValue}" delims="|">
							&gt;
							<c:if test="${nucValue == true}">${subTextVals}</c:if>
							<c:if test="${nucValue != true}"><spring:message code="${subTextVals}" /></c:if>
						</c:forTokens>
					</span>
				</c:if>
			</h1>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'simpleImgUpload')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="thumbnail_wrap" id="${varNameValue}ImgCon">
				<img src="" id="${varNameValue}Img" width="${imgWidthValue}" height="${imgHeightValue}" onload="uploadBtnResize();"/>
				<form id="uploadFormPop" method="POST" enctype="multipart/form-data" style="float: left;">
					<input id="${varNameValue}FileBtn" type="file" name="file" data-url="${tempUploadValue}"/>
				</form>
				<img src="${defaultImageValue}" alt="" class="thumbnail_camera"/>
				<img id="${imgDeleteBtnIdValue}" hidden src="${imgDeleteBtnValue}" class="thumbnail_remove" onclick="${imgDeleteBtnFuncValue}()"/>
			</div>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'imgUpload')}">
		<script>
			var ${varNameValue};

			function ${varNameValue}Setting(){
				var _this = this;
				var tmpArr = new Array();
				for( var i = 0; i< ${maxCntValue}; i++ ){
					tmpArr.push({ index : i });
				}

				var template = $('#${varNameValue}Template').tmpl(tmpArr);
				$("#${varNameValue}Container").append(template);

				${varNameValue} = new ifvMultiUpLoader({
					container : $("#${varNameValue}Container"),
					uploadBtn : $('#${varNameValue}UploadPop'),
					tempUpLoadFormId : '${varNameValue}UploadFormPop',
					tempUploadBtnId : '${varNameValue}UploadPop',
					imgId : '${varNameValue}ImgPop',
					btnConId : '${varNameValue}PostPopPicBtns',
					imgContainerId : '${varNameValue}ImgContainerPop',
					rotationBtnId : '${varNameValue}ImgRotation',
					progressId : '${varNameValue}Progress',
					deleteBtnId : '${varNameValue}ImgDelPop',
					<c:if test="${useSortableValue != null}">useSortable : ${useSortableValue},</c:if>
					tempImgUrl : <c:choose>
							<c:when test="${tempImgUrlValue != null }">
							'${tempImgUrlValue}',
					</c:when>
					<c:otherwise>
					'',
					</c:otherwise>
					</c:choose>
					tempUploadIE : <c:choose>
							<c:when test="${tempUploadIEValue != null }">
							'${tempUploadIEValue}',
					</c:when>
					<c:otherwise>
					'',
					</c:otherwise>
					</c:choose>
					'category' : <c:choose>
							<c:when test="${categoryValue != null }">
							'${categoryValue}',
					</c:when>
					<c:otherwise>
					'',
					</c:otherwise>
					</c:choose>
					'maxNumber' : ${maxCntValue},
					'tempImgWidth' : ${imgWidthValue},
					'tempImgHeight' : ${imgHeightValue},
					errFunc : function(msg) {
						$.ifvErrorPop(ifv.validationMessage.imageCondition);
					}

				});
			};
		</script>
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="picture_area" id="${varNameValue}Container"></div>
			<c:if test="${descValue != null}"><span class="detail_txt">
			<c:if test="${nucValue == true}">${desc}</c:if>
			<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
		</span></c:if>
		</div>

		<script id="${varNameValue}Template" type="text/x-jquery-tmpl">
	<div id='${varNameValue}ImgContainerPop${S}{index}' class="image_box" seq='${S}{index}' isBind='false' RotateAngle='0' >
		<form id='${varNameValue}UploadFormPop${S}{index}' method="POST" enctype="multipart/form-data" style="float: left;">
			<input id="${varNameValue}UploadPop${S}{index}" type="file" name="file" data-url="${tempUploadValue}" onclick="javascript:${varNameValue}.clickEditImage(this);" title='<spring:message code="S02167"/>'>
		</form>
		<div class="btns" id="${varNameValue}PostPopPicBtns${S}{index}">
			<a id="${varNameValue}ImgRotation${S}{index}" href="javascript:;" onclick="javascript:${varNameValue}.rotationImage(this);" title='<spring:message code="S02168"/>'><img src='${imgRotationBtnValue}' class="btn_delete" /></a>
			<a id="${varNameValue}ImgDelPop${S}{index}" href="javascript:;" onclick="javascript:${varNameValue}.delImage(this);" title='<spring:message code="S02169"/>'><img src='${imgDeleteBtnValue}' class="btn_delete" /></a>
		</div>
		<img id='${varNameValue}ImgPop${S}{index}' width="${imgWidthValue}" height="${imgHeightValue}" src='' class="handle"/>
		<div class="upload_progress_container" id="${varNameValue}Progress${S}{index}"></div>
	</div>
	</script>
	</c:when>

	<c:when test="${(typeValue == 'htmlUpload')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<input type="text"
					<c:if test="${idValue  != null }"> id="${id}"</c:if>
					<c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
					<c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
					<c:if test="${readonly == true}"> readonly</c:if>
					<c:if test="${disabled == true}"> disabled</c:if>
					<c:if test="${required == true}"> required</c:if>
					<c:if test="${classValue != null}"> class="${classValue}"</c:if>
					<c:if test="${val != null }"> value="${val}"</c:if>
					<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
					<c:if test="${title != null }"> title="<c:if test="${nucValue == true}">${title}</c:if><c:if test="${nucValue != true}"><spring:message code="${title}" /></c:if>"</c:if>
			/>
			<c:if test="${hidIdValue != null}">
				<input type="hidden" id="${hidId}" <c:if test="${hidDtoValue != null}">dtoParam="${hidDto}"</c:if> style="display: none;"/>
			</c:if>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
		<a href="javascript:${funcNameValue}()" class="btn btn-sm btn_lightGray row_btn">
			<spring:message code="S06161"/>
		</a>

	</c:when>

	<c:when test="${(typeValue == 'password')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<input <c:if test="${typeValue != null }"> type="${typeValue}"</c:if>
					<c:if test="${typeValue == null }"> type="text"</c:if>
					<c:if test="${idValue  != null }"> id="${id}"</c:if>
					<c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
					<c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
					<c:if test="${readonly == true}"> readonly</c:if>
					<c:if test="${disabled == true}"> disabled</c:if>
					<c:if test="${required == true}"> required</c:if>
					<c:if test="${classValue != null}"> class="${classValue}"</c:if>
					<c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
					<c:if test="${minLength != null}"> minLength="${minLength}"</c:if>
					<c:if test="${val != null }"> value="${val}"</c:if>
					<c:if test="${title != null }"> title="<c:if test="${nucValue == true}">${title}</c:if><c:if test="${nucValue != true}"><spring:message code="${title}" /></c:if>"</c:if>
					vali-type="password"
					<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
					<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if>
					autocomplete="new-password"/>
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'emptyDiv')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}" <c:if test="${idValue != null }"> id="${id}"</c:if>>
		</div>
	</c:when>

	<c:when test="${(typeValue == 'onlyLabel')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}"
					<c:if test="${forIdValue != null }"> for="${forIdValue}"</c:if> >
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
	</c:when>

	<c:when test="${(typeValue == 'btnPopupClose')}">
		<button type="button" class="close"
				<c:if test="${btnFuncValue != null }"> onclick="${btnFuncValue}()" </c:if>
				<c:if test="${btnFuncValue == null }"> onclick="$.modalClose()" </c:if>
				<c:if test="${idValue == null }"> id="${id}" </c:if>
				data-dismiss="modal" aria-hidden="true">&times;</button>
	</c:when>

	<c:when test="${(typeValue == 'sideText')}">
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<div class="col-sm-${sideClassValue}">
				<input type="text"
						<c:if test="${idValue  != null}"> id="${id}"</c:if>
						<c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
						<c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
						<c:if test="${readonly == true}"> readonly</c:if>
						<c:if test="${disabled == true}"> disabled</c:if>
						<c:if test="${required == true}"> required</c:if>
						<c:if test="${checked == true}"> checked</c:if>
						<c:if test="${classValue != null}"> class="${classValue}"</c:if>
						<c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
						<c:if test="${minLength != null}"> minLength="${minLength}"</c:if>
						<c:if test="${val != null}"> value="${val}"</c:if>
						<c:if test="${title != null}"> title="<c:if test="${nucValue == true}">${title}</c:if><c:if test="${nucValue != true}"><spring:message code="${title}" /></c:if>"</c:if>
						<c:if test="${placeholderValue != null}"> placeholder="<c:if test="${nucValue == true}">${placeholderValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${placeholderValue}" /></c:if>"</c:if>
						<c:if test="${valiItemValue != null}"> vali-type="${valiItemValue}"</c:if>
						<c:if test="${minNumValue != null}"> min="${minNumValue}"</c:if>
						<c:if test="${maxNumValue != null}"> max="${maxNumValue}"</c:if>
						<c:if test="${valiItemValue == 'number' || valiItemValue == 'float' || valiItemValue == 'lat' || valiItemValue == 'lng' }"> style="ime-mode: disabled;"</c:if>
						<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
						<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
				<c:if test="${descValue != null}"><span class="detail_txt">
       				<c:if test="${nucValue == true}">${desc}</c:if>
					<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
		        </span></c:if>
			</div>
			<span class="sub"><c:if test="${nucValue == true}">${sideTextValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${sideTextValue}" /></c:if></span>
		</div>
	</c:when>
	<c:when test="${(typeValue == 'hidden')}">
		<input type="hidden"
				<c:if test="${idValue  != null}"> id="${id}"</c:if>
				<c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
				<c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
				<c:if test="${readonly == true}"> readonly</c:if>
				<c:if test="${disabled == true}"> disabled</c:if>
				<c:if test="${required == true}"> required</c:if>
				<c:if test="${checked == true}"> checked</c:if>
				<c:if test="${classValue != null}"> class="${classValue}"</c:if>
				<c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
				<c:if test="${minLength != null}"> minLength="${minLength}"</c:if>
				<c:if test="${val != null}"> value="${val}"</c:if>
				<c:if test="${title != null}"> title="<c:if test="${nucValue == true}">${title}</c:if><c:if test="${nucValue != true}"><spring:message code="${title}" /></c:if>"</c:if>
				<c:if test="${placeholderValue != null}"> placeholder="<c:if test="${nucValue == true}">${placeholderValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${placeholderValue}" /></c:if>"</c:if>
				<c:if test="${valiItemValue != null}"> vali-type="${valiItemValue}"</c:if>
				<c:if test="${minNumValue != null}"> min="${minNumValue}"</c:if>
				<c:if test="${maxNumValue != null}"> max="${maxNumValue}"</c:if>
				<c:if test="${valiItemValue == 'number' || valiItemValue == 'float' || valiItemValue == 'lat' || valiItemValue == 'lng' }"> style="ime-mode: disabled;"</c:if>
				<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
	</c:when>

	<c:otherwise>
		<c:if test="${labelValue != null }">
			<label class="control-label col-xs-${labelClass}">
				<c:if test="${required == true}"><span class="asterisk">*</span></c:if>
				<c:if test="${nucValue == true}">${label}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${label}" /></c:if>
			</label>
		</c:if>
		<div class="control_content col-xs-${conClass}">
			<input <c:if test="${typeValue != null}"> type="${typeValue}"</c:if>
					<c:if test="${typeValue == null}"> type="text"</c:if>
					<c:if test="${idValue  != null}"> id="${id}"</c:if>
					<c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
					<c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
					<c:if test="${readonly == true}"> readonly</c:if>
					<c:if test="${disabled == true}"> disabled</c:if>
					<c:if test="${required == true}"> required</c:if>
					<c:if test="${checked == true}"> checked</c:if>
					<c:if test="${classValue != null}"> class="${classValue}"</c:if>
					<c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
					<c:if test="${minLength != null}"> minLength="${minLength}"</c:if>
					<c:if test="${val != null}"> value="${val}"</c:if>
					<c:if test="${title != null}"> title="<c:if test="${nucValue == true}">${title}</c:if><c:if test="${nucValue != true}"><spring:message code="${title}" /></c:if>"</c:if>
					<c:if test="${placeholderValue != null}"> placeholder="<c:if test="${nucValue == true}">${placeholderValue}</c:if><c:if test="${nucValue != true}"><spring:message code="${placeholderValue}" /></c:if>"</c:if>
					<c:if test="${valiItemValue != null}"> vali-type="${valiItemValue}"</c:if>
					<c:if test="${minNumValue != null}"> min="${minNumValue}"</c:if>
					<c:if test="${maxNumValue != null}"> max="${maxNumValue}"</c:if>
					<c:if test="${valiItemValue == 'number' || valiItemValue == 'float' || valiItemValue == 'lat' || valiItemValue == 'lng' }"> style="ime-mode: disabled;"</c:if>
					<c:if test="${objCode != null}"> objCode="${objCode}"</c:if>
					<c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
			<c:if test="${descValue != null}"><span class="detail_txt">
				<c:if test="${nucValue == true}">${desc}</c:if>
				<c:if test="${nucValue != true}"><spring:message code="${desc}" /></c:if>
	        </span></c:if>
		</div>
	</c:otherwise>
</c:choose>