public class ContactTriggerHandler implements TriggerInterface {
    public static void beforeInsert(List<sObject> newRecordsList){
        ContactTriggerHelper.checkDuplicate((List<Contact>)newRecordsList,null);
    }
    public static void afterInsert(List<sObject> newRecordsList,Map<Id,sObject> newRecordsMap){
        List<Contact> contactList = (List<Contact>)newRecordsList;
        ContactTriggerHelper.updateCount(contactList);
    }
    public static void beforeUpdate(Map<Id, sObject> newRecordsMap, Map<Id, sObject> oldRecordsMap) {
        List<Contact> newRecordsList = (List<Contact>) newRecordsMap.values();
        List<Contact> existingRecords = (List<Contact>) oldRecordsMap.values();
        ContactTriggerHelper.checkDuplicate(newRecordsList,existingRecords);
	}
    public static void afterUpdate(Map<Id,sObject> newRecordsMap,Map<Id,sObject> oldRecordsMap){
        List<Contact> contactList = new List<Contact>();
        List<Contact> existingRecords = (List<Contact>)newRecordsMap.values();
        for(Contact con: existingRecords){
            Contact oldContact = (Contact)oldRecordsMap.get(con.Id);
            if(oldContact.AccountId != con.AccountId){
                contactList.add(con);
            }
        }
        ContactTriggerHelper.updateCount(contactList);

    
    
    }
    public static void afterDelete(Map<Id,sObject> oldRecordsMap){
        List<Contact> contactList = (List<Contact>)oldRecordsMap.values();
        ContactTriggerHelper.updateCount(contactList);
    }
    public static void beforeDelete(List<sObject> oldRecordsList,Map<Id,sObject> oldRecordsMap){
        
    }
    public static void afterUndelete(List<sObject> newRecordsList,Map<Id,sObject> newRecordsMap){
        List<Contact> contactList = (List<Contact>)newRecordsList;
        ContactTriggerHelper.updateCount(contactList);
        ContactTriggerHelper.checkDuplicate(contactList,null);

    }
}