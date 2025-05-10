trigger AccountTrigger on Account (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            AccountTriggerHandler.insertOrUpdateOperation(Trigger.new,trigger.oldMap);
        }
        
    }
}