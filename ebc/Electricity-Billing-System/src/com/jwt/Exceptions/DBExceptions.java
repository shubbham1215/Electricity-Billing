package com.jwt.Exceptions;

public class DBExceptions extends Exception{
	   String exception;
	   public DBExceptions(String b) {
		   exception=b;
	   }
	   public String toString(){
	     return exception;
	  }
}