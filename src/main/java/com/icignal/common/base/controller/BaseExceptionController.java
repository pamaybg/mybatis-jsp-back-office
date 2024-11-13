 /*
  * Copyright 2016-2020 by Quintet Systems Corp.,
  * All rights reserved.
  *
  * This software is the confidential and proprietary information
  * of Quintet Systems Corp.
  */

package com.icignal.common.base.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import com.icignal.core.exception.*;
import org.springframework.dao.DataAccessException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.icignal.auth.exception.LoginWrongUserInfoException;
import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.common.helper.ErrorHelper;
import com.icignal.common.util.LogUtil;

/**
 * 1. FileName	: CommonExcptionController.java
 * 2. Package	: com.icignal.common.controller
 * 3. Comments	:	
 * 4. Author	: knlee
 * 5. DateTime	: 2020. 2. 25. 오전 10:18:53
 * 6. History	:

 * -----------------------------------------------------------------

 *	Date		 |	Name			|	Comment

 * -------------  -----------------   ------------------------------

 * 2020. 2. 25.		 | knlee			|	최초작성

 * -----------------------------------------------------------------

 */

/*
 * 1. 클래스명	: CommonExcptionController
 * 2. 파일명	: CommonExcptionController.java
 * 3. 패키지명	: com.icignal.common.controller
 * 4. 작성자명	: knlee
 * 5. 작성일자	: 2020. 2. 25.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */

public class BaseExceptionController {
	
	@ExceptionHandler(DataAccessException.class)
	@ResponseBody
	public StatusResDto DataAccessException(HttpServletRequest request, DataAccessException e) throws IOException {
		LogUtil.error(e);
		LogUtil.error("DataAccessException(Controller) : " + e.getMessage(), e);
		return new StatusResDto(false, ErrorHelper.DATA_UNHANDLED, ErrorHelper.MSG_1004);
	}

	@ExceptionHandler(DataSQLException.class)
	@ResponseBody
	public StatusResDto DATASQLException(HttpServletRequest request, DataSQLException e) throws IOException {

		LogUtil.error("SQLException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		LogUtil.error(e);
		return new StatusResDto(false, ErrorHelper.DATA_UNHANDLED, ErrorHelper.MSG_1004);
	}

	@ExceptionHandler(DataIOException.class)
	@ResponseBody
	public StatusResDto DataIOException(HttpServletRequest request, DataIOException e) throws IOException {

		LogUtil.error("DataIOException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		LogUtil.error(e);
		return new StatusResDto(false, ErrorHelper.DATA_UNHANDLED, ErrorHelper.MSG_1004);
	}

	@ExceptionHandler(SQLException.class)
	@ResponseBody
	public StatusResDto SQLException(HttpServletRequest request, SQLException e) throws IOException {
		LogUtil.error(e);
		LogUtil.error("SQLException(Controller) : " + e.getMessage());
		return new StatusResDto(false, ErrorHelper.DATA_UNHANDLED, ErrorHelper.MSG_1004);
	}

	@ExceptionHandler(DataBadRequestException.class)
	@ResponseBody
	public StatusResDto DataBadRequestException(HttpServletRequest request, DataBadRequestException e) throws IOException {

		LogUtil.error("DataBadRequestException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		LogUtil.error(e);
		return new StatusResDto(false, ErrorHelper.DATA_BAD_REQUEST, e.getBaseMessage() == null ? "" : e.getBaseMessage());
	}

	@ExceptionHandler(DataNotPermissionException.class)
	@ResponseBody
	public StatusResDto DataNotPermissionException(HttpServletRequest request, DataNotPermissionException e) throws IOException {
		LogUtil.error(e);
		LogUtil.error("DataNotPermissionException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.DATA_NOT_PERMISSION, e.getBaseMessage() == null ? "" : e.getBaseMessage());
	}

	@ExceptionHandler(DataUnauthrizedException.class)
	@ResponseBody
	public StatusResDto DataUnauthrizedException(HttpServletRequest request, DataUnauthrizedException e) throws IOException {
		LogUtil.debug("DataUnauthrizedException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.DATA_UNAUTHORIZED, e.getBaseMessage() == null ? "" : e.getBaseMessage());
	}

	@ExceptionHandler(DataUnhandledException.class)
	@ResponseBody
	public StatusResDto DataUnhandledException(HttpServletRequest request, DataUnhandledException e) throws IOException {
		LogUtil.error(e);
		LogUtil.error("DataUnhandledException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.DATA_UNHANDLED, e.getBaseMessage() == null ? ErrorHelper.MSG_1004 : e.getBaseMessage());
	}

	@ExceptionHandler(DataDuplicationException.class)
	@ResponseBody
	public StatusResDto DataDuplicationException(HttpServletRequest request, DataDuplicationException e) throws IOException {
		LogUtil.error(e);
		LogUtil.debug("DataDuplicationException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(true, ErrorHelper.DATA_DUPLICATION, e.getBaseMessage() == null ? ErrorHelper.MSG_1004 : e.getBaseMessage());
	}

	@ExceptionHandler(DataFailException.class)
	@ResponseBody
	public StatusResDto DataFailException(HttpServletRequest request, DataFailException e) throws IOException {
		LogUtil.error(e);
		//TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		LogUtil.error("DataFailException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.DATA_FAIL, e.getBaseMessage() == null ? "" : e.getBaseMessage());
	}

	@ExceptionHandler(DataForbiddenException.class)
	@ResponseBody
	public StatusResDto DataForbiddenException(HttpServletRequest request, DataForbiddenException e) throws IOException {
		LogUtil.error(e);
		LogUtil.error("DataForbiddenException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.DATA_FORBIDDEN, e.getBaseMessage() == null ? "" : e.getBaseMessage());
	}

	@ExceptionHandler(DataBanWordRequestException.class)
	@ResponseBody
	public StatusResDto DataBanWordRequestException(HttpServletRequest request, DataBanWordRequestException e) throws IOException {
		LogUtil.debug("DataBanWordRequestException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.DATA_BAN_WORD_REQUEST, e.getBaseMessage() == null ? "" : e.getBaseMessage());
	}

	@ExceptionHandler(LoginWrongUserInfoException.class)
	@ResponseBody
	public StatusResDto LoginWrongUserInfoException(HttpServletRequest request, LoginWrongUserInfoException e) throws IOException {
		LogUtil.info("LoginWrongUserInfoException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.LOGIN_WRONG_USER_INFO, e.getBaseMessage() == null ? ErrorHelper.MSG_1004 : e.getBaseMessage());
	}

	@ExceptionHandler(BenefitValidationException.class)
	@ResponseBody
	public StatusResDto BenefitValidationException(HttpServletRequest request, BenefitValidationException e) throws IOException {
		LogUtil.info("BenefitValidationException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());
		return new StatusResDto(false, ErrorHelper.BENEFIT_VALIDATION, e.getBaseMessage() == null ? ErrorHelper.MSG_1004 : e.getBaseMessage());
	}

	@ExceptionHandler(DataSQLNonPopException.class)
	@ResponseBody
	public StatusResDto DataSQLNonPopException(HttpServletRequest request, DataSQLNonPopException e) throws IOException {

		LogUtil.info("BenefitValidationException(Controller) : " + e.getBaseMessage() == null ? e.getMessage() : e.getBaseMessage());

		return new StatusResDto(false, ErrorHelper.DATA_UNHANDLED, ErrorHelper.MSG_1004);
	}


}

