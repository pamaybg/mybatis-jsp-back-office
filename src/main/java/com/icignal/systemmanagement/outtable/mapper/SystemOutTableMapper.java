package com.icignal.systemmanagement.outtable.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.response.StatusResDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemColTypeReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteColConChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemDeleteTvlConTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemEditOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetChannelListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetChannelRelListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetDetailOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetEmailHostListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetFtpConnectListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutColumnListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutTableListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetOutTgtLvllListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetPermissionListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemGetWebServiceListReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetChnlRelReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutColumnReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutTableReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemSetOutTgtLvlReqDto;
import com.icignal.systemmanagement.outtable.dto.request.SystemTableTypeCheckReqDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetChannelListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetChannelRelListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutColumnlResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutTalbleResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetDetailOutTgtLvllResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetEmailHostListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetFtpConnectListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutColumnListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutTalbleListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetOutTgtLvllListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetPermissionListResDto;
import com.icignal.systemmanagement.outtable.dto.response.SystemGetWebServiceListResDto;

/*
 * 1. 클래스명	: SystemOutTableMapper
 * 2. 파일명	: SystemOutTableMapper.java
 * 3. 패키지명	: com.icignal.systemmanagement.outtable.mapper
 * 4. 작성자명	: 박지열
 * 5. 작성일자	: 
 */
/**
 * <PRE>
 * 1. 설명
 *		시스템운영 - 외부 테이블 관리 Mapper
 * </PRE>
 */ 
@Mapper
public interface SystemOutTableMapper {

	List<SystemGetPermissionListResDto> selectpermissionList(SystemGetPermissionListReqDto met);

	List<SystemGetChannelRelListResDto> selectchannelrel(SystemGetChannelRelListReqDto met);

	List<SystemGetChannelListResDto> selectchannel(SystemGetChannelListReqDto met);

	List<SystemGetOutColumnListResDto> selectcolumnList(SystemGetOutColumnListReqDto met);

	List<SystemGetOutTgtLvllListResDto> selectTgtLevelList(SystemGetOutTgtLvllListReqDto met);

	List<SystemGetOutTalbleListResDto> selectTableList(SystemGetOutTableListReqDto met);

	void insertTgtLevel(SystemSetOutTgtLvlReqDto x);

	Integer insertTable(SystemSetOutTableReqDto met);

	Integer insertColumn(SystemSetOutColumnReqDto x);

	SystemGetDetailOutColumnlResDto selectDtlColumn(SystemGetDetailOutColumnReqDto met);

	SystemGetDetailOutTalbleResDto selectDtlTable(SystemGetDetailOutTableReqDto met);

	SystemGetDetailOutTgtLvllResDto selectDtlTgtLevel(SystemGetDetailOutTgtLvlReqDto met);

	void deleteTable(SystemDeleteOutTableReqDto mdtl);

	void deleteColumn(SystemDeleteOutColumnReqDto mdtl);

	List<String> getDbinfromSecretNms(List<String> targetLevelId);

	void deleteTgtLevel(SystemDeleteOutTgtLvlReqDto mdtl);

	void updateTgtLevel(SystemEditOutTgtLvlReqDto x);

	void updateColumn(SystemEditOutColumnReqDto mdtl);

	void updateTable(SystemEditOutTableReqDto mdtl);

	Integer insertChnlRel(SystemSetChnlRelReqDto mscr);

	void deleteChnlRel(SystemDeleteChnlRelReqDto mdcl);

	String selectTblTypeChk(SystemTableTypeCheckReqDto mdtl);

	String selectColTypeChk(SystemColTypeReqDto mdtl);

	void deleteTvlConTable(SystemDeleteTvlConTableReqDto mdtl);

//	void deleteTblConCol(SystemDeleteTblConColReqDto mdtl);

	void deleteColConChnlRel(SystemDeleteColConChnlRelReqDto mdtl);

	List<SystemGetFtpConnectListResDto> getFtpConnect(SystemGetFtpConnectListReqDto met);

	void setFtpConnect(SystemGetFtpConnectListReqDto mor);

	void editFtpConnect(SystemGetFtpConnectListReqDto mor);

	void removeFtpConnect(SystemGetFtpConnectListReqDto mor);

	List<String> getDbInfromServiceNms(List<String> mdtl);

	 /*
	  * 1. 메소드명: selectEmailHost
	  * 2. 클래스명: SystemOutTableMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param met
	 *   @return	
	 */
	
	List<SystemGetEmailHostListResDto> selectEmailHost(SystemGetEmailHostListReqDto met);

	 /*
	  * 1. 메소드명: selectDetailEmailHost
	  * 2. 클래스명: SystemOutTableMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor
	 *   @return	
	 */
	
	SystemGetEmailHostListResDto selectDetailEmailHost(SystemGetEmailHostListReqDto mor);

	 /*
	  * 1. 메소드명: insertEmailHost
	  * 2. 클래스명: SystemOutTableMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor	
	 */
	
	void insertEmailHost(SystemGetEmailHostListReqDto mor);

	 /*
	  * 1. 메소드명: updateEmailHost
	  * 2. 클래스명: SystemOutTableMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor	
	 */
	
	void updateEmailHost(SystemGetEmailHostListReqDto mor);

	 /*
	  * 1. 메소드명: deleteEmailHost
	  * 2. 클래스명: SystemOutTableMapper
	  * 3. 작성자명: iticd 
	  * 4. 작성일자: 2020. 8. 31.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param mor	
	 */
	
	void deleteEmailHost(SystemGetEmailHostListReqDto mor);

	 /*
	  * 1. 메소드명: getwebService
	  * 2. 클래스명: SystemOutTableMapper
	  * 3. 작성자명: LEE GYEONG YOUNG 
	  * 4. 작성일자: 2020. 12. 08.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param met
	 *   @return	
	 */
	
	List<SystemGetWebServiceListResDto> getwebService(SystemGetWebServiceListReqDto met);
	
	SystemGetWebServiceListResDto getwebServiceDetailPop(SystemGetWebServiceListReqDto met);
	
	void insertWebService(SystemGetWebServiceListReqDto met);
	
	void updateWebService(SystemGetWebServiceListReqDto met);
	
	void deleteWebService(SystemGetWebServiceListReqDto met);
	
}
