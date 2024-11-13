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
<%@ attribute name="maxLength"      required="false" type="java.lang.Integer" %>
<%@ attribute name="minLength"      required="false" type="java.lang.Integer" %>
<%@ attribute name="rows"      required="false" type="java.lang.Integer" %>
<%-- 하단에 표시된 변수는 type이 [select || checkbox || radio] 일 경우에만 사용됨. --%>
<%@ attribute name="text"       required="false" type="java.lang.String" %>
<%@ attribute name="values"     required="false" type="java.lang.String" %>
<%@ attribute name="className"      required="false" type="java.lang.String" %>
<%@ attribute name="checkIndex" required="false" type="java.lang.Integer" %>
<%@ attribute name="title" required="false" type="java.lang.String" %>
<%@ attribute name="autoCompleted" required="false" type="java.lang.String" %>
<%@ attribute name="valOpt" required="false" type="java.lang.String" %>

<%@ attribute name="dataBind" required="false" type="java.lang.String" %>

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
checkIndex  = {int} - radio버튼에 defulat 체크 index값.
maxLength   = {Integer} - 최대 글자수
minLength   = {Integer} - 최소 글자수  
className   = {String} - 별도의 클래스 선언시.
title   	= {String} - title이 필요한 경우(


ex) radioType
<ifvm:input type="radio" names="targetMethod" checkIndex="1" text="beacon.common.product.productExposure.exposureProduct|beacon.common.product.productExposure.notExposureProduct" values="Y|N" />
--%>

<c:set var="valOpt"  value="${valOpt}"/>
<c:set var="typeValue"  value="${type}"/>
<c:set var="idValue"    value="${id}"/>
<c:set var="dtoValue"   value="${dto}"/>
<c:set var="nameValue"  value="${names}"/>
<c:set var="readonly"   value="${readonly}"/>
<c:set var="disabled"   value="${disabled}"/>
<c:set var="required"   value="${required}"/>
<c:set var="checked"   value="${checked}"/>
<c:set var="valiItemValue" value="${valiItem}"/>
<c:set var="textValue" value="${text}"/>
<c:set var="placeholderValue" value="${placeholder}"/>
<c:set var="checkIdx" value="${checkIndex}" />
<c:set var="val" value="${values}" />
<c:set var="vals" value="${fn:split(val,'|')}" />
<c:set var="maxLength" value="${maxLength}" />
<c:set var="minLength" value="${minLength}" />
<c:set var="rows" value="${rows}" />
<c:set var="classValue" value="${className}" />
<c:set var="title" value="${title}" />
<c:set var="autoCompleted" value="${autoCompleted}" />
<c:choose>
    <c:when test="${typeValue=='select'}">
        <select<c:if test="${idValue != null }"> id="${id}"</c:if>
            <c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
            <c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
            <c:if test="${readonly != null}"> readonly</c:if>
            <c:if test="${disabled != null}"> disabled</c:if>
            <c:if test="${required != null}"> required</c:if>
            <c:if test="${classValue != null}"> class="${classValue}"</c:if>
            <c:if test="${title != null }"> title="${title}"</c:if>            
            <c:if test="${( valiItemValue == 'email') || ( valiItemValue == 'password') || ( valiItemValue == 'passwordConfirm') || ( valiItemValue == 'phone') || ( valiItemValue == 'url') || ( valiItemValue == 'kor') || ( valiItemValue == 'eng') || ( valiItemValue == 'number') || ( valiItemValue == 'exceptHangul')}">
             vali-type="${valiItemValue}"</c:if>
            <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if>>
            <c:forTokens var="textVals" varStatus="status" items="${textValue}" delims="|">
            <option <c:if test="${vals[status.index] != '' && vals[status.index] != null }"> value="${vals[status.index]}"</c:if>
                <c:if test="${vals[status.index] == '' || vals[status.index] == null}">value="${status.count}"</c:if>
                <c:if test="${(checkIdx != null) && (checkIdx == status.count)}"> selected</c:if>><spring:message code="${textVals}" /></option>
            </c:forTokens>
        </select>
    </c:when>
    <c:when test="${(typeValue == 'checkboxType') || (typeValue == 'radioType')}">
        <c:forTokens var="textVals" varStatus="status" items="${textValue}" delims="|">
        <span class="i${typeValue}">
            <label for="${id}${status.count}" <c:if test="${classValue != null}"> class="${classValue}"</c:if>>
            	
                <input <c:if test="${typeValue == 'checkboxType' }"> type="checkbox"</c:if>
                <c:if test="${typeValue == 'radioType' }"> type="radio"</c:if>
                
                <c:if test="${idValue  != null }"> id="${id}${status.count}"</c:if>
                <c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
                <c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
                <c:if test="${readonly != null}"> readonly</c:if>
                <c:if test="${disabled != null}"> disabled</c:if>
                <c:if test="${required != null}"> required</c:if>
    	        <c:if test="${title != null }"> title="${title}"</c:if>                
                <c:if test="${( valiItemValue == 'email') || ( valiItemValue == 'password') || ( valiItemValue == 'passwordConfirm') || ( valiItemValue == 'phone') || ( valiItemValue == 'url') || ( valiItemValue == 'kor') || ( valiItemValue == 'eng') || ( valiItemValue == 'number') || ( valiItemValue == 'exceptHangul')}">
                vali-type="${valiItemValue}"
                </c:if>
                <c:if test="${vals[status.index] != '' && vals[status.index] != null }"> value="${vals[status.index]}"</c:if>
                <c:if test="${vals[status.index] == '' || vals[status.index] == null}"> value="${status.count}"</c:if>
                <c:if test="${(typeValue == 'radioType') && (checkIdx != null) && (checkIdx == status.count)}"> checked</c:if> 
                <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> /> <spring:message code="${textVals}" />
            </label>
        </span>
        </c:forTokens>
    </c:when>
    <c:when test="${(typeValue == 'date')}">
        <div class="smart-form">
            <div class="input"><i class="icon-append fa fa-calendar"></i>
                <input type="text" class="datepicker text-right" data-dateformat='yy-mm-dd'
                <c:if test="${idValue  != null }"> id="${id}"</c:if>
                <c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
                <c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
                <c:if test="${readonly != null}"> readonly</c:if>
                <c:if test="${disabled != null}"> disabled</c:if>
                <c:if test="${required != null}"> required</c:if>
                <c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
                <c:if test="${minLength != null}"> minLength="${minLength}"</c:if> 
            	<c:if test="${title != null }"> title="${title}"</c:if>
            	<c:if test="${val != null }"> value="${val}"</c:if>
                <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> 
                />
            </div>
        </div>
    </c:when>
    <c:when test="${(typeValue == 'textarea')}">
        <textarea<c:if test="${idValue != null }"> id="${id}"</c:if>
            <c:if test="${dtoValue != null}"> dtoParam="${dto}"</c:if>
            <c:if test="${nameValue != null}"> name="${nameValue}"</c:if>
            <c:if test="${readonly != null}"> readonly</c:if>
            <c:if test="${disabled != null}"> disabled</c:if>
            <c:if test="${required != null}"> required</c:if>
            <c:if test="${classValue != null}"> class="${classValue}"</c:if>
            <c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
            <c:if test="${minLength != null}"> minLength="${minLength}"</c:if>
            <c:if test="${title != null }"> title="${title}"</c:if>            
            <c:if test="${placeholderValue != null}"> placeholder="<spring:message code='${placeholderValue}'/>"</c:if>
            <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if>
            <c:if test="${rows != null}"> rows="${rows}"</c:if>></textarea>
    </c:when>
    <c:otherwise>
        <input <c:if test="${typeValue != null }"> type="${typeValue}"</c:if>
            <c:if test="${typeValue == null }"> type="text"</c:if>
            <c:if test="${idValue  != null }"> id="${id}"</c:if>
            <c:if test="${dtoValue != null }"> dtoParam="${dto}"</c:if>
            <c:if test="${nameValue != null }"> name="${nameValue}"</c:if>
            <c:if test="${readonly != null}"> readonly</c:if>
            <c:if test="${disabled != null}"> disabled</c:if>
            <c:if test="${required != null}"> required</c:if>
            <c:if test="${checked != null}"> checked</c:if>
            <c:if test="${autoCompleted != null}"> autocomplete="new-password"</c:if>
            <c:if test="${classValue != null}"> class="${classValue}"</c:if>
            <c:if test="${maxLength != null}"> maxLength="${maxLength}"</c:if>
            <c:if test="${minLength != null}"> minLength="${minLength}"</c:if>
            <c:if test="${val != null }"> value="${val}"</c:if>
            <c:if test="${title != null }"> title="${title}"</c:if>            
            <c:if test="${placeholderValue != null}"> placeholder="<spring:message code='${placeholderValue}'/>"</c:if>
            <c:if test="${( valiItemValue == 'email') || ( valiItemValue == 'password') || ( valiItemValue == 'passwordConfirm') || ( valiItemValue == 'phone') || ( valiItemValue == 'url') || ( valiItemValue == 'kor') || ( valiItemValue == 'eng') || ( valiItemValue == 'number') || ( valiItemValue == 'exceptHangul')}">
            vali-type="${valiItemValue}"
            </c:if> 
            <c:if test="${valOpt != null}"> val-opt="${valOpt}"</c:if>
            <c:if test="${dataBind != null}"> data-bind="${dataBind}"</c:if> />
    </c:otherwise>
</c:choose>