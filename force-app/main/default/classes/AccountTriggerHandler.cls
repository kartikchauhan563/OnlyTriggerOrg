public class AccountTriggerHandler {
    public static void insertOrUpdateOperation(List<Account> newAccList, Map<Id, Account> oldAccountMap) {
        Map<Id, Account> updatedAccList = new Map<Id, Account>();
        
        for (Account acc : newAccList) {
            // Check if oldAccountMap contains the key before accessing it
            if (oldAccountMap != null && oldAccountMap.containsKey(acc.Id) &&
                acc.Phone != oldAccountMap.get(acc.Id).Phone) {
                updatedAccList.put(acc.Id, acc);
            }
        }
        
        if (!updatedAccList.isEmpty()) {
            List<Contact> listToUpdateAccount = new List<Contact>();
            List<Contact> listofUpdatedContacts = [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN :updatedAccList.keySet()];
            
            for (Contact con : listofUpdatedContacts) {
                con.Phone = updatedAccList.get(con.AccountId).Phone;
                listToUpdateAccount.add(con);
            }
            
            if (!listToUpdateAccount.isEmpty()) {
                update listToUpdateAccount;
            }
        }
    }
}