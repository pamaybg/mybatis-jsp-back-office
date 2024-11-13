package com.icignal.kepler.targetGroup.targetSql.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.icignal.core.database.dto.request.MKTDBInfoDTO;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlDetailReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlEditReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlListReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.request.KprTargetSqlTargetListReqDto;
import com.icignal.kepler.targetGroup.targetSql.dto.response.KprTargetSqlDetailResDto;
import com.icignal.kepler.targetGroup.targetSql.dto.response.KprTargetSqlListResDto;
import com.icignal.loyalty.customer.dto.response.LoyCafe24MbrResDto;

/**
 * 타겟SQL DAO
 *
 * @name : infavor.kepler.targetGroup.dao.impl.KprTargetSqlDAO
 * @date : 2018. 4. 23.
 * @author : jh.kim
 * @description :
 */
@Mapper
public interface KprTargetSqlMapper {

    /**
     * 타겟SQL 그룹정보 상세 조회
     *
     * @programId :
     * @name : selectTargetSqlDetail
     * @date : 2018. 4. 11.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public KprTargetSqlDetailResDto selectTargetSqlDetail(KprTargetSqlDetailReqDto param);

    /**
     * DB접속정보 조회
     *
     * @programId :
     * @name : selectDBInform
     * @date : 2018. 4. 13.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public MKTDBInfoDTO selectDBInform(MKTDBInfoDTO param);

    /**
     * 등록
     *
     * @programId :
     * @name : insertAnlTargetGroup
     * @date : 2018. 4. 18.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public void insertAnlTargetGroup(KprTargetSqlEditReqDto param);

    /**
     * 수정
     *
     * @programId :
     * @name : updateAnlTargetGroup
     * @date : 2018. 4. 18.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public void updateAnlTargetGroup(KprTargetSqlEditReqDto param);

    /**
     * 타겟SQL 목록 조회
     *
     * @programId :
     * @name : selectTargetSqlList
     * @date : 2018. 4. 25.
     * @author : jh.kim
     * @table :
     * @description :
     */
    public List<KprTargetSqlListResDto> selectTargetSqlList(KprTargetSqlListReqDto param);
    
    /**
     * @programId :
     * @name : updateTagetGroupCount
     * @date : 2019. 4. 18.
     * @author : dg.ryu
     * @table :
     * @description : 타겟그룹 건수 저장
     */
    public void updateTagetGroupCount(KprTargetSqlDetailReqDto param);

    
    /**
     * @programId :
     * @name : selectTargetCafe24List
     * @date : 2020. 12. 15.
     * @author : yj.choi
     * @table :
     * @description : 카페24 타겟그룹
     */
	public List<LoyCafe24MbrResDto> selectTargetCafe24List(KprTargetSqlTargetListReqDto reqDto);

	public String selectCafe24LgcId();
   
	/**
	 * select cafe24 Flag
	 *
	 * @programId :
	 * @name : getTargetCafe24YnFlag
	 * @date : 2021. 4. 14.
	 * @author : lee.gy
	 * @table :
	 * @param request
	 * @param response
	 * @param param
	 * @return
	 * @description :
	 */
    public KprTargetSqlDetailResDto getTargetCafe24YnFlag(KprTargetSqlDetailReqDto param);

}
