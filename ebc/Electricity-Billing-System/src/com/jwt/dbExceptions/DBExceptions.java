package com.jwt.dbExceptions;

public class DBExceptions extends Exception{
	   String exception;
	   public DBExceptions(String b) {
		   exception=b;
	   }
	   public String toString(){
	     return ("Invalid Consumer ID: " + exception);
	  }
}