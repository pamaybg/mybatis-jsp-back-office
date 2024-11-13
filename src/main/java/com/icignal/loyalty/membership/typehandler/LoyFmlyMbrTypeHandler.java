package com.icignal.loyalty.membership.typehandler;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ibatis.sqlmap.client.extensions.ParameterSetter;
import com.ibatis.sqlmap.client.extensions.ResultGetter;
import com.ibatis.sqlmap.client.extensions.TypeHandlerCallback;

import oracle.jdbc.driver.OracleConnection;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;


@SuppressWarnings("deprecation")
public class LoyFmlyMbrTypeHandler implements TypeHandlerCallback{

	@Override
	public Object valueOf(String value) {
		 if (value == null)
		      return new ArrayList();
		    return value;
	}

	@Override
	public Object getResult(ResultGetter paramResultGetter) throws SQLException {
		// 
		return null;
	}

	@Override
	public void setParameter(ParameterSetter setter, Object param) throws SQLException {

        final String typeName = "LOY.TY_FMLY_MBR";
        Connection conn = null;
        OracleConnection oracleConneciton = null;
        try {
	  		conn = setter.getPreparedStatement(). getConnection();
	  		oracleConneciton = conn.unwrap(OracleConnection.class); 
	  	    StructDescriptor structDescriptor = StructDescriptor.createDescriptor(typeName.toUpperCase(), oracleConneciton);		
	        STRUCT str = new STRUCT(structDescriptor, oracleConneciton, (Object[]) param);
	       setter.setObject(str);	
       } finally {
    	   conn.close();
    	   oracleConneciton.close();
       }
	}

}

