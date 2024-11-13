package com.icignal.kepler.operation.dto.response;

import java.util.List;

import com.icignal.common.base.dto.response.StatusResDto;

/**
 * 
 * @name : infavor.kepler.operation.dto.response
 * @date : 2016. 10. 5.
 * @author : LEE
 * @description :
 */
public class KprSalesDtlListsResDto extends StatusResDto {

	
	private List<KprSalesDtlListResDto> items;

	public List<KprSalesDtlListResDto> getItems() {
		return items;
	}

	public void setItems(List<KprSalesDtlListResDto> items) {
		this.items = items;
	}

}
