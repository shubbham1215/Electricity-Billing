package com.jwt.Services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random; 
import com.jwt.Exceptions.DBExceptions;
import com.jwt.dbtools.DBtools;
import com.mysql.cj.jdbc.result.ResultSetMetaData;

public class AdminServices {
	
	private String username, password;
	DBtools tools = new DBtools();
	
	public AdminServices(String UserName, String PassWord) {
		username = UserName;
		password = PassWord;
	}

    
	public void AdminAuthentication()
            throws SQLException, ClassNotFoundException, DBExceptions
    {
		if(username == null && password == null) {
			throw new DBExceptions("Unauthorised Access: Access Denied!");
		}
		
		DBtools tools = new DBtools();
		Connection connection = tools.DBConnect(username, password);
		tools.DBClose(connection);
		return;
    }
	
	public void RegisterCustomer(String dis_id, String cat, String name, String address, String email, String Phone) 
			throws Exception{
		Connection connection = tools.DBConnect(username, password);
		Random rand = new Random();
		try {
			int cus_id = rand.nextInt(100000000);
			String query = "consumer_details(`Dis_id`, `Category_id`, `Cus_id`, `Cus_name`, `Cus_address`, `Payment_due`, `Email`, `Phone`, `Reg_date`) VALUES "
					+ "(" + dis_id + "," + cat  + ",\"" + "CAN" + cus_id + "\",\"" + name + "\",\"" + address + "\", 0 ,\"" + email + "\"," + Phone + ",CURRENT_DATE)";
			connection = tools.DBInsert(connection, query);
			
			query = "`cus_meter_reading`(`Consumer_id`, `Reading`, `Date`, `Peak_load`) VALUES (\"" + "CAN" + cus_id + "\",0,CURRENT_DATE,0)";
			connection = tools.DBInsert(connection, query);
			query = "`meter`(`Cus_id`) VALUES (\"CAN" + cus_id + "\")";
			connection = tools.DBInsert(connection, query);
			return;
			   
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		} 
	}
	
	public List<Object> getDISCOMnCats() 
			throws Exception{
		
		Connection connection = tools.DBConnect(username, password);
		try {
			String query = "dis.Dis_id,sb.Category_id,Dis_name,sb.Category_name from discom as dis join slabs1 as sb ON dis.Dis_id=sb.Dis_id";
			ResultSet resultset = tools.DBSelect(connection, query);
			
			List<String> discoms = new ArrayList<String>();
			List<String> vals = new ArrayList<String>();
			
			List<Object> dis_vals = new ArrayList<Object>();
			
			   while (resultset.next()) {
				   vals.add(resultset.getString(1) + ":" +  resultset.getString(2));
				   discoms.add(resultset.getString(3) + ":" +  resultset.getString(4));
			   }
			   
			   dis_vals.add(discoms);
			   dis_vals.add(vals);
			   
			   return dis_vals;
			   
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		}  
	}
	
	public void UpdateReadings(String Cus_id, String reading, String Date, String peak)
            throws Exception{
		Connection connection = tools.DBConnect(username, password);
		
		//System.out.println(Cus_id + reading + Date + peak);
		
		try {
			String query = "`cus_meter_reading`(`Consumer_id`, `Reading`, `Date`, `Peak_load`) VALUES (\"" +
					Cus_id + "\"," + reading + ",\"" + Date + "\"," + peak + ")";
			connection = tools.DBInsert(connection, query);
			
			//calculate bill
			Double amount = ChargeDetails(connection, Cus_id);
			
			//insert into consumer
			
			Random rand = new Random();
			
			int billno = rand.nextInt(100000000);
			
			query = "`cons_bill_calendar_payment_info`(`Bill_no`, `Cus_id`, `From_date`, `To_date`, `Status_id`, `Amount`) VALUES (\"" + billno + "\",\""+ Cus_id +"\","
					+ "(SELECT DATE_ADD((SELECT cus_meter_reading.Date FROM cus_meter_reading WHERE cus_meter_reading.Consumer_id=\"" + Cus_id + "\" ORDER BY cus_meter_reading.Date DESC LIMIT 1 OFFSET 1), INTERVAL 1 DAY)),"
							+ "(SELECT cus_meter_reading.Date from cus_meter_reading WHERE cus_meter_reading.Consumer_id=\"" + Cus_id + "\" ORDER BY cus_meter_reading.Date DESC LIMIT 1),11,"
					 + amount +")";
			
			connection = tools.DBInsert(connection, query);	
			return;
			   
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		}   
    }

	
	public List<Complaint> AdminComplaints()
            throws Exception{
		Connection connection = tools.DBConnect(username, password);
		try {
			String query = "* FROM `bill_correction` WHERE 1";
			ResultSet resultset = tools.DBSelect(connection, query);
			
			ResultSetMetaData rsmd = (ResultSetMetaData) resultset.getMetaData();
	
			int columnsNumber = rsmd.getColumnCount();
			List<Complaint> complaints = new ArrayList<Complaint>();
			
			   while (resultset.next()) {
				   List<Object> row = new ArrayList<Object>();
				   for (int i = 1; i <= columnsNumber; i++) {
			           String columnValue = resultset.getString(i);
			           row.add(columnValue);
				   }
				   complaints.add(new Complaint(row));
			   }
			   
			   return complaints;
			   
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		}   
    }
	
	public Double ChargeDetails(Connection connection, String customerid)
            throws DBExceptions, ClassNotFoundException, SQLException
    {
		
		String subCategoryIterator = "sc.Low,sc.High,sc.Charges from consumer_details as cd join slabs1 as sb on cd.Dis_id=sb.Dis_id AND cd.Category_id=sb.Category_id join slabs_charges as sc on sc.Dis_id=sb.Dis_id AND sc.Category_id=sb.Category_id join sanctioned_load_table as slt ON slt.Dis_id=sb.Dis_id AND slt.Category_id=sb.Category_id WHERE cd.Cus_id=\""+customerid+"\"";
		String FixedChargesQuery = "Fppca FROM elec_charges JOIN consumer_details as cd ON cd.Dis_id=elec_charges.Dis_id ORDER BY To_date DESC LIMIT 1";
		String meterReadingQuery = "Reading,peak_load FROM cus_meter_reading WHERE cus_meter_reading.Consumer_id=\""+ customerid +"\" ORDER BY Date DESC LIMIT 2";
		String fixedRatesforCustomer = "cd.Payment_due,slt.Sanctioned_load,slt.Sanctioned_load_rate,slt.Sanctioned_Cross_rate,slt.Subsidy from consumer_details as cd join slabs1 as sb on cd.Dis_id=sb.Dis_id AND cd.Category_id=sb.Category_id join sanctioned_load_table as slt ON slt.Dis_id=sb.Dis_id AND slt.Category_id=sb.Category_id WHERE cd.Cus_id=\"" + customerid + "\"";
		String finalAmount = "cbp.Amount from cons_bill_calendar_payment_info as cbp WHERE cbp.Cus_id=\"" + customerid + "\" ORDER BY cbp.To_date DESC LIMIT 1";
		
		ResultSet rsFC = tools.DBSelect(connection, FixedChargesQuery);
		ResultSet rsSCIterator = tools.DBSelect(connection, subCategoryIterator);
		ResultSet rsmeterReading = tools.DBSelect(connection, meterReadingQuery);
		ResultSet rsFR = tools.DBSelect(connection, fixedRatesforCustomer);
		ResultSet rsFA = tools.DBSelect(connection, finalAmount);
		
		rsFR.next();
		Double payment_due = rsFR.getDouble(1);
		Double sanc_load = rsFR.getDouble(2);
		Double sanc_load_rate = rsFR.getDouble(3);
		Double sanc_cross_rate = rsFR.getDouble(4);
		Double subsidy = rsFR.getDouble(5);

		rsmeterReading.next();
		int new_meterReading = rsmeterReading.getInt(1);
		double peakLoad = rsmeterReading.getInt(2);
		double sanc_rate = 0.0;
		
		if(peakLoad<=sanc_load){
			sanc_rate = peakLoad * sanc_load_rate;
		}else{
			sanc_rate = peakLoad * sanc_cross_rate;
		}

		rsmeterReading.next();
		int old_meterReading = rsmeterReading.getInt(1);
		
		int meterReading = new_meterReading - old_meterReading;
		
		Double value = 0.0; 
		int temp = meterReading;

		while(rsSCIterator.next()) {
			int r1 = Integer.parseInt(rsSCIterator.getString(1));
			int r2 = Integer.parseInt(rsSCIterator.getString(2));
			
			Double elec_Charge = Double.parseDouble(rsSCIterator.getString(3));
			
			if(meterReading < r2) {
				value = temp * elec_Charge + value;
				break;
			}
			else {
				value = (r2-r1) * elec_Charge + value;
				temp = temp - (r2-r1);
			}			
		}
		
		rsFC.next();
		Double fixedCharge = Double.parseDouble(rsFC.getString(1));
		
		Double FinalAmount = fixedCharge - subsidy  + sanc_rate + value + payment_due;
		
		return FinalAmount;
		   
    }
	
	public void DeleteComplaint(String cus_id , String corrected_amt, String C_id,String status)
            throws Exception{
        Connection connection = tools.DBConnect(username, password);
        String Query = " FROM bill_correction WHERE bill_correction.Complaint_id=\""+C_id+"\"";
       
        String getPD = "Payment_due FROM `consumer_details` WHERE Cus_id=\""+cus_id+"\"";
        try {
        	
        	if(status == "accept") {
		        ResultSet RSget = tools.DBSelect(connection, getPD);
		       
		        RSget.next();
		        Double paydue = RSget.getDouble(1);
		        Double finalPaydue = paydue - Double.parseDouble(corrected_amt);
		       
		        String UpdatePay = " consumer_details SET consumer_details.Payment_due="+finalPaydue+" WHERE consumer_details.Cus_id=\""+cus_id+"\"";
		        tools.DBUpdate(connection, UpdatePay);
	         }else{
	         }
	        tools.DBDelete(connection, Query);   
        }catch(Exception e) {
            throw e;
        }finally {
            tools.DBClose(connection);
        }
    }
}
  
