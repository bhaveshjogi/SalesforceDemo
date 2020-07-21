public with sharing class wtrapperclass1 {
    public string a;
    public wrp1 abc;
    public class Wrp1 {
 
      public  string xyz;
       public Account app;

}
    
    public wtrapperclass1() {
       a='this is test';
       abc = new wrp1();
       abc.xyz='test';
       abc.app=[select Id,name from Account limit 1];
       //System.debug(a);
      system.debug(abc.app);
}

}
