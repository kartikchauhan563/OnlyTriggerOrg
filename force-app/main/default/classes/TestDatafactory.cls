public class TestDatafactory {
    
   public static Account createTestAccount(String phone) {
        Account acc = new Account(Name = 'Test Account', Phone = phone);
        insert acc;
        return acc;
    }
    
    public static Contact createTestContact(Id accountId, String phone) {
        Contact con = new Contact(FirstName = 'Test', LastName = 'Contact', Phone = phone, AccountId = accountId);
        insert con;
        return con;
    }
}