trigger TaskTrigger on Task (before insert) {
    TaskTriggerHandler handler = new TaskTriggerHandler(
        Trigger.old, Trigger.new, Trigger.newMap, Trigger.oldMap
    );
    
    switch on Trigger.operationType {
        when BEFORE_INSERT {
            handler.beforeInsert();
        }
    }
}