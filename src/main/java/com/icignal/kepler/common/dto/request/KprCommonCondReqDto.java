package com.icignal.kepler.common.dto.request;

import java.util.ArrayList;
import java.util.List;

import com.icignal.common.base.dto.request.MKTGridPagingReqDto;
import com.icignal.common.util.ObjectUtil;

/*
 * 1. 클래스명	: KPRCommonCondRequestDTO
 * 2. 파일명	: KPRCommonCondRequestDTO.java
 * 3. 패키지명	: com.icignal.kepler.common.dto.request
 * 4. 작성자명	: 류동균
 * 5. 작성일자	: 2015. 10. 16.
 */
/**
 * <PRE>
 * 1. 설명
 *		조건 조회 공통 dto
 * </PRE>
 */ 
public class KprCommonCondReqDto extends MKTGridPagingReqDto {
	
	private List<KprCommonCodeItemReqDto> item;
	private String strCondWhere;
	
	/*public void setStrAlias(String pAlias) {
		strCondWhere = "1=1";
		String space = " ";
		String alias = pAlias;
		
		if(pAlias == null)
			alias = "";
		else if(pAlias.length() == 0)
			alias = "";
		else
			alias = alias + ".";
		
		if(this.getItem() != null || this.getItem().size() > 0){
					
			for(int i=0; i<this.getItem().size(); i++){
					if(this.getItem().get(i).getCondType().trim().equals("DATE")){
						if(this.getItem().get(i).getOperationType().trim().equals("BETWEEN")){	
							strCondWhere += " and" + space + alias + this.getItem().get(i).getTgCol() + space  + this.getItem().get(i).getOperationType() + space +"'" + this.getItem().get(i).getStartDate() + "'" + " and "  +"'" + this.getItem().get(i).getEndDate()+ "'"  ;
						}
						else { 
							strCondWhere += " and" + space + alias + this.getItem().get(i).getTgCol() + this.getItem().get(i).getOperationType() + this.getItem().get(i).getWhereVal();
						}
					}
					else if(this.getItem().get(i).getCondType().trim().equals("INT")){
						strCondWhere += " and" + space + alias +  this.getItem().get(i).getTgCol() + this.getItem().get(i).getOperationType() + this.getItem().get(i).getWhereVal();
					}
					
					else{
						if(this.getItem().get(i).getOperationType().trim().equals("LIKE")){
							strCondWhere += " and" + space + alias + this.getItem().get(i).getTgCol() + this.getItem().get(i).getOperationType() + "'%" + this.getItem().get(i).getWhereVal() + "%'";
						}
						else{
							strCondWhere += " and" + space + alias + this.getItem().get(i).getTgCol() + this.getItem().get(i).getOperationType() + "'" + this.getItem().get(i).getWhereVal() + "'";
						}
					}

			}
		}
		else{
			strCondWhere = "1=1";
		}

		
		this.setStrCondWhere(strCondWhere);
	}*/

	
	
	public String getStrCondWhere() {
		
		String space = " ";
		String alias = "";
		strCondWhere = "1=1";
		
		if(this.getItem() != null || this.getItem().size() > 0){
			
			for(int i=0; i<this.getItem().size(); i++){
				
				if(this.getItem().get(i).getCondType().trim().equals("DATE") || ObjectUtil.isNotEmpty(this.getItem().get(i).getWhereVal())){
					
				
					if(item.get(i).getBaseTblAlias() != null && item.get(i).getBaseTblAlias().length() > 0){
						alias = item.get(i).getBaseTblAlias() + ".";
					}
					
					if(item.get(i).getComprTgtTblAlias() != null && item.get(i).getComprTgtTblAlias().length() > 0){
						alias = item.get(i).getComprTgtTblAlias() + ".";
					}
				
					if(this.getItem().get(i).getCondType().trim().equals("DATE")){
						if(this.getItem().get(i).getOperationType().trim().equals("BETWEEN")){	
							strCondWhere += " and" + space + alias + this.getItem().get(i).getSrcCol() + space  + this.getItem().get(i).getOperationType() + space +"'" + this.getItem().get(i).getStartDate() + "'" + " and "  +"'" + this.getItem().get(i).getEndDate()+ "'"  ;
						}
						else {
							strCondWhere += " and" + space + alias + this.getItem().get(i).getSrcCol() + this.getItem().get(i).getOperationType() + this.getItem().get(i).getWhereVal();
						}
					}
					else if(this.getItem().get(i).getCondType().trim().equals("INT")){
						strCondWhere += " and" + space + alias +  this.getItem().get(i).getSrcCol() + this.getItem().get(i).getOperationType() + this.getItem().get(i).getWhereVal();
					}
					
					else{
						if(this.getItem().get(i).getOperationType().trim().equals("LIKE")){
							strCondWhere += " and" + space + alias + this.getItem().get(i).getSrcCol() + this.getItem().get(i).getOperationType() + "'%" + this.getItem().get(i).getWhereVal() + "%'";
						}
						else{
							strCondWhere += " and" + space + alias + this.getItem().get(i).getSrcCol() + this.getItem().get(i).getOperationType() + "'" + this.getItem().get(i).getWhereVal() + "'";
						}
					}
				}

			}
		}
		else{
			strCondWhere = "1=1";
		}
		
		
		return strCondWhere;
	}

	public void setStrCondWhere(String strCondWhere) {
		
		this.strCondWhere = strCondWhere;
	}



	public List<KprCommonCodeItemReqDto> getItem() {
		if(item == null){
			item = new ArrayList();
			
		}
		return item;
	}



	public void setItem(List<KprCommonCodeItemReqDto> item) {
		this.item = item;
	}
 
}

	
