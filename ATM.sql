package atm1;

import java.util.Scanner;

import java.sql.*;

public class AtmProject {
    public static void main(String[] args){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3307/atm","root","");
            Statement stmt=con.createStatement();

            Scanner sc = new Scanner(System.in);
            System.out.println("Hi Welcome to All in One ATM");
            System.out.println("Enter your Pin Number");
            int pin=sc.nextInt();
            ResultSet rs=stmt.executeQuery("select * from atm1 where ac_no="+pin);
            String name=null;
            int balance=0;
            int count=0;
            while(rs.next()){
                name=rs.getString(3);
                balance=rs.getInt(4);
                count++;
            }
            int choice;
            int amount=0;
            int take_amount=0;
            if(count > 0){
                System.out.println("Hello "+name);
                while(true){
                    System.out.println("Press 1 to check balance");
                    System.out.println("Press 2 to Add Amount");
                    System.out.println("Press 3 to Take Amount");
                    System.out.println("Press 4 to print the Recipt");
                    System.out.println("Press 5 to Exit / Quit");
                    System.out.println();
                    System.out.println("Enter your Choice");
                    choice=sc.nextInt();
                    
                    switch(choice){
                        case 1: System.out.println("Your Balance is : "+balance);
                        break;
                        case 2: System.out.println("How much amount did you want to add ");
                            amount=sc.nextInt();
                            balance=balance+amount;
                            int bal=stmt.executeUpdate("Update atm1 set balance = "+balance+" where ac_no = "+pin);
                            System.out.println("Successfully added now your current balance is : "+balance);
                            break;
                        case 3:
                        System.out.println("How much amount did you want to add to take");
                        take_amount=sc.nextInt();
                        if(take_amount > balance){
                            System.out.println("your balance is inSufficient");
                        }
                        else{
                        balance=balance-take_amount;
                        int sub=stmt.executeUpdate("Update atm1 set balance = "+balance+" where ac_no = "+pin);
                        System.out.println("Successfully added now your current balance is : "+balance);
                        }
                        break;
                        case 4:
                            System.out.println("Thanks for Coming");
                            System.out.println("Your  Current Balance is : "+balance);
                            System.out.println("Amount added is : "+amount);
                            System.out.println("Amount taken : "+take_amount);
                            break;
                        
                     }
                     if(choice==5){
                        break;
                     }
                }
            }else{
                System.out.println("Wrong pin Number");
            }

        }
        catch(Exception e){
            System.out.println(e);
        }
    }


}
