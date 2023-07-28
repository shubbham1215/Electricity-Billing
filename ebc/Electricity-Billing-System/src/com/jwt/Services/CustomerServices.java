package com.jwt.Services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import com.jwt.dbtools.DBtools;
import com.mysql.cj.jdbc.result.ResultSetMetaData;
import com.jwt.Exceptions.DBExceptions;

public class CustomerServices {
	
	private String customerid, username = "root", password = "";
	DBtools tools = new DBtools();
	
	public CustomerServices(String CustomerID) {
		customerid = CustomerID;
	}

	public void CustomerAuthentication()
            throws DBExceptions, ClassNotFoundException, SQLException
    {
		if(customerid == null) {
			throw new DBExceptions("Unauthorised Access: Access Denied!");
		}
		
		Connection connection = tools.DBConnect(username, password);
		
		String query = "* FROM `consumer_details` WHERE `Cus_id` = \"" + customerid + "\"";
		ResultSet resultset = tools.DBSelect(connection, query);
		
		if(resultset.next() == false) {
			throw new DBExceptions("Customer ID: " + customerid + " does not exist!");
		}
		
		if(connection!= null)
			tools.DBClose(connection);
		return;
    }
	
	public void CustomerComplaint(String billno, String description, String amount)
			throws Exception{
		
		Connection connection = tools.DBConnect(username, password);

		try {
			String query = "* FROM `bill_correction` WHERE `Bill_no` = \"" + billno + "\"";
			ResultSet resultset = tools.DBSelect(connection, query);
			
			if(resultset.next() == false) {
				query = "`bill_correction` VALUES(null,'" + customerid +"','" + billno + "',\"" + description + "\",'" + amount + "')";
				System.out.println(query);
				tools.DBInsert(connection, query);
				System.out.println("Inserted successfully");
				return;
			}else {
				throw new DBExceptions("Complaint for Bill No: " + billno + " already exists");
			}
		}catch(Exception e) {
			throw e;
		}finally {
			if(connection!= null)
				tools.DBClose(connection);
		}
	}
	
	public void CustomerPayment(String billno) 
	throws Exception{
		Connection connection = tools.DBConnect(username, password);
		try {
			String query = "st.Status from cons_bill_calendar_payment_info as cbc join status_table as st ON cbc.Status_id=st.Status_id WHERE cbc.Bill_no=" + billno;
			ResultSet resultset = tools.DBSelect(connection, query);
			
			resultset.next();
			
			Random rand = new Random();
			
			int trans_id = rand.nextInt(100000000);
			
			if((resultset.getString(1)).equals("UnPaid")) {
				query = "cons_bill_calendar_payment_info SET cons_bill_calendar_payment_info.Status_id=10, cons_bill_calendar_payment_info.Trans_id=\""  + trans_id
						+ "\" WHERE cons_bill_calendar_payment_info.Bill_no=(SELECT cbc.Bill_no from cons_bill_calendar_payment_info as cbc WHERE cbc.Cus_id=\"" + customerid + "\" "
						+ "ORDER BY cbc.To_date DESC LIMIT 1)";
				tools.DBUpdate(connection, query);
			}
			else {
				throw new DBExceptions("Bill No: " + billno + " already PAID!");
			}
			return;	
		} catch (Exception e) {
			throw e;
		}finally {
			if(connection!= null)
				tools.DBClose(connection);
		}
		
	}
	
	public List<Bill> CustomerBillHistory()
            throws DBExceptions, ClassNotFoundException, SQLException
    {
		Connection connection = tools.DBConnect(username, password);
		try {
			String query = "cbcp.Bill_no,cbcp.Cus_id,cbcp.From_date,cbcp.To_date,st.Status,cbcp.Trans_id,cbcp.Amount FROM cons_bill_calendar_payment_info as cbcp join status_table as st ON cbcp.Status_id=st.Status_id WHERE cbcp.Cus_id=\"" + customerid +"\"";
			ResultSet resultset = tools.DBSelect(connection, query);
			
			ResultSetMetaData rsmd = (ResultSetMetaData) resultset.getMetaData();
	
			int columnsNumber = rsmd.getColumnCount();
			List<Bill> bills = new ArrayList<Bill>();
			
			   while (resultset.next()) {
				   List<Object> row = new ArrayList<Object>();
				   for (int i = 1; i <= columnsNumber; i++) {
			           String columnValue = resultset.getString(i);
			           row.add(columnValue);
				   }
				   bills.add(new Bill(row));
			   }
			   
			   return bills;
			   
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		}   
    }
	
	public List<String> CustomerBillsforComplaint()
            throws DBExceptions, ClassNotFoundException, SQLException
    {
		Connection connection = tools.DBConnect(username, password);
		try {
			String query = "Bill_no FROM cons_bill_calendar_payment_info WHERE Cus_id=\"" + customerid + "\" ORDER BY To_date DESC LIMIT 4";
			ResultSet resultset = tools.DBSelect(connection, query);
			
			ResultSetMetaData rsmd = (ResultSetMetaData) resultset.getMetaData();
	
			int columnsNumber = rsmd.getColumnCount();
			List<String> bills = new ArrayList<String>();
			
		    while (resultset.next()) {
			   for (int i = 1; i <= columnsNumber; i++) {
		           String columnValue = resultset.getString(i);
		           bills.add(columnValue);
			   }
		   }
		   return bills;
			   
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		}   
    }
	
public LatestBill FinalBillData() 
		throws ClassNotFoundException, DBExceptions, SQLException{
		
		Connection connection = tools.DBConnect(username, password);
		try {
			String customerD = "* FROM `consumer_details` WHERE Cus_id=\""+ customerid +"\"";
			String todate = "cus_meter_reading.Date FROM cus_meter_reading WHERE cus_meter_reading.Consumer_id=\""+customerid+"\" ORDER BY Date DESC LIMIT 1 OFFSET 0";
			String fromdate = "DATE_ADD((SELECT cus_meter_reading.Date FROM cus_meter_reading WHERE cus_meter_reading.Consumer_id=\""+customerid+"\" ORDER BY Date DESC LIMIT 1 OFFSET 1),  INTERVAL 1 DAY)";
			String moreDetails = "me.Meter_Number,sb.Category_name,dcom.Dis_name from meter as me join consumer_details as cd ON me.Cus_id=cd.Cus_id join slabs1 as sb ON sb.Dis_id=cd.Dis_id AND sb.Category_id=cd.Cus_id join discom as dcom ON dcom.Dis_id=cd.Dis_id where cd.Cus_id=\""+customerid+"\"";
			String billNo = "cb.Bill_no,st.Status FROM cons_bill_calendar_payment_info as cb join status_table as st ON cb.Status_id=st.Status_id WHERE cb.Cus_id=\"" + customerid + "\" ORDER BY cb.To_date DESC LIMIT 1";
			
			ResultSet rsMD = tools.DBSelect(connection, moreDetails);
			
			ResultSet rs = tools.DBSelect(connection, customerD);
			List<Object> row = new ArrayList<Object>();
			
			ResultSetMetaData rsmd = (ResultSetMetaData) rs.getMetaData();
			int columnsNumber = rsmd.getColumnCount();

			while(rs.next()) {
				for (int i = 1; i <= columnsNumber; i++) {
					row.add(rs.getString(i));
				}
			}
			
			rs = tools.DBSelect(connection, todate);
			while(rs.next()) {
				row.add(rs.getString(1));
			}
			
			
			rs = tools.DBSelect(connection, fromdate);
			while(rs.next()) {
				row.add(rs.getString(1));
			}
	
			List amountBreakdown = ChargeDetails(connection);
			
			for(int j = 0; j < amountBreakdown.size(); j++){
				row.add(amountBreakdown.get(j));
			}
			
			rsmd = (ResultSetMetaData) rsMD.getMetaData();
			columnsNumber = rsmd.getColumnCount();
			
			while(rsMD.next()) {
				for (int i = 1; i <= columnsNumber; i++) {
					row.add(rsMD.getString(i));
				}
			}
			
			rs = tools.DBSelect(connection, billNo);
			
			rs.next();
			row.add(rs.getString(1));
			row.add(rs.getString(2));
			
			LatestBill bill = new LatestBill(row);
			return bill;
		}catch(Exception e) {
			throw e;
		}finally {
			tools.DBClose(connection);
		}
	}
	
	public List ChargeDetails(Connection connection)
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
			sanc_rate = sanc_load_rate;
		}else{
			sanc_rate = (peakLoad - sanc_load) * sanc_cross_rate;
		}
		
		rsmeterReading.next();
		int old_meterReading = rsmeterReading.getInt(1);
		
		Double meterReading = (double) (new_meterReading - old_meterReading);
		
		Double value = 0.0; 
		Double temp = (double) meterReading;

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

		Double FinalAmount= 0.0;
		
		while(rsFA.next() != false) {
			FinalAmount = rsFA.getDouble(1);
			System.out.println(FinalAmount);
		}
		
		List allValues = Arrays.asList(value, fixedCharge, sanc_rate, meterReading, subsidy, FinalAmount);
		return allValues;
		   
    }
}
