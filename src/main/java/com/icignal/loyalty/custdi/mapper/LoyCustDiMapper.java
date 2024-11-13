package com.icignal.loyalty.custdi.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.loyalty.custdi.dto.request.LoyCustDiDetailReqDto;
import com.icignal.loyalty.custdi.dto.request.LoyCustDiListReqDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiDetailResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiListResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDiValListResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDupRstDetailResDto;
import com.icignal.loyalty.custdi.dto.response.LoyCustDupRstResDto;

@Mapper
public interface LoyCustDiMapper {

	 /*
	  * 1. 메소드명: selectCustDiList
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 2.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 식별 관리 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyCustDiListResDto> selectCustDiList(LoyCustDiListReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustDiDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyCustDiDetailResDto selectCustDiDetail(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustDiValList
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 3.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 식별값 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyCustDiValListResDto> selectCustDiValList(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: insertCustDiDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertCustDiDetail(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateCustDiDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복룰 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateCustDiDetail(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: getCustDiValDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	LoyCustDiDetailResDto selectCustDiValDetail(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: insertCustDiValDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세 저장
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void insertCustDiValDetail(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: updateCustDiValDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 4.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 상세 수정
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void updateCustDiValDetail(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectCustDupRstList
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복 결과 리스트
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyCustDupRstResDto> selectCustDupRstList(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteCustDiVal
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 5.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteCustDiVal(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: fieldValCheck
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		식별값 중복 체크
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	Integer fieldValCheck(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: selectDupRstDetail
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 8.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객중복체크 결과 상세 - I: 개인, C: 단체(사업자)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto
	 *   @return	
	 */
	List<LoyCustDupRstDetailResDto> selectDupRstDetailI(LoyCustDiDetailReqDto reqDto);
	List<LoyCustDupRstDetailResDto> selectDupRstDetailC(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: custMergePrcs
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		중복 결과 병합 처리 (작업상태만 완료로 바뀌게 해놨음 - 추후 개발 필요)
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void custMergePrcs(LoyCustDiDetailReqDto reqDto);

	 /*
	  * 1. 메소드명: deleteCustDi
	  * 2. 클래스명: LoyCustDiMapper
	  * 3. 작성자명: hr.noh
	  * 4. 작성일자: 2020. 6. 9.
	  */
	/**
	 * <PRE>
	 * 1. 설명
	 *		고객 식별 정책 삭제
	 * 2. 사용법
	 *		
	 * </PRE>
	 *   @param reqDto	
	 */
	void deleteCustDi(LoyCustDiListReqDto reqDto);

	Integer selectMaxSeq(LoyCustDiDetailReqDto reqDto);


}
