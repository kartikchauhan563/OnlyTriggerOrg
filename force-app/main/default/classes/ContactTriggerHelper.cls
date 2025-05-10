public class ContactTriggerHelper {
        
       
    public static void checkDuplicate(List<Contact> contactList, Map<Id, Contact> oldMap) {
        Set<String> newEmailSet = new Set<String>();

        for (Contact con : contactList) {
            String oldEmail = (oldMap != null && oldMap.containsKey(con.Id)) ? oldMap.get(con.Id).Email : null;

            // For insert: oldEmail is null; for update: check change
            if (con.Email != null && con.Email != oldEmail) {
                newEmailSet.add(con.Email);
            }
        }

        if (newEmailSet.isEmpty()) return;

        List<Contact> existingContactList = [
            SELECT Id, Email FROM Contact WHERE Email IN :newEmailSet
        ];

        Map<String, Id> emailToIdMap = new Map<String, Id>();
        for (Contact con : existingContactList) {
            emailToIdMap.put(con.Email, con.Id);
        }

        for (Contact con : contactList) {
            if (con.Email != null && emailToIdMap.containsKey(con.Email)) {
                if (emailToIdMap.get(con.Email) != con.Id) {
                    con.addError('Same email already exists on another contact. Please update the email.');
                }
            }
        }
    }
    
  
    public static void updateCount(List<Contact> contactList){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con: contactList){
            if(con.AccountId !=null){
                accountIdSet.add(con.AccountId);
            }
        }
        Map<Id,Account> accountMap = new Map<Id,Account>();
        List<Contact> conList = [select id,Name,AccountId from Contact Where AccountId in: accountIdSet];
        for(Contact c: conList){
            if(!accountMap.containsKey(c.AccountId)){
                accountMap.put(c.AccountId,new Account(Id=c.AccountId,Contact_Count__c=1));
            }else{
                Account tempAccount = accountMap.get(c.AccountId);
                tempAccount.Contact_Count__c +=1;
                accountMap.put(c.AccountId,tempAccount);
            }
        }
        update accountMap.values();
    }

}