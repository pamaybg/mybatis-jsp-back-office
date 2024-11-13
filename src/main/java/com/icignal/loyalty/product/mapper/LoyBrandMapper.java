package com.icignal.loyalty.product.mapper;/**
 * 1. FileName	: iCIGNAL_LOYALTY_T10_Descente
 * 2. Package	: com.icignal.loyalty.product.mapper
 * 3. Comments	:
 * 4. Author	: hr.noh
 * 5. DateTime	: 2022-01-05 오전 9:55
 * 6. History	:
 * -----------------------------------------------------------------
 * Date		 |	Name			|	Comment
 * -------------  -----------------   ------------------------------
 * 2022-01-05		 | hr.noh			|	최초작성
 * -----------------------------------------------------------------
 * <p>
 * 1. 메소드명: LoyBrandMapper
 * 2. 클래스명: LoyBrandMapper
 * 3. 작성자명: hr.noh
 * 4. 작성일자: 2022-01-05
 */

import com.icignal.loyalty.product.dto.request.LoyBrandReqDto;
import com.icignal.loyalty.product.dto.response.LoyBrandListResDto;
import com.icignal.loyalty.product.dto.response.LoyBrandResDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * PRE
 * 1. 설명
 *
 * PRE
 *   브랜드 Mapper	
 */
@Mapper
public interface LoyBrandMapper {

    List<LoyBrandListResDto> selectBrandList(LoyBrandReqDto reqDto);

    LoyBrandResDto selectBrandDetail(LoyBrandReqDto reqDto);

    void insertBrand(LoyBrandReqDto reqDto);

    void updateBrand(LoyBrandReqDto reqDto);

    void deleteBrand(LoyBrandReqDto reqDto);
}
