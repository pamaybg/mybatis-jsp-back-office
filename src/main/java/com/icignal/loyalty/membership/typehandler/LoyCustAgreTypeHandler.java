package com.icignal.loyalty.membership.typehandler;

import java.sql.Array;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.TypeHandler;

import com.icignal.common.util.LogUtil;

import net.sf.log4jdbc.sql.jdbcapi.ConnectionSpy;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;



/*
 * 1. 클래스명	: LoyCustAgreTypeHandler
 * 2. 파일명	: LoyCustAgreTypeHandler.java
 * 3. 패키지명	: com.icignal.loyalty.membership.typehandler
 * 4. 작성자명	: hr.noh
 * 5. 작성일자	: 2020. 7. 10.
 */
/**
 * <PRE>
 * 1. 설명
 *
 * </PRE>
 */ 
@SuppressWarnings({ "unchecked", "deprecation", "rawtypes" })
public class LoyCustAgreTypeHandler implements TypeHandler<Object>{
	
	@Override
	public void setParameter(PreparedStatement ps, int i, Object parameter, JdbcType jdbcType) throws SQLException {

		try {
				ConnectionSpy spyConn = ps.getConnection().unwrap(ConnectionSpy.class);

//				Map param = (Map)parameter;
//				List<Map> objects = new ArrayList<Map>();
//				objects.add(param);
				List<Map> objects =	 (List<Map>)parameter;
//				objects.add((List<Map>)parameter);
				
				StructDescriptor structDescriptor = new StructDescriptor("T_CUST_AGRE",spyConn.getRealConnection());
				STRUCT[] structs = new STRUCT[objects.size()];
				
				for(int index =0; index< objects.size(); index++) {
					Map map = (Map) objects.get(index);
					
					Object[] params = new Object[map.keySet().size()];
		            Iterator<String> iterator = map.keySet().iterator();
		            int keyIndex = 0;
		            while (iterator.hasNext()) {
		                String key = (String)iterator.next();
		                params[keyIndex] = map.get(key);
		                keyIndex++;
		            }
		
		            STRUCT struct = new STRUCT(structDescriptor, spyConn.getRealConnection(), params);
		            structs[index] = struct;
		
		        }
		        ArrayDescriptor desc = ArrayDescriptor.createDescriptor("T_CUST_AGRE_TBL",spyConn.getRealConnection());
		        Array array = new ARRAY(desc,spyConn.getRealConnection(), structs);
		        ps.setArray(i, array);
		        
		}catch (Exception e) {
			
			LogUtil.error("LoyCustAgreTypeHandler 오류",e);
		
		}
		
	}

	@Override
	public Object getResult(ResultSet rs, String columnName) throws SQLException {
		
		return null;
	}

	@Override
	public Object getResult(ResultSet rs, int columnIndex) throws SQLException {
		
		return null;
	}

	@Override
	public Object getResult(CallableStatement cs, int columnIndex) throws SQLException {
		
            return null;

	}


}
