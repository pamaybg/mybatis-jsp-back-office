package com.icignal.loyalty.club.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.common.base.dto.response.LoyMbrListPopResDto;
import com.icignal.loyalty.club.dto.request.LoyClubAttrDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubListReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubMbrDetailReqDto;
import com.icignal.loyalty.club.dto.request.LoyClubOfferDetailReqDto;
import com.icignal.loyalty.club.dto.response.LoyClubAttrListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubDetailResDto;
import com.icignal.loyalty.club.dto.response.LoyClubListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubMbrAttrDetailResDto;
import com.icignal.loyalty.club.dto.response.LoyClubMbrListResDto;
import com.icignal.loyalty.club.dto.response.LoyClubOfferListResDto;

/*
 * 1. 클래스명	: LoyClubMasterMapper
 * 2. 파일명	: LoyClubMapper.java
 * 3. 패키지명	: com.icignal.loyalty.club.mapper
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 5. 13.
 */
/**
 * <PRE>
 * 1. 설명
 *		멤버십 클럽 - Mapper
 * </PRE>
 */ 
@Mapper
public interface LoyClubMasterMapper {

	 /*
	  * 1. 메소드명: selectClubList
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 13.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubListResDto> selectClubList(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubAttrList
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		
	 * 2. 사용법
	 *		클럽 속성 리스트
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubAttrListResDto> selectClubAttrList(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyClubDetailResDto selectClubDetail(LoyClubDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: insertClubDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 15.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void insertClubDetail(LoyClubDetailReqDto reqDto);
	
	 /*
	  * 1. 메소드명: updateClubDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	void updateClubDetail(LoyClubDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteClub
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 삭제  (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteClub(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubAttrDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyClubDetailResDto selectClubAttrDetail(LoyClubAttrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: insertClubAttrDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertClubAttrDetail(LoyClubAttrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateClubAttrDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateClubAttrDetail(LoyClubAttrDetailReqDto reqDto);
	
	 /*
	  * 1. 메소드명: deleteClubAttr
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 속성 정보 삭제 (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteClubAttr(LoyClubAttrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubOfferList
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 18.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 혜택 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubOfferListResDto> selectClubOfferList(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: insertClubOfferDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오펴 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertClubOfferDetail(LoyClubOfferDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateClubOfferDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateClubOfferDetail(LoyClubOfferDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteClubOffer
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼 삭제 (FLAG = 0)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteClubOffer(LoyClubOfferDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubOfferDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 오퍼(혜택)상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyClubDetailResDto selectClubOfferDetail(LoyClubOfferDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubMbrList
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 19.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubMbrListResDto> selectClubMbrList(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubAttrInMbr
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 20.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 -> 속성정보 가져오기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubAttrListResDto> selectClubAttrInMbr(LoyClubListReqDto reqDto);
	
	 /*
	  * 1. 메소드명: insertClubMbrDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertClubMbr(LoyClubMbrDetailReqDto reqDto);
	void insertClubMbrAttrDetail(LoyClubMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateClubMbrDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateClubMbrDetail(LoyClubMbrDetailReqDto reqDto);
	
	void mergeClubMbrDetail(LoyClubMbrDetailReqDto reqDto);
	
	 /*
	  * 1. 메소드명: selectFileValue
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 증빙서류 업데이트시 기존의 파일의 정보를 가져와 삭제해주기
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	Integer selectFileValueCnt(LoyClubMbrDetailReqDto reqDto);
	LoyClubDetailResDto selectFileValue(LoyClubMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectClubMbrDetail
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 22.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 상세(속성값 가져와서 뿌려주기)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyClubMbrAttrDetailResDto> selectClubMbrDetail(LoyClubMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: clearMaskClubMbr
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 리스트 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyMbrListPopResDto clearMaskClubMbr(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: apprClubMbr
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 - 승인(상태 STAT_CD : A)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void apprClubMbr(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: saveResnRgst
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 26.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 (반려, 탈뢰)사유 등록
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void saveResnRgst(LoyClubListReqDto reqDto);

	 /*
	  * 1. 메소드명: validChekFile
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 5. 27.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		동일 파일명 체크(추후 개발필요)
	 *		개선안	 -> 1. 파일명을 uuid or sessionId or 시분초를 붙여 새로운 이름으로 파일생성하고 저장
	 *				 -> 2. client 에게 보여줄 실제 파일명과 서버(db) 에서 사용될 uuid를 사용하여 제어하기
	 *		정도로 생각이 됩니다.
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	int validChekFile(LoyClubMbrDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateLogicalFileName
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		로직컬 파일 이름 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param fileName
	 *   @param clubMbrRid
	 *   @param ridAttr	
	 */
	void updateLogicalFileName(String fileName, String clubMbrRid, String ridAttr);

	 /*
	  * 1. 메소드명: selectClubMbrValidCheck
	  * 2. 클래스명: LoyClubMasterMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		클럽 회원 가입 여부 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer selectClubMbrValidCheck(LoyClubMbrDetailReqDto reqDto);



	
	 /*
	  * 1. 메소드명: selectMbrListPop
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 리스트 팝업
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyMbrListPopResDto> selectClubMbrListPop(LoyClubListReqDto reqDto);
	
	 /*
	  * 1. 메소드명: clearMaskMbrNew
	  * 2. 클래스명: CommonViewMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		회원 팝업 마스킹 해제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyMbrListPopResDto clearMaskMbrNew(LoyClubListReqDto reqDto);


}
